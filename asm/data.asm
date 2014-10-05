
data_text: .pc = data_text "Text constants"

hello2:
	.text "vintage COMMODORE PET assembly code" .byte 0
hello3:
	.text "  by Graf Hardt and Dr.Ergo" .byte 0
hello4:
	.text "      on a COMMODORE PET" .byte 0
	
text1:
	.text "Elapsed time: 00:00.00" .byte 0
	
text2:
	.text "b00lduck  " .byte 0
			
data_images: .pc = data_images "Images"			
			
.var image2Data = LoadBinary("../data/b00lduck.nar")
image2: .fill image2Data.getSize(), image2Data.get(i)
image2_size: .word image2Data.getSize()

data_font: .pc = data_font "Font"	

.var font1Data = LoadBinary("../data/font1.nar")
font1: .fill font1Data.getSize(), font1Data.get(i)
font1_size: .word font1Data.getSize()

