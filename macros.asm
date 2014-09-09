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

/**
 * ZP1: VVRAM even line address
 * ZP2: VVRAM odd line address
 * ZP3: VRAM line address
 */
.macro DrawVVramLine() {
	
		// index of the graphics table value (0-15)
		lda #0
		sta ZP4

		// offset counter
		lda #0
		sta ZP4+1
		
	loop:	
		ldy #0
			
		// store first bit in ZP3 and shift left
		lda (ZP1),y
		asl
		sta ZP4
		:IncZp(ZP1)
			
		// store second bit in ZP3 and shift left
		lda (ZP1),y
		ora ZP4
		asl
		sta ZP4
		:IncZp(ZP1)
			
		// store third bit in ZP3 and shift left
		lda (ZP2),y
		ora ZP4
		asl
		sta ZP4
		:IncZp(ZP2)

		// store fourth bit in ZP3
		lda (ZP2),y
		ora ZP4
		sta ZP4

		// ZP4+1 is teh value to draw, copy it from acc		
		tay		
		:IncZp(ZP2)
		
		lda gfxtable,y
		
		ldy	ZP4+1	
		sta (ZP3),y

		// Draw 1 lines of real screen memory (40 chars)
		inc ZP4+1
		lda ZP4+1
		cmp #$28
		bne loop
	
}


.macro DrawMemory() {

	// Pointer to the even line VVRAM (ZP1) and odd line VVRAM (ZP2)

	// ZP1 = $4000
	// ZP2 = $4050
	// ZP3 = $80A0
	
	lda #$40
	sta ZP1+1
	sta ZP2+1

	lda #$00
	sta ZP1
		
	lda #$50
	sta ZP2
		
	lda #$80
	sta ZP3+1
	
	lda #$A0
	sta ZP3
	
	clc


	.for(var i = 0; i < 15; i++) {

		:DrawVVramLine()
	
		:IncZp4fh(ZP1)
		:IncZp50h(ZP2)
		:IncZp28h(ZP3)

	}
	

}


/**
 * Increments ZP address by one
 * Be careful, do a CLC before
 * Affects: CARRY,AC
 */
.macro IncZp(addr) {
	// increment (16-bit add by 1)
	lda addr
	adc #$01
	sta addr
	bcc end
	clc
	inc addr+1
	end:
}

/**
 * Increments ZP address by $4f
 * Be careful, do a CLC before
 * Affects: CARRY,AC
 */
.macro IncZp4fh(addr) {	
	lda addr
	adc #$4f
	sta addr
	bcc end
	clc
	inc addr+1
	end:
}

.macro IncZp50h(addr) {	
	lda addr
	adc #$50
	sta addr
	bcc end
	clc
	inc addr+1
	end:
}

/**
 * Increments ZP address by $28
 * Be careful, do a CLC before
 * Affects: CARRY,AC
 */
.macro IncZp28h(addr) {	
	lda addr
	adc #$28
	sta addr
	bcc end
	clc
	inc addr+1
	end:
}

.macro ClearVVRAM() {

		// Load VVRAM address to ZP1
		lda #$00
		sta ZP1
		lda #$40
		sta ZP1+1
				
		ldx #0 // counter
		ldy #0
		
	loop:
		
		// set the pixel value 0
		lda #0
		sta (ZP1),y
						
		// inc ZP1 by 1, lower byte		
		clc
		lda ZP1		
		adc #1
		sta ZP1
		bcc endcheck
		
		// inc ZP1+1 because carry was set and clear carry
		inc ZP1+1
		clc

	endcheck:
		// check if end is reached ($7e80)
		lda ZP1+1
		cmp #$7e 
		bne loop
		lda ZP1
		cmp #$80
		bne loop

}

.macro Checkerboard() {

		// clear carry
		clc
		
		// Load VVRAM address to ZP1
		lda #$00
		sta ZP1
		lda #$40
		sta ZP1+1
		
		ldy #0 // always zero
		
		ldx #0 // counter
		
		lda #0
		sta ZP4 // column
		sta ZP4+1 // flipped each column
		
	loop:
		
		// set the pixel value (1 or 0)
		lda ZP1		
		adc ZP4+1
		and #1
		
		sta (ZP1),y
				
		// inc ZP4
		inc ZP4		
		lda ZP4
		cmp #80		
		bne next
		
		// reset ZP4 and flip ZP4+1
		lda #0
		sta ZP4
		
		lda ZP4+1
		eor #1
		sta ZP4+1
		
	next:
		// inc ZP1 by 1, lower byte		
		clc
		lda ZP1		
		adc #1
		sta ZP1
		bcc endcheck
		
		// inc ZP1+1 because carry was set and clear carry
		inc ZP1+1
		clc

	endcheck:
		// check if end is reached ($7e80)
		lda ZP1+1
		cmp #$7e 
		bne loop
		lda ZP1
		cmp #$80
		bne loop

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

//reads one byte from the source address and writes two bytes to the target address
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