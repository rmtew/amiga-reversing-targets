; Memory map
;   code[$00000000-$00000FA0] -> runtime[$00078000-$00078FA0] policy materialized
;   Absolute memory refs:
;     absolute[$00000800] refs=5 access=a
;     absolute[$00058000] refs=1 access=a
;     absolute[$00070000] refs=1 access=a
;     absolute[$0007A4F8] refs=1 access=a
;     absolute[$0007A4FC-$0007A4FE] refs=1 access=r

; AmigaOS compatibility
;   required OS floor: unknown
;   evidence: no recovered OS calls

 INCLUDE "platform/amiga-export-symbols.i"

; STRUCT DiskResourceDescriptor
    RSRESET
DiskResourceDescriptor_destination RS.L 1
DiskResourceDescriptor_start_track RS.L 1
DiskResourceDescriptor_track_offset RS.L 1
DiskResourceDescriptor_remaining_bytes RS.L 1
DiskResourceDescriptor_SIZEOF EQU __RS

_ciaa	EQU	$BFE001
_ciab	EQU	$BFD000
_custom	EQU	$DFF000
absolute_slot_00000800	EQU	$800
absolute_slot_00058000	EQU	$58000
absolute_slot_00070000	EQU	$70000
absolute_slot_0007A4F8	EQU	$7A4F8
disk_buffer_00000800	EQU	$800
m68k_vector_privilege_violation	EQU	$20

    SECTION code,code
BootLoaderEntry:
    ORG $78000
abs_0_00078000:
	lea.l abs_0_0007800C(pc),a0
	move.l a0,m68k_vector_privilege_violation.w
	move #$2700,sr
abs_0_0007800C:
	lea.l _custom.l,a6
	move.w #$FFF,color(a6)
	move.w #(4<<PLNCNTSHFT)|COLORON,bplcon0(a6)	; display 4 bitplanes lores color
	move.w #$0,bplcon1(a6)	; display scroll pf1=0 pf2=0
	move.w #$0,bplcon2(a6)
	move.w #$0,bpl1mod(a6)	; bitplane modulo 0 bytes
	move.w #$0,bpl2mod(a6)	; bitplane modulo 0 bytes
	move.w #$2C81,diwstrt(a6)	; display window start v=$2C h=$81
	move.w #$F4C1,diwstop(a6)	; display window stop v=$F4 h=$C1
	move.w #$38,ddfstrt(a6)	; display fetch start $38
	move.w #$D0,ddfstop(a6)	; display fetch stop $D0
	move.l #$788B2,cop1lc(a6)	; copper_list pointer
	clr.w copjmp1(a6)
	clr.w _custom+color.l	; palette color 0
	jsr InitializeBootFloppyReader(pc)
	jsr StartBootDrive0Motor(pc)
	moveq.l #0,d0
	jsr LoadBootResource(pc)
	lea.l absolute_slot_00058000.l,a0
	lea.l absolute_slot_00070000.l,a1
	move.w #$F9F,d7
abs_0_0007807E:
	move.w (a0)+,(a1)
	move.w (a0)+,$1F40(a1)
	move.w (a0)+,$3E80(a1)
	move.w (a0)+,$5DC0(a1)
	addq.w #2,a1
	dbf.w d7,abs_0_0007807E
	lea.l abs_0_0007891A(pc),a0
	lea.l color(a6),a1
	moveq.l #15,d7
abs_0_0007809C:
	move.w (a0)+,(a1)+
	dbf.w d7,abs_0_0007809C
	move.w #DMAF_SETCLR|DMAF_BLITHOG|DMAF_MASTER|DMAF_RASTER|DMAF_COPPER|DMAF_BLITTER|DMAF_DISK,dmacon(a6)
abs_0_000780A8:
	move.w #$F00,_custom+color.l
	move.w #$9E,d0
	jsr SeekBootLogicalTrack(pc)
	lea.l disk_buffer_00000800.l,a0
	jsr abs_0_000780FA(pc)
	lea.l absolute_slot_00000800.l,a0
	jsr abs_0_00078138.l
	bmi.w abs_0_000780A8
	clr.w _custom+color.l	; palette color 0
	moveq.l #1,d0
	jsr LoadBootResource(pc)
	lea.l _custom.l,a6
	move.w #DMAF_RASTER,dmacon(a6)
	moveq.l #2,d0
	jsr LoadBootResource(pc)
	jsr abs_0_00078610(pc)
	jmp $00000800.l
