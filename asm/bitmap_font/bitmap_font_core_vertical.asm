


.macro VerticalMove_0000() {
	lda (ZP1),y	
	sta (ZP2),y	

	// add 22 to y
	tya
	clc
	adc #22
	tay

	lda (ZP1),y	
	sta (ZP2),y	

	// add 22 to y
	tya
	clc
	adc #22
	tay

	lda (ZP1),y	
	sta (ZP2),y	
	
	rts
}

// 1 2 5 x
// 3 4 7 6
// x x x 8
// x x x x
.macro VerticalMove_0001() {
	:VerticalMove(vertical_move_lut_0001_a, vertical_move_lut_0001_b)
	rts
}

// 1 2 x 6
// 3 4 5 8
// x x 7 x
// x x x x
.macro VerticalMove_0010() {
	:VerticalMove(vertical_move_lut_0010_a, vertical_move_lut_0010_b)
	rts
}

// 1 2 x x
// 3 4 5 6
// x x 7 8
// x x x x
.macro VerticalMove_0011() {
	:VerticalMove(vertical_move_lut_0011_a, vertical_move_lut_0011_b)
	rts
}

// 1 x 5 6
// 3 2 7 8
// x 4 x x
// x x x x
.macro VerticalMove_0100() {
	:VerticalMove(vertical_move_lut_0100_a, vertical_move_lut_0100_b)	
	rts
}

// 1 x 5 x
// 3 2 7 6
// x 4 x 8
// x x x x
.macro VerticalMove_0101() {
	:VerticalMove(vertical_move_lut_0101_a, vertical_move_lut_0101_b)
	rts
}

// 1 x x 6
// 3 2 5 8
// x 4 7 x
// x x x x
.macro VerticalMove_0110() {
	:VerticalMove(vertical_move_lut_0110_a, vertical_move_lut_0110_b)
	rts
}

// 1 x x x
// 3 2 5 6
// x 4 7 8
// x x x x
.macro VerticalMove_0111() {
	:VerticalMove(vertical_move_lut_0111_a, vertical_move_lut_0111_b)
	rts
}

// x 2 5 6
// 1 4 7 8
// 3 x x x
// x x x x
.macro VerticalMove_1000() {
	:VerticalMove(vertical_move_lut_1000_a, vertical_move_lut_1000_b)
	rts
}

// x 2 5 x
// 1 4 7 6
// 3 x x 8
// x x x x
.macro VerticalMove_1001() {
	:VerticalMove(vertical_move_lut_1001_a, vertical_move_lut_1001_b)
	rts
}

// x 2 x 6
// 1 4 5 8
// 3 x 7 x
// x x x x
.macro VerticalMove_1010() {
	:VerticalMove(vertical_move_lut_1010_a, vertical_move_lut_1010_b)
	rts
}

// x 2 x x
// 1 4 5 6
// 3 x 7 8
// x x x x
.macro VerticalMove_1011() {
	:VerticalMove(vertical_move_lut_1011_a, vertical_move_lut_1011_b)
	rts
}

// x x 5 6
// 1 2 7 8
// 3 4 x x
// x x x x
.macro VerticalMove_1100() {
	:VerticalMove(vertical_move_lut_1100_a, vertical_move_lut_1100_b)	
	rts
}

// x x 5 x
// 1 2 7 6
// 3 4 x 8
// x x x x
.macro VerticalMove_1101() {
	:VerticalMove(vertical_move_lut_1101_a, vertical_move_lut_1101_b)
	rts
}

// x x x 6
// 1 2 5 8
// 3 4 7 x
// x x x x
.macro VerticalMove_1110() {
	:VerticalMove(vertical_move_lut_1110_a, vertical_move_lut_1110_b)
	rts
}

// x x x x
// 1 2 5 6
// 3 4 7 8
// x x x x
.macro VerticalMove_1111() {
	:VerticalMove(vertical_move_lut_1111_a, vertical_move_lut_1111_b)
	rts
}

// y must be the byte offset for src and target
.macro VerticalMove(LUT_A, LUT_B) {	
	:VerticalMoveOneLine(LUT_A, LUT_B)
	:VerticalMoveOneLine(LUT_A, LUT_B)
	:VerticalMoveOneLine(LUT_A, LUT_B)
}

.macro VerticalMoveOneLine(LUT_A, LUT_B) {
	
// ERSTE ZEILE
	
	lda (ZP1),y	
	tax		
	lda LUT_A,x		
	ora (ZP2),y	
	sta (ZP2),y

	// add 22 to y
	tya
	clc
	adc #22
	tay
	
	lda LUT_B,x		
	ora (ZP2),y	
	sta (ZP2),y		
	
}