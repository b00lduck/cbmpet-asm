
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
	
	lda #$28
	sta ZP3
	
	//clc

	.for(var i = 0; i < 2; i++) {

		:DrawVVramLineV2()
	
		:IncZp8(ZP1,$52)
		:IncZp8(ZP2,$52)
		:IncZp8(ZP3,$28)

	}

}

// Draw 1 lines of real screen memory (40 chars)
.macro DrawVVramLineV2() {
	
		// set x=0 for ConvertPixel()
		// set in-line offset counter to 0
		lax #0 // illegal opcode for lda/ldx
		sta ZP4
				
	loop:	

		// ZP1 even line vvram ptr, pointing to begin of line
		// ZP2 odd line vvram ptr, pointing to begin of line
		// ZP3 vram line ptr, pointing to begin of line
		// ZP4 offset in vram line
		:ConvertPixel()	
		
		// Store to VRAM
		ldy	ZP4
		sta (ZP3),y
		
		// Increment in line pointer		
		iny
		sty ZP4
		cpy #$28
		beq end
		
		// Increment VVRAM pointers by 2
		:IncZp8(ZP1,$02)
		:IncZp8(ZP2,$02)
				
		jmp loop		
		
	end:
	
}

// ZP1 even line ptr
// ZP2 odd line ptr
// RX needs to be 0
// Return value is in ACC
// Affects: ACC,RY
.macro ConvertPixel() {

		
	
			ldy #1	
		
			lda (ZP1,x)		// 6
			bne b2
			
		b1:	
			lda (ZP1),y		// 5		
			bne c2
			
		c1:
			lda (ZP2,x)		// 6
			bne d2
			
		d1: 
			lda (ZP2),y		// 5
			bne e2
			lda #32			// space
			jmp draw		
			
		b2:
			lda (ZP1),y		// 6		
			bne c4
			
		c3:
			lda (ZP2,x)		// 5
			bne d6
			
		d5: 
			lda (ZP2),y		// 6
			bne e10
			lda #126
			jmp draw	
			
		c2:
			lda (ZP2,x)		// 5
			bne d4
			
		d3: 
			lda (ZP2),y		// 6
			bne e6
			lda #124
			jmp draw
			
		c4:
			lda (ZP2,x)		// 5
			bne d8
		
		d7:
			lda (ZP2),y		// 6
			bne e14
			lda #226
			jmp draw
			
		d2:
			lda (ZP2),y		// 6
			bne e4
			lda #123
			jmp draw
			
		d4: 
			lda (ZP2),y		// 6
			bne e8
			lda #255
			jmp draw	
			
		d6:
			lda (ZP2),y		// 6
			bne e12
			lda #97
			jmp draw

		d8:
			lda (ZP2),y		// 6
			bne e16
			lda #236
			jmp draw	
				
		e2:	 lda #108  jmp draw
		e4:	 lda #98   jmp draw
		e6:	 lda #225  jmp draw
		e8:	 lda #254  jmp draw
		e10: lda #127  jmp draw
		e12: lda #252  jmp draw
		e14: lda #251  jmp draw
		e16: lda #160
			
	draw:
	
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

.macro LoadImage() {

	init:
		// Load VVRAM address to ZP1
		lda #$00
		sta ZP1
		lda #$40
		sta ZP1+1
		
		// Load src Image address to ZP2
		lda #<image1
		sta ZP2
		lda #>image1
		sta ZP2+1
		
		// Load Image length to ZP3
		lda image1_size
		sta ZP3
		lda image1_size+1
		sta ZP3+1	
		
		// Set ZP4 to current state 0 (0 or 1)
		lda #0
		sta ZP4
			
	outerloop:
		// Load one compressed byte from the image pointer ZP2 and copy it to x
		ldy #0	
		lda (ZP2),y
		tay
	
	innerloop:
		lda ZP4
		sta (ZP1),y
		dey
		bne innerloop

		// last byte (which is the first in fact at offset 0)
		lda ZP4
		sta (ZP1),y
		
		// flip current state
		lda ZP4
		eor #1
		sta ZP4
		
	inc_zp1:
		// add length of recently added bytes to ZP1, the target VVRAM
		clc
		ldy #0
		lda (ZP2),y		
		adc ZP1
		sta ZP1
		bcc inc_zp2
		inc ZP1+1		

	inc_zp2:
		clc
		lda #1
		adc ZP2
		sta ZP2
		bcc dec_zp3
		inc ZP2+1
		
	dec_zp3:
		sec
		lda ZP3
		sbc #1
		sta ZP3
		lda ZP3+1
		sbc #0
		sta ZP3+1
		
	end_check:
		lda ZP3+1
		cmp #$ff
		bne outerloop
		lda ZP3
		cmp #$ff
		bne outerloop
	
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