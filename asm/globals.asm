globals: .pc = globals "Global variables"

active_phase:	.byte 0
phase_counter:	.byte 0

perfcount: 		.byte 	0

framecount: 	.dword 	0

frames:  		.byte 	0
seconds: 		.byte 	0
minutes: 		.byte 	0
       
orig_isr: 		.dword 	0