// Bitmap font core macros

.macro MaskTarget0() {
	:MaskTargetByte(1,%01011111)
}

.macro MaskTarget1() {
	:MaskTargetByte(0,%10100000)
	:MaskTargetByte(1,%00001111)	
}

.macro MaskTarget2() {
	:MaskTargetByte(0,%11110000)
	:MaskTargetByte(1,%00000101)	
}

.macro MaskTarget3() {
	:MaskTargetByte(0,%11111010)
	:MaskTargetByte(1,%00000000)	
}

/* Offsets: Source 0, Target 0
   "straight" case
   one source byte are two PETSCII chars, which are 4x2 VVRAM pixels
   source:      target:
   1 2  5 6     1 2  5 6 
   3 4  7 8     3 4  7 8
*/
.macro DrawBitmapChar_Source0_Target0() {

	:MaskTarget0()
	
	ldy #0
	lda (ZP2),y
	sta (ZP1),y
	
	ldy #20
	lda (ZP2),y
	sta (ZP1),y
	
	ldy #40
	lda (ZP2),y
	sta (ZP1),y
	
	rts
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
	:MaskTarget1()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s0_t1_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s0_t1_b)		
	rts
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
	:MaskTarget2()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s0_t2_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s0_t2_b)	
	rts	
}

/* Offsets: Source 0, Target 3
// source:      target:
// 1 2  5 6     x x  x 1 | 2 5  6 x 
// 3 4  7 8     x x  x 3 | 4 7  8 x
//
// 1st target byte				2nd target byte
// src bit      target bit          src bit      target bit
//  			1			        2            1			
//  			2			        5            2			
//  			3					4            3			
//  			4					7			 4			
//  			5					6			 5			
// 1			6					 			 6			
//  			7 					8			 7			
// 3			8					 			 8			
*/
.macro DrawBitmapChar_Source0_Target3() {
	:MaskTarget3()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s0_t3_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s0_t3_b)	
	rts
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
	:MaskTarget0()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s1_t0_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s1_t0_b)
	rts	
}

/* Offsets: Source 1, Target 1
   source:      	target:
   x 2  5 6  A x 	x 2  5 6  A x
   x 4  7 8  B x	x 4  7 8  B x
*/
.macro DrawBitmapChar_Source1_Target1() {
	:MaskTarget1()
	:BitTranslator_Masking(%01011111)
	rts
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
	:MaskTarget2()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s1_t2_a)
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s1_t2_b)
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s1_t2_c)	
	rts	
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
	:MaskTarget3()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s1_t3_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s1_t3_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s1_t3_c)	
	rts
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
	:MaskTarget0()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s2_t0_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s2_t0_b)		
	rts
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
	:MaskTarget1()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s2_t1_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s2_t1_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s2_t1_c)
	rts	
}

/* Offsets: Source 2, Target 2
// source:         target:
// x x  5 6  1 2   x x  5 6  1 2 
// x x  7 8  3 4   x x  7 8  3 4
*/
.macro DrawBitmapChar_Source2_Target2() {
	:MaskTarget2()
	:BitTranslator_Masking(%00001111)
	rts
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
	:MaskTarget3()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s2_t3_a)	
	:BitTranslator_1st_src_2nd_target(pixel_move_lut_s2_t3_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s2_t3_c)
	rts	
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
	:MaskTarget0()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s3_t0_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s3_t0_b)
	rts	
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
	:MaskTarget1()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s3_t1_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s3_t1_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s3_t1_c)
	rts	
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
	:MaskTarget2()
	:BitTranslator_1st_src_1st_target(pixel_move_lut_s3_t2_a)	
	:BitTranslator_2nd_src_1st_target(pixel_move_lut_s3_t2_b)	
	:BitTranslator_2nd_src_2nd_target(pixel_move_lut_s3_t2_c)
	rts
}

// source:                  target:
// x x  x 6  | A B  E x     x x  x 6  | A B  E x 
// x x  x 8  | C D  G x     x x  x 8  | C D  G x
.macro DrawBitmapChar_Source3_Target3() {
	:MaskTarget3()
	:BitTranslator_Masking(%00000101)
	rts	
}





// Take 1st src byte, translate it via given lookup table, and write the result to the 1st target byte
.macro BitTranslator_1st_src_1st_target(LUT_TABLE) {	
	:BitTranslator_Case1(0,LUT_TABLE)
}

// Take 1st src byte, translate it via given lookup table, and write the result to the 2nd target byte
.macro BitTranslator_1st_src_2nd_target(LUT_TABLE) {	
	:BitTranslator_Case2(0,1,LUT_TABLE)
}

// Take 2nd src byte, translate it via given lookup table, and write the result to the 1st target byte
.macro BitTranslator_2nd_src_1st_target(LUT_TABLE) {
	:BitTranslator_Case2(1,0,LUT_TABLE)
}

// Take 2nd src byte, translate it via given lookup table, and write the result to the 2nd target byte
.macro BitTranslator_2nd_src_2nd_target(LUT_TABLE) {
	:BitTranslator_Case1(1,LUT_TABLE)
}

.macro BitTranslator_Case1(DELTA, LUT_TABLE) {
	ldy #DELTA
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// add
	sta (ZP1),y				// store to vram
	
	ldy #DELTA+20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// add
	sta (ZP1),y				// store to vram	
	
	ldy #DELTA+40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ora (ZP1),y				// add
	sta (ZP1),y				// store to vram	
}

.macro BitTranslator_Case2(DELTA1, DELTA2, LUT_TABLE) {	
	ldy #DELTA1
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #DELTA2
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #DELTA1+20	
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #DELTA2+20	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #DELTA1+40
	lda (ZP2),y				// load original font byte
	tax						// copy it to x
	lda LUT_TABLE,x			// lookup shifted font byte	
	ldy #DELTA2+40	
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
}

.macro BitTranslator_Masking(MASK_A) {

	.var MASK_I = 255-MASK_A

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
	and #MASK_I
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram
	
	ldy #21	
	lda (ZP2),y				// load original font byte
	and #MASK_I
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
	
	ldy #41
	lda (ZP2),y				// load original font byte
	and #MASK_I
	ora (ZP1),y				// store to vram
	sta (ZP1),y				// store to vram	
		
}

.macro MaskTargetByte(OFS, MASK) {
	ldy #OFS
	lda (ZP1),y
	and #MASK
	sta (ZP1),y
	
	ldy #OFS+20
	lda (ZP1),y
	and #MASK
	sta (ZP1),y

	ldy #OFS+40
	lda (ZP1),y
	and #MASK
	sta (ZP1),y

	
}