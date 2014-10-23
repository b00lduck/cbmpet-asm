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
 * b00lduck on Z80 - unlikely
 */
.import source "config.asm"
.import source "macros.asm"
.import source "macros_text.asm"
.import source "macros_vram.asm"
.import source "bitmap_font/bitmap_font_macros.asm"
.import source "vvram_common/vvram_common_macros.asm"
.import source "vvram_mode2/vvram_mode2_macros.asm"

.import source "basic_upstart.asm"
.import source "globals.asm"


.pc = MAIN "Main code"
	
	start:	
	
		:SaveZeroPage()
	
		cld
	
		:ClearScreen()	
		:ClearVVRAM()
		//:Checkerboard2()
		//:LoadImage()
		//:LoadImageNA()
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

		// set timer 2 to zero
		lda #$00		
		sta $E848	
		sta $E849	

		
		:DrawScroller()
		
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

		// copy timer 2 to zp1
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
							
		jsr $ffe4
		
		bne end								
		jmp mainloop	
		
	end:

		//:RestoreZeroPage()
							
	    :RestoreIsr()
		:ClearHome()			
		:SwitchGraphics()			
		
		rts

		
	// Interrupt service routine	
	isr:			
		
		// advance frames
		sed // decimal mode on				
		clc
		lda frames
		adc #01
		sta frames
		cld // decimal mode off		
		cmp #$60
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
			ora VVRAM+a,y		
			sta VVRAM+a,y
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
			ora VVRAM+a,y		
			sta VVRAM+a,y
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
			eor VVRAM+a,y	
			sta VVRAM+a,y
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

data: .pc = data "Main data"

.import source "data.asm"

.import source "bitmap_font/bitmap_font_data.asm"
.import source "vvram_common/vvram_common_data.asm"
.import source "vvram_mode2/vvram_mode2_data.asm"
	


lut:			.byte 	$20,$7e,$7c,98+128,123,97,127+128,108+128,108,127,97+128,123+128,98,124+128,126+128,160
lut1:			.byte   $20,$6c,$7b,$62,$7c,$e1,$ff,$fe,$7e,$7f,$61,$fc,$e2,$fb,$ec,$a0
shift_lut:		.byte	$01,$02,$04,$08,$10,$20,$40,$80,$FF

.pc = VRAM "Hardware video RAM (VRAM)" virtual
vram: .fill 1000,0

.pc = ZP_BACKUP "Zero page backup" virtual
zp_backup: .fill 256,0
