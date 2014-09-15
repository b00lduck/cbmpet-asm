/**
 * PET 3008 assembler demo by graf_hardt of b00lduck
 * compatible with BASIC V2
 * written in September 2014
 *
 * b00lduck on AVR - check!
 * b00lduck on x86 - check!
 * b00lduck on ARM - check!
 * b00luck on 6502 - check!
 * b00lduck on 68000 - to come
 */
.import source "config.asm"
.import source "macros.asm"
.import source "macros_text.asm"
.import source "macros_vram.asm"
.import source "macros_vvram.asm"

.pc = BASIC "Basic upstart" {

!:	.word !+
	.byte 1, $00
rp:	.byte $9e, $20
	.byte $31, $33, $33, $37
	.text ":"
	.byte $9b,0
!:	.word !+
	.byte 2, $00
	.byte $8f, $20
	.text "PET-A-BYTE"
	.byte 0
!:	.word !+
	.byte 3, $00
	.byte $8f, $20
	.text "      "
	.text "BY B00LDUCK"
	.byte 0	
!:	.word !+
	.byte 5,$00
	.byte $8f, $20
	.text "CODE:  GRAF HARDT"
	.byte 0
!:	.word !+
	.byte 7, $00
	.byte $8f, $20
	.text "HARDWARE: DR ERGO"
	.byte 0
!:	.word !+
	.byte 11, $00
	.byte $80
	.byte 0	
	
!:	.byte 0,0
}


.pc = MAIN "Main code" {
	
	start:				
		cld
	
		:ClearScreen()	
		//:ClearVVRAM()
		//:Checkerboard()
		:LoadImage()
		:SwitchLowercase()
		
		:DrawTextZt(2, 18, hello2)
		:DrawTextZt(6, 20, hello3)
		
			
		:InstallIsr(isr)		
						
	mainloop:	

		lda #$00		
		sta $E848	
		sta $E849	

		//:DrawMemoryRandom()
		
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
vvram:




