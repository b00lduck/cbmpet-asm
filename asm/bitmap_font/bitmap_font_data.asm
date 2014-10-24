
.import source "bitmap_font_table_generated.asm"
.import source "bitmap_font_jumptable.asm"

bf_char_index:	  .byte   0
bf_xpos:		  .byte   0

scroller_pos: 	  .byte   0
scroller_subpos:  .byte   0 
scroller_frame:	  .byte   0

bf_yoff:		  .word   0

scroller_changed: .byte   0