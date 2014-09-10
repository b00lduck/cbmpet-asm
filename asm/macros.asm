/**
 * Set the interrupt vector to 'addr' and store the original value to 'orig_isr'
 * Affected: AC,ZERO
 */
.macro InstallIsr(addr) {
	sei

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

	cli
}

/**
 * Restore the interrupt vector to the old value from 'orig_isr'
 * Affected: AC,ZERO
 */
.macro RestoreIsr() {
	sei
	lda orig_isr
	sta ZP_ISR
	lda orig_isr + 1
	sta ZP_ISR + 1
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
// Affects: ZERO
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

// Increments ZP address 
// Affects: ZERO
.macro IncZp(addr) {
	inc addr		// increment ZP1
	bne end  		// if ZP1 is zero, increment high byte
	inc addr+1		
	end:
}

// Increments ZP address by value
// Affects: CARRY,ZERO,AC
.macro IncZp8(addr, val) {	
	clc
	lda addr
	adc #val
	sta addr
	bcc end	
	inc addr+1
	end:
}



