.const BASIC=$0401
.const MAIN=$0539 // 1337
.const VRAM=$8000
.const VVRAM=$7e00
.const VVRAM_SIZE=$013f
.const VVRAM_END=VVRAM+VVRAM_SIZE

.const DATA = $4000

.const DBMF_SUBROUTINES=$5a8a
.const DBMF_TABLES=$6000

.const PETSCIITABLE=$7ff0

.const GLOBALS=$7f40

.const ZP1=$e0
.const ZP2=$e2
.const ZP3=$e4
.const ZP4=$e6
.const ZP5=$e8
.const ZP6=$ea
.const ZP7=$ec
.const ZP8=$ee // PRNG 16

.const ZP10=$f0
.const ZP11=$f1
.const ZP12=$f2
.const ZP13=$f3 // PRNG 8
.const ZP14=$f4 // PRNG 8

.const ZP_ISR=$90