; Memory map
;   code[$00000000-$0000738A] -> runtime[$00058000-$0005F38A] policy materialized

; AmigaOS compatibility
;   required OS floor: unknown
;   evidence: no recovered OS calls

 INCLUDE "platform/amiga-export-symbols.i"

; STRUCT AudioInstrument
    RSRESET
AudioInstrument_sample_offset RS.L 1
AudioInstrument_repeat_offset RS.L 1
AudioInstrument_sample_length_words RS.W 1
AudioInstrument_repeat_length_words RS.W 1
AudioInstrument_base_volume RS.W 1
AudioInstrument_volume_delta RS.W 1
AudioInstrument_initial_ramp_ticks RS.W 1
AudioInstrument_initial_period_scale RS.W 1
AudioInstrument_alternating_ticks RS.W 1
AudioInstrument_alternating_period_scale RS.W 1
AudioInstrument_pitch_reference_note RS.W 1
AudioInstrument_period_scale RS.W 1
AudioInstrument_SIZEOF EQU __RS

; STRUCT Bank5Voice
    RSRESET
Bank5Voice_dma_mask RS.W 1
Bank5Voice_irq_mask RS.W 1
Bank5Voice_custom_offset RS.W 1
Bank5Voice_playback_phase RS.W 1
Bank5Voice_base_period RS.W 1
Bank5Voice_period_slide_offset RS.W 1
Bank5Voice_volume RS.W 1
Bank5Voice_volume_step_interval RS.W 1
Bank5Voice_volume_step_delta RS.W 1
Bank5Voice_volume_step_countdown RS.W 1
Bank5Voice_hold_ticks RS.W 1
Bank5Voice_initial_period_steps_left RS.W 1
Bank5Voice_initial_period_step RS.W 1
Bank5Voice_alternating_period_steps_left RS.W 1
Bank5Voice_period_modulation_offset RS.W 1
Bank5Voice_alternating_period_step RS.W 1
Bank5Voice_update_callback RS.L 1
Bank5Voice_instrument_pointer RS.L 1
Bank5Voice_SIZEOF EQU __RS

; STRUCT Bank5PatternNote
    RSRESET
Bank5PatternNote_note RS.B 1
Bank5PatternNote_ticks RS.B 1
Bank5PatternNote_SIZEOF EQU __RS

; STRUCT Bank5PatternRest
    RSRESET
Bank5PatternRest_rest_code RS.B 1
Bank5PatternRest_ticks RS.B 1
Bank5PatternRest_SIZEOF EQU __RS

; STRUCT Bank5OrderParameter
    RSRESET
Bank5OrderParameter_command RS.B 1
Bank5OrderParameter_parameter RS.B 1
Bank5OrderParameter_SIZEOF EQU __RS

; STRUCT Bank5PatternTrackPrefix
    RSRESET
Bank5PatternTrackPrefix_instrument_map_offset RS.W 1
Bank5PatternTrackPrefix_order_cursor RS.L 1
Bank5PatternTrackPrefix_pattern_start RS.L 1
Bank5PatternTrackPrefix_pattern_cursor RS.L 1
Bank5PatternTrackPrefix_instrument_pointer RS.L 1
Bank5PatternTrackPrefix_order_repeat_count RS.B 1
Bank5PatternTrackPrefix_transpose RS.B 1
Bank5PatternTrackPrefix_pattern_finished RS.B 1
Bank5PatternTrackPrefix_note_ticks RS.B 1
Bank5PatternTrackPrefix_active RS.B 1
Bank5PatternTrackPrefix_current_note RS.B 1
Bank5PatternTrackPrefix_first_note RS.B 1
    RS.B 1
Bank5PatternTrackPrefix_note_instrument_pointer RS.L 1
Bank5PatternTrackPrefix_reference_note RS.B 1
Bank5PatternTrackPrefix_period_slide_enabled RS.B 1
Bank5PatternTrackPrefix_period_slide_delay RS.B 1
Bank5PatternTrackPrefix_period_slide_steps RS.B 1
Bank5PatternTrackPrefix_slide_note_delta RS.B 1
Bank5PatternTrackPrefix_note_slide_flags RS.B 1
Bank5PatternTrackPrefix_note_slide_delay RS.B 1
Bank5PatternTrackPrefix_note_slide_steps_left RS.B 1
Bank5PatternTrackPrefix_slide_ratio_or_step RS.L 1
Bank5PatternTrackPrefix_slide_from_previous_note RS.B 1
Bank5PatternTrackPrefix_volume_mod_enabled RS.B 1
Bank5PatternTrackPrefix_volume_mod_interval RS.B 1
Bank5PatternTrackPrefix_volume_mod_steps RS.B 1
Bank5PatternTrackPrefix_volume_mod_delta RS.W 1
Bank5PatternTrackPrefix_note_volume_mod_enabled RS.B 1
Bank5PatternTrackPrefix_note_volume_mod_interval RS.B 1
Bank5PatternTrackPrefix_note_volume_mod_countdown RS.B 1
Bank5PatternTrackPrefix_note_volume_mod_steps_left RS.B 1
Bank5PatternTrackPrefix_note_volume_mod_step RS.W 1
Bank5PatternTrackPrefix_note_volume_mod_offset RS.W 1
Bank5PatternTrackPrefix_volume_scale RS.W 1
Bank5PatternTrackPrefix_volume_step_interval RS.W 1
Bank5PatternTrackPrefix_volume_step_delta RS.W 1
Bank5PatternTrackPrefix_command_nibble RS.B 1
    RS.B 7
Bank5PatternTrackPrefix_encoded_note_command RS.B 1
Bank5PatternTrackPrefix_SIZEOF EQU __RS

_ciaa	EQU	$BFE001
_custom	EQU	$DFF000
m68k_vector_level_4_interrupt_autovector	EQU	$70

    SECTION code,code
    ; Resource-5 start ABI entry forwards to this bank's initializer.
MusicEntryStart:
    ORG $58000
abs_0_00058000:
	bra.w Bank5StartSong
MusicEntryTick:
	bra.w Bank5UpdateSong
bank5PlaybackActive:
	dc.b $00,$00,$60,$00,$0E,$A4
MusicEntryStop:
	lea.l bank5PlaybackActive(pc),a0
	clr.w (a0)
	bra.w Bank5MuteAudio
bank5PitchOctaveRatios:
	dc.l $00001000,$000010F3,$000011F5,$00001306
	dc.l $00001429,$0000155B,$000016A0,$000017F9
	dc.l $00001965,$00001AE9,$00001C82,$00001E34
	dc.l $00002000,$000021E7,$000023EB,$0000260D
	dc.l $00002851,$00002AB7,$00002D41,$00002FF2
	dc.l $000032CC,$000035D1,$00003904,$00003C68
	dc.l $00004000,$000043CE,$000047D6,$00004C1B
	dc.l $000050A2,$0000556E,$00005A82,$00005FE4
	dc.l $00006597,$00006BA2,$00007208,$000078D0
	dc.l $00008000,$0000879C,$00008FAC,$00009837
	dc.l $0000A145,$0000AADC,$0000B504,$0000BFC8
	dc.l $0000CB2F,$0000D744,$0000E411,$0000F1A1
bank5PitchScaleTable:
	dc.l $00010000,$00010F38,$00011F59,$0001306F
	dc.l $0001428A,$000155B8,$00016A09,$00017F91
	dc.l $0001965F,$0001AE89,$0001C823,$0001E343
	dc.l $00020000,$00021E71,$00023EB3,$000260DF
	dc.l $00028514,$0002AB70,$0002D413,$0002FF22
	dc.l $00032CBF,$00035D13,$00039047,$0003C686
	dc.l $00040000,$00043CE3,$00047D66,$0004C1BF
	dc.l $00050A28,$000556E0,$0005A827,$0005FE44
	dc.l $0006597F,$0006BA27,$0007208F,$00078D0D
	dc.l $00080000,$000879C7,$0008FACD,$0009837F
	dc.l $000A1451,$000AADC0,$000B504F,$000BFC88
	dc.l $000CB2FF,$000D7450,$000E411F,$000F1A1B
	dc.l $00100000,$0010F38F,$0011F59A,$001307B2
	dc.l $001428A2,$00155B81,$0016A09E,$0017F910
	dc.l $001965FE,$001AE8A0,$001C823E,$001E3438
	dc.l $00200000,$0021E71F,$0023EB35,$00260DFC
	dc.l $00285145,$002AB702,$002D413C,$002FF221
	dc.l $0032CBFD,$0035D13F,$0039047C,$003C6870
bank5Voices:
	dc.w $0001	; dma_mask
	dc.w $0080	; irq_mask
	dc.w $00A0	; custom_offset
	dc.w $0000	; playback_phase
	dc.w $0000	; base_period
	dc.w $0000	; period_slide_offset
	dc.w $0000	; volume
	dc.w $0000	; volume_step_interval
	dc.w $0000	; volume_step_delta
	dc.w $0000	; volume_step_countdown
	dc.w $0000	; hold_ticks
	dc.w $0000	; initial_period_steps_left
	dc.w $0000	; initial_period_step
	dc.w $0000	; alternating_period_steps_left
	dc.w $0000	; period_modulation_offset
	dc.w $0000	; alternating_period_step
	dc.l $00000000	; update_callback
	dc.l $00000000	; instrument_pointer
bank5Voice1:
	dc.w $0002	; dma_mask
	dc.w $0100	; irq_mask
	dc.w $00B0	; custom_offset
	dc.w $0000	; playback_phase
	dc.w $0000	; base_period
	dc.w $0000	; period_slide_offset
	dc.w $0000	; volume
	dc.w $0000	; volume_step_interval
	dc.w $0000	; volume_step_delta
	dc.w $0000	; volume_step_countdown
	dc.w $0000	; hold_ticks
	dc.w $0000	; initial_period_steps_left
	dc.w $0000	; initial_period_step
	dc.w $0000	; alternating_period_steps_left
	dc.w $0000	; period_modulation_offset
	dc.w $0000	; alternating_period_step
	dc.l $00000000	; update_callback
	dc.l $00000000	; instrument_pointer
bank5Voice2:
	dc.w $0004	; dma_mask
	dc.w $0200	; irq_mask
	dc.w $00C0	; custom_offset
	dc.w $0000	; playback_phase
	dc.w $0000	; base_period
	dc.w $0000	; period_slide_offset
	dc.w $0000	; volume
	dc.w $0000	; volume_step_interval
	dc.w $0000	; volume_step_delta
	dc.w $0000	; volume_step_countdown
	dc.w $0000	; hold_ticks
	dc.w $0000	; initial_period_steps_left
	dc.w $0000	; initial_period_step
	dc.w $0000	; alternating_period_steps_left
	dc.w $0000	; period_modulation_offset
	dc.w $0000	; alternating_period_step
	dc.l $00000000	; update_callback
	dc.l $00000000	; instrument_pointer
bank5Voice3:
	dc.w $0008	; dma_mask
	dc.w $0400	; irq_mask
	dc.w $00D0	; custom_offset
	dc.w $0000	; playback_phase
	dc.w $0000	; base_period
	dc.w $0000	; period_slide_offset
	dc.w $0000	; volume
	dc.w $0000	; volume_step_interval
	dc.w $0000	; volume_step_delta
	dc.w $0000	; volume_step_countdown
	dc.w $0000	; hold_ticks
	dc.w $0000	; initial_period_steps_left
	dc.w $0000	; initial_period_step
	dc.w $0000	; alternating_period_steps_left
	dc.w $0000	; period_modulation_offset
	dc.w $0000	; alternating_period_step
	dc.l $00000000	; update_callback
	dc.l $00000000	; instrument_pointer
    ; KNOWN: type A1=Target code-entry register seed:Bank5Voice; type A0=Target code-entry register seed:AudioInstrument