abs_0_000780FA:
	jsr abs_0_00078676(pc)
	lea.l _custom.l,a6
	move.w #INTF_DSKBLK,intreq(a6)
	move.l a0,dskpt(a6)	; disk_buffer pointer $00000800
	move.w #$4124,dsksync(a6)	; disk sync word $4124
	move.w #ADKF_PRE560NS|ADKF_MFMPREC|ADKF_UARTBRK|ADKF_WORDSYNC|ADKF_MSBSYNC|ADKF_FAST,adkcon(a6)
	move.w #ADKF_SETCLR|ADKF_MFMPREC|ADKF_UARTBRK|ADKF_WORDSYNC|ADKF_FAST,adkcon(a6)
	move.w #$4000,dsklen(a6)
	move.w #$9B58,dsklen(a6)	; disk DMA read 14000 bytes
	move.w #$9B58,dsklen(a6)	; disk DMA read 14000 bytes
	jsr WaitBootDiskDma(pc)
	rts
abs_0_00078138:
	move.w #$4124,d1
	cmp.w (a0)+,d1
	bne.w abs_0_0007815A
	moveq.l #-1,d0
abs_0_00078144:
	addq.w #1,d0
	cmp.w (a0)+,d1
	bne.b abs_0_00078144
	subi.w #6400,d0
	bpl.b abs_0_00078156
	jmp abs_0_000788DA.l
abs_0_00078156:
	clr.w d0
	rts
abs_0_0007815A:
	move.w #$FFFF,d0
	rts
InitializeBootFloppyReader:
	lea.l _custom.l,a6
	lea.l _ciaa.l,a5
	lea.l _ciab.l,a4
	move.w #$4000,dsklen(a6)
	move.w #DMAF_SETCLR|DMAF_MASTER|DMAF_DISK,dmacon(a6)
	move.w #$4489,dsksync(a6)	; disk sync word $4489
	move.w #ADKF_PRE140NS,adkcon(a6)
	move.w #ADKF_PRE280NS,adkcon(a6)
	move.w #ADKF_SETCLR|ADKF_MFMPREC,adkcon(a6)
	move.w #ADKF_UARTBRK,adkcon(a6)
	move.w #ADKF_SETCLR|ADKF_WORDSYNC,adkcon(a6)
	move.w #ADKF_MSBSYNC,adkcon(a6)
	move.w #ADKF_SETCLR|ADKF_FAST,adkcon(a6)
	move.b #$FF,ciaddrb(a4)
	move.b #$3,ciaddra(a5)
	jsr StartBootDrive0Motor(pc)
	jsr abs_0_000785C4(pc)
	jsr abs_0_00078610(pc)
	rts
abs_0_000781C8:
	dc.l $00000000
ReadBootDecodedTrack:
	lea.l _custom.l,a6
	move.l #$0,abs_0_000781C8.l
	move.w #$5,abs_0_00078898.l
	move.w #$A,abs_0_0007889E.l
abs_0_000781EC:
	jsr abs_0_00078676(pc)
abs_0_000781F0:
	jsr ReadBootRawTrack(pc)
	move.w $0007A4FC.l,d0
	jsr DecodeBootMfmByte(pc)
	cmp.w abs_0_0007889C(pc),d0
	beq.b abs_0_00078214
	subq.w #1,abs_0_00078898.l
	bmi.w abs_0_000782D6
	jsr abs_0_000787E8(pc)
	bra.b abs_0_000781F0
abs_0_00078214:
	move.w #$2,abs_0_000788A0.l
	lea.l absolute_slot_0007A4F8.l,a5
abs_0_00078222:
	move.w $0006(a5),d0
	jsr DecodeBootMfmByte(pc)
	cmp.w #$2,d0
	bgt.w abs_0_0007828E
	lea.l abs_0_000781C8(pc),a4
	tst.b $0(a4,d0.w)
	bne.b abs_0_0007828E
	move.w d0,d7
	lea.l abs_0_00078942.l,a0
	mulu.w #$7D0,d0
	adda.l d0,a0
	movea.l a0,a2
	move.w $0FA8(a5),d0
	jsr DecodeBootMfmByte(pc)
	move.w d0,d4
	lsl.w #8,d4
	move.w $0FAA(a5),d0
	jsr DecodeBootMfmByte(pc)
	or.w d0,d4
	lea.l $0008(a5),a0
	move.w #$3E7,d0
	jsr ChecksumBootEncodedWords(pc)
	cmp.w d1,d4
	beq.b abs_0_00078274
	bra.b abs_0_0007828E
