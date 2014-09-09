/**
 * CBM 4016 assembler demo by graf hardt of b00lduck
 * written in September 2014
 */
.import source "config.asm"
.import source "macros.asm"

.pc = BASIC "Basic Upstart" {
	:BasicUpstart(MAIN)
}

.pc = MAIN "Main" {
	
	start:			
	
		cld
	
		:ClearScreen()	
		:SwitchLowercase()
		
		:DrawTextZt(6, 8, hello1)
		:DrawTextZt(6, 12, hello2)
		:DrawTextZt(6, 14, hello3)
		:DrawTextZt(6, 16, hello4)
						
		:InstallIsr(isr)		
				
	mainloop:	
		
		:DrawMemory()
		//:DrawOuterBox(framecount)		
		
		
		
		:ItoA(text1 + 14, minutes)		
		:ItoA(text1 + 17, seconds)		
		:ItoA(text1 + 20, frames)		
		:DrawTextZt(3, 22, text1)		
		
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

	isr:		
	
	    // slowdown the whole demo
		dec delay
		lda delay
		bne wigga
		lda #SLOWDOWN
		sta delay
	
		
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
		
}




delay: .byte SLOWDOWN

framecount: .dword 0

frames:  .byte $00
seconds: .byte $00
minutes: .byte $00


hello1: .text " b00lduck  proudly  presents" .byte 0
hello2: .text "vintage  6502  assembly  code" .byte 0
hello3: .text "  by Graf Hardt and Shazman" .byte 0
hello4: .text "     runs on a CBM 4032" .byte 0

text1:  .text "Elapsed time: 00:00.00    " .byte 0
        
orig_isr: .word 0,0