Bank5StartVoice:
	lea.l _custom.l,a6
	move sr,-(a7)
	ori #1792,sr
	move.w Bank5Voice_irq_mask(a1),intena(a6)
	move.w (a1),dmacon(a6)	; operand 1: Bank5Voice_dma_mask at (a1)
	move.w Bank5Voice_custom_offset(a1),d5
	lea.l $0(a6,d5.w),a2
	lea.l bank5InstrumentOffsets(pc),a3
	adda.l (a0),a3	; operand 1: AudioInstrument_sample_offset at (a0)
	move.l a3,(a2)
	move.w AudioInstrument_sample_length_words(a0),$0004(a2)
	clr.w $0008(a2)
	move.l a0,Bank5Voice_instrument_pointer(a1)
	move.w d1,Bank5Voice_hold_ticks(a1)
	andi.w #127,d0
	neg.w d0
	add.w AudioInstrument_pitch_reference_note(a0),d0
	add.w d0,d0
	add.w d0,d0
	lea.l bank5PitchScaleTable(pc),a3
	adda.w d0,a3
	move.w AudioInstrument_period_scale(a0),d0
	move.w (a3)+,d1
	mulu.w d0,d1
	mulu.w (a3),d0
	swap.w d0
	add.w d1,d0
	move.w d0,Bank5Voice_base_period(a1)
	move.w AudioInstrument_initial_ramp_ticks(a0),Bank5Voice_initial_period_steps_left(a1)
	bmi.b abs_0_00058328
	move.w AudioInstrument_alternating_ticks(a0),d1
	lsr.w #1,d1
	bcc.b abs_0_00058308
	addq.w #1,d1
abs_0_00058308:
	move.w d1,Bank5Voice_alternating_period_steps_left(a1)
	move.w AudioInstrument_initial_period_scale(a0),d1
	muls.w d0,d1
	swap.w d1
	rol.l #1,d1
	move.w d1,Bank5Voice_initial_period_step(a1)
	move.w AudioInstrument_alternating_period_scale(a0),d1
	muls.w d0,d1
	swap.w d1
	rol.l #1,d1
	move.w d1,Bank5Voice_alternating_period_step(a1)
abs_0_00058328:
	clr.w Bank5Voice_period_modulation_offset(a1)
	lea.l Bank5UpdateLoopedVoice(pc),a3
	tst.w AudioInstrument_volume_delta(a0)
	bne.b abs_0_0005833A
	lea.l Bank5UpdateOneShotVoice(pc),a3
abs_0_0005833A:
	move.w d2,Bank5Voice_volume(a1)
	move.w d2,$0008(a2)
	move.w d3,Bank5Voice_volume_step_interval(a1)
	move.w d3,Bank5Voice_volume_step_countdown(a1)
	move.w d4,Bank5Voice_volume_step_delta(a1)
	move.l a3,Bank5Voice_update_callback(a1)
	move.w #$2,Bank5Voice_playback_phase(a1)
	rte
Bank5MuteAudio:
	lea.l _custom.l,a6
	moveq.l #15,d0
	move.w d0,dmacon(a6)
	move.w d0,aud0+ac_per(a6)	; audio period
	move.w d0,aud1+ac_per(a6)	; audio period
	move.w d0,aud2+ac_per(a6)	; audio period
	move.w d0,aud3+ac_per(a6)	; audio period
	moveq.l #0,d0
	move.w d0,aud0+ac_vol(a6)
	move.w d0,aud1+ac_vol(a6)
	move.w d0,aud2+ac_vol(a6)
	move.w d0,aud3+ac_vol(a6)
	lea.l bank5Voices(pc),a0
	move.w d0,Bank5Voice_playback_phase(a0)
	move.w d0,Bank5Voice_playback_phase+Bank5Voice_SIZEOF(a0)
	move.w d0,Bank5Voice_playback_phase+2*Bank5Voice_SIZEOF(a0)
	move.w d0,Bank5Voice_playback_phase+3*Bank5Voice_SIZEOF(a0)
abs_0_0005839C:
	rts
Bank5UpdateVoices:
	lea.l _custom.l,a6
	lea.l bank5Voices(pc),a3
	bsr.w Bank5UpdateVoice
	lea.l bank5Voice1(pc),a3
	bsr.w Bank5UpdateVoice
	lea.l bank5Voice2(pc),a3
	bsr.w Bank5UpdateVoice
	lea.l bank5Voice3(pc),a3
    ; Resource5 voice stride is 40 bytes; callback LONG +32, instrument pointer +36. Initial bank9 Audio2 is incompatible; callback targets remain open.
    ; KNOWN: type A3=Target code-entry register seed:Bank5Voice
Bank5UpdateVoice:
	tst.w Bank5Voice_playback_phase(a3)
	bne.b abs_0_000583C8
	rts
abs_0_000583C8:
	movea.l Bank5Voice_instrument_pointer(a3),a2
	tst.w Bank5Voice_hold_ticks(a3)
	ble.b abs_0_000583D6
	subq.w #1,Bank5Voice_hold_ticks(a3)
abs_0_000583D6:
	bsr.w Bank5UpdatePeriodModulation
	bsr.w Bank5UpdateVolumeSteps
	movea.l Bank5Voice_update_callback(a3),a0
	move.w Bank5Voice_custom_offset(a3),d0
	lea.l $0(a6,d0.w),a1
	jsr (a0)
	move.w $000C(a3),d0
	bgt.b abs_0_00058400
	clr.w $000A(a1)
	move.w (a3),$0096(a6)
	clr.w $0006(a3)
	rts
abs_0_00058400:
	cmp.w #$40,d0
	ble.b abs_0_00058408
	moveq.l #64,d0
abs_0_00058408:
	move.w d0,$0008(a1)
	move.w $0008(a3),d0
	add.w $001C(a3),d0
	add.w $000A(a3),d0
	move.w d0,$0006(a1)
	rts
    ; KNOWN: type A3=Target code-entry register seed:Bank5Voice; type A2=Target code-entry register seed:AudioInstrument
Bank5UpdateLoopedVoice:
	tst.w Bank5Voice_playback_phase(a3)
	bpl.b abs_0_00058438
	cmpi.w #1,Bank5Voice_hold_ticks(a3)
	bgt.w abs_0_0005839C
	lea.l Bank5ApplyInstrumentVolumeDelta(pc),a0
	move.l a0,Bank5Voice_update_callback(a3)
	rts
abs_0_00058438:
	move.w (a3),d0	; operand 1: Bank5Voice_dma_mask at (a3)
	ori.w #32768,d0
	move.w d0,$0096(a6)
	subq.w #1,Bank5Voice_playback_phase(a3)
	bne.w abs_0_0005839C
	not.w Bank5Voice_playback_phase(a3)
	lea.l bank5InstrumentOffsets(pc),a0
	adda.l AudioInstrument_repeat_offset(a2),a0
	move.l a0,(a1)
	move.w AudioInstrument_repeat_length_words(a2),$0004(a1)
	rts
    ; KNOWN: type A2=Target code-entry register seed:AudioInstrument; type A3=Target code-entry register seed:Bank5Voice
Bank5ApplyInstrumentVolumeDelta:
	move.w #$8000,Bank5Voice_playback_phase(a3)
	move.w AudioInstrument_volume_delta(a2),d0
	add.w d0,Bank5Voice_volume(a3)
	rts
    ; KNOWN: type A3=Target code-entry register seed:Bank5Voice
Bank5UpdateOneShotVoice:
	tst.w Bank5Voice_playback_phase(a3)
	bpl.b abs_0_00058494
	cmpi.w #1,Bank5Voice_hold_ticks(a3)
	bne.b abs_0_00058484
	move.w #$8000,Bank5Voice_playback_phase(a3)
abs_0_00058484:
	move.w (a3),d0	; operand 1: Bank5Voice_dma_mask at (a3)
	and.w $0002(a6),d0
	bne.w abs_0_0005839C
	clr.w Bank5Voice_volume(a3)
	rts
abs_0_00058494:
	subq.w #1,Bank5Voice_playback_phase(a3)
	beq.b abs_0_000584A6
	move.w (a3),d0	; operand 1: Bank5Voice_dma_mask at (a3)
	ori.w #32768,d0
	move.w d0,$0096(a6)
	rts
abs_0_000584A6:
	not.w Bank5Voice_playback_phase(a3)
	move.w Bank5Voice_irq_mask(a3),d0
	move.w d0,$009C(a6)
	ori.w #32768,d0
	move.w d0,$009A(a6)
	rts
    ; KNOWN: type A3=Target code-entry register seed:Bank5Voice
Bank5UpdatePeriodModulation:
	move.w Bank5Voice_initial_period_steps_left(a3),d0
	beq.b abs_0_000584D8
	cmp.w #$FFFF,d0
	beq.w abs_0_000584F4
	move.w Bank5Voice_initial_period_step(a3),d0
	add.w d0,Bank5Voice_period_modulation_offset(a3)
	subq.w #1,Bank5Voice_initial_period_steps_left(a3)
	bne.b abs_0_000584F4
abs_0_000584D8:
	move.w Bank5Voice_alternating_period_step(a3),d0
	add.w d0,Bank5Voice_period_modulation_offset(a3)
	subq.w #1,Bank5Voice_alternating_period_steps_left(a3)
	bne.b abs_0_000584F4
	move.w AudioInstrument_alternating_ticks(a2),d0
	beq.b abs_0_000584F4
	move.w d0,Bank5Voice_alternating_period_steps_left(a3)
	neg.w Bank5Voice_alternating_period_step(a3)
abs_0_000584F4:
	rts
    ; KNOWN: type A3=Target code-entry register seed:Bank5Voice
Bank5UpdateVolumeSteps:
	move.w Bank5Voice_volume_step_interval(a3),d0
	beq.b abs_0_0005850E
	subq.w #1,Bank5Voice_volume_step_countdown(a3)
	bne.b abs_0_0005850E
	move.w d0,Bank5Voice_volume_step_countdown(a3)
	move.w Bank5Voice_volume_step_delta(a3),d0
	add.w d0,Bank5Voice_volume(a3)
abs_0_0005850E:
	rts
abs_0_00058510:
	move.w d0,-(a7)
	move.w _custom+intreqr.l,d0	; interrupt request state
	andi.w #1920,d0
	and.w _custom+intenar.l,d0
	move.w d0,_custom+intena.l
	move.w d0,_custom+intreq.l
	lsr.w #7,d0
	move.w d0,_custom+dmacon.l
	move.w (a7)+,d0
	rte
bank5Pattern0:
	dc.b $84	; audio_pattern_stream
	dc.b $0F,$09,$15,$03,$16,$08
	dc.b $FF	; audio_pattern_stream
