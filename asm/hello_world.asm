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
		:ClearVVRAM()
		//:Checkerboard2()
		//:LoadImage()
		:LoadImageNA()
		:SwitchLowercase()
		
		:DrawTextZt(2, 18, hello2)
		:DrawTextZt(6, 20, hello3)	
			
		:InstallIsr(isr)				
		
		// seed PRNG16
		//lda #$00
		//sta ZP8
		//sta ZP8+1
		
		// seed PRNG8
		lda #$00
		sta ZP13
						
	mainloop:	

		// ??
		lda #$00		
		sta $E848	
		sta $E849	

		lda seconds
		cmp #$20
		bcs !+
		jsr dissolve_in
		jsr dissolve_in
		jsr dissolve_in
		jsr dissolve_in
		jsr dissolve_in
		jsr dissolve_in
		jsr dissolve_in
		jmp maindraw
		
	!:
		lda seconds
		cmp #$30
		bcc maindraw
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out
		jsr dissolve_out		
	
	
	maindraw:
		
		//:DrawMemoryRandom()
		//:DrawMemory()
		:DrawMemoryNA()
		//DrawOuterBox(framecount)	

		// copy counter to zp1
		lda $e848
		sta ZP1
		lda $e849	
		sta ZP1+1			
		
		// substract ZP1 from FFFF
        sec             
        lda #$ff        
        sbc ZP1
        sta ZP2         
        lda #$ff        
        sbc ZP1+1       
        sta ZP2+1       
				
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
		
		
	dissolve_in:
		// determine pixel mask to set
		jsr prng16
		lda ZP8
		and #$07
		tax				
		lda shift_lut,x		
				
		// AND it
		ldy ZP8+1		
		and $3000,y
		ora $4000,y		
		sta $4000,y

		// mask y with 63 ($3f) to fill the last 64 bytes (whole VVRAM has 320 bytes)
		cpy #$40
		bcs !+
		and $3100,y	
		ora $4100,y
		sta $4100,y
	!:
		rts
		
	dissolve_out:

		// determine pixel mask to set
		jsr prng16
		lda ZP8
		and #$07
		tax				
		lda shift_lut,x		
				
		// OR it with the VVRAM contents at index y
		ldy ZP8+1		
		ora $4000,y	
		sta $4000,y

		// mask y with 63 ($3f) to fill the last 64 bytes (whole VVRAM has 320 bytes)
		cpy #$40
		bcs !+
		ora $4100,y	
		sta $4100,y
	!:
		rts
		
	
	// AC $01 -> AC $01
	// AC $01 -> AC $01
	getBit: {
		rts
	}
	
		
	// PRNG 8 subroutine
	prng8: {
		lda ZP13
        beq doEor
        asl
        beq noEor
        bcc noEor
	doEor:
		eor #$1d
	noEor:
		sta ZP13
		rts
	}
	
	// PRNG 16 subroutine
	prng16: {	
		lda ZP8
		beq lowZero	 // $0000 and $8000 are special values to test for 
		asl ZP8
		lda ZP8+1
		rol
		bcc noEor
 
	doEor:
		eor #>$002d
		sta ZP8+1
		lda ZP8
		eor #<$002d
		sta ZP8
		rts
 
	lowZero:
		lda ZP8+1
		beq doEor
		asl
		beq noEor
		bcs doEor
 
	noEor:
		sta ZP8+1
		rts	
	}
	
	
	
	
	.import source "data.asm"

}	

perfcount: 		.byte 	0

framecount: 	.dword 	0

frames:  		.byte 	0
seconds: 		.byte 	0
minutes: 		.byte 	0
       
orig_isr: 		.dword 	0

lut:			.byte 	$20,$7e,$7c,98+128,123,97,127+128,108+128,108,127,97+128,123+128,98,124+128,126+128,160
lut1:			.byte   $20,$6c,$7b,$62,$7c,$e1,$ff,$fe,$7e,$7f,$61,$fc,$e2,$fb,$ec,$a0
shift_lut:		.byte	$01,$02,$04,$08,$10,$20,$40,$80,$FF
		

.pc = VVRAM "Virtual Video RAM" virtual
vvram: .fill 320,0

.pc = VRAM "Video RAM" virtual
vram: .fill 1000,0




