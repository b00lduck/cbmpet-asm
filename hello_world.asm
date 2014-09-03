.const BASIC=$0401
.const MAIN=$040d
.const VRAM=$8000

.pc = BASIC "Basic Upstart"
:BasicUpstart(MAIN)

.var framecount = 0

.pc = MAIN "Main" {
	start:
		
		:ClearScreen()	
		:SwitchLowercase()
		
		:DrawText(7, 6, hello1, $1d)
		:DrawText(7, 8, hello2, $1d)
		:DrawText(7, 10, hello3, $1d)
		:DrawText(7, 12, hello4, $1d)	
			
		sei
		lda #<isr
		sta $90
		lda #>isr
		sta $91
		cli
		
	endloop:
		jmp endloop

	isr:
		inc $8000
		inc framecount
		
		//.var myString= "frame " + framecount		
		//:DrawText(0, 2, myString, $0d)			
							
		jmp $e455		
		
}



hello1: .text " b00lduck  proudly  presents "
hello2: .text "vintage  6502  assembly  code"
hello3: .text "  by graf hardt and shazman  "
hello4: .text "      on  an  cbm 4032       "


// switch to upeprcase/lowercase mode
.macro SwitchLowercase() {		
		lda #$0e
		sta $e84c
}

// switch to uppercase/graphics mode
.macro SwitchGraphics() {		
		lda #$0c
		sta $e84c
}

.macro DrawText(tx, ty, text, len) {

		.var addr = VRAM + tx + ty * 40

		ldx #$00
	loop:
		lda text, x
		sta addr, x
		inx
		cpx #len
		bne loop

}

.macro ClearScreen() {
	:FillScreen($20)
}

.macro FillScreen(clearByte) {
		lda #clearByte
		ldx #$00
	loop:
		.for(var i = 0; i < 3; i++) {
			sta VRAM + [i * $0100], x
		}
		sta VRAM + [$02e8], x
		inx
		bne loop
}