bank5Pattern1:
	dc.b $81	; audio_pattern_stream
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $1F	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $1F	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $1F	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $1F	; note
	dc.b $0A	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern2:
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A
	dc.b $32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$30,$05
	dc.b $31,$05,$32,$0A,$32,$0A,$32,$0A,$30,$05,$31,$05,$32,$0A,$32,$0A
	dc.b $32,$0A,$30,$05,$31,$05,$32,$0A,$32,$0A,$32,$0A,$30,$05,$31,$05
	dc.b $32,$0A,$32,$0A,$32,$0A,$32,$0A,$31,$0A,$31,$0A,$30,$0A,$30,$0A
	dc.b $2F,$0A,$2F,$0A,$2E,$0A,$2E,$14,$25,$10,$24,$02,$23,$02,$22,$14
	dc.b $32,$05,$31,$05,$30,$05,$2F,$05,$2E,$14,$25,$10,$24,$02,$23,$02
	dc.b $22,$28
	dc.b $FF	; audio_pattern_stream
bank5Pattern3:
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $91	; audio_pattern_stream
	dc.b $2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A
	dc.b $2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A
	dc.b $90	; audio_pattern_stream
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2B,$0A,$2B,$0A,$2B,$0A
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2B,$0A,$2B,$0A,$2B,$0A
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2B,$0A,$2B,$0A,$2B,$0A
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2B,$0A,$2B,$0A,$2B,$0A,$2B,$14,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A
	dc.b $2B,$0A,$2B,$0A,$2B,$14
	dc.b $7F	; rest_code
	dc.b $3C	; ticks
	dc.b $7F	; rest_code
	dc.b $50	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern4:
	dc.b $7F	; rest_code
	dc.b $50	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern5:
	dc.b $83	; audio_pattern_stream
	dc.b $0F,$08,$15,$04,$16,$08,$0F,$08,$15,$04,$16,$08,$0F,$14
	dc.b $FF	; audio_pattern_stream
bank5Pattern6:
	dc.b $80	; audio_pattern_stream
	dc.b $0F,$14,$1B,$0A,$1D,$0A,$1F,$0A,$20,$0A,$22,$14,$24,$0A,$20,$0A
	dc.b $22,$14,$24,$0A,$20,$0A,$22,$14,$24,$0A,$20,$0A,$22,$14,$16,$14
	dc.b $16,$14,$22,$14,$12,$14,$12,$14,$12,$14,$12,$14
	dc.b $FF	; audio_pattern_stream
bank5Pattern7:
	dc.b $0F	; note
	dc.b $14	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern8:	; ARRAY Bank5PatternNote[18]
	dc.b $0F,$14,$17,$0A,$23,$0A,$1A,$0A,$26,$0A,$1C,$0A,$28,$0A,$1E,$0A
	dc.b $2A,$0A,$21,$0A,$2D,$0A,$23,$0A,$2F,$0A,$26,$0A,$26,$0A,$27,$26
	dc.b $0E,$02,$0F,$14
	dc.b $FF	; audio_pattern_stream
bank5Pattern9:
	dc.b $83	; audio_pattern_stream
	dc.b $7F	; rest_code
	dc.b $14	; ticks
	dc.b $25,$14,$28,$14,$2A,$14,$2B,$50,$22,$14,$25,$14,$29,$1E,$25,$0A
	dc.b $27,$14,$28,$3C,$2B,$14,$2C,$14,$2B,$14,$2B,$14,$22,$14,$25,$14
	dc.b $29,$1E,$25,$0A,$27,$14,$28,$3C,$2A,$50,$20,$14,$22,$14,$24,$28
	dc.b $25,$14,$27,$3C,$26,$28,$23,$14,$2C,$3C,$2B,$1E,$29,$0A,$2B,$14
	dc.b $FF	; audio_pattern_stream
bank5Pattern10:
	dc.b $83	; audio_pattern_stream
	dc.b $0F,$09,$14,$03,$16,$08
	dc.b $FF	; audio_pattern_stream
bank5Pattern11:
	dc.b $82	; audio_pattern_stream
	dc.b $7F	; rest_code
	dc.b $14	; ticks
	dc.b $22,$3C,$25,$50
	dc.b $7F	; rest_code
	dc.b $28	; ticks
	dc.b $22,$3C,$25,$3C,$22,$50
	dc.b $7F	; rest_code
	dc.b $28	; ticks
	dc.b $22,$3C,$25,$3C,$27,$50
	dc.b $7F	; rest_code
	dc.b $28	; ticks
	dc.b $20,$3C,$24,$3C,$20,$3C,$23,$3C,$23,$3C
	dc.b $FF	; audio_pattern_stream
bank5Pattern12:
	dc.b $7F	; rest_code
	dc.b $14	; ticks
	dc.b $2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2F,$14,$2E,$14
	dc.b $2F,$14,$2E,$14
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E,$0A,$1B,$0A,$2E,$0A,$1B,$0A,$2E,$0A,$1B,$0A,$2E,$0A,$19,$0A
	dc.b $2E,$0A,$19,$0A,$2E,$0A,$19,$0A,$2E,$0A,$19,$0A,$2E,$0A
	dc.b $FF	; audio_pattern_stream
bank5Pattern13:
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A
	dc.b $32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A,$31,$0A
	dc.b $32,$0A,$32,$0A,$32,$0A,$31,$0A,$32,$0A,$32,$0A,$32,$0A,$31,$0A
	dc.b $32,$0A,$32,$0A,$32,$0A,$31,$0A,$32,$0A,$32,$0A,$32,$0A,$32,$0A
	dc.b $31,$0A,$31,$0A,$30,$0A,$30,$0A,$2F,$0A,$2F,$0A,$2E,$0A,$2E,$14
	dc.b $25,$10,$24,$02,$23,$02,$22,$14,$32,$05,$31,$05,$30,$05,$2F,$05
	dc.b $2E,$14,$25,$10,$24,$02,$23,$02,$22,$14,$2F,$05,$2E,$05,$2D,$05
	dc.b $2C,$05,$2B,$14
	dc.b $7F	; rest_code
	dc.b $14	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern14:
	dc.b $82	; audio_pattern_stream
	dc.b $22	; note
	dc.b $78	; ticks
	dc.b $7F	; rest_code
	dc.b $A0	; ticks
	dc.b $33,$26,$1A,$02,$1B,$14
	dc.b $FF	; audio_pattern_stream
bank5Pattern15:
	dc.b $92	; audio_pattern_stream
	dc.b $7F	; rest_code
	dc.b $14	; ticks
	dc.b $27,$0A,$27,$0A,$27,$0A,$27,$0A,$27,$0A,$27,$0A
	dc.b $90	; audio_pattern_stream
	dc.b $2C,$14,$2B,$14,$2C,$14,$2B,$14
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $91	; audio_pattern_stream
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $90	; audio_pattern_stream
	dc.b $1F	; note
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $90	; audio_pattern_stream
	dc.b $1F	; note
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $90	; audio_pattern_stream
	dc.b $1F	; note
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $90	; audio_pattern_stream
	dc.b $18	; note
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $90	; audio_pattern_stream
	dc.b $18	; note
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $90	; audio_pattern_stream
	dc.b $18	; note
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $90	; audio_pattern_stream
	dc.b $18	; note
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $25	; note
	dc.b $0A	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern16:
	dc.b $7F	; rest_code
	dc.b $28	; ticks
	dc.b $83	; audio_pattern_stream
	dc.b $1F	; note
	dc.b $78	; ticks
	dc.b $7F	; rest_code
	dc.b $A0	; ticks
	dc.b $7F	; rest_code
	dc.b $50	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern17:
	dc.b $81	; audio_pattern_stream
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A
	dc.b $2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A,$2E,$0A
	dc.b $FF	; audio_pattern_stream
bank5Pattern18:
	dc.b $7F	; rest_code
	dc.b $14	; ticks
	dc.b $2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A,$2B,$0A
	dc.b $7F	; rest_code
	dc.b $50	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $92	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $0A	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern19:
	dc.b $82	; audio_pattern_stream
	dc.b $22	; note
	dc.b $50	; ticks
	dc.b $7F	; rest_code
	dc.b $28	; ticks
	dc.b $7F	; rest_code
	dc.b $3C	; ticks
	dc.b $22,$3C,$25,$50
	dc.b $7F	; rest_code
	dc.b $28	; ticks
	dc.b $7F	; rest_code
	dc.b $3C	; ticks
	dc.b $22,$3C,$24,$50
	dc.b $7F	; rest_code
	dc.b $28	; ticks
	dc.b $7F	; rest_code
	dc.b $3C	; ticks
	dc.b $24	; note
	dc.b $3C	; ticks
	dc.b $7F	; rest_code
	dc.b $3C	; ticks
	dc.b $26,$3C,$23,$3C
	dc.b $FF	; audio_pattern_stream
bank5Pattern20:
	dc.b $81	; audio_pattern_stream
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E,$0A,$2E,$0A,$2E,$0A
	dc.b $7F	; rest_code
	dc.b $0A	; ticks
	dc.b $2E,$0A,$2E,$0A,$2E,$0A
	dc.b $FF	; audio_pattern_stream
bank5Pattern21:
	dc.b $84	; audio_pattern_stream
	dc.b $0F,$0A,$16,$0A
	dc.b $FF	; audio_pattern_stream
bank5Pattern22:
	dc.b $84	; audio_pattern_stream
	dc.b $0F,$0A,$15,$04
	dc.b $7F	; rest_code
	dc.b $06	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern23:
	dc.b $83	; audio_pattern_stream
	dc.b $0F,$0A,$15,$04
	dc.b $7F	; rest_code
	dc.b $06	; ticks
	dc.b $0F,$0A,$15,$04
	dc.b $7F	; rest_code
	dc.b $06	; ticks
	dc.b $0F	; note
	dc.b $14	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern24:
	dc.b $85	; audio_pattern_stream
	dc.b $12,$18,$19,$18,$0D,$08,$0F,$08,$11,$08,$12,$10,$15,$08,$12,$10
	dc.b $15,$08,$14,$08,$12,$08,$11,$08,$12,$10,$15,$08,$12,$10,$15,$08
	dc.b $14,$08,$12,$08,$11,$08,$12,$10,$15,$08,$12,$08,$15,$08,$14,$08
	dc.b $12,$08,$14,$08,$15,$08,$14,$08,$17,$08,$15,$08,$14,$10,$1A,$08
	dc.b $13,$10,$17,$08,$14,$08,$17,$08,$15,$08,$14,$10,$1A,$08,$13,$10
	dc.b $17,$08,$14,$08,$15,$08,$17,$08,$18,$08,$18,$08,$18,$08,$18,$08
	dc.b $18,$08,$18,$08,$19,$08,$19,$08,$19,$08,$19,$08,$1A,$08,$19,$08
	dc.b $17,$08,$15,$08,$14,$05
	dc.b $FF	; audio_pattern_stream
bank5Pattern25:
	dc.b $86	; audio_pattern_stream
	dc.b $2D,$18,$34,$18,$29,$08,$2A,$08,$2C,$08,$2D,$18,$31,$18,$2F,$18
	dc.b $2D,$18,$31,$18,$2F,$18,$2D,$18,$31,$18,$2D,$18,$2A,$18,$32,$18
	dc.b $29,$18,$2A,$18,$32,$18,$29,$18
	dc.b $87	; audio_pattern_stream
	dc.b $2A,$10,$2B,$08,$2C,$18,$2D,$18,$2E,$10,$2F,$08,$30,$18,$31,$18
	dc.b $FF	; audio_pattern_stream
