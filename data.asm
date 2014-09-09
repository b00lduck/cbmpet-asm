
.align $0100
gfxtable:
	.byte 32,108,123,98,124,97+128,127+128,126+128
	.byte 126,127,97,124+128,98+128,123+128,108+128,160

hello1:
	.text " b00lduck(tm) proudly presents:" .byte 0
hello2:
	.text "vintage COMMODORE PET assembly code" .byte 0
hello3:
	.text "  by Graf Hardt and Shazman" .byte 0
hello4:
	.text "      on a COMMODORE PET" .byte 0
text1:
	.text "Elapsed time: 00:00.00    " .byte 0