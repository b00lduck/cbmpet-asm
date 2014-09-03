.const BASIC=$0401
.const MAIN=$040d
.const VRAM=$8000
.const ORIG_ISR=$e455

.const ZP1=$e0
.const ZP2=$e2
.const ZP_ISR=$90

.pc = BASIC "Basic Upstart" {
	:BasicUpstart(MAIN)
}

.pc = MAIN "Main" {
	start:
		
		:ClearScreen()	
		:SwitchLowercase()
		
		:DrawText(6, 8, hello1, $1d)
		:DrawText(6, 12, hello2, $1d)
		:DrawText(6, 14, hello3, $1d)
		:DrawText(6, 16, hello4, $1d)	
			
		// set interrupt vector to 'isr'
		sei
		:loadToZP(ZP_ISR, isr)
		cli
		
	mainloop:
	
		:DrawOuterBox(framecount)
		
		// check for keystroke
		lda $97
		cmp #$ff
		beq mainloop
	
		
	ende:
		lda #$00
		sta $9e
		:loadToZP(ZP_ISR, ORIG_ISR)
		:ClearScreen()	
		:SwitchGraphics()						
		rts

	isr:		
		inc framecount	
		jmp ORIG_ISR	// jump to original interrupt	
		
}

framecount: .dword 0

hello1: .text " b00lduck  proudly  presents "
hello2: .text "vintage  6502  assembly  code"
hello3: .text "  by graf hardt and shazman  "
hello4: .text "      on  an  cbm 4032       "


// Draw outer box
// uses ACC, X, Y
// ZP $30, $32
.macro DrawOuterBox(char) {	
	
	// Draw horizontal lines
	:loadToZP(ZP1, $8000)
	:loadToZP(ZP2, $83C0)
		
	lda char	
	ldy #$28
	hloop:				
		dey
		sta (ZP1),y	
		sta (ZP2),y			
		bne hloop
	
	// Draw vertical lines
	:loadToZP(ZP1, $8028)	
	
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

// In-Place add of an 8-Bit value to an address pointer in the ZeroPage
// no regs changed
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

// clear the screen
.macro ClearScreen() {
	:FillScreen($20)
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