bank5Pattern26:
	dc.b $86	; audio_pattern_stream
	dc.b $25,$18,$2D,$18
	dc.b $7F	; rest_code
	dc.b $18	; ticks
	dc.b $25,$18,$2D,$18,$2C,$18,$25,$18,$2D,$18,$2C,$18,$25,$18,$2D,$18
	dc.b $25,$18,$26,$18,$2F,$18,$25,$18,$26,$18,$2F,$18,$25,$18
	dc.b $87	; audio_pattern_stream
	dc.b $26,$10,$28,$08,$28,$18,$29,$18,$2B,$10,$2C,$08,$2D,$18,$29,$18
	dc.b $FF	; audio_pattern_stream
bank5Pattern27:
	dc.b $7F	; rest_code
	dc.b $03	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern28:
	dc.b $85	; audio_pattern_stream
	dc.b $12,$10,$15,$08,$12,$08,$15,$08,$14,$08,$12,$08,$11,$08,$0F,$08
	dc.b $0D,$08,$19,$08,$14,$08,$0D,$08,$19,$08,$14,$08,$18,$08,$15,$08
	dc.b $12,$08,$0D,$08,$19,$08,$14,$08,$0D,$08,$19,$08,$14,$08,$18,$08
	dc.b $15,$08,$12,$08,$0D,$08,$19,$08,$14,$08,$0D,$08,$19,$08,$14,$08
	dc.b $11,$08,$19,$08,$14,$08,$12,$08,$19,$08,$15,$08,$13,$08,$19,$08
	dc.b $17,$08,$15,$08,$14,$08,$13,$08,$12,$08,$19,$08,$15,$08,$13,$08
	dc.b $19,$08,$17,$08,$15,$08,$14,$08,$13,$08,$12,$08,$19,$08,$15,$08
	dc.b $16,$08,$1D,$08,$1A,$08,$17,$08,$1E,$08,$1A,$08,$18,$08,$1F,$08
	dc.b $1B,$08,$19,$08,$15,$08,$1D,$08,$0D,$18
	dc.b $FF	; audio_pattern_stream
bank5Pattern29:
	dc.b $85	; audio_pattern_stream
	dc.b $12,$90,$12,$90,$12,$18,$12,$78,$12,$18,$12,$78,$12,$18,$12,$18
	dc.b $12,$18,$12,$18,$12,$18,$12,$18
	dc.b $FF	; audio_pattern_stream
bank5Pattern30:
	dc.b $85	; audio_pattern_stream
	dc.b $15,$90,$15,$90,$15,$10
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $15,$78,$15,$10
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $15,$78,$15,$10
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $15	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $15	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $15	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $15	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $15	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $FF	; audio_pattern_stream
bank5Pattern31:
	dc.b $86	; audio_pattern_stream
	dc.b $7F	; rest_code
	dc.b $90	; ticks
	dc.b $7F	; rest_code
	dc.b $A0	; ticks
	dc.b $21	; note
	dc.b $08	; ticks
	dc.b $7F	; rest_code
	dc.b $88	; ticks
	dc.b $21	; note
	dc.b $08	; ticks
	dc.b $7F	; rest_code
	dc.b $88	; ticks
	dc.b $21,$18,$21,$18,$21,$18,$21,$18,$21,$18,$21,$08
	dc.b $FF	; audio_pattern_stream
bank5Pattern32:
	dc.b $85	; audio_pattern_stream
	dc.b $12,$18,$19,$18,$0D,$08,$0F,$08,$11,$08,$12,$10,$15,$08,$12,$10
	dc.b $15,$08,$14,$08,$12,$08,$11,$08,$12,$10,$15,$08,$12,$10,$15,$08
	dc.b $14,$08,$12,$08,$11,$08,$12,$10,$15,$08,$12,$08,$15,$08,$14,$08
	dc.b $12,$08,$14,$08,$15,$08,$14,$08,$17,$08,$15,$08,$14,$10,$1A,$08
	dc.b $13,$10,$17,$08,$14,$08,$17,$08,$15,$08,$14,$10,$1A,$08,$13,$10
	dc.b $17,$08,$14,$08,$15,$08,$17,$08,$19,$08,$19,$08,$19,$08,$19,$08
	dc.b $19,$08,$19,$08,$19,$08,$17,$08,$15,$08,$14,$08,$17,$08,$15,$08
	dc.b $14,$08,$12,$08,$10,$08,$10,$08,$0F,$08,$0D,$08,$0B,$08,$09,$08
	dc.b $08,$08,$06,$08,$04,$08,$03,$08
	dc.b $FF	; audio_pattern_stream
bank5Pattern33:
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1B	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1B	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1B	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $0D	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $20	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2C	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $12	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2D	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $13	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $13	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $12	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $13	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $13	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $15	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $16	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $08	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $18	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2A	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $19	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $21	; note
	dc.b $08	; ticks
	dc.b $87	; audio_pattern_stream
	dc.b $23,$30,$19,$48
	dc.b $FF	; audio_pattern_stream
bank5Pattern34:
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1C	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1C	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $12	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $20	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $20	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $20	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $12	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $20	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $20	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $12	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $20	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $10	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $14	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $19	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $25	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $19	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2D	; note
	dc.b $08	; ticks
	dc.b $7F	; rest_code
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $19	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2D	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $19	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2D	; note
	dc.b $08	; ticks
	dc.b $7F	; rest_code
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2E	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $18	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $30	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $1A	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2E	; note
	dc.b $08	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $1C	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $2C	; note
	dc.b $08	; ticks
	dc.b $85	; audio_pattern_stream
	dc.b $1C	; note
	dc.b $10	; ticks
	dc.b $86	; audio_pattern_stream
	dc.b $26	; note
	dc.b $08	; ticks
	dc.b $87	; audio_pattern_stream
	dc.b $27,$30,$1F,$48
	dc.b $FF	; audio_pattern_stream
bank5Pattern35:
	dc.b $85	; audio_pattern_stream
	dc.b $91	; audio_pattern_stream
	dc.b $FF	; audio_pattern_stream
bank5Pattern36:
	dc.b $85	; audio_pattern_stream
	dc.b $15,$18,$1E,$18,$11,$08,$12,$08,$14,$08,$15,$10,$19,$08,$15,$10
	dc.b $19,$08,$17,$08,$15,$08,$14,$08,$15,$10,$19,$08,$15,$10,$19,$08
	dc.b $17,$08,$15,$08,$14,$08,$15,$10,$19,$08,$15,$08,$19,$08,$17,$08
	dc.b $15,$08,$17,$08,$19,$08,$17,$08,$1A,$08,$19,$08,$17,$10,$1D,$08
	dc.b $17,$10,$1A,$08,$17,$08,$1A,$08,$19,$08,$17,$10,$1D,$08,$17,$10
	dc.b $1A,$08,$17,$08,$19,$08,$1A,$08,$1B,$08,$1B,$08,$1B,$08,$1B,$08
	dc.b $1B,$08,$1B,$08,$1D,$08,$1D,$08,$1D,$08,$1D,$08,$1E,$08,$1D,$08
	dc.b $1A,$08,$19,$08,$17,$08
	dc.b $FF	; audio_pattern_stream
bank5Pattern37:	; ARRAY Bank5PatternNote[9]
	dc.b $19,$08,$19,$08,$19,$08,$19,$08,$1A,$08,$19,$08,$17,$08,$15,$08
	dc.b $14,$08
	dc.b $FF	; audio_pattern_stream
bank5Pattern38:	; ARRAY Bank5PatternNote[9]
	dc.b $1D,$08,$1D,$08,$1D,$08,$1D,$08,$1E,$08,$1D,$08,$1A,$08,$19,$08
	dc.b $17,$08
	dc.b $FF	; audio_pattern_stream
bank5Pattern39:
	dc.b $85	; audio_pattern_stream
	dc.b $12,$30,$0D,$08,$0F,$08,$11,$08,$12,$30,$0D,$08,$0F,$08,$11,$08
	dc.b $12,$30,$0B,$08,$0D,$08,$0F,$08,$10,$30,$0B,$08,$0D,$08,$0F,$08
	dc.b $FF	; audio_pattern_stream
bank5Pattern40:
	dc.b $85	; audio_pattern_stream
	dc.b $12	; note
	dc.b $30	; ticks
	dc.b $7F	; rest_code
	dc.b $48	; ticks
	dc.b $7F	; rest_code
	dc.b $48	; ticks
	dc.b $7F	; rest_code
	dc.b $60	; ticks
	dc.b $FF	; audio_pattern_stream
bank5Pattern41:	; ARRAY Bank5PatternNote[7]
	dc.b $18,$08,$1F,$08,$1B,$08,$19,$08,$15,$08,$1D,$08,$0D,$18
	dc.b $FF	; audio_pattern_stream
	dc.b $00
bank5PatternOffsets:
	dc.w bank5Pattern0-bank5Pattern0	; audio_relative_offsets
	dc.w bank5Pattern1-bank5Pattern0
	dc.w bank5Pattern2-bank5Pattern0
	dc.w bank5Pattern3-bank5Pattern0
	dc.w bank5Pattern4-bank5Pattern0
	dc.w bank5Pattern5-bank5Pattern0
	dc.w bank5Pattern6-bank5Pattern0
	dc.w bank5Pattern7-bank5Pattern0
	dc.w bank5Pattern8-bank5Pattern0
	dc.w bank5Pattern9-bank5Pattern0
	dc.w bank5Pattern10-bank5Pattern0
	dc.w bank5Pattern11-bank5Pattern0
	dc.w bank5Pattern12-bank5Pattern0
	dc.w bank5Pattern13-bank5Pattern0
	dc.w bank5Pattern14-bank5Pattern0
	dc.w bank5Pattern15-bank5Pattern0
	dc.w bank5Pattern16-bank5Pattern0
	dc.w bank5Pattern17-bank5Pattern0
	dc.w bank5Pattern18-bank5Pattern0
	dc.w bank5Pattern19-bank5Pattern0
	dc.w bank5Pattern20-bank5Pattern0
	dc.w bank5Pattern21-bank5Pattern0
	dc.w bank5Pattern22-bank5Pattern0
	dc.w bank5Pattern23-bank5Pattern0
	dc.w bank5Pattern24-bank5Pattern0
	dc.w bank5Pattern25-bank5Pattern0
	dc.w bank5Pattern26-bank5Pattern0
	dc.w bank5Pattern27-bank5Pattern0
	dc.w bank5Pattern28-bank5Pattern0
	dc.w bank5Pattern29-bank5Pattern0
	dc.w bank5Pattern30-bank5Pattern0
	dc.w bank5Pattern31-bank5Pattern0
	dc.w bank5Pattern32-bank5Pattern0
	dc.w bank5Pattern33-bank5Pattern0
	dc.w bank5Pattern34-bank5Pattern0
	dc.w bank5Pattern35-bank5Pattern0
	dc.w bank5Pattern36-bank5Pattern0
	dc.w bank5Pattern37-bank5Pattern0
	dc.w bank5Pattern38-bank5Pattern0
	dc.w bank5Pattern39-bank5Pattern0
	dc.w bank5Pattern40-bank5Pattern0
	dc.w bank5Pattern41-bank5Pattern0
