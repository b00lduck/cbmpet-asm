
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
	.text "                 "
	.text "b00lduck proudly presents: pet-a-byte: a short presentation of oldschool technology by graf hardt and dr.ergo. a scroller is in the house. yeeeehaw.... over and out                    " 

	
!: .pc = !- "Image: b00lduck logo"			
image2: :ConvertPicture("../data/b00lduck.png")

!: .pc = !- "Image: verfassungsschutz logo"			
image3: :ConvertPicture("../data/demo1.png")

!: .pc = !- "Image: Scroller background"			
image4: :ConvertPicture("../data/scroller_bg.png")

!: .pc = !- "Image: Donut car 1"			
donutcar1: :ConvertPicture("../data/DonutCar1.png")

!: .pc = !- "Image: Donut car 2"			
donutcar2: :ConvertPicture("../data/DonutCar2.png")

!: .pc = !- "Image: Donut car 3"			
donutcar3: :ConvertPicture("../data/DonutCar3.png")


!: .pc = !- "Image: Bus"			
bus: :ConvertPicture("../data/Bus.png")

!: .pc = !- "Font: 5x6"			
font1: :ConvertPicture("../data/font.png")

!: .pc = !- "End of data"	
		
.macro ConvertPicture(FILENAME) {
	
	.var data = LoadPicture(FILENAME)
	.for (var y = 0; y < 16; y++)
		.for (var x = 0; x < 22; x++) {
			.var sx = x * 4
			.var sy = y * 2
			.var value = 0
			.eval value += data.getPixel(sx,sy) & 1 << 7
			.eval value += data.getPixel(sx + 1,sy) & 1 << 6
			.eval value += data.getPixel(sx,sy + 1) & 1 << 5
			.eval value += data.getPixel(sx + 1,sy + 1) & 1 << 4
			.eval value += data.getPixel(sx + 2,sy) & 1 << 3
			.eval value += data.getPixel(sx + 3,sy) & 1 << 2
			.eval value += data.getPixel(sx + 2,sy + 1) & 1 << 1
			.eval value += data.getPixel(sx + 3,sy + 1) & 1 << 0			  
			.byte value			  
		}

}