abs_0_00078274:
	move.w d7,d0
	move.w #$7CF,d0
	movea.l a2,a0
	lea.l $0008(a5),a1
	jsr DecodeBootMfmBytes(pc)
	lea.l abs_0_000781C8(pc),a4
	move.b #$FF,$0(a4,d7.w)
abs_0_0007828E:
	lea.l $0FC8(a5),a5
	subq.w #1,abs_0_000788A0.l
	bpl.w abs_0_00078222
	move.l abs_0_000781C8(pc),d0
	cmp.l #$FFFFFF00,d0
	beq.b abs_0_000782DE
	subq.w #1,abs_0_0007889E.l
	cmpi.w #5,abs_0_0007889E.l
	bgt.w abs_0_000781F0
	bpl.w abs_0_000781EC
	subq.w #1,abs_0_00078898.l
	bmi.b abs_0_000782D6
	jsr abs_0_000787E8(pc)
	move.w #$A,abs_0_0007889E.l
	bra.w abs_0_000781F0
abs_0_000782D6:
	move.l abs_0_000781C8(pc),d1
	moveq.l #-1,d0
	rts
abs_0_000782DE:
	move.l abs_0_000781C8(pc),d1
	moveq.l #0,d0
	rts
ReadBootRawTrack:
	move.w #$2,$009C(a6)
	move.l #$7A4F8,$0020(a6)
	move.w #$4489,$007E(a6)
	move.w #$7F00,$009E(a6)
	move.w #$9D00,$009E(a6)
	move.w #$4000,$0024(a6)
	move.w #$97BC,$0024(a6)
	move.w #$97BC,$0024(a6)
	jsr WaitBootDiskDma(pc)
	rts
	dc.b $4E,$BA,$03,$56,$4D,$F9,$00,$DF,$F0,$00,$3D,$7C,$00,$02,$00,$9C
	dc.b $2D,$7C,$00,$07,$A4,$F8,$00,$20,$3D,$7C,$41,$24,$00,$7E,$3D,$7C
	dc.b $7F,$00,$00,$9E,$3D,$7C,$9D,$00,$00,$9E,$3D,$7C,$40,$00,$00,$24
	dc.b $3D,$7C,$9B,$58,$00,$24,$3D,$7C,$9B,$58,$00,$24,$4E,$BA,$01,$86
	dc.b $4E,$75,$2F,$08,$4E,$BA,$04,$10,$20,$57,$43,$F9,$00,$07,$89,$4E
	dc.b $30,$3C,$01,$F3,$4E,$BA,$00,$2E,$43,$F9,$00,$07,$91,$32,$30,$3C
	dc.b $01,$F3,$4E,$BA,$00,$20,$43,$F9,$00,$07,$99,$16,$30,$3C,$01,$F3
	dc.b $4E,$BA,$00,$12,$4E,$BA,$04,$14,$4E,$BA,$00,$12,$4E,$BA,$00,$80
	dc.b $20,$5F,$4E,$75,$22,$D8,$51,$C8,$FF,$FC,$4E,$75,$41,$F9,$00,$07
	dc.b $A5,$1C,$30,$3C,$03,$E7,$4E,$BA,$04,$50,$30,$01,$49,$F9,$00,$07
	dc.b $B4,$BC,$4E,$BA,$03,$1C,$28,$81,$4E,$BA,$00,$44,$41,$F9,$00,$07
	dc.b $B4,$E4,$30,$3C,$03,$E7,$4E,$BA,$04,$30,$30,$01,$49,$F9,$00,$07
	dc.b $C4,$84,$4E,$BA,$02,$FC,$28,$81,$4E,$BA,$00,$24,$41,$F9,$00,$07
	dc.b $C4,$AC,$30,$3C,$03,$E7,$4E,$BA,$04,$10,$30,$01,$49,$F9,$00,$07
	dc.b $D4,$4C,$4E,$BA,$02,$DC,$28,$81,$4E,$BA,$00,$04,$4E,$75,$08,$2C
	dc.b $00,$00,$00,$03,$67,$06,$08,$AC,$00,$07,$00,$04,$4E,$75,$4D,$F9
	dc.b $00,$DF,$F0,$00,$4B,$F9,$00,$BF,$E0,$01,$08,$2D,$00,$03,$00,$00
	dc.b $67,$48,$40,$E7,$00,$7C,$07,$00,$4E,$BA,$02,$3E,$3D,$7C,$00,$02
	dc.b $00,$9C,$2D,$7C,$00,$07,$A4,$F8,$00,$20,$3D,$7C,$7F,$00,$00,$9E
	dc.b $30,$3C,$99,$00,$3D,$40,$00,$9E,$3D,$7C,$40,$00,$00,$24,$3D,$7C
	dc.b $D7,$BC,$00,$24,$3D,$7C,$D7,$BC,$00,$24,$4E,$BA,$00,$78,$3D,$7C
	dc.b $40,$00,$00,$24,$46,$DF,$70,$FF,$4E,$75,$70,$00,$4E,$75,$4D,$F9
	dc.b $00,$DF,$F0,$00,$4B,$F9,$00,$BF,$E0,$01,$08,$2D,$00,$03,$00,$00
	dc.b $67,$4E,$40,$E7,$00,$7C,$07,$00,$4E,$BA,$01,$DE,$3D,$7C,$00,$02
	dc.b $00,$9C,$2D,$7C,$00,$07,$A4,$F8,$00,$20,$3D,$7C,$7F,$00,$00,$9E
	dc.b $3D,$7C,$7F,$FF,$00,$9E,$30,$3C,$99,$00,$3D,$40,$00,$9E,$3D,$7C
	dc.b $40,$00,$00,$24,$3D,$7C,$DB,$58,$00,$24,$3D,$7C,$DB,$58,$00,$24
	dc.b $4E,$BA,$00,$12,$3D,$7C,$40,$00,$00,$24,$46,$DF,$70,$FF,$4E,$75
	dc.b $70,$00,$4E,$75
WaitBootDiskDma:
	lea.l _custom.l,a6
abs_0_000784E8:
	move.w intreqr(a6),d0	; interrupt request state
	andi.w #2,d0
	beq.b abs_0_000784E8
	move.w #INTF_DSKBLK,intreq(a6)
	rts
SeekBootLogicalTrack:
	move.w d0,d1
	lea.l _ciaa.l,a5
	lea.l _ciab.l,a4
	bclr.b #CIAB_DSKSIDE,ciaprb(a4)
	btst #0,d1
	beq.b abs_0_0007851A
	bset.b #CIAB_DSKSIDE,ciaprb(a4)
abs_0_0007851A:
	cmpi.w #160,d1
	bge.b abs_0_0007856E
	move.w d1,d2
	move.w abs_0_0007889C(pc),d0
	lsr.w #1,d0
	lsr.w #1,d1
	sub.w d0,d1
	beq.b abs_0_00078568
	bmi.b abs_0_00078538
	bclr.b #CIAB_DSKDIREC,ciaprb(a4)
	bra.b abs_0_00078540
abs_0_00078538:
	bset.b #CIAB_DSKDIREC,ciaprb(a4)
	neg.w d1
abs_0_00078540:
	subq.w #1,d1
abs_0_00078542:
	bset.b #CIAB_DSKSTEP,ciaprb(a4)
	bclr.b #CIAB_DSKSTEP,ciaprb(a4)
	nop
	nop
	nop
	nop
	bset.b #CIAB_DSKSTEP,ciaprb(a4)
	move.w #$FA0,d0
abs_0_00078560:
	dbf.w d0,abs_0_00078560
	dbf.w d1,abs_0_00078542
abs_0_00078568:
	lea.l abs_0_0007889C(pc),a4
	move.w d2,(a4)
abs_0_0007856E:
	rts