bank5InitialSongOffsets:
	dc.w bank5Order0-bank5InitialSongOffsets	; audio_relative_offsets
	dc.w bank5Order1-bank5InitialSongOffsets
	dc.w bank5Order2-bank5InitialSongOffsets
	dc.w bank5Order3-bank5InitialSongOffsets
	dc.w bank5Order4-bank5InitialSongOffsets
	dc.w bank5Order5-bank5InitialSongOffsets
	dc.w bank5Order6-bank5InitialSongOffsets
	dc.w bank5Order7-bank5InitialSongOffsets
bank5Order0:
	dc.b $CC,$15,$D0,$00,$DC,$15	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $CC,$15,$D0,$00,$DD,$15,$05	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $F4	; command
	dc.b $0C	; parameter
	dc.b $E0,$00,$DD,$0A	; audio_order_stream
	dc.b $F4	; command
	dc.b $10	; parameter
	dc.b $D3,$00,$06,$D8,$00,$D8,$00	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $E3,$00,$07	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $D0,$00,$08,$FF	; audio_order_stream
bank5Order1:
	dc.b $01,$02,$04	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $02	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $09,$01,$0C,$01,$02	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $0D	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $0E,$FF	; audio_order_stream
bank5Order2:
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $01	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $03,$04	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $03	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $0B	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $01	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $0F	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $01	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $03	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $03	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $10,$FF	; audio_order_stream
bank5Order3:
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $CC,$16,$11,$DC,$16	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $CC,$16,$11,$DD,$16,$17	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $13	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $04	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $12	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $04	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $11,$14,$14,$CB,$04	; audio_order_stream
	dc.b $FE	; command
	dc.b $03	; parameter
	dc.b $11,$14,$14,$D0,$04,$FF	; audio_order_stream
bank5Order4:
	dc.b $FE	; command
	dc.b $F4	; parameter
	dc.b $1D,$18,$1B,$18,$1B	; audio_order_stream
	dc.b $FE	; command
	dc.b $00	; parameter
	dc.b $20,$20	; audio_order_stream
	dc.b $FE	; command
	dc.b $0C	; parameter
	dc.b $F5	; command
	dc.b $04	; parameter
	dc.b $18,$1B,$18,$1B	; audio_order_stream
	dc.b $FE	; command
	dc.b $0E	; parameter
	dc.b $18,$1B,$18,$1B,$25	; audio_order_stream
	dc.b $FE	; command
	dc.b $02	; parameter
	dc.b $25	; audio_order_stream
	dc.b $FE	; command
	dc.b $F6	; parameter
	dc.b $25,$28,$FF	; audio_order_stream
bank5Order5:
	dc.b $1E,$19,$19	; audio_order_stream
	dc.b $FE	; command
	dc.b $05	; parameter
	dc.b $21,$21,$1B	; audio_order_stream
	dc.b $FE	; command
	dc.b $0C	; parameter
	dc.b $F5	; command
	dc.b $04	; parameter
	dc.b $18,$1B,$18,$23	; audio_order_stream
	dc.b $FE	; command
	dc.b $0E	; parameter
	dc.b $24,$24,$26	; audio_order_stream
	dc.b $FE	; command
	dc.b $02	; parameter
	dc.b $26	; audio_order_stream
	dc.b $FE	; command
	dc.b $F6	; parameter
	dc.b $26,$28,$FF	; audio_order_stream
bank5Order6:
	dc.b $1F,$1A,$1A	; audio_order_stream
	dc.b $FE	; command
	dc.b $05	; parameter
	dc.b $22,$22	; audio_order_stream
	dc.b $FE	; command
	dc.b $F4	; parameter
	dc.b $1C,$1C	; audio_order_stream
	dc.b $FE	; command
	dc.b $F6	; parameter
	dc.b $1C,$1C,$CB,$29,$27,$FF	; audio_order_stream
bank5Order7:
	dc.b $FF	; audio_order_stream
	dc.b $41,$FA,$F6,$5E,$21,$C8,$00,$70,$34,$00,$D0,$40,$D0,$40,$41,$FA
	dc.b $08,$04,$D1,$F0,$00,$00,$02,$42,$00,$03,$D4,$42,$D4,$42,$43,$FA
	dc.b $00,$16,$D3,$F1,$20,$00,$30,$28,$00,$18,$72,$FF,$74,$40,$76,$00
	dc.b $78,$00,$60,$00,$F3,$B4,$FF,$FF,$F3,$12,$FF,$FF,$F3,$3A,$FF,$FF
	dc.b $F3,$62,$FF,$FF,$F3,$8A
bank5PatternTrack0:
	dc.w $0000	; instrument_map_offset
	dc.l $00000000	; order_cursor
	dc.l $00000000	; pattern_start
	dc.l $00000000	; pattern_cursor
	dc.l $00000000	; instrument_pointer
	dc.b $00	; order_repeat_count
	dc.b $00	; transpose
	dc.b $00	; pattern_finished
	dc.b $00	; note_ticks
	dc.b $00	; active
	dc.b $00	; current_note
	dc.b $00	; first_note
bank5PatternTrack0_gap_19:
	dc.b $00	; typed data block gap
	dc.l $00000000	; note_instrument_pointer
	dc.b $00	; reference_note
	dc.b $00	; period_slide_enabled
	dc.b $00	; period_slide_delay
	dc.b $00	; period_slide_steps
	dc.b $00	; slide_note_delta
	dc.b $00	; note_slide_flags
	dc.b $00	; note_slide_delay
	dc.b $00	; note_slide_steps_left
	dc.l $00000000	; slide_ratio_or_step
	dc.b $00	; slide_from_previous_note
	dc.b $00	; volume_mod_enabled
	dc.b $00	; volume_mod_interval
	dc.b $00	; volume_mod_steps
	dc.w $0000	; volume_mod_delta
	dc.b $00	; note_volume_mod_enabled
	dc.b $00	; note_volume_mod_interval
	dc.b $00	; note_volume_mod_countdown
	dc.b $00	; note_volume_mod_steps_left
	dc.w $0000	; note_volume_mod_step
	dc.w $0000	; note_volume_mod_offset
	dc.w $0000	; volume_scale
	dc.w $0000	; volume_step_interval
	dc.w $0000	; volume_step_delta
	dc.b $00	; command_nibble
bank5PatternTrack0_gap_3F:
	dc.b $00,$00,$00,$00,$00,$00,$00	; typed data block gap
	dc.b $00	; encoded_note_command
	dc.b $00
bank5PatternTrack1:
	dc.w $0008	; instrument_map_offset
	dc.l $00000000	; order_cursor
	dc.l $00000000	; pattern_start
	dc.l $00000000	; pattern_cursor
	dc.l $00000000	; instrument_pointer
	dc.b $00	; order_repeat_count
	dc.b $00	; transpose
	dc.b $00	; pattern_finished
	dc.b $00	; note_ticks
	dc.b $00	; active
	dc.b $00	; current_note
	dc.b $00	; first_note
bank5PatternTrack1_gap_19:
	dc.b $00	; typed data block gap
	dc.l $00000000	; note_instrument_pointer
	dc.b $00	; reference_note
	dc.b $00	; period_slide_enabled
	dc.b $00	; period_slide_delay
	dc.b $00	; period_slide_steps
	dc.b $00	; slide_note_delta
	dc.b $00	; note_slide_flags
	dc.b $00	; note_slide_delay
	dc.b $00	; note_slide_steps_left
	dc.l $00000000	; slide_ratio_or_step
	dc.b $00	; slide_from_previous_note
	dc.b $00	; volume_mod_enabled
	dc.b $00	; volume_mod_interval
	dc.b $00	; volume_mod_steps
	dc.w $0000	; volume_mod_delta
	dc.b $00	; note_volume_mod_enabled
	dc.b $00	; note_volume_mod_interval
	dc.b $00	; note_volume_mod_countdown
	dc.b $00	; note_volume_mod_steps_left
	dc.w $0000	; note_volume_mod_step
	dc.w $0000	; note_volume_mod_offset
	dc.w $0000	; volume_scale
	dc.w $0000	; volume_step_interval
	dc.w $0000	; volume_step_delta
	dc.b $00	; command_nibble
bank5PatternTrack1_gap_3F:
	dc.b $00,$00,$00,$00,$00,$00,$00	; typed data block gap
	dc.b $00	; encoded_note_command
	dc.b $00
bank5PatternTrack2:
	dc.w $0010	; instrument_map_offset
	dc.l $00000000	; order_cursor
	dc.l $00000000	; pattern_start
	dc.l $00000000	; pattern_cursor
	dc.l $00000000	; instrument_pointer
	dc.b $00	; order_repeat_count
	dc.b $00	; transpose
	dc.b $00	; pattern_finished
	dc.b $00	; note_ticks
	dc.b $00	; active
	dc.b $00	; current_note
	dc.b $00	; first_note
bank5PatternTrack2_gap_19:
	dc.b $00	; typed data block gap
	dc.l $00000000	; note_instrument_pointer
	dc.b $00	; reference_note
	dc.b $00	; period_slide_enabled
	dc.b $00	; period_slide_delay
	dc.b $00	; period_slide_steps
	dc.b $00	; slide_note_delta
	dc.b $00	; note_slide_flags
	dc.b $00	; note_slide_delay
	dc.b $00	; note_slide_steps_left
	dc.l $00000000	; slide_ratio_or_step
	dc.b $00	; slide_from_previous_note
	dc.b $00	; volume_mod_enabled
	dc.b $00	; volume_mod_interval
	dc.b $00	; volume_mod_steps
	dc.w $0000	; volume_mod_delta
	dc.b $00	; note_volume_mod_enabled
	dc.b $00	; note_volume_mod_interval
	dc.b $00	; note_volume_mod_countdown
	dc.b $00	; note_volume_mod_steps_left
	dc.w $0000	; note_volume_mod_step
	dc.w $0000	; note_volume_mod_offset
	dc.w $0000	; volume_scale
	dc.w $0000	; volume_step_interval
	dc.w $0000	; volume_step_delta
	dc.b $00	; command_nibble
bank5PatternTrack2_gap_3F:
	dc.b $00,$00,$00,$00,$00,$00,$00	; typed data block gap
	dc.b $00	; encoded_note_command
	dc.b $00
bank5PatternTrack3:
	dc.w $0018	; instrument_map_offset
	dc.l $00000000	; order_cursor
	dc.l $00000000	; pattern_start
	dc.l $00000000	; pattern_cursor
	dc.l $00000000	; instrument_pointer
	dc.b $00	; order_repeat_count
	dc.b $00	; transpose
	dc.b $00	; pattern_finished
	dc.b $00	; note_ticks
	dc.b $00	; active
	dc.b $00	; current_note
	dc.b $00	; first_note
bank5PatternTrack3_gap_19:
	dc.b $00	; typed data block gap
	dc.l $00000000	; note_instrument_pointer
	dc.b $00	; reference_note
	dc.b $00	; period_slide_enabled
	dc.b $00	; period_slide_delay
	dc.b $00	; period_slide_steps
	dc.b $00	; slide_note_delta
	dc.b $00	; note_slide_flags
	dc.b $00	; note_slide_delay
	dc.b $00	; note_slide_steps_left
	dc.l $00000000	; slide_ratio_or_step
	dc.b $00	; slide_from_previous_note
	dc.b $00	; volume_mod_enabled
	dc.b $00	; volume_mod_interval
	dc.b $00	; volume_mod_steps
	dc.w $0000	; volume_mod_delta
	dc.b $00	; note_volume_mod_enabled
	dc.b $00	; note_volume_mod_interval
	dc.b $00	; note_volume_mod_countdown
	dc.b $00	; note_volume_mod_steps_left
	dc.w $0000	; note_volume_mod_step
	dc.w $0000	; note_volume_mod_offset
	dc.w $0000	; volume_scale
	dc.w $0000	; volume_step_interval
	dc.w $0000	; volume_step_delta
	dc.b $00	; command_nibble
