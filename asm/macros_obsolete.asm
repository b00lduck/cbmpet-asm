
// Draw one line of VVRAM to VRAM
// ZP1: VVRAM even line address
// ZP2: VVRAM odd line address
// ZP3: VRAM line address
// Affects: AC,YR,Z,C
.macro DrawVVramLine() {
	
		// index of the graphics table value (0-15)
		lda #0
		sta ZP4

		// offset counter
		lda #0
		sta ZP4+1
		
	loop:	
					
		// store first bit in ZP3 and shift left
		ldy #0			// 2
		lda (ZP1),y		// 5
		asl				// 2	
		sta ZP4			// 3							
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