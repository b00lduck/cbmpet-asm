.pc = DBMF_TABLES "Lookup tables (aligned)" 
.align $0100
// Conversion table for bitmap font output
pixel_move_lut_s0_t1_a:
.byte $00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$02,$02,$03,$03,$02,$02,$03,$03,$06,$06,$07,$07,$06,$06,$07,$07,$10,$10,$11,$11,$10,$10,$11,$11,$14,$14,$15,$15,$14,$14,$15,$15,$12,$12,$13,$13,$12,$12,$13,$13,$16,$16,$17,$17,$16,$16,$17,$17,$08,$08,$09,$09,$08,$08,$09,$09,$0C,$0C,$0D,$0D,$0C,$0C,$0D,$0D,$0A,$0A,$0B,$0B,$0A,$0A,$0B,$0B,$0E,$0E,$0F,$0F,$0E,$0E,$0F,$0F,$18,$18,$19,$19,$18,$18,$19,$19,$1C,$1C,$1D,$1D,$1C,$1C,$1D,$1D,$1A,$1A,$1B,$1B,$1A,$1A,$1B,$1B,$1E,$1E,$1F,$1F,$1E,$1E,$1F,$1F,$40,$40,$41,$41,$40,$40,$41,$41,$44,$44,$45,$45,$44,$44,$45,$45,$42,$42,$43,$43,$42,$42,$43,$43,$46,$46,$47,$47,$46,$46,$47,$47,$50,$50,$51,$51,$50,$50,$51,$51,$54,$54,$55,$55,$54,$54,$55,$55,$52,$52,$53,$53,$52,$52,$53,$53,$56,$56,$57,$57,$56,$56,$57,$57,$48,$48,$49,$49,$48,$48,$49,$49,$4C,$4C,$4D,$4D,$4C,$4C,$4D,$4D,$4A,$4A,$4B,$4B,$4A,$4A,$4B,$4B,$4E,$4E,$4F,$4F,$4E,$4E,$4F,$4F,$58,$58,$59,$59,$58,$58,$59,$59,$5C,$5C,$5D,$5D,$5C,$5C,$5D,$5D,$5A,$5A,$5B,$5B,$5A,$5A,$5B,$5B,$5E,$5E,$5F,$5F,$5E,$5E,$5F,$5F
pixel_move_lut_s0_t1_b:
.byte $00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0
pixel_move_lut_s0_t2_a:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
pixel_move_lut_s0_t2_b:
.byte $00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0
pixel_move_lut_s0_t3_a:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05
pixel_move_lut_s0_t3_b:
.byte $00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA
pixel_move_lut_s1_t0_a:
.byte $00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$20,$22,$30,$32,$28,$2A,$38,$3A,$60,$62,$70,$72,$68,$6A,$78,$7A,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA,$80,$82,$90,$92,$88,$8A,$98,$9A,$C0,$C2,$D0,$D2,$C8,$CA,$D8,$DA,$A0,$A2,$B0,$B2,$A8,$AA,$B8,$BA,$E0,$E2,$F0,$F2,$E8,$EA,$F8,$FA
pixel_move_lut_s1_t0_b:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05
pixel_move_lut_s1_t2_a:
.byte $00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$02,$02,$03,$03,$02,$02,$03,$03,$06,$06,$07,$07,$06,$06,$07,$07,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$02,$02,$03,$03,$02,$02,$03,$03,$06,$06,$07,$07,$06,$06,$07,$07,$08,$08,$09,$09,$08,$08,$09,$09,$0C,$0C,$0D,$0D,$0C,$0C,$0D,$0D,$0A,$0A,$0B,$0B,$0A,$0A,$0B,$0B,$0E,$0E,$0F,$0F,$0E,$0E,$0F,$0F,$08,$08,$09,$09,$08,$08,$09,$09,$0C,$0C,$0D,$0D,$0C,$0C,$0D,$0D,$0A,$0A,$0B,$0B,$0A,$0A,$0B,$0B,$0E,$0E,$0F,$0F,$0E,$0E,$0F,$0F,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$02,$02,$03,$03,$02,$02,$03,$03,$06,$06,$07,$07,$06,$06,$07,$07,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$02,$02,$03,$03,$02,$02,$03,$03,$06,$06,$07,$07,$06,$06,$07,$07,$08,$08,$09,$09,$08,$08,$09,$09,$0C,$0C,$0D,$0D,$0C,$0C,$0D,$0D,$0A,$0A,$0B,$0B,$0A,$0A,$0B,$0B,$0E,$0E,$0F,$0F,$0E,$0E,$0F,$0F,$08,$08,$09,$09,$08,$08,$09,$09,$0C,$0C,$0D,$0D,$0C,$0C,$0D,$0D,$0A,$0A,$0B,$0B,$0A,$0A,$0B,$0B,$0E,$0E,$0F,$0F,$0E,$0E,$0F,$0F
pixel_move_lut_s1_t2_b:
.byte $00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0
pixel_move_lut_s1_t2_c:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50
pixel_move_lut_s1_t3_a:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05
pixel_move_lut_s1_t3_b:
.byte $00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0
pixel_move_lut_s1_t3_c:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A
pixel_move_lut_s2_t0_a:
.byte $00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0,$00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0
pixel_move_lut_s2_t0_b:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
pixel_move_lut_s2_t1_a:
.byte $00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A,$00,$02,$10,$12,$08,$0A,$18,$1A,$40,$42,$50,$52,$48,$4A,$58,$5A
pixel_move_lut_s2_t1_b:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05
pixel_move_lut_s2_t1_c:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
pixel_move_lut_s2_t3_a:
.byte $00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05
pixel_move_lut_s2_t3_b:
.byte $00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0
pixel_move_lut_s2_t3_c:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$42,$42,$42,$42,$42,$42,$42,$42,$42,$42,$42,$42,$42,$42,$42,$42,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$50,$52,$52,$52,$52,$52,$52,$52,$52,$52,$52,$52,$52,$52,$52,$52,$52,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$4A,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A,$5A
pixel_move_lut_s3_t0_a:
.byte $00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0,$00,$20,$00,$20,$80,$A0,$80,$A0
pixel_move_lut_s3_t0_b:
.byte $00,$00,$01,$01,$00,$00,$01,$01,$04,$04,$05,$05,$04,$04,$05,$05,$02,$02,$03,$03,$02,$02,$03,$03,$06,$06,$07,$07,$06,$06,$07,$07,$10,$10,$11,$11,$10,$10,$11,$11,$14,$14,$15,$15,$14,$14,$15,$15,$12,$12,$13,$13,$12,$12,$13,$13,$16,$16,$17,$17,$16,$16,$17,$17,$08,$08,$09,$09,$08,$08,$09,$09,$0C,$0C,$0D,$0D,$0C,$0C,$0D,$0D,$0A,$0A,$0B,$0B,$0A,$0A,$0B,$0B,$0E,$0E,$0F,$0F,$0E,$0E,$0F,$0F,$18,$18,$19,$19,$18,$18,$19,$19,$1C,$1C,$1D,$1D,$1C,$1C,$1D,$1D,$1A,$1A,$1B,$1B,$1A,$1A,$1B,$1B,$1E,$1E,$1F,$1F,$1E,$1E,$1F,$1F,$40,$40,$41,$41,$40,$40,$41,$41,$44,$44,$45,$45,$44,$44,$45,$45,$42,$42,$43,$43,$42,$42,$43,$43,$46,$46,$47,$47,$46,$46,$47,$47,$50,$50,$51,$51,$50,$50,$51,$51,$54,$54,$55,$55,$54,$54,$55,$55,$52,$52,$53,$53,$52,$52,$53,$53,$56,$56,$57,$57,$56,$56,$57,$57,$48,$48,$49,$49,$48,$48,$49,$49,$4C,$4C,$4D,$4D,$4C,$4C,$4D,$4D,$4A,$4A,$4B,$4B,$4A,$4A,$4B,$4B,$4E,$4E,$4F,$4F,$4E,$4E,$4F,$4F,$58,$58,$59,$59,$58,$58,$59,$59,$5C,$5C,$5D,$5D,$5C,$5C,$5D,$5D,$5A,$5A,$5B,$5B,$5A,$5A,$5B,$5B,$5E,$5E,$5F,$5F,$5E,$5E,$5F,$5F
pixel_move_lut_s3_t1_a:
.byte $00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50,$00,$10,$00,$10,$40,$50,$40,$50
pixel_move_lut_s3_t1_b:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
pixel_move_lut_s3_t1_c:
.byte $00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0,$00,$00,$20,$20,$00,$00,$20,$20,$80,$80,$A0,$A0,$80,$80,$A0,$A0
pixel_move_lut_s3_t2_a:
.byte $00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A,$00,$02,$00,$02,$08,$0A,$08,$0A
pixel_move_lut_s3_t2_b:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05
pixel_move_lut_s3_t2_c:
.byte $00,$00,$10,$10,$00,$00,$10,$10,$40,$40,$50,$50,$40,$40,$50,$50,$20,$20,$30,$30,$20,$20,$30,$30,$60,$60,$70,$70,$60,$60,$70,$70,$00,$00,$10,$10,$00,$00,$10,$10,$40,$40,$50,$50,$40,$40,$50,$50,$20,$20,$30,$30,$20,$20,$30,$30,$60,$60,$70,$70,$60,$60,$70,$70,$80,$80,$90,$90,$80,$80,$90,$90,$C0,$C0,$D0,$D0,$C0,$C0,$D0,$D0,$A0,$A0,$B0,$B0,$A0,$A0,$B0,$B0,$E0,$E0,$F0,$F0,$E0,$E0,$F0,$F0,$80,$80,$90,$90,$80,$80,$90,$90,$C0,$C0,$D0,$D0,$C0,$C0,$D0,$D0,$A0,$A0,$B0,$B0,$A0,$A0,$B0,$B0,$E0,$E0,$F0,$F0,$E0,$E0,$F0,$F0,$00,$00,$10,$10,$00,$00,$10,$10,$40,$40,$50,$50,$40,$40,$50,$50,$20,$20,$30,$30,$20,$20,$30,$30,$60,$60,$70,$70,$60,$60,$70,$70,$00,$00,$10,$10,$00,$00,$10,$10,$40,$40,$50,$50,$40,$40,$50,$50,$20,$20,$30,$30,$20,$20,$30,$30,$60,$60,$70,$70,$60,$60,$70,$70,$80,$80,$90,$90,$80,$80,$90,$90,$C0,$C0,$D0,$D0,$C0,$C0,$D0,$D0,$A0,$A0,$B0,$B0,$A0,$A0,$B0,$B0,$E0,$E0,$F0,$F0,$E0,$E0,$F0,$F0,$80,$80,$90,$90,$80,$80,$90,$90,$C0,$C0,$D0,$D0,$C0,$C0,$D0,$D0,$A0,$A0,$B0,$B0,$A0,$A0,$B0,$B0,$E0,$E0,$F0,$F0,$E0,$E0,$F0,$F0
