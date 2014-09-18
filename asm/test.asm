.const BASIC=$0401
.const MAIN=$040d

.const ZP1=$00e0

.const ZP10=$00f0

.pc = BASIC "Basic upstart" {
	:BasicUpstart(MAIN)
}


.pc = MAIN "Main code" {

		:clearScreen()
		
		lda #$0e
		sta $e84c		
		
		// Load start address to ZP1
		lda #$00
		sta ZP1
		lda #$80
		sta ZP1+1
		
		// Set ZP10 to 0 = down (1 = up)
		lda #0
		sta ZP10
		
	loop:
		lda ZP10
		bne up
	
	down:
		// Add $28 to ZP1
		clc
		lda ZP1
		adc #$28
		sta ZP1
		bcc !+
		inc ZP1+1
	!:	
		lda #$c0  // $83c0
		cmp ZP1
		bne !+
		lda #$83 
		cmp ZP1+1
		bne !+
			
		lda #1
		sta ZP10
	
	!:	jmp draw
	
	up:
		// Substract $28 from ZP1
		sec
		lda ZP1
		sbc #$28
		sta ZP1
		bcs !+
		dec ZP1+1
	!:	
		lda #$00  // $8000
		cmp ZP1
		bne !+
		lda #$80 
		cmp ZP1+1
		bne !+
			
		lda #0
		sta ZP10
	
	!:	jmp draw	
	
	draw:
	
		:clearScreen()
						
		:helloWorld()		
		
		ldy #$ff
	brake:
		nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop 
		nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop nop
		dey
		bne brake
		
		jmp loop

				
				
	hello:
		.text "Hello, world!"
		.byte 0
	
}	


.macro helloWorld() {

		lda #$0	
		ldy #$0
	
	loop:			
		lda hello,y		
		beq quit		
		sta (ZP1),y				
		iny
		bne loop
	quit:
	
}


.macro clearScreen() {

		lda #$20	
		ldy #$00
	
	loop:	
		iny
		sta $8000,y
		sta $8100,y
		sta $8200,y
		sta $82e9,y		
		bne loop

}

/*
	rts

	$0000
		ZERO PAGE
	$0100
		STACK
	$01ff 
	
	$0401 
		BASIC RAM
		
		
		RAM	
		
		
		
	$7fff
	
	$8000
		VRAM
	$83E8
	
	
	$fffa
	$fffb	
	
	$fffc 
	$fffd
	
	$fffe
	$ffff
	
	ABCDEFGH
	    EFGH
	
	xxxxxxx xxxxxxx
	xA xB x xE xF x
    xxxxxxx	xxxxxxx
	xC xD x xG xH x
    xxxxxxx	xxxxxxx
	
	
	
*/