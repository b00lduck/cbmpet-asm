/**
 * PET 3008 assembler demo by graf_hardt of b00lduck
 * compatible with BASIC V2
 * written in September 2014
 *
 * b00luck on 6502 - check!
 */
.import source "config.asm"
.import source "macros.asm"

.pc = BASIC "Basic upstart" {
	:BasicUpstart(MAIN)
}

.pc = MAIN "Main code" {
	
	start:			
	
		cld
	
		:ClearScreen()	
		//:ClearVVRAM()
		:Checkerboard()
		:SwitchLowercase()
		
		:DrawTextZt(4, 0, hello1)
		:DrawTextZt(2, 2, hello2)
		:DrawTextZt(6, 20, hello3)
		//:DrawTextZt(6, 22, hello4)
			
		:InstallIsr(isr)		
				
	mainloop:	

		lda #$00		
		sta $E848	
		sta $E849	

		:DrawMemory()
		//DrawOuterBox(framecount)	

		// copy addr to zp1
		lda $e848
		sta ZP1
		lda $e849	
		sta ZP1+1			
		
		// substract ZP1 from FFFF
        sec             // Ensure carry is set
        lda #$ff        // Subtract the two least significant bytes
        sbc ZP1
        sta ZP2         // ... and store the result in ZP2
        lda #$ff        // Subtract the two most significant bytes
        sbc ZP1+1       // ... and any propagated borrow bit
        sta ZP2+1       // ... and store the result	in ZP2
				
		:DisplayHexWord(ZP2,$83bb)
		
		
		:ItoA(text1 + 14, minutes)		
		:ItoA(text1 + 17, seconds)		
		:ItoA(text1 + 20, frames)				
				
		:DrawTextZt(1, 23, text1)		
		
		
		
		lda $97
		cmp #$ff		// check for keystroke
		
		bne end					
		
		jmp mainloop	
		
	end:		
		lda #$00
		sta $9e	// set keyboard buffer len to $00		
	    :RestoreIsr()
		:ClearHome()			
		:SwitchGraphics()				
		rts

		
	/**
     *	Interrupt service routine	
	 */
	isr:			
		
		// advance frames
		sed // decimal mode on				
		clc
		lda frames
		adc #01
		sta frames
		cld // decimal mode off		
		cmp #$50
		bne wigga
		
		// advance seconds				
		lda #$00
		sta frames // reset frames	
		sed // decimal mode on				
		clc
		lda seconds
		adc #01
		sta seconds
		cld // decimal mode off	
		
		cmp #$60
		bne wigga
		
		// advance minutes		
		lda #$00
		sta seconds // reset seconds
		sed // decimal mode on				
		clc
		lda minutes
		adc #01
		sta minutes
		cld // decimal mode off			
				
	wigga:
		inc framecount			
		jmp (orig_isr)		// jump to original interrupt	
		
	.import source "data.asm"

}	

perfcount: 		.byte 	0

framecount: 	.dword 	0

frames:  		.byte 	0
seconds: 		.byte 	0
minutes: 		.byte 	0
       
orig_isr: 		.dword 	0

.pc = VVRAM "Virtual Video RAM" virtual
vvram: .fill VVRAM_SIZE,0





