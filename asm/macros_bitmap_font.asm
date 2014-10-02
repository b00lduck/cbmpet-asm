
// even target and source offset 0
// "straight" case
// one source byte are two PETSCII chars, which are 4x2 VVRAM pixels
// source:      target:
// 1 2  5 6     1 2  5 6 
// 3 4  7 8     3 4  7 8
.macro DrawBitmapChar_Target0_Source0() {
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
// even target and source offset 1
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
.macro DrawBitmapChar_Target0_Source1() {

	// First Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// Second Byte
	ldy #1
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t0_b,x	// lookup shifted font byte	
	ldy #0
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t0_b,x	// lookup shifted font byte	
	ldy #20
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t0_b,x	// lookup shifted font byte	
	ldy #40
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}



// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// even target and source offset 2
// two source bytes are one target byte. The "x" bits must not be touched.
//
// source:      	target:
// x x  5 6  1 2 	1 2  5 6     
// x x  7 8  3 4	3 4  7 8
//
// a translation table is used to translate the source to the target bits by following table:
//
// first source byte				second source byte
// src bit      target bit          src bit      target bit
// 5			1			        x            1
// 6			2			        x            2
// 7			3					x            3
// 8			4					x			 4
// x			5					1			 5
// x			6					2			 6
// x			7 					3			 7
// x			8					4			 8
//
// x bits are always zero. An ORA is used instead of an STA to leave these bits unchanged
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target0_Source2() {

	// First Byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	// Second Byte
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t0_b,x	// lookup shifted font byte	
	ldy #0
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t0_b,x	// lookup shifted font byte	
	ldy #20
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t0_b,x	// lookup shifted font byte	
	ldy #40
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
		
}



// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// even target and source offset 3
// two source bytes are one target byte. The "x" bits must not be touched.
//
// source:      			target:
// x x  x 6  1 2  5 x		1 2  5 6     
// x x  x 8  3 4  7 x		3 4  7 8
//
// a translation table is used to translate the source to the target bits by following table:
//
// first source byte				second source byte
// src bit      target bit          src bit      target bit
// 6			1			        x            1
// x			2			        1            2
// 8			3					x            3
// x			4					3			 4
// x			5					2			 5
// x			6					5			 6
// x			7 					4			 7
// x			8					7			 8
//
// x bits are always zero. An ORA is used instead of an STA to leave these bits unchanged
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target0_Source3() {

	// First Byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t0_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	// Second Byte
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t0_b,x	// lookup shifted font byte	
	ldy #0
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t0_b,x	// lookup shifted font byte	
	ldy #20
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t0_b,x	// lookup shifted font byte	
	ldy #40
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
		
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
.macro DrawBitmapChar_Target1_Source0() {

	// First Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// Second Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t1_b,x	// lookup shifted font byte	
	ldy #1
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t1_b,x	// lookup shifted font byte	
	ldy #21
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t1_b,x	// lookup shifted font byte	
	ldy #41
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
.macro DrawBitmapChar_Target1_Source1() {

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

// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:        target:
// x x  5 6  1 2   x 5  6 1  2 x
// x x  7 8  3 4   x 7  8 3  4 x
//
// a translation table is used to translate the source to the target bits by following table:
//
// 1st T, 1st S						1st T, 2nd S			second target byte
// src bit      target bit      	src bit  target bit	   	src bit      target bit
// x			1			        x		 1				6	         1
// 5			2			        x		 2				x            2
// x			3					x		 3				8            3
// 7			4					x		 4	 			x			 4
// 6			5					x		 5				x			 5
// x			6					1		 6				x			 6
// 8			7 					x		 7				x			 7
// x			8					3		 8				x			 8
//
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target1_Source2() {

	// 1st target, 1st src
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	// 1st target, 2nd src
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_b,x	// lookup shifted font byte	
	ldy #0
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_b,x	// lookup shifted font byte	
	ldy #20
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_b,x	// lookup shifted font byte	
	ldy #40	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	// 2nd target, 2nd src
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t1_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram		
		
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:        		  target:
// x x  x 6  1 2  5 x     x 6  1 2  5 x  x x
// x x  x 8  3 4  7 x     x 8  3 4  7 x  x x
//
// a translation table is used to translate the source to the target bits by following table:
//
// 1st T, 1st S						1st T, 2nd S			second target byte
// src bit      target bit      	src bit  target bit	   	src bit      target bit
// x			1			        x		 1				5	         1
// 6			2			        x		 2				x            2
// x			3					x		 3				7            3
// 8			4					x		 4	 			x			 4
// x			5					1		 5				x			 5
// x			6					2		 6				x			 6
// x			7 					3		 7				x			 7
// x			8					4		 8				x			 8
//
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target1_Source3() {

	// 1st target, 1st src
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	// 1st target, 2nd src
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_b,x	// lookup shifted font byte	
	ldy #0
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_b,x	// lookup shifted font byte	
	ldy #20
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_b,x	// lookup shifted font byte	
	ldy #40	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	// 2nd target, 2nd src
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t1_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram		
		
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:      target:
// 1 2  5 6     x x  1 2  5 6  x x
// 3 4  7 8     x x  3 4  7 8  x x
//
// a translation table is used to translate the source to the target bits by following table:
//
// first target byte				second target byte
// src bit      target bit          src bit      target bit
// x			1			        5            1
// x			2			        6            2
// x			3					7            3
// x			4					8			 4
// 1			5					x			 5
// 2			6					x			 6
// 3			7 					x			 7
// 4			8					x			 8
//
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target2_Source0() {

	// First Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// Second Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t2_b,x	// lookup shifted font byte	
	ldy #1
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t2_b,x	// lookup shifted font byte	
	ldy #21	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s0_t2_b,x	// lookup shifted font byte	
	ldy #41	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:        target:
// x 2  5 6  1    x x  2 5  6 1 
// x 4  7 8  3    x x  4 7  8 3
//
// a translation table is used to translate the source to the target bits by following table:
//
// first target byte				second target byte
// src bit      target bit          src bit      target bit
// x			1			        6            1
// x			2			        1            2
// x			3					8            3
// x			4					3			 4
// 2			5					x			 5
// 5			6					x			 6
// 4			7 					x			 7
// 7			8					x			 8
//
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target2_Source1() {

	// First Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// Second Byte
	ldy #1
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t2_b,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t2_b,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda pixel_move_lut_s1_t2_b,x	// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}

// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:         target:
// x x  5 6  1 2   x x  5 6  1 2 
// x x  7 8  3 4   x x  7 8  3 4
//
.macro DrawBitmapChar_Target2_Source2() {

	// First Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	and #%11110000
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	and #%11110000
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	and #%11110000
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// Second Byte
	ldy #1
	lda (ZP2),y				// load original font byte
	and #%1111
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21
	lda (ZP2),y				// load original font byte
	and #%1111
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	and #%1111
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:        		  target:
// x x  x 6  1 2  5 x	  x x  6 1  2 5  x x 
// x x  x 8  3 4  7 x  	  x x  8 3  4 7  x x
//
// a translation table is used to translate the source to the target bits by following table:
//
// first target byte (src #1)		first target byte (src#2)		second target byte (src#2)
// src bit      target bit          src bit      target bit			src bit      target bit
// x			1			        x            1						2			1
// x			2			        x            2						5			2
// x			3					x            3						4			3
// x			4					x			 4						7			4
// 6			5					x			 5						x			5
// x			6					1			 6						x			6
// 8			7 					x			 7						x			7
// x			8					3			 8						x			8
//
.macro DrawBitmapChar_Target2_Source3() {

	// First target byte, first source byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	
	// 1st target byte, 2nd source byte
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_b,x	// lookup shifted font byte	
	ldy #0
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_b,x	// lookup shifted font byte	
	ldy #20
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_b,x	// lookup shifted font byte	
	ldy #40
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	
	// Second target byte, second source byte
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s3_t2_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram		
			
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:      target:
// 1 2  5 6     x x  x 1  2 5  6 x 
// 3 4  7 8     x x  x 3  4 7  8 x
//
// a translation table is used to translate the source to the target bits by following table:
//
// first target byte				second target byte
// src bit      target bit          src bit      target bit
// x			1			        2            1			
// x			2			        5            2			
// x			3					4            3			
// x			4					7			 4			
// x			5					6			 5			
// 1			6					x			 6			
// x			7 					8			 7			
// 3			8					x			 8			
//
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target3_Source0() {

	// First target byte, first source byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s0_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s0_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s0_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	
	// Second target byte, first source byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s0_t3_b,x	// lookup shifted font byte	
	ldy #1
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s0_t3_b,x	// lookup shifted font byte	
	ldy #21
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s0_t3_b,x	// lookup shifted font byte	
	ldy #41
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
				
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:        target:
// x 2  5 6  1    x x  x 2  5 6  1 x 
// x 4  7 8  3    x x  x 4  7 8  3 x
//
// a translation table is used to translate the source to the target bits by following table:
//
// first target byte				second target byte (src#1)		second target byte (src#2)
// src bit      target bit          src bit      target bit			src bit      target bit
// x			1			        5            1						x			1
// x			2			        6            2						x			2
// x			3					7            3						x			3
// x			4					8			 4						x			4
// x			5					x			 5						1			5
// x			6					x			 6						x			6
// 2			7 					x			 7						3			7
// 4			8					x			 8						x			8
//
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target3_Source1() {

	// First target byte, first source byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	
	// Second target byte, first source byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t2_b,x	// lookup shifted font byte	
	ldy #1
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t2_b,x	// lookup shifted font byte	
	ldy #21
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t2_b,x	// lookup shifted font byte	
	ldy #41
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	
	// Second target byte, second source byte
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t2_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t2_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s1_t2_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram		
			
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:         target:
// x x  5 6  1 2   x x  x 5  6 1  2 x 
// x x  7 8  3 3   x x  x 7  8 3  4 x
//
// a translation table is used to translate the source to the target bits by following table:
//
// first target byte				second target byte (src#1)		second target byte (src#2)
// src bit      target bit          src bit      target bit			src bit      target bit
// x			1			        6            1						x			1
// x			2			        x            2						1			2
// x			3					8            3						x			3
// x			4					x			 4						3			4
// x			5					x			 5						2			5
// 5			6					x			 6						x			6
// x			7 					x			 7						4			7
// 7			8					x			 8						x			8
//
// TODO: clear the target bits before ORA
.macro DrawBitmapChar_Target3_Source2() {

	// First target byte, first source byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_a,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	
	// Second target byte, first source byte
	ldy #0
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_b,x	// lookup shifted font byte	
	ldy #1
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_b,x	// lookup shifted font byte	
	ldy #21
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_b,x	// lookup shifted font byte	
	ldy #41
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	
	// Second target byte, second source byte
	ldy #1
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #21
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #41
	lda (ZP2),y						// load original font byte
	tax								// copy it to x
	lda pixel_move_lut_s2_t3_c,x	// lookup shifted font byte	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram		
			
}


// Current VVRAM target address (left upper corner of char) in ZP1
// Font address in ZP2
// Char to draw in AC
// odd target and even source
// one source byte is two output bytes. The "x" bits must not be touched.
//
// source:              target:
// x x  x 6  1 2  5 x   x x  x 6  1 2  5 x 
// x x  x 8  3 4  7 x   x x  x 8  3 4  7 x
//
.macro DrawBitmapChar_Target3_Source3() {

	// First target byte, first source byte
	ldy #0
	lda (ZP2),y						// load original font byte
	and #%11000000
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20	
	lda (ZP2),y						// load original font byte
	and #%11000000	
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	and #%11000000
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	
	// Second  byte
	ldy #1
	lda (ZP2),y						// load original font byte
	and #%00111111
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram
	
	ldy #20
	lda (ZP2),y						// load original font byte
	and #%00111111
	ldy #21
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram	
	
	ldy #40
	lda (ZP2),y						// load original font byte
	and #%00111111
	ldy #41
	ora (ZP1),y						// store to vram
	sta (ZP1),y						// store to vram				
}


// determine x pixel offset of the desired character in the source bitmap
// choose one of the DrawBitmapChar macros depending on the modulo of the offset
// deliver char id in accumulator!
.macro DrawBitmapChar() {
		
		sta ZP10	// save char id in ZP10
		
		ldx #4 		// multipicator minus one	
		mul:		// multiplicate with 5
			clc
			adc ZP10
			dex
			bne mul
						
		sta ZP11	// store offset in vvram pixels in zp11	
		lsr			// divide by 2
		lsr			// divide by 2 again
		sta ZP12	// store "offset / 4" in ZP12
		
		
		// Load font address to ZP2
		clc
		lda #<font1
		adc ZP12
		sta ZP2
		lda #>font1
		adc #0
		sta ZP2+1		
		
		
		// choose one of the DrawBitmapChar macros depending on the modulo of the offset		
		lda ZP11	// load offset
		and #%11	// "offset % 4"
		
		bne !+
		:DrawBitmapChar_Target2_Source0()
		jmp weiter
	
	!:	cmp #1
		bne !+
		:DrawBitmapChar_Target2_Source1()
		jmp weiter
		
	!:	cmp #2
		bne !+
		:DrawBitmapChar_Target2_Source2()
		jmp weiter

	!:	:DrawBitmapChar_Target2_Source3()

	weiter:
	
}

.macro DrawBitmapText() {

	// Load target VVRAM address to ZP1
	lda #$00
	sta ZP1
	lda #$40
	sta ZP1+1
	
	lda #2
	:DrawBitmapChar()
	
	// Load target VVRAM address to ZP1
	lda #$02
	sta ZP1
	lda #$40
	sta ZP1+1
	
	lda #15
	:DrawBitmapChar()	
	
	// Load target VVRAM address to ZP1
	lda #$04
	sta ZP1
	lda #$40
	sta ZP1+1
	
	lda #15
	:DrawBitmapChar()		
					
}