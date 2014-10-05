.pc = BASIC "Basic upstart" {
	.word !+
	.byte 1, 0
rp:	.byte $9e, $20
	.byte $31, $33, $33, $37, 0
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