AdvanceBootLogicalTrack:
	lea.l _ciab.l,a4
	bclr.b #CIAB_DSKDIREC,ciaprb(a4)
	move.w abs_0_0007889C(pc),d0
	addq.w #1,d0
	cmpi.w #160,d0
	beq.b abs_0_000785C2
	lea.l abs_0_0007889C(pc),a0
	move.w d0,(a0)
	bclr.b #CIAB_DSKSIDE,ciaprb(a4)
	lsr.w #1,d0
	bcc.b abs_0_000785A0
	bset.b #CIAB_DSKSIDE,ciaprb(a4)
	bra.b abs_0_000785C2
abs_0_000785A0:
	bset.b #CIAB_DSKSTEP,ciaprb(a4)
	bclr.b #CIAB_DSKSTEP,ciaprb(a4)
	nop
	nop
	nop
	nop
	bset.b #CIAB_DSKSTEP,ciaprb(a4)
	move.w #$FA0,d0
abs_0_000785BE:
	dbf.w d0,abs_0_000785BE
abs_0_000785C2:
	rts
abs_0_000785C4:
	lea.l _ciaa.l,a5
	lea.l _ciab.l,a4
	bset.b #CIAB_DSKDIREC,ciaprb(a4)
abs_0_000785D6:
	btst.b #CIAB_DSKTRACK0,ciapra.w(a5)
	beq.b abs_0_00078602
	bset.b #CIAB_DSKSTEP,ciaprb(a4)
	bclr.b #CIAB_DSKSTEP,ciaprb(a4)
	nop
	nop
	nop
	nop
	bset.b #CIAB_DSKSTEP,ciaprb(a4)
	move.w #$FA0,d0
abs_0_000785FC:
	dbf.w d0,abs_0_000785FC
	bra.b abs_0_000785D6
abs_0_00078602:
	lea.l abs_0_0007889C(pc),a4
	clr.w (a4)
	bclr.b #2,$0100(a4)
	rts
abs_0_00078610:
	lea.l _ciab.l,a4
	bset.b #CIAB_DSKSEL0,ciaprb(a4)
	bset.b #CIAB_DSKMOTOR,ciaprb(a4)
	nop
	nop
	nop
	bclr.b #CIAB_DSKSEL0,ciaprb(a4)
	nop
	nop
	nop
	nop
	nop
	bset.b #CIAB_DSKSEL0,ciaprb(a4)
	rts
StartBootDrive0Motor:
	lea.l _ciab.l,a4
	bset.b #CIAB_DSKSEL0,ciaprb(a4)
	bclr.b #CIAB_DSKMOTOR,ciaprb(a4)
	bclr.b #CIAB_DSKSEL0,ciaprb(a4)
	jsr WaitBootDriveReady(pc)
	rts
WaitBootDriveReady:
	move.w #$BB8,d0
abs_0_00078662:
	dbf.w d0,abs_0_00078662
	lea.l _ciaa.l,a4
abs_0_0007866C:
	btst.b #CIAB_DSKRDY,ciapra.w(a4)
	bne.b abs_0_0007866C
	rts
abs_0_00078676:
	lea.l _ciab.l,a4
abs_0_0007867C:
	btst.b #CIAICRB_FLG,ciaicr(a4)
	bne.b abs_0_0007867C
abs_0_00078684:
	btst.b #CIAICRB_FLG,ciaicr(a4)
	beq.b abs_0_00078684
	rts
DecodeBootMfmBytes:
	moveq.l #0,d1
	moveq.l #7,d2
	move.w (a1)+,d3
abs_0_00078694:
	lsl.w #1,d3
	lsl.l #1,d3
	dbf.w d2,abs_0_00078694
	swap.w d3
	move.b d3,(a0)+
	dbf.w d0,DecodeBootMfmBytes
	rts
DecodeBootMfmByte:
	moveq.l #7,d2
