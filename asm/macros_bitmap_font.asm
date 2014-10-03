/* Offsets: Source 0, Target 0
   "straight" case
   one source byte are two PETSCII chars, which are 4x2 VVRAM pixels
   source:      target:
   1 2  5 6     1 2  5 6 
   3 4  7 8     3 4  7 8
*/
.macro DrawBitmapChar_Source0_Target0() {
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

/*  Offsets: Source 0, Target 1
   source:      target:
   1 2  5 6     x 1  2 5 | 6 x 
   3 4  7 8     x 3  4 7 | 8 x

   1st target byte					2nd target byte
   src bit      target bit          src bit      target bit
    			1			        6            1
   1			2			                     2
    			3					8            3
   3			4					 			 4
   2			5					 			 5
   5			6					 			 6
   4			7 					 			 7
   7			8					 			 8
*/  
.macro DrawBitmapChar_Source0_Target1() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s0_t1_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s0_t1_b)		
}

/* Offsets: Source 0, Target 2
   source:      target:
   1 2  5 6     x x  1 2 | 5 6  x x
   3 4  7 8     x x  3 4 | 7 8  x x
  
   1st target byte				2nd target byte
   src bit      target bit          src bit      target bit
   x			1			        5            1
   x			2			        6            2
   x			3					7            3
   x			4					8			 4
   1			5					x			 5
   2			6					x			 6
   3			7 					x			 7
   4			8					x			 8
*/
.macro DrawBitmapChar_Source0_Target2() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s0_t2_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s0_t2_b)		
}

/* Offsets: Source 0, Target 3
// source:      target:
// 1 2  5 6     x x  x 1  2 5  6 x 
// 3 4  7 8     x x  x 3  4 7  8 x
//
// 1st target byte				2nd target byte
// src bit      target bit          src bit      target bit
// x			1			        2            1			
// x			2			        5            2			
// x			3					4            3			
// x			4					7			 4			
// x			5					6			 5			
// 1			6					x			 6			
// x			7 					8			 7			
// 3			8					x			 8			
*/
.macro DrawBitmapChar_Source0_Target3() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s0_t3_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s0_t3_b)	
}

/* Offsets: Source 1, Target 0
   source:      	target:
   x 2  5 6 | A x 	2 5  6 A     
   x 4  7 8 | C x	4 7  8 C
   (source bits are notated)
  
   1st source byte				2nd source byte
   src bit      target bit      src bit      target bit
   2			1			                 1
   5			2			                 2
   4			3				 	         3
   7			4				 			 4
   6			5				 			 5
    			6				A(1)   		 6
   8			7 				 			 7
    			8				C(3)		 8
*/
.macro DrawBitmapChar_Source1_Target0() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s1_t0_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s1_t0_b)			
}

/* Offsets: Source 1, Target 1
   source:      	target:
   x 2  5 6  A x 	x 2  5 6  A x
   x 4  7 8  B x	x 4  7 8  B x
*/
.macro DrawBitmapChar_Source1_Target1() {
	:BitTranslator_Masking(%01011111,%10100000)
}

/* Offsets: Source 1, Target 2 
   source:                target:
   x 2  5 6 | A x  x x    x x  2 5 | 6 A  x x 
   x 4  7 8 | C x  x x    x x  4 7 | 8 C  x x
  
   (A) 1st target byte			(B) 2nd target byte (1st src byte)	(C) 2nd target byte (2st src byte)		
   src bit      target bit          src bit      target bit				src bit      target bit
    			1			        6            1						 			 1
    			2			                     2 	                    A(1)         2
    			3					8            3  					 			 3
    			4					 			 4                      C(3)         4
   2			5					 			 5						 			 5
   5			6					 			 6						 			 6
   4			7 					   		 	 7						 			 7
   7			8					   		 	 8						 			 8
*/
.macro DrawBitmapChar_Source1_Target2() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s1_t2_a)
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s1_t2_b)
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s1_t2_c)		
}

