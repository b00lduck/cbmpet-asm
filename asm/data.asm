
.pc = PETSCIITABLE "PETSCII translation table"
.align $0010
gfxtable:
	.byte 32,108,123,98,124,97+128,127+128,126+128
	.byte 126,127,97,124+128,98+128,123+128,108+128,160

.pc = DATA "Data constants (Text, image, font)"	
	
hello2:
	.text "vintage COMMODORE PET assembly code" .byte 0
hello3:
	.text "  by Graf Hardt and Dr.Ergo" .byte 0
hello4:
	.text "      on a COMMODORE PET" .byte 0
	
text1:
	.text "Elapsed time: 00:00.00" .byte 0
		
.var image2Data = LoadBinary("../data/b00lduck.nar")
image2: .fill image2Data.getSize(), image2Data.get(i)
image2_size: .word image2Data.getSize()

.var font1Data = LoadBinary("../data/font1.nar")
font1: .fill font1Data.getSize(), font1Data.get(i)
font1_size: .word font1Data.getSize()