abs_0_000786A8:
	lsl.w #1,d0
	lsl.l #1,d0
	dbf.w d2,abs_0_000786A8
	swap.w d0
	andi.w #255,d0
	rts
	dc.b $74,$00,$76,$FF,$7C,$05,$7E,$02,$14,$18,$72,$07,$E3,$8B,$E3,$12
	dc.b $E3,$93,$3A,$03,$CA,$46,$66,$02,$86,$47,$51,$C9,$FF,$F0,$32,$C3
	dc.b $51,$C8,$FF,$E6,$4E,$75,$38,$00,$74,$00,$26,$2C,$FF,$FC,$7C,$05
	dc.b $7E,$02,$34,$00,$E0,$4A,$72,$07,$E3,$8B,$E3,$12,$E3,$93,$3A,$03
	dc.b $CA,$46,$66,$02,$86,$47,$51,$C9,$FF,$F0,$14,$04,$38,$03,$48,$44
	dc.b $02,$42,$00,$FF,$72,$07,$E3,$8B,$E3,$12,$E3,$93,$3A,$03,$CA,$46
	dc.b $66,$02,$86,$47,$51,$C9,$FF,$F0,$38,$03,$22,$04,$4E,$75,$3F,$00
	dc.b $4E,$BA,$FD,$D0,$4E,$BA,$00,$2E,$4E,$BA,$FD,$4A,$30,$17,$4E,$BA
	dc.b $00,$3C,$4E,$BA,$00,$6C,$4E,$BA,$FC,$6A,$4E,$BA,$FC,$D8,$4A,$40
	dc.b $67,$00,$00,$08,$42,$41,$30,$1F,$4E,$75,$50,$F9,$00,$07,$89,$3A
	dc.b $30,$1F,$4E,$75,$41,$F9,$00,$07,$A4,$F8,$20,$3C,$AA,$AA,$AA,$AA
	dc.b $32,$3C,$0F,$9F,$20,$C0,$51,$C9,$FF,$FC,$4E,$75,$41,$F9,$00,$07
	dc.b $89,$3C,$72,$00,$34,$3C,$06,$D5,$20,$C1,$51,$CA,$FF,$FC,$22,$3C
	dc.b $00,$FF,$00,$00,$41,$F9,$00,$07,$89,$3C,$E1,$48,$82,$40,$21,$41
	dc.b $00,$0E,$52,$41,$21,$41,$07,$F2,$52,$41,$21,$41,$0F,$D6,$4E,$75
	dc.b $41,$F9,$00,$07,$89,$3C,$43,$F9,$00,$07,$A4,$F8,$30,$3C,$18,$69
	dc.b $4E,$BA,$FE,$FE,$43,$F9,$00,$07,$A4,$F8,$33,$7C,$44,$89,$00,$1A
	dc.b $33,$7C,$44,$89,$00,$1C,$33,$7C,$44,$89,$0F,$E2,$33,$7C,$44,$89
	dc.b $0F,$E4,$33,$7C,$44,$89,$1F,$AA,$33,$7C,$44,$89,$1F,$AC,$4E,$75
abs_0_000787E8:
	move.w abs_0_0007889C(pc),abs_0_0007889A.l
	jsr abs_0_000785C4(pc)
	jsr abs_0_00078610(pc)
	jsr StartBootDrive0Motor(pc)
	move.w abs_0_0007889A(pc),d0
	jsr SeekBootLogicalTrack(pc)
	rts
ChecksumBootEncodedWords:
	move.w d2,-(a7)
	moveq.l #0,d1
	move.w d1,d2
abs_0_0007880C:
	move.w (a0)+,d2
	eor.w d2,d1
	move.w (a0)+,d2
	eor.w d2,d1
	dbf.w d0,abs_0_0007880C
	move.w (a7)+,d2
	rts
    ; Original resource order 0: title, 1: $800/456000 bytes, 2: $6FD40/33472 bytes; main segments are adjacent.
LoadBootResource:
	lea.l bootResourceCatalog(pc),a0
	lea.l bootResourceWork(pc),a1
	movea.l a1,a3
	mulu.w #$10,d0
	lea.l $0(a0,d0.w),a0
	moveq.l #15,d1
abs_0_00078830:
	move.b (a0)+,(a1)+
	dbf.w d1,abs_0_00078830
	move.l DiskResourceDescriptor_start_track(a3),d0
	jsr SeekBootLogicalTrack(pc)
abs_0_0007883E:
	jsr ReadBootDecodedTrack(pc)
	tst.w d0
	bmi.b abs_0_0007888C
	move.l #$1770,d0
	sub.l DiskResourceDescriptor_track_offset(a3),d0
	cmp.l DiskResourceDescriptor_remaining_bytes(a3),d0
	ble.b abs_0_0007885A
	move.l DiskResourceDescriptor_remaining_bytes(a3),d0