/* Offsets: Source 1, Target 3
// source:           target:
// x 2  5 6  | A x   x x  x 2 | 5 6  A x 
// x 4  7 8  | C x   x x  x 4 | 7 8  C x
//
// 1st target byte				2nd target byte (src#1)		2nd target byte (src#2)
// src bit      target bit          src bit      target bit			src bit      target bit
//  			1			        5            1						 			1
//  			2			        6            2						 			2
//  			3					7            3						 			3
//  			4					8			 4						 			4
//  			5					 			 5						A(1)		5
// 2			6					 			 6						 			6
//  			7 					 			 7						C(3)		7
// 4			8					 			 8						 			8
*/
.macro DrawBitmapChar_Source1_Target3() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s1_t3_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s1_t3_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s1_t3_c)	
}

/* Offsets: Source 2, Target 0
   source:      	target:
   x x  5 6  A B 	5 6  A B     
   x x  7 8  C D	7 8  C D
   (source bits are notated)
  
   1st source byte				2nd source byte
   src bit      target bit      src bit      target bit
   5			1			                 1
   6			2			                 2
   7			3				             3
   8			4				 			 4
    			5				A(1)		 5
    			6				B(2)		 6
				7 				C(3)		 7
				8				D(4)		 8
*/
.macro DrawBitmapChar_Source2_Target0() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s2_t0_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s2_t0_b)		
}

/* Offsets: Source 2, Target 1
   source:          target:
   x x  5 6 | A B   x 5  6 A | B x
   x x  7 8 | C D   x 7  8 C | D x
  
   1st T, 1st S						1st T, 2nd S			2nd target byte
   src bit      target bit      	src bit  target bit	   	src bit      target bit
    			1			         		 1				B(2)         1
   5			2			         		 2				             2
    			3					 		 3				D(4)         3
   7			4					 		 4	 			 			 4
   6			5					 		 5				 			 5
    			6					A(1)	 6				 			 6
   8			7 					 		 7				 			 7
    			8					C(3) 	 8				 			 8

*/
.macro DrawBitmapChar_Source2_Target1() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s2_t1_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s2_t1_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s2_t1_c)	
}

/* Offsets: Source 2, Target 2
// source:         target:
// x x  5 6  1 2   x x  5 6  1 2 
// x x  7 8  3 4   x x  7 8  3 4
*/
.macro DrawBitmapChar_Source2_Target2() {
	:BitTranslator_Masking(%00001111, %11110000)
}

// source:         target:
// x x  5 6  |  A B   x x  x 5  |  6 A  B x 
// x x  7 8  |  C D   x x  x 7  |  8 C  D x
//
// 1st target byte					2nd target byte (src#1)		    2nd target byte (src#2)
// src bit      target bit          src bit      target bit			src bit     target bit
//  			1			        6            1					 			1
//  			2			                     2					A(1)		2
//  			3					8            3					 			3
//  			4					 			 4					C(3)		4
//  			5					 			 5					B(2)		5
// 5			6					 			 6					 			6
//  			7 					 			 7					D(4)		7
// 7			8					 			 8					 			8
.macro DrawBitmapChar_Source2_Target3() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s2_t3_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s2_t3_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s2_t3_c)				
}

/*  Offsets: Source 3, Target 0
   source:      			target:
   x x  x 6  A B  E x		6 A  B E     
   x x  x 8  C D  G x		8 C  D G

   1st source byte					2nd source byte
   src bit      target bit          src bit      target bit
   6			1			                     1
    			2			        A(1)         2
   8			3					             3
    			4					C(3)		 4
    			5					B(2)		 5
    			6					E(5)		 6
    			7 					D(4)		 7
    			8					G(7)		 8
*/
.macro DrawBitmapChar_Source3_Target0() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s3_t0_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s3_t0_b)			
}

