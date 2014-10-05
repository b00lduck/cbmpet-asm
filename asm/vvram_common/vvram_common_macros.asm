
.macro ClearVVRAM() {

		// Load VVRAM address to ZP1
		lda #<VVRAM
		sta ZP1
		lda #>VVRAM
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
		cmp #>VVRAM_END+1
		bne loop
		lda ZP1
		cmp #<VVRAM_END+1
		bne loop

}