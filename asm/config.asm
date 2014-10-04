.const BASIC = 			  	$0401
.const GLOBALS = 			$0470
.const PETSCIITABLE =		$04f0
.const MAIN = 			  	$0539 // 1337
.const DATA = 		      	$1000
.const DBMF_SUBROUTINES = 	DATA + $300
.const DBMF_TABLES = 	  	DBMF_SUBROUTINES + $900
.const ZP_BACKUP = 		  	$7d00
.const VVRAM =		 		$7e00
.const VRAM =  				$8000
.const VVRAM_SIZE = 		$013f
.const VVRAM_END =  		VVRAM + VVRAM_SIZE


// we dont need floating point kernal stuff, so we can use this area of the zero page
.const ZP1  = $54
.const ZP2  = $56
.const ZP3  = $58
.const ZP4  = $5a
.const ZP5  = $5c
.const ZP6  = $5e
.const ZP7  = $60
.const ZP8  = $62 // PRNG 16

.const ZP10 = $66
.const ZP11 = $67
.const ZP12 = $68
.const ZP13 = $69 // PRNG 8
.const ZP14 = $6a 
.const ZP15 = $6b 

.const ZP_ISR = $90	// Hardware interrupt