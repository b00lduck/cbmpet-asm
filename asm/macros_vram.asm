// Draw outer box
// uses ACC, X, Y
// ZP1, ZP2
.macro DrawOuterBox(char) {	
	
	// Draw horizontal lines
	:loadToZP(ZP1, VRAM)
	:loadToZP(ZP2, VRAM + $03C0)
		
	lda char	
	ldy #$28
	hloop:				
		dey
		sta (ZP1),y	
		sta (ZP2),y			
		bne hloop
	
	// Draw vertical lines
	:loadToZP(ZP1, VRAM + $0028)	
	
	// Vertical lines			
	ldx #23
	ldy #0			
	vloop:				
		
		sta (ZP1),y		
		:addToZP8(ZP1, $27)
		
		sta (ZP1),y
		:addToZP8(ZP1, $01)
		
		dex
		bne vloop
		
}






// fill the screen with character 'clearByte'
.macro FillScreen(clearByte) {
		lda #clearByte
		ldx #$00
	loop:
		.for(var i = 0; i < 3; i++) {
			sta VRAM + [i * $0100], x
		}
		sta VRAM + [$02e8], x
		inx
		bne loop
}