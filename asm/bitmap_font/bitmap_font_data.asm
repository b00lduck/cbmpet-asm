
.import source "bitmap_font_table_generated.asm"
.import source "bitmap_font_jumptable.asm"

!: .pc = !- "other bitmap font data"	

bf_char_index:	  .byte   0
bf_xpos:		  .byte   0

scroller_pos: 	  .byte   0
scroller_subpos:  .byte   0 
scroller_frame:	  .byte   0

bf_yoff:		  .word   0

scroller_changed: .byte   0

.align $0100
yoff_array:		  
.byte   1,1,1,1,0, 0,0,0,1,1, 1,1,0,0,0, 0,1,1,1,1
.byte   0,0,0,0,1, 1,1,1,0,0, 0,0,1,1,1, 1,0,0,0,0
.byte   1,1,1,1,1, 0,0,0,0,1, 1,1,1,0,0, 0,0,1,1,1
.byte   1,0,0,0,0, 1,1,1,1,0, 0,0,0,1,1, 1,1,0,0,0


