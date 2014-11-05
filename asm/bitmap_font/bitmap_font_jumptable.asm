// Bitmap font jumptable

!: .pc = !- "bitmap font jumptable"	
.align $0020

dbmc_jumptable:
.word dbmc_s0_t0, dbmc_s0_t1, dbmc_s0_t2, dbmc_s0_t3
.word dbmc_s1_t0, dbmc_s1_t1, dbmc_s1_t2, dbmc_s1_t3
.word dbmc_s2_t0, dbmc_s2_t1, dbmc_s2_t2, dbmc_s2_t3
.word dbmc_s3_t0, dbmc_s3_t1, dbmc_s3_t2, dbmc_s3_t3

dbmc_s0_t0: :DrawBitmapChar_Source0_Target0() 
dbmc_s0_t1: :DrawBitmapChar_Source0_Target1() 
dbmc_s0_t2: :DrawBitmapChar_Source0_Target2() 
dbmc_s0_t3: :DrawBitmapChar_Source0_Target3() 		
dbmc_s1_t0: :DrawBitmapChar_Source1_Target0() 
dbmc_s1_t1: :DrawBitmapChar_Source1_Target1() 
dbmc_s1_t2: :DrawBitmapChar_Source1_Target2() 
dbmc_s1_t3: :DrawBitmapChar_Source1_Target3() 		
dbmc_s2_t0: :DrawBitmapChar_Source2_Target0() 
dbmc_s2_t1: :DrawBitmapChar_Source2_Target1() 
dbmc_s2_t2: :DrawBitmapChar_Source2_Target2() 
dbmc_s2_t3: :DrawBitmapChar_Source2_Target3() 		
dbmc_s3_t0: :DrawBitmapChar_Source3_Target0() 
dbmc_s3_t1: :DrawBitmapChar_Source3_Target1() 
dbmc_s3_t2: :DrawBitmapChar_Source3_Target2() 
dbmc_s3_t3: :DrawBitmapChar_Source3_Target3() 

!: .pc = !- "bitmap font vertical move jumptable"	
.align $0020

vm_jumptable:
.word vm0000, vm0001, vm0010, vm0011
.word vm0100, vm0101, vm0110, vm0111
.word vm1000, vm1001, vm1010, vm1011
.word vm1100, vm1101, vm1110, vm1111

vm0000: :VerticalMove_0000()
vm0001: :VerticalMove_0001()
vm0010: :VerticalMove_0010()
vm0011: :VerticalMove_0011()
vm0100: :VerticalMove_0100()
vm0101: :VerticalMove_0101()
vm0110: :VerticalMove_0110()
vm0111: :VerticalMove_0111()
vm1000: :VerticalMove_1000()
vm1001: :VerticalMove_1001()
vm1010: :VerticalMove_1010()
vm1011: :VerticalMove_1011()
vm1100: :VerticalMove_1100()
vm1101: :VerticalMove_1101()
vm1110: :VerticalMove_1110()
vm1111: :VerticalMove_1111()