/*
   source:        		   target:
   x x  x 6 | A B  E x     x 6  A B | E x  x x
   x x  x 8 | C D  G x     x 8  C D | G x  x x
  
   1st T, 1st S						1st T, 2nd S			2nd target byte
   src bit      target bit      	src bit  target bit	   	src bit      target bit
    			1			         		 1				5	         1
   6			2			         		 2				             2
    			3					 		 3				7            3
   8			4					 		 4	 			 			 4
    			5					1		 5				 			 5
    			6					2		 6				 			 6
    			7 					3		 7				 			 7
    			8					4		 8				 			 8

*/ 
.macro DrawBitmapChar_Source3_Target1() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s3_t1_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s3_t1_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s3_t1_c)		
}

/*
// source:        		  target:
// x x  x 6 | A B  E x	  x x  6 A | B E  x x 
// x x  x 8 | C D  G x    x x  8 C | D G  x x
//
// 1st target byte (src #1)		1st target byte (src#2)		2nd target byte (src#2)
// src bit      target bit          src bit      target bit			src bit      target bit
//  			1			                     1						B(2)		1
//  			2			                     2						E(5)		2
//  			3					             3						D(4)		3
//  			4					 			 4						G(7)		4
// 6			5					 			 5						 			5
//  			6					A(1) 		 6						 			6
// 8			7 					 			 7						 			7
//  			8					C(3)		 8						 			8
*/
.macro DrawBitmapChar_Source3_Target2() {
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s3_t2_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s3_t2_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s3_t2_c)		
}

// source:                  target:
// x x  x 6  | A B  E x     x x  x 6  | A B  E x 
// x x  x 8  | C D  G x     x x  x 8  | C D  G x
.macro DrawBitmapChar_Source3_Target3() {
	:BitTranslator_Masking(%00000101, %11111010)			
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
		:DrawBitmapChar_Source0_Target0()
		jmp weiter
	
	!:	cmp #1
		bne !+
		:DrawBitmapChar_Source1_Target0()
		jmp weiter
		
	!:	cmp #2
		bne !+
		:DrawBitmapChar_Source2_Target0()
		jmp weiter

	!:	:DrawBitmapChar_Source3_Target0()

	weiter:
	
}

.macro DrawBitmapText() {

	// Load target VVRAM address to ZP1
	lda #<VVRAM
	sta ZP1
	lda #>VVRAM
	sta ZP1+1
	
	lda #4
	:DrawBitmapChar()
	
	lda #%10011001	
	sta VVRAM + $50
	sta VVRAM + $51
	sta VVRAM + $52
	
	

					
}




// Take 1st src byte, translate it via given lookup table, and write the result to the 1st target byte
.macro BitTranslator_1st_src_1st_target(LUT_TABLE) {
	
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// add
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// add
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// add
	sta (ZP1),y				// store to vram	
}

// Take 1st src byte, translate it via given lookup table, and write the result to the 2nd target byte
.macro BitTranslator_1st_src_2nd_target(LUT_TABLE) {
	
	ldy #0
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #1
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #21	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #41	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
}

// Take 2nd src byte, translate it via given lookup table, and write the result to the 1st target byte
.macro BitTranslator_2nd_src_1st_target(LUT_TABLE) {
	
	ldy #1
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #0
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #20	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #40	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
}

// Take 2nd src byte, translate it via given lookup table, and write the result to the 2nd target byte
.macro BitTranslator_2nd_src_2nd_target(LUT_TABLE) {
	
	ldy #1
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
}

.macro BitTranslator_Masking(MASK_A, MASK_B) {

	// 1st Byte
	ldy #0
	lda (ZP2),y				// load original font byte
	and #MASK_A
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #20	
	lda (ZP2),y				// load original font byte
	and #MASK_A
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #40
	lda (ZP2),y				// load original font byte
	and #MASK_A
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	// 2nd Byte
	ldy #1
	lda (ZP2),y				// load original font byte
	and #MASK_B
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21	
	lda (ZP2),y				// load original font byte
	and #MASK_B
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	and #MASK_B
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}