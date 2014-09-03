.const BASIC=$0401
.const MAIN=$040d
.const VRAM=$8000
.const ORIG_ISR=$e455

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
		lda #<isr	// high byte
		sta $90
		lda #>isr	// low byte
		sta $91
		cli
		
	mainloop:
	
		:DrawOuterBox(framecount)
	
		jmp mainloop

	isr:		
		inc framecount	
		jmp ORIG_ISR	// jump to original interrupt	
		
}

framecount: .dword 0

hello1: .text " b00lduck  proudly  presents "
hello2: .text "vintage  6502  assembly  code"
hello3: .text "  by graf hardt and shazman  "
hello4: .text "      on  an  cbm 4032       "

.macro DrawOuterBox(char) {	
	
	// Draw horizontal lines
	:loadToZP($30, $8000)
	:loadToZP($32, $83C0)
		
	lda char	
	ldy #$28
	hloop:				
		dey
		sta ($30),y	
		sta ($32),y			
		bne hloop
	
	// Draw vertical lines
	:loadToZP($30, $8028)	
	
	// Vertical lines			
	ldx #23
	ldy #0			
	vloop:				
		
		sta ($30),y		
		:addToZP8($30, $27)
		
		sta ($30),y
		:addToZP8($30, $01)
		
		dex
		bne vloop
		
}

// In-Place add of an 8-Bit value to an address pointer in the ZeroPage
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
.macro loadToZP(addr, value) {
	pha			// push acc to stack	
	
	// high byte
	lda #<value   	
	sta addr	
	
	// low byte	
	lda #>value	
	sta addr + 1
		
	pla			// pull acc from stack
}

// switch to upeprcase/lowercase mode
.macro SwitchLowercase() {		
		lda #$0e
		sta $e84c
}

// switch to uppercase/graphics mode
.macro SwitchGraphics() {		
		lda #$0c
		sta $e84c
}

// draw text without clipping
.macro DrawText(tx, ty, text, len) {
		.var addr = VRAM + tx + ty * 40
		ldx #$00
	loop:
		lda text, x
		sta addr, x
		inx
		cpx #len
		bne loop
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
