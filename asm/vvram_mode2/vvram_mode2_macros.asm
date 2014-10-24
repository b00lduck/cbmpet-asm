// VVRAM mode 2 macros

.macro DrawMemoryNA() {

	// Pointer to the VVRAM line (ZP1)

	// ZP1 = VVRAM+1 (padding 4px on the left side)
	// ZP3 = $80A0
	
	lda #<VVRAM+1 // padding 4px = 1 byte
	sta ZP1
	lda #>VVRAM+1 // padding 4px = 1 byte
	sta ZP1+1
			
	lda #$80
	sta ZP3+1	
	lda #$28
	sta ZP3
	
	.for(var i = 0; i < 16; i++) {
		:DrawVVramLineNA()	
		:IncZp8(ZP1,$16)
		:IncZp8(ZP3,$28)
	}

}


// Draw 1 line of real VRAM (40 chars)
.macro DrawVVramLineNA() {
	
		// set VRAM in-line offset counter to 0
		lda #$00
		sta ZP10

		// set VVRAM in-line offset counter to 0
		lda #$00
		sta ZP11
						
	loop:	

		// ZP1 vvram line ptr, pointing to begin of line
		// ZP3 vram line ptr, pointing to begin of line
		// ZP10 offset in vram line		
		// ZP11 offset in vvram line		
		
		// fetch one half byte from VVRAM
		ldy ZP11
		lda (ZP1),y
		pha	// save to stack
		lsr
		lsr
		lsr
		lsr		
		
		// look up value in lookup table
		tax
		lda lut1,x	

						
		// Store to VRAM
		ldy	ZP10
		sta (ZP3),y
		inc ZP10
		

		// fetch other half byte with help from stack
		pla		
		and #$0f

		// look up value in lookup table
		tax
		lda lut1,x		
						
		// Store to VRAM
		ldy	ZP10
		sta (ZP3),y
		inc ZP10
		
		// Increment in line pointer		
		inc ZP11		
		lda ZP11
		cmp #$14	
		bne loop

}


.macro LoadImageNA(IMAGE) {

	init:
		// Load VVRAM address to ZP1
		lda #<VVRAM
		sta ZP1
		lda #>VVRAM
		sta ZP1+1
		
		// Load src Image address to ZP2
		lda #<IMAGE
		sta ZP2
		lda #>IMAGE
		sta ZP2+1
		
		// Load Image end address to ZP3
		lda #<IMAGE+352
		sta ZP3
		lda #>IMAGE+352
		sta ZP3+1	
		
	loop:
	
		ldy #0
		lda (ZP2),y
		sta (ZP1),y
		
	
		clc
		lda #1
		adc ZP1
		sta ZP1
		bcc !+
		inc ZP1+1			
		
	!: 
		clc
		lda #1
		adc ZP2
		sta ZP2
		bcc !+
		inc ZP2+1
	!:

		lda ZP3
		cmp ZP2		
		bne loop
		
		lda ZP3+1
		cmp ZP2+1
		
		bne loop

}