abs_0_0007885A:
	lea.l abs_0_00078942.l,a0
	adda.l DiskResourceDescriptor_track_offset(a3),a0
	move.l d0,d1
	subq.w #1,d0
	movea.l DiskResourceDescriptor_destination.w(a3),a1
abs_0_0007886C:
	move.b (a0)+,(a1)+
	dbf.w d0,abs_0_0007886C
	move.l a1,DiskResourceDescriptor_destination.w(a3)
	jsr AdvanceBootLogicalTrack(pc)
	addq.l #1,DiskResourceDescriptor_start_track(a3)
	clr.l DiskResourceDescriptor_track_offset(a3)
	sub.l d1,DiskResourceDescriptor_remaining_bytes(a3)
	beq.b abs_0_0007888A
	bpl.b abs_0_0007883E
abs_0_0007888A:
	rts
abs_0_0007888C:
	jsr abs_0_00078610(pc)
	st.b abs_0_0007893A.l
	rts
abs_0_00078898:
	dc.w $0000
abs_0_0007889A:
	dc.w $0000
abs_0_0007889C:
	dc.w $0000
abs_0_0007889E:
	dc.w $0000
abs_0_000788A0:
	dc.w $0000
bootResourceWork:
	dc.l $00000000,$00000000,$00000000,$00000000
	dc.b $00,$E0,$00,$07,$00,$E2,$00,$00,$00,$E4,$00,$07,$00,$E6,$1F,$40
	dc.b $00,$E8,$00,$07,$00,$EA,$3E,$80,$00,$EC,$00,$07,$00,$EE,$5D,$C0
	dc.b $F3,$DF,$FF,$FE,$FF,$FF,$FF,$FE
abs_0_000788DA:
	lea.l abs_0_000788DA(pc),a0
	lea.l $0014(a0),a1
	moveq.l #0,d0
abs_0_000788E4:
	move.l d0,-(a0)
	move.l d0,(a1)+
	bra.b abs_0_000788E4
bootResourceCatalog:	; ARRAY DiskResourceDescriptor[3]
	dc.l $00058000,$00000055,$00000000,$00007D00
	dc.l $00000800,$00000003,$00000000,$0006F540
	dc.l $0006FD40,$0000004F,$00000000,$000082C0
abs_0_0007891A:
	dc.b $00,$00,$0C,$02,$0E,$22,$0E,$66,$00,$48,$02,$6A,$06,$66,$0C,$00
	dc.b $0A,$02,$08,$64,$0C,$A8,$0A,$EA,$08,$88,$0E,$E0,$0A,$AA,$0E,$EE
abs_0_0007893A:
	dcb.b $8,$00
