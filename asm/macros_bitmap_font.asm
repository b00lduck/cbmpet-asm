
// even target and even source
// "straight" case
// one source byte are two PETSCII chars, which are 4x2 VVRAM pixels
// source:      target:
// 1 2  5 6     1 2  5 6 
// 3 4  7 8     3 4  7 8
.macro DrawBitmapChar_EvenTarget_EvenSource() {
	ldy #0
	lda (ZP2),y
	sta (ZP1),y
	
	ldy #20
	lda (ZP2),y
	sta (ZP1),y
	
	ldy #40
	lda (ZP2),y
	sta (ZP1),y
}

// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:      target:
// 1 2  5 6     x 1  2 5  6 x 
// 3 4  7 8     x 3  4 7  8 x
//
// a translation table is used to translate the source to the target bits by following table:
//
// first target byte				second target byte
// src bit      target bit          src bit      target bit
// x			1			        6            1
// 1			2			        x            2
// x			3					8            3
// 3			4					x			 4
// 2			5					x			 5
// 5			6					x			 6
// 4			7 					x			 7
// 7			8					x			 8
//
// bits 1 and 3 are always zero. An ORA is used instead of an STA to leave these bits unchanged
// TODO: clear the target bits before ORA (with AND %10100000)
.macro DrawBitmapChar_OddTarget_EvenSource() {

	// First Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut1,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut1,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut1,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// Second Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut2,x	// lookup shifted font byte	
	ldy #1
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut2,x	// lookup shifted font byte	
	ldy #21
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut2,x	// lookup shifted font byte	
	ldy #41
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}

// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// two source bytes are one target byte. The "x" bits must not be touched.
//
// source:      	target:
// x 2  5 6  1 x 	1 2  5 6     
// x 4  7 8  3 x	3 4  7 8
//
// a translation table is used to translate the source to the target bits by following table:
//
// first source byte				second source byte
// src bit      target bit          src bit      target bit
// 2			1			        x            1
// 5			2			        x            2
// 4			3					x            3
// 7			4					x			 4
// 6			5					x			 5
// x			6					1			 6
// 8			7 					x			 7
// x			8					3			 8
//
// x bits are always zero. An ORA is used instead of an STA to leave these bits unchanged
// TODO: clear the target bits before ORA (with AND #0)
.macro DrawBitmapChar_EvenTarget_OddSource() {

	// First Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut3,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut3,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut3,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// Second Byte
	ldy #1
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut4,x	// lookup shifted font byte	
	ldy #0
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut4,x	// lookup shifted font byte	
	ldy #20
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut4,x	// lookup shifted font byte	
	ldy #40
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and odd source
// two source byte are two target bytes. The "x" bits must not be touched.
//
// source:      	target:
// x 2  5 6  1 x 	x 2  5 6  1 x
// x 4  7 8  3 x	x 4  7 8  3 x
//
// x bits are always zero. An ORA is used instead of an STA to leave these bits unchanged
// TODO: clear the target bits before ORA (with AND #0)
.macro DrawBitmapChar_OddTarget_OddSource() {

	// First Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	and #%01011111
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	and #%01011111
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	and #%01011111
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// Second Byte
	ldy #1
	lda (ZP2),y				// load original font byte
	and #%10100000
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21	
	lda (ZP2),y				// load original font byte
	and #%10100000
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	and #%10100000
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}


.macro DrawBitmapChar() {

	// Calc start address of char in src font
	// Load src font address to ZP2 and add offset
	clc
	lda #<font1	
	adc #5
	sta ZP2
	
	lda #>font1
	adc #0
	sta ZP2+1
	
	:DrawBitmapChar_EvenTarget_EvenSource()
	//:DrawBitmapChar_OddTarget_EvenSource()
	//:DrawBitmapChar_EvenTarget_OddSource()
	//:DrawBitmapChar_OddTarget_OddSource()
}

.macro DrawBitmapText() {

	// Load target VVRAM address to ZP1
	lda #$00
	sta ZP1
	lda #$40
	sta ZP1+1
	

	
	:DrawBitmapChar()
				
}