// draw text 
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

.macro DisplayHexWord(addr,vram) {
		
	// DIGIT 4		
	lda addr
	and #$0f		
	sed             
	clc
	adc #$90        // Produce $90-$99 (C=0) or $00-$05 (C=1)
	adc #$40        // Produce $30-$39 or $41-$46
	cld             				
	sta vram+3

	
	// DIGIT 3
	lda addr
	and #$f0
	clc
	ror
	ror
	ror
	ror
	sed             
	clc
	adc #$90        // Produce $90-$99 (C=0) or $00-$05 (C=1)
	adc #$40        // Produce $30-$39 or $41-$46
	cld             				
	sta vram+2		
	
	
	// DIGIT 2	
	lda addr+1
	and #$0f		
	sed             
	clc
	adc #$90        // Produce $90-$99 (C=0) or $00-$05 (C=1)
	adc #$40        // Produce $30-$39 or $41-$46
	cld             				
	sta vram+1

	
	// DIGIT 1
	lda addr+1
	and #$f0
	clc
	ror
	ror
	ror
	ror		
	sed             
	clc
	adc #$90        // Produce $90-$99 (C=0) or $00-$05 (C=1)
	adc #$40        // Produce $30-$39 or $41-$46
	cld             				
	sta vram	

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