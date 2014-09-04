/**
 * Set the interrupt vector to 'addr' and store the original value to 'orig_isr'
 * no regs changed
 */
.macro InstallIsr(addr) {
	sei
	pha
	// save original isr
	lda ZP_ISR
	sta orig_isr
	lda ZP_ISR + 1
	sta orig_isr + 1
	
	// set new isr
	lda #<addr
	sta ZP_ISR
	lda #>addr
	sta ZP_ISR + 1
	pla
	cli
}

/**
 * Restore the interrupt vector to the old value from 'orig_isr'
 * no regs changed
 */
.macro RestoreIsr() {
	sei
	pha
	lda orig_isr
	sta ZP_ISR
	lda orig_isr + 1
	sta ZP_ISR + 1
	pla
	cli
}

/**
 * In-Place add of an 8-Bit value to an address pointer in the ZeroPage
 * no regs changed
 */
.macro addToZP8(addr, val) {
	pha           // push acc to stack	
	
    clc           // Ensure carry is clear
    lda addr      // Add the least significant address byte
    adc #val	  // Add $28 with carry	
    sta addr      // store the result
		
    lda addr + 1  // Add the most significant byte
    adc #$00      // add propagated carry bit
    sta addr + 1  // store the result
	
	pla			  // pull acc from stack
} 

// Load address into ZeroPage at offset	
// no regs changed
.macro loadToZP(addr, value) {
	pha			// push acc to stack	
	tya
	pha
	
	// high byte
	lda #<value   	
	sta addr	
		
	// low byte	
	ldy #$01	
	lda #>value	
	sta addr, y
		
	pla
	tay
	pla			// pull acc from stack
}

// switch to upeprcase/lowercase mode
.macro SwitchLowercase() {		
	pha
	lda #$0e
	sta $e84c
	pla
}

// switch to uppercase/graphics mode
.macro SwitchGraphics() {		
	pha
	lda #$0c
	sta $e84c
	pla
}

// draw text without clipping
.macro DrawText(tx, ty, text, len) {

		pha
				
		.var addr = VRAM + tx + ty * 40		
		
		ldx #$00
	loop:
		lda text, x
		sta addr, x
		inx
		cpx #len
		bne loop
		
		pla
}

// draw zero terminated text
.macro DrawTextZt(tx, ty, text) {
		pha				
		.var addr = VRAM + tx + ty * 40				
		ldx #$00
	loop:
		lda text, x		
		cmp #$00
		beq end
		sta addr, x
		inx		
		jmp loop	

	end:		
		pla
}

// Draw outer box
// uses ACC, X, Y
// ZP1, ZP2
.macro DrawOuterBox(char) {	
	
	// Draw horizontal lines
	:loadToZP(ZP1, VRAM)
	:loadToZP(ZP2, VRAM + $03C0)
		
	lda char	
	ldy #$28
	hloop:				
		dey
		sta (ZP1),y	
		sta (ZP2),y			
		bne hloop
	
	// Draw vertical lines
	:loadToZP(ZP1, VRAM + $0028)	
	
	// Vertical lines			
	ldx #23
	ldy #0			
	vloop:				
		
		sta (ZP1),y		
		:addToZP8(ZP1, $27)
		
		sta (ZP1),y
		:addToZP8(ZP1, $01)
		
		dex
		bne vloop
		
}

/**
 * reads one byte from the source address and writes two bytes to the target address
 * 
 */
.macro ItoA(target, source) {
	pha
	lda source				
	lsr
	lsr
	lsr
	lsr
	ora #'0'
	sta target
	lda source				
	and #$0f
	ora #'0'
	sta target + 1		
	pla
}


// clear the screen
.macro ClearScreen() {
	:FillScreen($20)
}

// clear hove via ROM call
.macro ClearHome() {
    lda #$93    
    jsr $ffd2	
}

// fill the screen with character 'clearByte'
.macro FillScreen(clearByte) {
		lda #clearByte
		ldx #$00
	loop:
		.for(var i = 0; i < 3; i++) {
			sta VRAM + [i * $0100], x
		}
		sta VRAM + [$02e8], x
		inx
		bne loop
}