abs_0_00078942:
	dcb.b $9,$00
	dc.b $01,$00,$01
	dcb.b $13,$00
	dc.b $10,$00,$38,$00,$38
	dcb.b $2D,$00
	dc.b $40,$00,$40,$00,$40
	dcb.b $B,$00
	dc.b $08,$00,$08,$00,$00,$00,$00,$00,$01,$00,$01,$00,$00,$80,$00,$C0
	dc.b $00,$C0,$00,$80,$00,$00,$00,$02,$00,$02
	dcb.b $8,$00
	dc.b $10,$00,$10
	dcb.b $39,$00
	dc.b $38,$00,$38,$00,$38,$00,$10
	dcb.b $3A,$00
	dc.b $40,$08,$40,$08,$00,$00,$00,$01,$00,$01,$00,$01,$00,$01,$C0,$00
	dc.b $C0,$00,$C0,$00,$C0
	dcb.b $B,$00
	dc.b $01,$00,$01
	dcb.b $15,$00
	dc.b $40,$00,$40
	dcb.b $15,$00
	dc.b $08,$40,$08,$40,$00,$40,$00,$00,$00,$02,$00,$02,$00,$00,$00,$10
	dc.b $02,$38,$02,$38
	dcb.b $D,$00
	dc.b $20,$00,$20
	dcb.b $2F,$00
	dc.b $08,$00,$08,$00,$00,$00,$01,$00,$01,$00,$00,$80,$00,$C0,$00,$C0
	dc.b $00,$80
	dcb.b $C,$00
	dc.b $08,$00,$28,$00,$20
	dcb.b $B,$00
	dc.b $02,$00,$02,$00,$00,$00,$00,$04,$00,$04,$00,$00,$00,$00,$00,$04
	dc.b $00,$04
	dcb.b $D,$00
	dc.b $40,$00,$40,$00,$40
	dcb.b $A,$00
	dc.b $01,$00,$01,$00,$01,$00,$01
	dcb.b $A,$00
	dc.b $50,$00,$50,$00,$10
	dcb.b $2C,$00
	dc.b $08,$00,$08
	dcb.b $A,$00
	dc.b $80,$00,$80,$00,$80,$00,$80
	dcb.b $E,$00
	dc.b $01,$00,$01
	dcb.b $C,$00
	dc.b $20,$00,$20,$00,$00,$00,$80,$00,$80,$00,$80,$00,$00,$00,$00,$00
	dc.b $04,$00,$04
	dcb.b $5B,$00
	dc.b $10,$00,$10,$08,$00,$08
	dcb.b $8,$00
	dc.b $80,$00,$80,$00,$80,$00,$80
	dcb.b $29,$00
	dc.b $04,$00,$0E,$00,$0E
	dcb.b $D,$00
	dc.b $02,$00,$02
	dcb.b $26,$00
	dc.b $80,$00,$80,$00,$00,$00,$00,$00,$04,$00,$04,$00,$04
	dcb.b $10,$00
	dc.b $01,$00,$01,$00,$01,$00,$00,$00,$04,$00,$04,$08,$04,$08
	dcb.b $8,$00
	dc.b $40,$00,$80,$00,$80,$00,$80
	dcb.b $10,$00
	dc.b $24,$00,$24,$80,$00,$90,$00,$90,$00,$80,$00,$00,$00,$00,$10,$00
	dc.b $10
	dcb.b $A,$00
	dc.b $0E,$00,$2E,$80,$3F,$80,$15,$00,$00,$00,$00,$02,$00,$02,$00,$00
	dc.b $00,$00,$00,$40,$00,$40,$00,$40
	dcb.b $13,$00
	dc.b $02,$00,$02
	dcb.b $37,$00
	dc.b $08,$00,$08
	dcb.b $8,$00
	dc.b $80,$00,$80,$00,$80,$00,$00,$00,$00,$00,$10,$00,$10
	dcb.b $23,$00
	dc.b $04,$00,$0E,$00,$0E
	dcb.b $D,$00
	dc.b $10,$00,$10
	dcb.b $C,$00
	dc.b $08,$00,$48,$00,$48,$00,$08
	dcb.b $23,$00
	dc.b $04,$00,$04,$00,$00,$00,$00,$40,$00,$40,$00,$00,$00,$00,$00,$40
	dc.b $00,$40,$00,$00,$00,$00,$00,$00,$08,$00,$08
	dcb.b $8,$00
	dc.b $40,$00,$80,$00,$80,$00,$80,$00,$00,$00,$10,$00,$10,$00,$10,$02
	dc.b $50,$02
	dcb.b $C,$00
	dc.b $40,$00,$40,$00,$00,$00,$00,$48,$00,$48,$00,$08
	dcb.b $C,$00
	dc.b $04,$00,$04,$00,$00,$00,$00,$80,$00,$80
	dcb.b $44,$00
	dc.b $02,$00,$02
	dcb.b $D,$00
	dc.b $04,$00,$04,$08,$00,$08,$00,$00,$40,$00,$00,$00,$00,$00,$80,$00
	dc.b $80,$00,$80,$00,$00,$00,$10,$00,$10,$00,$10,$00,$10
	dcb.b $23,$00
	dc.b $04,$00,$04,$00,$00,$00,$00,$01,$00,$01,$00,$01,$00,$01,$00,$00
	dc.b $40,$80,$40,$80
	dcb.b $15,$00
	dc.b $01,$00,$01
	dcb.b $25,$00
	dc.b $40,$00,$40
	dcb.b $F,$00
	dc.b $08,$00,$08,$00,$00,$00,$00,$00,$00,$40,$00,$80,$00,$80,$00,$80
	dc.b $00,$00,$00,$00,$00,$00,$00,$10,$00,$50
	dcb.b $D,$00
	dc.b $04,$00,$04
	dcb.b $31,$00
