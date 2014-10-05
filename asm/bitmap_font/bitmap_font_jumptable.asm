// Bitmap font jumptable

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