bank5PatternTrack3_gap_3F:
	dc.b $00,$00,$00,$00,$00,$00,$00	; typed data block gap
	dc.b $00	; encoded_note_command
bank5InstrumentMap:
	dcb.b $20,$00
	dc.b $00
    ; Masks subsong to a byte and reads four WORD offsets per descriptor at bank5InitialSongOffsets. Menu uses indices 0 and 1; no general bound or song-count closure.
Bank5StartSong:
	move.w d0,-(a7)
	bsr.w Bank5MuteAudio
	move.w #ADKF_USE3PN|ADKF_USE2P3|ADKF_USE1P2|ADKF_USE0P1|ADKF_USE3VN|ADKF_USE2V3|ADKF_USE1V2|ADKF_USE0V1,adkcon(a6)
	lea.l abs_0_00058510(pc),a0
	move.l a0,m68k_vector_level_4_interrupt_autovector.w
	bset.b #CIAB_LED,_ciaa+ciapra.l
	move.w #INTF_AUD3|INTF_AUD2|INTF_AUD1|INTF_AUD0,intreq(a6)
	move.w #INTF_AUD3|INTF_AUD2|INTF_AUD1|INTF_AUD0,intena(a6)
	move.w #INTF_SETCLR|INTF_INTEN,intena(a6)
	move.w (a7)+,d0
	andi.w #255,d0
	lea.l bank5PatternTrack0(pc),a1
	lea.l bank5PatternTrack1(pc),a2
	lea.l bank5PatternTrack2(pc),a3
	lea.l bank5PatternTrack3(pc),a4
	add.w d0,d0
	add.w d0,d0
	add.w d0,d0
	lea.l bank5InitialSongOffsets(pc),a0
	move.l a0,d1
	moveq.l #0,d2
	lea.l $0(a0,d0.w),a0
	move.l d1,d0
	move.w (a0)+,d2
	add.l d2,d0
	move.l d0,Bank5PatternTrackPrefix_order_cursor(a1)
	move.l d1,d0
	move.w (a0)+,d2
	add.l d2,d0
	move.l d0,Bank5PatternTrackPrefix_order_cursor(a2)
	move.l d1,d0
	move.w (a0)+,d2
	add.l d2,d0
	move.l d0,Bank5PatternTrackPrefix_order_cursor(a3)
	move.l d1,d0
	move.w (a0)+,d2
	add.l d2,d0
	move.l d0,Bank5PatternTrackPrefix_order_cursor(a4)
	moveq.l #0,d0
	move.b d0,Bank5PatternTrackPrefix_transpose(a1)
	move.b d0,Bank5PatternTrackPrefix_transpose(a2)
	move.b d0,Bank5PatternTrackPrefix_transpose(a3)
	move.b d0,Bank5PatternTrackPrefix_transpose(a4)
	move.b d0,Bank5PatternTrackPrefix_command_nibble(a1)
	move.b d0,Bank5PatternTrackPrefix_command_nibble(a2)
	move.b d0,Bank5PatternTrackPrefix_command_nibble(a3)
	move.b d0,Bank5PatternTrackPrefix_command_nibble(a4)
	move.b d0,Bank5PatternTrackPrefix_period_slide_enabled(a1)
	move.b d0,Bank5PatternTrackPrefix_period_slide_enabled(a2)
	move.b d0,Bank5PatternTrackPrefix_period_slide_enabled(a3)
	move.b d0,Bank5PatternTrackPrefix_period_slide_enabled(a4)
	move.b d0,Bank5PatternTrackPrefix_volume_mod_enabled(a1)
	move.b d0,Bank5PatternTrackPrefix_volume_mod_enabled(a2)
	move.b d0,Bank5PatternTrackPrefix_volume_mod_enabled(a3)
	move.b d0,Bank5PatternTrackPrefix_volume_mod_enabled(a4)
	move.b d0,Bank5PatternTrackPrefix_slide_from_previous_note(a1)
	move.b d0,Bank5PatternTrackPrefix_slide_from_previous_note(a2)
	move.b d0,Bank5PatternTrackPrefix_slide_from_previous_note(a3)
	move.b d0,Bank5PatternTrackPrefix_slide_from_previous_note(a4)
	move.b d0,Bank5PatternTrackPrefix_volume_step_interval(a1)
	move.b d0,Bank5PatternTrackPrefix_volume_step_interval(a2)
	move.b d0,Bank5PatternTrackPrefix_volume_step_interval(a3)
	move.b d0,Bank5PatternTrackPrefix_volume_step_interval(a4)
	moveq.l #1,d0
	move.b d0,Bank5PatternTrackPrefix_pattern_finished(a1)
	move.b d0,Bank5PatternTrackPrefix_pattern_finished(a2)
	move.b d0,Bank5PatternTrackPrefix_pattern_finished(a3)
	move.b d0,Bank5PatternTrackPrefix_pattern_finished(a4)
	move.b d0,Bank5PatternTrackPrefix_first_note(a1)
	move.b d0,Bank5PatternTrackPrefix_first_note(a2)
	move.b d0,Bank5PatternTrackPrefix_first_note(a3)
	move.b d0,Bank5PatternTrackPrefix_first_note(a4)
	move.b d0,Bank5PatternTrackPrefix_order_repeat_count(a1)
	move.b d0,Bank5PatternTrackPrefix_order_repeat_count(a2)
	move.b d0,Bank5PatternTrackPrefix_order_repeat_count(a3)
	move.b d0,Bank5PatternTrackPrefix_order_repeat_count(a4)
	move.b d0,Bank5PatternTrackPrefix_note_ticks(a1)
	move.b d0,Bank5PatternTrackPrefix_note_ticks(a2)
	move.b d0,Bank5PatternTrackPrefix_note_ticks(a3)
	move.b d0,Bank5PatternTrackPrefix_note_ticks(a4)
	lea.l bank5InstrumentOffsets(pc),a0
	move.l a0,Bank5PatternTrackPrefix_instrument_pointer(a1)
	move.l a0,Bank5PatternTrackPrefix_instrument_pointer(a2)
	move.l a0,Bank5PatternTrackPrefix_instrument_pointer(a3)
	move.l a0,Bank5PatternTrackPrefix_instrument_pointer(a4)
	lea.l bank5InstrumentMap(pc),a0
	moveq.l #3,d0
	moveq.l #4,d1
abs_0_00059174:
	moveq.l #0,d2
abs_0_00059176:
	move.b d2,(a0)+
	add.b d1,d2
	cmp.b #$20,d2
	bne.b abs_0_00059176
	dbf.w d0,abs_0_00059174
	moveq.l #-1,d0
	move.b d0,Bank5PatternTrackPrefix_active(a1)
	move.b d0,Bank5PatternTrackPrefix_active(a2)
	move.b d0,Bank5PatternTrackPrefix_active(a3)
	move.b d0,Bank5PatternTrackPrefix_active(a4)
	lea.l bank5PlaybackActive(pc),a0
	move.b d0,(a0)
	move.w d0,Bank5PatternTrackPrefix_volume_scale(a1)
	move.w d0,Bank5PatternTrackPrefix_volume_scale(a2)
	move.w d0,Bank5PatternTrackPrefix_volume_scale(a3)
	move.w d0,Bank5PatternTrackPrefix_volume_scale(a4)
	rts
Bank5UpdateSong:
	bsr.w Bank5UpdateVoices
	lea.l bank5PlaybackActive(pc),a0
	tst.b (a0)
	beq.w abs_0_0005839C
	lea.l bank5PatternTrack0(pc),a1
	move.b Bank5PatternTrackPrefix_active(a1),d0
	or.b $005E(a1),d0
	or.b $00A6(a1),d0
	or.b $00EE(a1),d0
	move.b d0,(a0)
	bne.b abs_0_000591D6
	rts
abs_0_000591D6:
	lea.l bank5Voices(pc),a1
	lea.l bank5PatternTrack0(pc),a4
	bsr.w Bank5UpdatePatternTrack
	lea.l bank5Voice1(pc),a1
	lea.l bank5PatternTrack1(pc),a4
	bsr.w Bank5UpdatePatternTrack
	lea.l bank5Voice2(pc),a1
	lea.l bank5PatternTrack2(pc),a4
	bsr.w Bank5UpdatePatternTrack
	lea.l bank5Voice3(pc),a1
	lea.l bank5PatternTrack3(pc),a4
    ; KNOWN: type A1=Target code-entry register seed:Bank5Voice; type A4=Target code-entry register seed:Bank5PatternTrackPrefix
Bank5UpdatePatternTrack:
	tst.b Bank5PatternTrackPrefix_active(a4)
	beq.w abs_0_0005839C
	bsr.w Bank5UpdatePeriodSlide
	bsr.w Bank5UpdateVolumeModulation
	tst.b Bank5PatternTrackPrefix_pattern_finished(a4)
	beq.w abs_0_000592A6
abs_0_0005921A:
	subq.b #1,$0012(a4)
	beq.b abs_0_0005922E
	move.l $0006(a4),$000A(a4)
	clr.b $0014(a4)
	bra.w abs_0_000592A6
abs_0_0005922E:
	move.b #$1,$0012(a4)
	movea.l $0002(a4),a3
abs_0_00059238:
	moveq.l #0,d0
	move.b (a3)+,d0
	cmp.b #$C8,d0
	bcs.b abs_0_00059288
	cmp.b #$FE,d0
	bne.b abs_0_0005924E
	move.b (a3)+,$0013(a4)
	bra.b abs_0_00059238
abs_0_0005924E:
	cmp.b #$FF,d0
	bne.b abs_0_00059268
	move.w $0006(a1),d0
	beq.b abs_0_00059262
	cmp.w #$8000,d0
	bne.w abs_0_0005839C
abs_0_00059262:
	clr.b $0016(a4)
	rts
abs_0_00059268:
	cmp.b #$F0,d0
	bge.b abs_0_00059278
	subi.b #200,d0
	move.b d0,$0012(a4)
	bra.b abs_0_00059238
abs_0_00059278:
	subi.b #240,d0
	add.w (a4),d0
	lea.l bank5InstrumentMap(pc),a0
	move.b (a3)+,$0(a0,d0.w)
	bra.b abs_0_00059238
abs_0_00059288:
	clr.b $0014(a4)
	move.l a3,$0002(a4)
	lea.l bank5PatternOffsets(pc),a3
	add.w d0,d0
	move.w $0(a3,d0.w),d0
	lea.l bank5Pattern0(pc),a3
	adda.w d0,a3
	move.l a3,$0006(a4)
	bra.b abs_0_000592AA
abs_0_000592A6:
	movea.l $000A(a4),a3
abs_0_000592AA:
	subq.b #1,$0015(a4)
	beq.b abs_0_000592BE
	tst.b (a3)
	bpl.b abs_0_000592B8
	bsr.w Bank5DecodePatternCommand
abs_0_000592B8:
	move.l a3,$000A(a4)
	rts
abs_0_000592BE:
	tst.b (a3)
	bpl.b abs_0_000592D0
	bsr.w Bank5DecodePatternCommand
	tst.b $0014(a4)
	beq.b abs_0_000592BE
	bra.w abs_0_0005921A
abs_0_000592D0:
	move.b (a3)+,d0
	cmp.b #$7F,d0
	beq.w abs_0_000593B8
	clr.w $000A(a1)
	add.b $0013(a4),d0
	move.b d0,$0017(a4)
	move.b $003E(a4),d1
	ori.b #192,d1
    ; KNOWN: type A4=Target code-entry register seed:Bank5PatternTrackPrefix
	move.b d1,Bank5PatternTrackPrefix_encoded_note_command(a4)
	move.b Bank5PatternTrackPrefix_period_slide_enabled(a4),Bank5PatternTrackPrefix_note_slide_flags(a4)
	beq.b abs_0_0005931C
	move.b Bank5PatternTrackPrefix_period_slide_delay(a4),Bank5PatternTrackPrefix_note_slide_delay(a4)
	move.b Bank5PatternTrackPrefix_period_slide_steps(a4),Bank5PatternTrackPrefix_note_slide_steps_left(a4)
	move.b Bank5PatternTrackPrefix_slide_note_delta(a4),d1
	ext.w d1
	neg.w d1
	add.w d1,d1
	add.w d1,d1
	lea.l bank5PitchScaleTable(pc),a0
	move.l $0(a0,d1.w),Bank5PatternTrackPrefix_slide_ratio_or_step(a4)
abs_0_0005931C:
	move.b Bank5PatternTrackPrefix_volume_mod_enabled(a4),Bank5PatternTrackPrefix_note_volume_mod_enabled(a4)
	beq.b abs_0_00059340
	move.b Bank5PatternTrackPrefix_volume_mod_interval(a4),d2
	move.b d2,Bank5PatternTrackPrefix_note_volume_mod_interval(a4)
	move.b d2,Bank5PatternTrackPrefix_note_volume_mod_countdown(a4)
	move.b Bank5PatternTrackPrefix_volume_mod_steps(a4),Bank5PatternTrackPrefix_note_volume_mod_steps_left(a4)
	move.w Bank5PatternTrackPrefix_volume_mod_delta(a4),Bank5PatternTrackPrefix_note_volume_mod_step(a4)
	clr.w Bank5PatternTrackPrefix_note_volume_mod_offset(a4)
abs_0_00059340:
	moveq.l #0,d1
	move.b (a3)+,d1
	bne.b abs_0_0005934E
	move.b (a3)+,Bank5PatternTrackPrefix_note_ticks(a4)
	moveq.l #-1,d1
	bra.b abs_0_00059352
abs_0_0005934E:
	move.b d1,Bank5PatternTrackPrefix_note_ticks(a4)
abs_0_00059352:
	tst.b Bank5PatternTrackPrefix_slide_from_previous_note(a4)
	beq.b abs_0_0005938A
	st.b Bank5PatternTrackPrefix_note_slide_flags(a4)
	clr.b Bank5PatternTrackPrefix_note_slide_delay(a4)
	move.b Bank5PatternTrackPrefix_period_slide_steps(a4),Bank5PatternTrackPrefix_note_slide_steps_left(a4)
	move.b d0,d2
	tst.b Bank5PatternTrackPrefix_first_note(a4)
	bne.b abs_0_00059372
	move.b Bank5PatternTrackPrefix_reference_note(a4),d0
abs_0_00059372:
	move.b d0,Bank5PatternTrackPrefix_current_note(a4)
	sub.b d0,d2
	ext.w d2
	neg.w d2
	add.w d2,d2
	add.w d2,d2
	lea.l bank5PitchScaleTable(pc),a0
	move.l $0(a0,d2.w),Bank5PatternTrackPrefix_slide_ratio_or_step(a4)
abs_0_0005938A:
	move.b Bank5PatternTrackPrefix_current_note(a4),Bank5PatternTrackPrefix_reference_note(a4)
	move.l a3,Bank5PatternTrackPrefix_pattern_cursor(a4)
	movea.l Bank5PatternTrackPrefix_instrument_pointer(a4),a0
	move.l a0,Bank5PatternTrackPrefix_note_instrument_pointer(a4)
	move.w $000C(a0),d2
	mulu.w Bank5PatternTrackPrefix_volume_scale(a4),d2
	swap.w d2
	rol.l #2,d2
	move.w Bank5PatternTrackPrefix_volume_step_interval(a4),d3
	move.w Bank5PatternTrackPrefix_volume_step_delta(a4),d4
	clr.b Bank5PatternTrackPrefix_first_note(a4)
	bra.w Bank5StartVoice
abs_0_000593B8:
	move.b (a3)+,$0015(a4)
	move.l a3,$000A(a4)
	rts
    ; KNOWN: type A4=Target code-entry register seed:Bank5PatternTrackPrefix
Bank5DecodePatternCommand:
	move.b (a3)+,d0
	cmp.b #$88,d0
	bgt.b abs_0_000593E6
	andi.w #7,d0
	add.w (a4),d0	; operand 1: Bank5PatternTrackPrefix_instrument_map_offset at (a4)
	lea.l bank5InstrumentMap(pc),a0
	move.b $0(a0,d0.w),d0
	lea.l bank5InstrumentOffsets(pc),a0
	adda.l $0(a0,d0.w),a0
	move.l a0,Bank5PatternTrackPrefix_instrument_pointer(a4)
	rts
abs_0_000593E6:
	cmp.b #$FF,d0
	bne.b abs_0_000593F2
	move.b d0,Bank5PatternTrackPrefix_pattern_finished(a4)
	rts
abs_0_000593F2:
	cmp.b #$C0,d0
	bge.b abs_0_00059402
	andi.b #15,d0
	move.b d0,Bank5PatternTrackPrefix_command_nibble(a4)
	rts
abs_0_00059402:
	bne.b abs_0_0005941A
	st.b Bank5PatternTrackPrefix_period_slide_enabled(a4)
	clr.b Bank5PatternTrackPrefix_slide_from_previous_note(a4)
	move.b (a3)+,Bank5PatternTrackPrefix_period_slide_delay(a4)
	move.b (a3)+,Bank5PatternTrackPrefix_period_slide_steps(a4)
	move.b (a3)+,Bank5PatternTrackPrefix_slide_note_delta(a4)
	rts
abs_0_0005941A:
	cmp.b #$C1,d0
	bne.b abs_0_00059426
	clr.b Bank5PatternTrackPrefix_period_slide_enabled(a4)
	rts
abs_0_00059426:
	cmp.b #$C2,d0
	bne.b abs_0_00059442
	st.b Bank5PatternTrackPrefix_volume_mod_enabled(a4)
	move.b (a3)+,Bank5PatternTrackPrefix_volume_mod_interval(a4)
	move.b (a3)+,Bank5PatternTrackPrefix_volume_mod_steps(a4)
	move.b (a3)+,d0
	ext.w d0
	move.w d0,Bank5PatternTrackPrefix_volume_mod_delta(a4)
	rts
abs_0_00059442:
	cmp.b #$C3,d0
	bne.b abs_0_0005944E
	clr.b Bank5PatternTrackPrefix_volume_mod_enabled(a4)
	rts
abs_0_0005944E:
	cmp.b #$C4,d0
	bne.b abs_0_00059462
	st.b Bank5PatternTrackPrefix_slide_from_previous_note(a4)
	clr.b Bank5PatternTrackPrefix_period_slide_enabled(a4)
	move.b (a3)+,Bank5PatternTrackPrefix_period_slide_steps(a4)
	rts
abs_0_00059462:
	cmp.b #$C5,d0
	bne.b abs_0_0005946E
	clr.b Bank5PatternTrackPrefix_slide_from_previous_note(a4)
	rts
abs_0_0005946E:
	cmp.b #$C6,d0
	bne.b abs_0_0005948A
	move.b (a3)+,Bank5PatternTrackPrefix_volume_scale(a4)
	moveq.l #0,d0
	move.b (a3)+,d0
	move.w d0,Bank5PatternTrackPrefix_volume_step_interval(a4)
	move.b (a3)+,d0
	ext.w d0
	move.w d0,Bank5PatternTrackPrefix_volume_step_delta(a4)
	rts
abs_0_0005948A:
	cmp.b #$C7,d0
	bne.b abs_0_0005949C
	clr.w Bank5PatternTrackPrefix_volume_step_interval(a4)
	move.w #$FFFF,Bank5PatternTrackPrefix_volume_scale(a4)
	rts
abs_0_0005949C:
	illegal
	dc.b $66,$00,$EE,$FC,$10,$2C,$00,$46,$6A,$00,$EE,$F4,$02,$00,$00,$3F
	dc.b $66,$08,$08,$AC,$00,$07,$00,$46,$4E,$75,$7E,$07,$08,$2C,$00,$06
	dc.b $00,$46,$66,$00,$00,$2E,$53,$2C,$00,$44,$66,$00,$EE,$D2,$53,$2C
	dc.b $00,$45,$67,$1E,$26,$6C,$00,$40,$10,$1B,$29,$4B,$00,$40,$12,$00
	dc.b $C2,$07,$19,$41,$00,$44,$E6,$08,$02,$00,$00,$1F,$D0,$2C,$00,$17
	dc.b $60,$46,$47,$FA,$00,$E6,$10,$2C,$00,$46,$E7,$48,$02,$40,$00,$FF
	dc.b $D6,$C0,$4A,$13,$6B,$10,$08,$2C,$00,$06,$00,$46,$66,$08,$19,$7C
	dc.b $00,$01,$00,$45,$4E,$75,$08,$AC,$00,$06,$00,$46,$10,$13,$E6,$08
	dc.b $C0,$07,$19,$40,$00,$44,$10,$1B,$C0,$07,$52,$00,$19,$40,$00,$45
	dc.b $29,$4B,$00,$40,$10,$2C,$00,$17,$48,$80,$D0,$40,$4E,$75
    ; KNOWN: type A4=Target code-entry register seed:Bank5PatternTrackPrefix; type A1=Target code-entry register seed:Bank5Voice
Bank5UpdatePeriodSlide:
	tst.b Bank5PatternTrackPrefix_note_slide_flags(a4)
	beq.b abs_0_0005957A
	bpl.b abs_0_00059570
	move.w Bank5Voice_base_period(a1),d0
	move.w d0,d1
	move.l Bank5PatternTrackPrefix_slide_ratio_or_step(a4),d2
	mulu.w d2,d0
	swap.w d0
	swap.w d2
	mulu.w d2,d1
	add.w d1,d0
	sub.w Bank5Voice_base_period(a1),d0
	ext.l d0
	moveq.l #0,d1
	move.b Bank5PatternTrackPrefix_note_slide_steps_left(a4),d1
	divs.w d1,d0
	move.w d0,Bank5PatternTrackPrefix_slide_ratio_or_step(a4)
	bclr.b #7,Bank5PatternTrackPrefix_note_slide_flags(a4)
abs_0_00059570:
	tst.b Bank5PatternTrackPrefix_note_slide_delay(a4)
	beq.b abs_0_0005957C
	subq.b #1,Bank5PatternTrackPrefix_note_slide_delay(a4)
