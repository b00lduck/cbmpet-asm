
.import source "bitmap_font_core.asm"


.macro DrawScroller() {

	clc
	lda scroller_frame
	adc #1
	sta scroller_frame

	cmp #1
	bne !+
	
	lda #0
	sta scroller_frame
	
	clc
	lda scroller_subpos
	adc #1
	sta scroller_subpos
	
	cmp #5
	bne !+
	
	lda #0
	sta scroller_subpos
	
	clc
	lda scroller_pos
	adc #1
	sta scroller_pos	
	
	

	
!:
	
	
	// The current char index of the text
	lda scroller_pos
	sta bf_char_index

	// current x pos	
	sec
	lda #5
	sbc scroller_subpos
	sta bf_xpos				
		
	:DrawBitmapText()
}


// Expects the following variables from bitmap_font_data to be set:
// bf_char_index	(The current char index of the text)
// bf_xpos 			(The current x-position on the screen)
.macro DrawBitmapText() {
	

	
	loop:

		// Load the on-screen (VVRAM coordinates) x-position from bf_xpos into X-Register (XR)
		ldx bf_xpos

		// Lookup which char we gonna draw and store it in the accumulator (AC)
		ldy bf_char_index
		lda text2,y
		
		// Draw the whole char into VVRAM.
		// Now:
		// 		XR is the x-position (VVRAM coordinates)
		// 		AC is the character to be drawn
		:DrawBitmapChar()		
		
		// Increment the char index (bf_char_index)
		inc bf_char_index
		lda bf_char_index
		
		// check for end
		//cmp #15		
		//beq exit
		
		// Increment the on-screen (VVRAM coordinates) x-position (bf_xpos) by 5
		lda bf_xpos
		adc #5
		sta bf_xpos
		
		// If the current on-screen (VVRAM coordinates) x-position is above #79 exit the loop.
		// We are done, because the right border of the screen is reached
		// TODO-DOC: why #79?
		cmp #79
		bcs exit
		
		// Draw next character
		jmp loop
		
	exit:	
					
}









// determine x pixel offset of the desired character in the source bitmap
// determine y pixel offser of the desired character in the source bitmap
// choose one of the DrawBitmapChar macros depending on the modulo of the y offset
// USES: ZP1, ZP2, ZP10, ZP11, ZP12, ZP13, ZP14
// IN: 
// 		AC:	char id
// 		XR:	x position
.macro DrawBitmapChar() {			
		
		// determine y-char-index and store in ZP14 for later use
		sta ZP13	// store char id for later use
		lsr			// 16 chars per row, just take the y-part
		lsr
		lsr
		lsr
		sta ZP14	// save y-index of char id in ZP14		

		
		// determine x-char-index and store in ZP10 for later use
		lda ZP13		
		and #$0f 	// 16 chars per row, just take the x-part		
		sta ZP10	// save x-index of char id in ZP10
		
		
		ldy #4 		// multipicator minus one	
	mul1:			// multiplicate with 5
		clc
		adc ZP10
		dey
		bne mul1
						
		sta ZP11	// store offset in vvram pixels in zp11	
		lsr			// divide by 2
		lsr			// divide by 2 again
		sta ZP12	// store "x pixel offset / 4" in ZP12
				
		// Load font address to ZP2 and add ZP12
		clc
		lda #<font1
		adc ZP12
		sta ZP2
		lda #>font1
		adc #0
		sta ZP2+1		
		
		// Add ZP14 * 80 ($50) to ZP2 (y-offset of the char in the source bitmap)
		ldy ZP14
	mul2:
		beq endmul2
		clc
		lda ZP2
		adc #80
		sta ZP2
		lda ZP2+1
		adc #0
		sta ZP2+1				
		dey
		jmp mul2
			
	endmul2:
									
		// Now calculate the "source" part of the jumptable address which can be 0,8,16 or 24
		lda ZP11	// load x character source offset
		and #%11	// "offset % 4"
		
		rol	// multiply by four, source part is bit 3 and 4
		rol
		
		sta ZP10 	// store intermediate result
		
					
		txa			// get target x-offset
		and #3		// use two bits
		clc			// add it
		adc ZP10 		
		
		rol // multiply by two, because jumptable has 16 bit addresses
		tay			

		// set the jump address of the draw routine
		lda dbmc_jumptable,y
		sta jump+1
		lda dbmc_jumptable+1,y
		sta jump+2
				
		// load the target VVRAM address and store in ZP1
		lda #<VVRAM
		sta ZP1
		lda #>VVRAM
		sta ZP1+1		
		
		// get offset
		txa
		lsr
		lsr
		sta ZP11
		
		// add it to the target address
		clc
		lda ZP1
		adc ZP11
		sta ZP1
		lda ZP1+1
		adc #0
		sta ZP1+1		
				
		// check for clipping
		cpx #77
		bcc jump
	
	nojump:	
		jmp exit
		
	jump:
		jsr dbmc_s0_t0 // first address byte will be overwritten at runtime (see above)
		
	exit:
	
}
