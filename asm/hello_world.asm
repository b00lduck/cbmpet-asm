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
.import source "macros_bitmap_font.asm"

.pc = BASIC "Basic upstart" {
	.word !+
	.byte 1, 0
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
		lda #$00
		sta ZP8
		sta ZP8+1
		
		// seed PRNG8
		lda #$00		
		sta ZP13
		
		lda #$ff
		sta ZP8
						
	mainloop:	

		// ?? (something with interrupt)
		lda #$00		
		sta $E848	
		sta $E849	

		
		:DrawBitmapText()
		
		jmp maindraw
		
		
		
		// 00:00.00 start first phase
		lda frames
		bne !+
		lda seconds
		bne !+
		lda minutes
		bne !+
		lda #$21
		sta phase_counter	
		lda #$00
		sta active_phase
		jmp phase_switch
				
		// 00:02.00 start phase 2
	!:	lda frames
		bne !+
		lda seconds
		cmp #$10
		bne !+
		lda minutes
		bne !+
		lda #$21
		sta phase_counter	
		lda #$01
		sta active_phase
		jmp phase_switch

	!:	
	
	phase_switch:
		lda active_phase
		beq phase0
		dec active_phase
		beq phase1
		jmp maindraw
					
	phase0:
		dec phase_counter
		beq maindraw
		
		jsr dissolve_in
		jsr dissolve_in
		jsr dissolve_in
		jsr dissolve_in
	
		jmp maindraw
	
	phase1:
		dec phase_counter
		beq maindraw
		
		//jsr invert

		jmp maindraw
				
				
				
					
				
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
		jsr prng8
		lda ZP13
		and #$07
		tax				
		lda shift_lut,x
		pha
		
		lda ZP13
		lsr
		lsr
		lsr		
		tay
		pla
				
		// AND it		
		.for(var a=$0;a<$140;a+=$20) {		
			pha
			and $3000+a,y
			ora $4000+a,y		
			sta $4000+a,y
			pla
		}		

		rts
		
	dissolve_out:

		// determine pixel mask to set
		jsr prng8
		lda ZP13
		and #$07
		tax				
		lda shift_lut,x
		pha
		
		lda ZP13
		lsr
		lsr
		lsr		
		tay
		pla
				
		// AND it		
		.for(var a=$0;a<$140;a+=$20) {		
			pha
			ora $4000+a,y		
			sta $4000+a,y
			pla
		}		

		rts
		
		
		
	invert:

		// determine pixel mask to set
		jsr prng8
		lda ZP13
		and #$07
		tax				
		lda shift_lut,x
		pha
		
		lda ZP13
		lsr
		lsr
		lsr		
		tay
		pla
				
		// AND it		
		.for(var a=$0;a<$140;a+=$20) {		
			pha
			eor $4000+a,y	
			sta $4000+a,y
			pla
		}		

		rts		
		
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

active_phase:	.byte 0
phase_counter:	.byte 0


perfcount: 		.byte 	0

framecount: 	.dword 	0

frames:  		.byte 	0
seconds: 		.byte 	0
minutes: 		.byte 	0
       
orig_isr: 		.dword 	0

lut:			.byte 	$20,$7e,$7c,98+128,123,97,127+128,108+128,108,127,97+128,123+128,98,124+128,126+128,160
lut1:			.byte   $20,$6c,$7b,$62,$7c,$e1,$ff,$fe,$7e,$7f,$61,$fc,$e2,$fb,$ec,$a0
shift_lut:		.byte	$01,$02,$04,$08,$10,$20,$40,$80,$FF

// bitmap font helper lookup tables
// Even source, odd target: target byte 1 
pixel_move_lut1: .byte  $00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$02,$02,$03,$03,$02,$02,$03,$03,$06,$06,$07,$07,$06,$06,$07,$07,$10,$10,$11,$11,$10,$10,$11,$11,$14,$14,$15,$15,$14,$14,$15,$15,$12,$12,$13,$13,$12,$12,$13,$13,$16,$16,$17,$17,$16,$16,$17,$17,$08,$08,$09,$09,$08,$08,$09,$09,$0C,$0C,$0D,$0D,$0C,$0C,$0D,$0D,$0A,$0A,$0B,$0B,$0A,$0A,$0B,$0B,$0E,$0E,$0F,$0F,$0E,$0E,$0F,$0F,$18,$18,$19,$19,$18,$18,$19,$19,$1C,$1C,$1D,$1D,$1C,$1C,$1D,$1D,$1A,$1A,$1B,$1B,$1A,$1A,$1B,$1B,$1E,$1E,$1F,$1F,$1E,$1E,$1F,$1F,$40,$40,$41,$41,$40,$40,$41,$41,$44,$44,$45,$45,$44,$44,$45,$45,$42,$42,$43,$43,$42,$42,$43,$43,$46,$46,$47,$47,$46,$46,$47,$47,$50,$50,$51,$51,$50,$50,$51,$51,$54,$54,$55,$55,$54,$54,$55,$55,$52,$52,$53,$53,$52,$52,$53,$53,$56,$56,$57,$57,$56,$56,$57,$57,$48,$48,$49,$49,$48,$48,$49,$49,$4C,$4C,$4D,$4D,$4C,$4C,$4D,$4D,$4A,$4A,$4B,$4B,$4A,$4A,$4B,$4B,$4E,$4E,$4F,$4F,$4E,$4E,$4F,$4F,$58,$58,$59,$59,$58,$58,$59,$59,$5C,$5C,$5D,$5D,$5C,$5C,$5D,$5D,$5A,$5A,$5B,$5B,$5A,$5A,$5B,$5B,$5E,$5E,$5F,$5F,$5E,$5E,$5F,$5F						
// Even source, odd target: target byte 2
pixel_move_lut2: .byte	$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0

// Odd source, even target: source byte 1
pixel_move_lut3: .byte  $00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA 
// Odd source, even target: source byte 2
pixel_move_lut4: .byte  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05
		
		
.pc = VVRAM "Virtual Video RAM" virtual
vvram: .fill 320,0


.pc = VRAM "Video RAM" virtual
vram: .fill 1000,0




