/**
 * Set the interrupt vector to 'addr' and store the original value to 'orig_isr'
 * no regs changed
 */
.macro InstallIsr(addr) {
	sei
	pha
	// save original isr
	lda ZP_ISR
	sta orig_isr
	lda ZP_ISR + 1
	sta orig_isr + 1
	
	// set new isr
	lda #<addr
	sta ZP_ISR
	lda #>addr
	sta ZP_ISR + 1
	pla
	cli
}

/**
 * Restore the interrupt vector to the old value from 'orig_isr'
 * no regs changed
 */
.macro RestoreIsr() {
	sei
	pha
	lda orig_isr
	sta ZP_ISR
	lda orig_isr + 1
	sta ZP_ISR + 1
	pla
	cli
}

// In-Place add of an 8-Bit value to an address pointer in the ZeroPage
.macro addToZP8(addr, val) {
	pha           // push acc to stack	
	
    clc           // Ensure carry is clear
    lda addr      // Add the least significant address byte
    adc #val	  // Add $28 with carry	
    sta addr      // store the result
		
    lda addr + 1  // Add the most significant byte
    adc #$00      // add propagated carry bit
    sta addr + 1  // store the result
	
	pla			  // pull acc from stack
} 

// Load address into ZeroPage at offset	
// no regs changed
.macro loadToZP(addr, value) {
	pha			// push acc to stack	
	tya
	pha
	
	// high byte
	lda #<value   	
	sta addr	
		
	// low byte	
	ldy #$01	
	lda #>value	
	sta addr, y
		
	pla
	tay
	pla			// pull acc from stack
}

// switch to upeprcase/lowercase mode
.macro SwitchLowercase() {		
	pha
	lda #$0e
	sta $e84c
	pla
}

// switch to uppercase/graphics mode
.macro SwitchGraphics() {		
	pha
	lda #$0c
	sta $e84c
	pla
}

// draw text without clipping
.macro DrawText(tx, ty, text, len) {

		pha
				
		.var addr = VRAM + tx + ty * 40		
		
		ldx #$00
	loop:
		lda text, x
		sta addr, x
		inx
		cpx #len
		bne loop
		
		pla
}

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

.macro DrawVVramLineV2() {
	
		// offset counter
		lda #0
		sta ZP4
		
		ldx #0
		
	loop:	
	
		ldy #1
	
		a1:	
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
			jmp e1
			
		b2:
			lda (ZP1),y		// 6		
			bne c4
			
		c3:
			lda (ZP2,x)		// 5
			bne d6
			
		d5: 
			lda (ZP2),y		// 6
			bne e10
			jmp e9
			
		c2:
			lda (ZP2,x)		// 5
			bne d4
			
		d3: 
			lda (ZP2),y		// 6
			bne e6
			jmp e5
			
		c4:
			lda (ZP2,x)		// 5
			bne d8
		
		d7:
			lda (ZP2),y		// 6
			bne e14
			jmp e13
			
		d2:
			lda (ZP2),y		// 6
			bne e4
			jmp e3
			
		d4: 
			lda (ZP2),y		// 6
			bne e8
			jmp e7
			
		d6:
			lda (ZP2),y		// 6
			bne e12
			jmp e11

		d8:
			lda (ZP2),y		// 6
			bne e16
			jmp e15	
		
		e1:	 lda #32   jmp draw		
		e2:	 lda #108  jmp draw
		e3:	 lda #123  jmp draw		
		e4:	 lda #98   jmp draw
		e5:	 lda #124  jmp draw		
		e6:	 lda #225  jmp draw
		e7:	 lda #255  jmp draw		
		e8:	 lda #254  jmp draw
		e9:	 lda #126  jmp draw		
		e10: lda #127  jmp draw
		e11: lda #97   jmp draw		
		e12: lda #252  jmp draw
		e13: lda #226  jmp draw		
		e14: lda #251  jmp draw
		e15: lda #236  jmp draw
		e16: lda #160  jmp draw
			
	draw:
	
		// y is teh value to draw, copy it from acc		
		//tay		
		
		//lda gfxtable,y
		
		ldy	ZP4
		sta (ZP3),y

		// Draw 1 lines of real screen memory (40 chars)
		inc ZP4
		lda ZP4
		cmp #$28
		beq end
		
		
		:IncZp8(ZP1,$02)
		:IncZp8(ZP2,$02)
		
		
		jmp loop
		
		
		end:
	
}


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
	
	lda #$A0
	sta ZP3
	
	clc

	.for(var i = 0; i < 15; i++) {

		//:DrawVVramLine()
		:DrawVVramLineV2()
	
		:IncZp8(ZP1,$52)
		:IncZp8(ZP2,$52)
		:IncZp8(ZP3,$28)

	}

}

// Increments ZP address 
// Affects: Z
.macro IncZp(addr) {
	inc addr		// increment ZP1
	bne end  		// if ZP1 is zero, increment high byte
	inc addr+1		
	end:
}

/**
 * Increments ZP address by $28
  * Affects: CARRY,AC
 */
.macro IncZp8(addr, val) {	
	clc
	lda addr
	adc #val
	sta addr
	bcc end
	clc
	inc addr+1
	end:
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

// draw zero terminated text
.macro DrawTextZt(tx, ty, text) {
		pha				
		.var addr = VRAM + tx + ty * 40				
		ldx #$00
	loop:
		lda text, x		
		cmp #$00
		beq end
		sta addr, x
		inx		
		jmp loop	

	end:		
		pla
}

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

//reads one byte from the source address and writes two bytes to the target address
.macro ItoA(target, source) {
	pha
	lda source				
	lsr
	lsr
	lsr
	lsr
	ora #'0'
	sta target
	lda source				
	and #$0f
	ora #'0'
	sta target + 1		
	pla
}

// clear the screen
.macro ClearScreen() {
	:FillScreen($20)
}

// clear hove via ROM call
.macro ClearHome() {
    lda #$93    
    jsr $ffd2	
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

.macro DisplayHexWord(addr,vram) {
		
	// DIGIT 4		
	lda addr
	and #$0f		
	sed             
	clc
	adc #$90        // Produce $90-$99 (C=0) or $00-$05 (C=1)
	adc #$40        // Produce $30-$39 or $41-$46
	cld             				
	sta vram+3

	
	// DIGIT 3
	lda addr
	and #$f0
	clc
	ror
	ror
	ror
	ror
	sed             
	clc
	adc #$90        // Produce $90-$99 (C=0) or $00-$05 (C=1)
	adc #$40        // Produce $30-$39 or $41-$46
	cld             				
	sta vram+2		
	
	
	// DIGIT 2	
	lda addr+1
	and #$0f		
	sed             
	clc
	adc #$90        // Produce $90-$99 (C=0) or $00-$05 (C=1)
	adc #$40        // Produce $30-$39 or $41-$46
	cld             				
	sta vram+1

	
	// DIGIT 1
	lda addr+1
	and #$f0
	clc
	ror
	ror
	ror
	ror		
	sed             
	clc
	adc #$90        // Produce $90-$99 (C=0) or $00-$05 (C=1)
	adc #$40        // Produce $30-$39 or $41-$46
	cld             				
	sta vram	

}