abs_0_0005957A:
	rts
abs_0_0005957C:
	tst.b Bank5PatternTrackPrefix_note_slide_steps_left(a4)
	beq.b abs_0_0005957A
	subq.b #1,Bank5PatternTrackPrefix_note_slide_steps_left(a4)
	move.w Bank5PatternTrackPrefix_slide_ratio_or_step(a4),d0
	add.w d0,Bank5Voice_period_slide_offset(a1)
	rts
    ; KNOWN: type A4=Target code-entry register seed:Bank5PatternTrackPrefix; type A1=Target code-entry register seed:Bank5Voice
Bank5UpdateVolumeModulation:
	tst.b Bank5PatternTrackPrefix_note_volume_mod_enabled(a4)
	beq.b abs_0_000595DE
	tst.b Bank5PatternTrackPrefix_note_volume_mod_steps_left(a4)
	beq.b abs_0_000595DE
	subq.b #1,Bank5PatternTrackPrefix_note_volume_mod_countdown(a4)
	bne.b abs_0_000595DE
	subq.b #1,Bank5PatternTrackPrefix_note_volume_mod_steps_left(a4)
	move.b Bank5PatternTrackPrefix_current_note(a4),d0
	moveq.l #0,d1
	move.b Bank5PatternTrackPrefix_note_volume_mod_interval(a4),d1
	move.b d1,Bank5PatternTrackPrefix_note_volume_mod_countdown(a4)
	movea.l Bank5PatternTrackPrefix_note_instrument_pointer(a4),a0
	move.w Bank5PatternTrackPrefix_note_volume_mod_offset(a4),d2
	add.w Bank5PatternTrackPrefix_note_volume_mod_step(a4),d2
	move.w d2,Bank5PatternTrackPrefix_note_volume_mod_offset(a4)
	add.w $000C(a0),d2
	bmi.w abs_0_000595DA
	cmp.w #$40,d2
	ble.w Bank5StartVoice
	moveq.l #64,d2
	bpl.w Bank5StartVoice
abs_0_000595DA:
	clr.b Bank5PatternTrackPrefix_note_volume_mod_steps_left(a4)
abs_0_000595DE:
	rts
bank5InstrumentOffsets:
	dc.l bank5Instruments-bank5InstrumentOffsets
	dc.l bank5Instruments-bank5InstrumentOffsets
	dc.l bank5Instrument2-bank5InstrumentOffsets
	dc.l bank5Instrument3-bank5InstrumentOffsets
	dc.l bank5Instrument4-bank5InstrumentOffsets
	dc.l bank5Instrument5-bank5InstrumentOffsets
	dc.l bank5Instrument6-bank5InstrumentOffsets
	dc.l bank5Instrument7-bank5InstrumentOffsets
bank5Instruments:
	dc.l bank5Sample0_1_3_4-bank5InstrumentOffsets	; sample_offset
	dc.l $00000000	; repeat_offset
	dc.w $1162	; sample_length_words
	dc.w $0000	; repeat_length_words
	dc.w $0040	; base_volume
	dc.w $0000	; volume_delta
	dc.w $FFFF	; initial_ramp_ticks
	dc.w $0000	; initial_period_scale
	dc.w $0000	; alternating_ticks
	dc.w $0000	; alternating_period_scale
	dc.w $0020	; pitch_reference_note
	dc.w $01A9	; period_scale
bank5Instrument3:
	dc.l bank5Sample0_1_3_4-bank5InstrumentOffsets	; sample_offset
	dc.l $00000000	; repeat_offset
	dc.w $1162	; sample_length_words
	dc.w $0000	; repeat_length_words
	dc.w $0008	; base_volume
	dc.w $0000	; volume_delta
	dc.w $FFFF	; initial_ramp_ticks
	dc.w $0000	; initial_period_scale
	dc.w $0000	; alternating_ticks
	dc.w $0000	; alternating_period_scale
	dc.w $0020	; pitch_reference_note
	dc.w $01A9	; period_scale
bank5Instrument4:
	dc.l bank5Sample0_1_3_4-bank5InstrumentOffsets	; sample_offset
	dc.l $00000000	; repeat_offset
	dc.w $1162	; sample_length_words
	dc.w $0000	; repeat_length_words
	dc.w $000A	; base_volume
	dc.w $0000	; volume_delta
	dc.w $FFFF	; initial_ramp_ticks
	dc.w $0000	; initial_period_scale
	dc.w $0000	; alternating_ticks
	dc.w $0000	; alternating_period_scale
	dc.w $0020	; pitch_reference_note
	dc.w $01A9	; period_scale
bank5Instrument2:
	dc.l bank5Sample2_7-bank5InstrumentOffsets	; sample_offset
	dc.l bank5Repeat2_7-bank5InstrumentOffsets	; repeat_offset
	dc.w $03E4	; sample_length_words
	dc.w $0BF9	; repeat_length_words
	dc.w $0008	; base_volume
	dc.w $FFFF	; volume_delta
	dc.w $FFFF	; initial_ramp_ticks
	dc.w $0000	; initial_period_scale
	dc.w $0000	; alternating_ticks
	dc.w $0000	; alternating_period_scale
	dc.w $0020	; pitch_reference_note
	dc.w $01A9	; period_scale
bank5Instrument7:
	dc.l bank5Sample2_7-bank5InstrumentOffsets	; sample_offset
	dc.l bank5Repeat2_7-bank5InstrumentOffsets	; repeat_offset
	dc.w $03E4	; sample_length_words
	dc.w $0BF9	; repeat_length_words
	dc.w $0040	; base_volume
	dc.w $FFFF	; volume_delta
	dc.w $FFFF	; initial_ramp_ticks
	dc.w $0000	; initial_period_scale
	dc.w $0000	; alternating_ticks
	dc.w $0000	; alternating_period_scale
	dc.w $0020	; pitch_reference_note
	dc.w $01A9	; period_scale
bank5Instrument6:
	dc.l bank5Sample6-bank5InstrumentOffsets	; sample_offset
	dc.l $00000000	; repeat_offset
	dc.w $03F0	; sample_length_words
	dc.w $0000	; repeat_length_words
	dc.w $0040	; base_volume
	dc.w $0000	; volume_delta
	dc.w $FFFF	; initial_ramp_ticks
	dc.w $0000	; initial_period_scale
	dc.w $0000	; alternating_ticks
	dc.w $0000	; alternating_period_scale
	dc.w $0020	; pitch_reference_note
	dc.w $01A7	; period_scale
bank5Instrument5:
	dc.l bank5Sample5-bank5InstrumentOffsets	; sample_offset
	dc.l $00000000	; repeat_offset
	dc.w $0874	; sample_length_words
	dc.w $0000	; repeat_length_words
	dc.w $0040	; base_volume
	dc.w $0000	; volume_delta
	dc.w $FFFF	; initial_ramp_ticks
	dc.w $0000	; initial_period_scale
	dc.w $0000	; alternating_ticks
	dc.w $0000	; alternating_period_scale
	dc.w $0008	; pitch_reference_note
	dc.w $01D9	; period_scale
	dc.b $80,$80
bank5Sample2_7:
	INCBIN "assets/bank5Sample2_7.bin"
; sound_sample
bank5Repeat2_7:
	INCBIN "assets/bank5Repeat2_7.bin"
; sound_sample
	dc.b $16,$21,$EF,$D8,$05,$2A,$34,$21,$FA,$04,$EA,$D3,$D5,$E7,$F9,$0E
	dc.b $12,$21,$EB,$D9,$0A,$2D,$33,$1B,$F6,$05,$E8,$CF,$D9,$EA,$FE,$0E
	dc.b $12,$24,$E8,$DD,$0E,$30,$31,$10,$FA,$06,$E1,$CC,$DC,$EE,$00,$0B
	dc.b $13,$22,$E5,$E2,$15,$30,$2E,$08,$00,$07,$DD,$CB,$DD,$F1,$05,$06
	dc.b $1B,$22,$DB,$EC,$17,$31,$2B,$FC,$06,$08,$D5,$CD,$E1,$F5,$06,$00
	dc.b $1F,$20,$D4,$F1,$1D,$32,$24,$F7,$09,$07,$D1,$D1,$E6,$F7,$06,$00
	dc.b $24,$19,$D1,$F9,$21,$32,$16,$F8,$0C,$03,$C8,$D7,$E9,$FB,$01,$02
	dc.b $28,$17,$CF,$00,$23,$31,$0D,$FF,$10,$02,$C4,$D9,$ED,$FE,$FC,$0C
	dc.b $2D,$09,$D3,$01,$26,$2F,$FD,$06,$14,$F8,$C6,$DE,$F1,$00,$F7,$13
	dc.b $2F,$F9,$DA,$06,$29,$27,$F6,$08,$17,$EC,$C9,$E2,$F5,$FF,$F8,$15
	dc.b $31,$E9,$DD,$0C,$29,$1A,$F8,$0B,$19,$E5,$CD,$E6,$F7,$FB,$FA,$18
	dc.b $31,$DF,$E2,$0F,$29,$0C,$FD,$0F,$17,$DD,$D4,$EB,$F9,$F8,$FD,$1E
	dc.b $2D,$D7,$E7,$13,$28,$FC,$02,$15,$13,$DB,$D9,$EF,$F8,$F6,$04,$23
	dc.b $26,$D6,$EC,$14,$21,$F6,$05,$18,$0E,$DD,$DF,$F2,$F8,$F5,$0A,$26
	dc.b $16,$D7,$F2,$17,$18,$F9,$08,$1B,$0C,$DE,$E2,$F4,$F7,$F4,$0D,$2B
	dc.b $0B,$D7,$F7,$18,$05,$FD,$0D,$1C,$07,$E3,$E7,$F4,$F9,$F6,$12,$2B
	dc.b $FD,$D7,$F9,$18,$F9,$01,$13,$1C,$01,$E9,$EB,$F4,$FA,$FB,$14,$29
	dc.b $F4,$D7,$FE,$12,$F7,$02,$16,$1A,$02,$EE,$EE,$F5,$F7,$00,$1A,$24
	dc.b $EC,$D9,$FE,$04,$FB,$04,$19,$19,$00,$F4,$EF,$F8,$F5,$05,$1E,$1A
	dc.b $E3,$DA,$01,$F5,$FF,$0A,$1A,$18,$00,$F8,$F0,$FB,$F4,$09,$1F,$11
	dc.b $DF,$DE,$FE,$EE,$00,$0D,$1C,$18,$04,$F9,$F1,$FC,$F5,$0B,$1E,$0D
	dc.b $D5,$E3,$F6,$F1,$01,$11,$1D,$1A,$09,$FD,$F5,$FB,$F8,$0F,$1A,$07
	dc.b $D0,$E3,$E8,$F6,$04,$13,$1E,$18,$10,$FC,$FA,$FB,$FD,$11,$13,$FF
	dc.b $CE,$E4,$DE,$FB,$08,$14,$20,$16,$14,$FB
bank5Sample0_1_3_4:
	INCBIN "assets/bank5Sample0_1_3_4.bin"
; sound_sample
bank5Sample6:
	INCBIN "assets/bank5Sample6.bin"
; sound_sample
	dc.b $FF,$80
bank5Sample5:
	INCBIN "assets/bank5Sample5.bin"
; sound_sample
	dc.b $01,$80
