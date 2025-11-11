
_custom_delay_ms:

;Tarea_2.c,22 :: 		void custom_delay_ms(unsigned int ms) {
;Tarea_2.c,24 :: 		for (i = 0; i < ms; i++) {
	CLRF       R1+0
	CLRF       R1+1
L_custom_delay_ms0:
	MOVF       FARG_custom_delay_ms_ms+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__custom_delay_ms67
	MOVF       FARG_custom_delay_ms_ms+0, 0
	SUBWF      R1+0, 0
L__custom_delay_ms67:
	BTFSC      STATUS+0, 0
	GOTO       L_custom_delay_ms1
;Tarea_2.c,25 :: 		for (j = 0; j < 1000; j++) {
	CLRF       R3+0
	CLRF       R3+1
L_custom_delay_ms3:
	MOVLW      3
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__custom_delay_ms68
	MOVLW      232
	SUBWF      R3+0, 0
L__custom_delay_ms68:
	BTFSC      STATUS+0, 0
	GOTO       L_custom_delay_ms4
;Tarea_2.c,26 :: 		asm nop;  // Ajusta este valor seg?n tu frecuencia de oscilador
	NOP
;Tarea_2.c,25 :: 		for (j = 0; j < 1000; j++) {
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;Tarea_2.c,27 :: 		}
	GOTO       L_custom_delay_ms3
L_custom_delay_ms4:
;Tarea_2.c,24 :: 		for (i = 0; i < ms; i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;Tarea_2.c,28 :: 		}
	GOTO       L_custom_delay_ms0
L_custom_delay_ms1:
;Tarea_2.c,29 :: 		}
L_end_custom_delay_ms:
	RETURN
; end of _custom_delay_ms

_custom_delay_us:

;Tarea_2.c,31 :: 		void custom_delay_us(unsigned int us) {
;Tarea_2.c,33 :: 		for (i = 0; i < us; i++) {
	CLRF       R1+0
	CLRF       R1+1
L_custom_delay_us6:
	MOVF       FARG_custom_delay_us_us+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__custom_delay_us70
	MOVF       FARG_custom_delay_us_us+0, 0
	SUBWF      R1+0, 0
L__custom_delay_us70:
	BTFSC      STATUS+0, 0
	GOTO       L_custom_delay_us7
;Tarea_2.c,34 :: 		asm nop;  // Ajusta seg?n tu oscilador
	NOP
;Tarea_2.c,33 :: 		for (i = 0; i < us; i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;Tarea_2.c,35 :: 		}
	GOTO       L_custom_delay_us6
L_custom_delay_us7:
;Tarea_2.c,36 :: 		}
L_end_custom_delay_us:
	RETURN
; end of _custom_delay_us

_beepPattern:

;Tarea_2.c,39 :: 		void beepPattern(unsigned short repeticiones, unsigned int onTime, unsigned int offTime) {
;Tarea_2.c,41 :: 		for (i = 0; i < repeticiones; i++) {
	CLRF       beepPattern_i_L0+0
L_beepPattern9:
	MOVF       FARG_beepPattern_repeticiones+0, 0
	SUBWF      beepPattern_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_beepPattern10
;Tarea_2.c,42 :: 		BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,43 :: 		custom_delay_ms(onTime);
	MOVF       FARG_beepPattern_onTime+0, 0
	MOVWF      FARG_custom_delay_ms_ms+0
	MOVF       FARG_beepPattern_onTime+1, 0
	MOVWF      FARG_custom_delay_ms_ms+1
	CALL       _custom_delay_ms+0
;Tarea_2.c,45 :: 		BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,46 :: 		custom_delay_ms(offTime);
	MOVF       FARG_beepPattern_offTime+0, 0
	MOVWF      FARG_custom_delay_ms_ms+0
	MOVF       FARG_beepPattern_offTime+1, 0
	MOVWF      FARG_custom_delay_ms_ms+1
	CALL       _custom_delay_ms+0
;Tarea_2.c,41 :: 		for (i = 0; i < repeticiones; i++) {
	INCF       beepPattern_i_L0+0, 1
;Tarea_2.c,47 :: 		}
	GOTO       L_beepPattern9
L_beepPattern10:
;Tarea_2.c,48 :: 		}
L_end_beepPattern:
	RETURN
; end of _beepPattern

_beepPattern_fixed:

;Tarea_2.c,51 :: 		void beepPattern_fixed(unsigned short repeticiones, unsigned char delay_type) {
;Tarea_2.c,53 :: 		for (i = 0; i < repeticiones; i++) {
	CLRF       R1+0
L_beepPattern_fixed12:
	MOVF       FARG_beepPattern_fixed_repeticiones+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_beepPattern_fixed13
;Tarea_2.c,54 :: 		BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,55 :: 		switch(delay_type) {
	GOTO       L_beepPattern_fixed15
;Tarea_2.c,56 :: 		case 1: Delay_ms(50); break;   // Corto
L_beepPattern_fixed17:
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_beepPattern_fixed18:
	DECFSZ     R13+0, 1
	GOTO       L_beepPattern_fixed18
	DECFSZ     R12+0, 1
	GOTO       L_beepPattern_fixed18
	NOP
	NOP
	GOTO       L_beepPattern_fixed16
;Tarea_2.c,57 :: 		case 2: Delay_ms(100); break;  // Medio
L_beepPattern_fixed19:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_beepPattern_fixed20:
	DECFSZ     R13+0, 1
	GOTO       L_beepPattern_fixed20
	DECFSZ     R12+0, 1
	GOTO       L_beepPattern_fixed20
	DECFSZ     R11+0, 1
	GOTO       L_beepPattern_fixed20
	NOP
	GOTO       L_beepPattern_fixed16
;Tarea_2.c,58 :: 		case 3: Delay_ms(150); break;  // Largo
L_beepPattern_fixed21:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_beepPattern_fixed22:
	DECFSZ     R13+0, 1
	GOTO       L_beepPattern_fixed22
	DECFSZ     R12+0, 1
	GOTO       L_beepPattern_fixed22
	DECFSZ     R11+0, 1
	GOTO       L_beepPattern_fixed22
	GOTO       L_beepPattern_fixed16
;Tarea_2.c,59 :: 		default: Delay_ms(100); break;
L_beepPattern_fixed23:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_beepPattern_fixed24:
	DECFSZ     R13+0, 1
	GOTO       L_beepPattern_fixed24
	DECFSZ     R12+0, 1
	GOTO       L_beepPattern_fixed24
	DECFSZ     R11+0, 1
	GOTO       L_beepPattern_fixed24
	NOP
	GOTO       L_beepPattern_fixed16
;Tarea_2.c,60 :: 		}
L_beepPattern_fixed15:
	MOVF       FARG_beepPattern_fixed_delay_type+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_beepPattern_fixed17
	MOVF       FARG_beepPattern_fixed_delay_type+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_beepPattern_fixed19
	MOVF       FARG_beepPattern_fixed_delay_type+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_beepPattern_fixed21
	GOTO       L_beepPattern_fixed23
L_beepPattern_fixed16:
;Tarea_2.c,61 :: 		BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,62 :: 		switch(delay_type) {
	GOTO       L_beepPattern_fixed25
;Tarea_2.c,63 :: 		case 1: Delay_ms(50); break;
L_beepPattern_fixed27:
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_beepPattern_fixed28:
	DECFSZ     R13+0, 1
	GOTO       L_beepPattern_fixed28
	DECFSZ     R12+0, 1
	GOTO       L_beepPattern_fixed28
	NOP
	NOP
	GOTO       L_beepPattern_fixed26
;Tarea_2.c,64 :: 		case 2: Delay_ms(100); break;
L_beepPattern_fixed29:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_beepPattern_fixed30:
	DECFSZ     R13+0, 1
	GOTO       L_beepPattern_fixed30
	DECFSZ     R12+0, 1
	GOTO       L_beepPattern_fixed30
	DECFSZ     R11+0, 1
	GOTO       L_beepPattern_fixed30
	NOP
	GOTO       L_beepPattern_fixed26
;Tarea_2.c,65 :: 		case 3: Delay_ms(150); break;
L_beepPattern_fixed31:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_beepPattern_fixed32:
	DECFSZ     R13+0, 1
	GOTO       L_beepPattern_fixed32
	DECFSZ     R12+0, 1
	GOTO       L_beepPattern_fixed32
	DECFSZ     R11+0, 1
	GOTO       L_beepPattern_fixed32
	GOTO       L_beepPattern_fixed26
;Tarea_2.c,66 :: 		default: Delay_ms(100); break;
L_beepPattern_fixed33:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_beepPattern_fixed34:
	DECFSZ     R13+0, 1
	GOTO       L_beepPattern_fixed34
	DECFSZ     R12+0, 1
	GOTO       L_beepPattern_fixed34
	DECFSZ     R11+0, 1
	GOTO       L_beepPattern_fixed34
	NOP
	GOTO       L_beepPattern_fixed26
;Tarea_2.c,67 :: 		}
L_beepPattern_fixed25:
	MOVF       FARG_beepPattern_fixed_delay_type+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_beepPattern_fixed27
	MOVF       FARG_beepPattern_fixed_delay_type+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_beepPattern_fixed29
	MOVF       FARG_beepPattern_fixed_delay_type+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_beepPattern_fixed31
	GOTO       L_beepPattern_fixed33
L_beepPattern_fixed26:
;Tarea_2.c,53 :: 		for (i = 0; i < repeticiones; i++) {
	INCF       R1+0, 1
;Tarea_2.c,68 :: 		}
	GOTO       L_beepPattern_fixed12
L_beepPattern_fixed13:
;Tarea_2.c,69 :: 		}
L_end_beepPattern_fixed:
	RETURN
; end of _beepPattern_fixed

_playNote:

;Tarea_2.c,72 :: 		void playNote(unsigned int frequency_delay, unsigned short duration) {
;Tarea_2.c,73 :: 		unsigned long cycles = (unsigned long)duration * 500UL / frequency_delay;
	MOVF       FARG_playNote_duration+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVLW      244
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVF       FARG_playNote_frequency_delay+0, 0
	MOVWF      R4+0
	MOVF       FARG_playNote_frequency_delay+1, 0
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      playNote_cycles_L0+0
	MOVF       R0+1, 0
	MOVWF      playNote_cycles_L0+1
	MOVF       R0+2, 0
	MOVWF      playNote_cycles_L0+2
	MOVF       R0+3, 0
	MOVWF      playNote_cycles_L0+3
;Tarea_2.c,76 :: 		for (i = 0; i < cycles; i++) {
	CLRF       playNote_i_L0+0
	CLRF       playNote_i_L0+1
	CLRF       playNote_i_L0+2
	CLRF       playNote_i_L0+3
L_playNote35:
	MOVF       playNote_cycles_L0+3, 0
	SUBWF      playNote_i_L0+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__playNote74
	MOVF       playNote_cycles_L0+2, 0
	SUBWF      playNote_i_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__playNote74
	MOVF       playNote_cycles_L0+1, 0
	SUBWF      playNote_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__playNote74
	MOVF       playNote_cycles_L0+0, 0
	SUBWF      playNote_i_L0+0, 0
L__playNote74:
	BTFSC      STATUS+0, 0
	GOTO       L_playNote36
;Tarea_2.c,77 :: 		BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,78 :: 		custom_delay_us(frequency_delay);
	MOVF       FARG_playNote_frequency_delay+0, 0
	MOVWF      FARG_custom_delay_us_us+0
	MOVF       FARG_playNote_frequency_delay+1, 0
	MOVWF      FARG_custom_delay_us_us+1
	CALL       _custom_delay_us+0
;Tarea_2.c,79 :: 		BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,80 :: 		custom_delay_us(frequency_delay);
	MOVF       FARG_playNote_frequency_delay+0, 0
	MOVWF      FARG_custom_delay_us_us+0
	MOVF       FARG_playNote_frequency_delay+1, 0
	MOVWF      FARG_custom_delay_us_us+1
	CALL       _custom_delay_us+0
;Tarea_2.c,76 :: 		for (i = 0; i < cycles; i++) {
	MOVF       playNote_i_L0+0, 0
	MOVWF      R0+0
	MOVF       playNote_i_L0+1, 0
	MOVWF      R0+1
	MOVF       playNote_i_L0+2, 0
	MOVWF      R0+2
	MOVF       playNote_i_L0+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      playNote_i_L0+0
	MOVF       R0+1, 0
	MOVWF      playNote_i_L0+1
	MOVF       R0+2, 0
	MOVWF      playNote_i_L0+2
	MOVF       R0+3, 0
	MOVWF      playNote_i_L0+3
;Tarea_2.c,81 :: 		}
	GOTO       L_playNote35
L_playNote36:
;Tarea_2.c,82 :: 		}
L_end_playNote:
	RETURN
; end of _playNote

_beep_short:

;Tarea_2.c,85 :: 		void beep_short() {
;Tarea_2.c,87 :: 		for (i = 0; i < 2; i++) {
	CLRF       R1+0
L_beep_short38:
	MOVLW      2
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_beep_short39
;Tarea_2.c,88 :: 		BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,89 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_beep_short41:
	DECFSZ     R13+0, 1
	GOTO       L_beep_short41
	DECFSZ     R12+0, 1
	GOTO       L_beep_short41
	NOP
	NOP
;Tarea_2.c,90 :: 		BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,91 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_beep_short42:
	DECFSZ     R13+0, 1
	GOTO       L_beep_short42
	DECFSZ     R12+0, 1
	GOTO       L_beep_short42
	DECFSZ     R11+0, 1
	GOTO       L_beep_short42
	NOP
;Tarea_2.c,87 :: 		for (i = 0; i < 2; i++) {
	INCF       R1+0, 1
;Tarea_2.c,92 :: 		}
	GOTO       L_beep_short38
L_beep_short39:
;Tarea_2.c,93 :: 		}
L_end_beep_short:
	RETURN
; end of _beep_short

_beep_long:

;Tarea_2.c,95 :: 		void beep_long() {
;Tarea_2.c,97 :: 		for (i = 0; i < 3; i++) {
	CLRF       R1+0
L_beep_long43:
	MOVLW      3
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_beep_long44
;Tarea_2.c,98 :: 		BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,99 :: 		Delay_ms(150);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_beep_long46:
	DECFSZ     R13+0, 1
	GOTO       L_beep_long46
	DECFSZ     R12+0, 1
	GOTO       L_beep_long46
	DECFSZ     R11+0, 1
	GOTO       L_beep_long46
;Tarea_2.c,100 :: 		BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,101 :: 		Delay_ms(150);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_beep_long47:
	DECFSZ     R13+0, 1
	GOTO       L_beep_long47
	DECFSZ     R12+0, 1
	GOTO       L_beep_long47
	DECFSZ     R11+0, 1
	GOTO       L_beep_long47
;Tarea_2.c,97 :: 		for (i = 0; i < 3; i++) {
	INCF       R1+0, 1
;Tarea_2.c,102 :: 		}
	GOTO       L_beep_long43
L_beep_long44:
;Tarea_2.c,103 :: 		}
L_end_beep_long:
	RETURN
; end of _beep_long

_startup_melody:

;Tarea_2.c,106 :: 		void startup_melody() {
;Tarea_2.c,108 :: 		playNote(SI, 200);
	MOVLW      246
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,109 :: 		playNote(DO_H, 200);
	MOVLW      188
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,110 :: 		playNote(RE, 200);
	MOVLW      164
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      6
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,111 :: 		playNote(MI, 200);
	MOVLW      239
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,112 :: 		playNote(FA, 200);
	MOVLW      152
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,113 :: 		playNote(SOL, 200);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,114 :: 		playNote(LA, 200);
	MOVLW      112
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,115 :: 		playNote(SI, 400);
	MOVLW      246
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      144
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,117 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_startup_melody48:
	DECFSZ     R13+0, 1
	GOTO       L_startup_melody48
	DECFSZ     R12+0, 1
	GOTO       L_startup_melody48
	DECFSZ     R11+0, 1
	GOTO       L_startup_melody48
	NOP
;Tarea_2.c,120 :: 		playNote(LA, 150);
	MOVLW      112
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,121 :: 		playNote(SOL, 150);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,122 :: 		playNote(FA, 150);
	MOVLW      152
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,123 :: 		playNote(MI, 150);
	MOVLW      239
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,124 :: 		playNote(RE, 150);
	MOVLW      164
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      6
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,125 :: 		playNote(DO, 300);
	MOVLW      123
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      7
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      44
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,127 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_startup_melody49:
	DECFSZ     R13+0, 1
	GOTO       L_startup_melody49
	DECFSZ     R12+0, 1
	GOTO       L_startup_melody49
	DECFSZ     R11+0, 1
	GOTO       L_startup_melody49
;Tarea_2.c,130 :: 		playNote(DO, 100);
	MOVLW      123
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      7
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,131 :: 		playNote(MI, 100);
	MOVLW      239
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,132 :: 		playNote(SOL, 100);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,133 :: 		playNote(DO_H, 400);
	MOVLW      188
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      144
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,134 :: 		}
L_end_startup_melody:
	RETURN
; end of _startup_melody

_retro_startup:

;Tarea_2.c,137 :: 		void retro_startup() {
;Tarea_2.c,139 :: 		playNote(DO, 100);
	MOVLW      123
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      7
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,140 :: 		playNote(MI, 100);
	MOVLW      239
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,141 :: 		playNote(SOL, 100);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,142 :: 		playNote(DO_H, 200);
	MOVLW      188
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,144 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_retro_startup50:
	DECFSZ     R13+0, 1
	GOTO       L_retro_startup50
	DECFSZ     R12+0, 1
	GOTO       L_retro_startup50
	NOP
	NOP
;Tarea_2.c,146 :: 		playNote(RE, 100);
	MOVLW      164
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      6
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,147 :: 		playNote(FA, 100);
	MOVLW      152
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,148 :: 		playNote(LA, 100);
	MOVLW      112
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      100
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,149 :: 		playNote(RE, 200);
	MOVLW      164
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      6
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      200
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,151 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_retro_startup51:
	DECFSZ     R13+0, 1
	GOTO       L_retro_startup51
	DECFSZ     R12+0, 1
	GOTO       L_retro_startup51
	DECFSZ     R11+0, 1
	GOTO       L_retro_startup51
	NOP
;Tarea_2.c,154 :: 		playNote(SOL, 150);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,155 :: 		playNote(LA, 150);
	MOVLW      112
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,156 :: 		playNote(SI, 150);
	MOVLW      246
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,157 :: 		playNote(DO_H, 300);
	MOVLW      188
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      44
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,158 :: 		playNote(SI, 150);
	MOVLW      246
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,159 :: 		playNote(LA, 150);
	MOVLW      112
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,160 :: 		playNote(SOL, 300);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      44
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,161 :: 		}
L_end_retro_startup:
	RETURN
; end of _retro_startup

_power_up_fanfare:

;Tarea_2.c,164 :: 		void power_up_fanfare() {
;Tarea_2.c,165 :: 		playNote(DO, 80);
	MOVLW      123
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      7
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      80
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,166 :: 		playNote(DO, 80);
	MOVLW      123
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      7
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      80
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,167 :: 		playNote(SOL, 120);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,168 :: 		playNote(SOL, 120);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,169 :: 		playNote(LA, 120);
	MOVLW      112
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,170 :: 		playNote(LA, 120);
	MOVLW      112
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,171 :: 		playNote(SOL, 250);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      250
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,173 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_power_up_fanfare52:
	DECFSZ     R13+0, 1
	GOTO       L_power_up_fanfare52
	DECFSZ     R12+0, 1
	GOTO       L_power_up_fanfare52
	DECFSZ     R11+0, 1
	GOTO       L_power_up_fanfare52
	NOP
;Tarea_2.c,175 :: 		playNote(FA, 120);
	MOVLW      152
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,176 :: 		playNote(FA, 120);
	MOVLW      152
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,177 :: 		playNote(MI, 120);
	MOVLW      239
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,178 :: 		playNote(MI, 120);
	MOVLW      239
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,179 :: 		playNote(RE, 120);
	MOVLW      164
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      6
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,180 :: 		playNote(RE, 120);
	MOVLW      164
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      6
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      120
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,181 :: 		playNote(DO, 250);
	MOVLW      123
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      7
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      250
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,182 :: 		}
L_end_power_up_fanfare:
	RETURN
; end of _power_up_fanfare

_waka_waka_sound:

;Tarea_2.c,185 :: 		void waka_waka_sound() {
;Tarea_2.c,186 :: 		beep_short();  // O usa: beepPattern_fixed(2, 1);
	CALL       _beep_short+0
;Tarea_2.c,187 :: 		}
L_end_waka_waka_sound:
	RETURN
; end of _waka_waka_sound

_game_over_sound:

;Tarea_2.c,190 :: 		void game_over_sound() {
;Tarea_2.c,191 :: 		beep_long();   // O usa: beepPattern_fixed(3, 3);
	CALL       _beep_long+0
;Tarea_2.c,192 :: 		}
L_end_game_over_sound:
	RETURN
; end of _game_over_sound

_victory_sound:

;Tarea_2.c,195 :: 		void victory_sound() {
;Tarea_2.c,196 :: 		playNote(DO, 150);
	MOVLW      123
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      7
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,197 :: 		playNote(MI, 150);
	MOVLW      239
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      5
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,198 :: 		playNote(SOL, 150);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,199 :: 		playNote(DO_H, 300);
	MOVLW      188
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      44
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,200 :: 		playNote(SOL, 150);
	MOVLW      251
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      4
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      150
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,201 :: 		playNote(DO_H, 300);
	MOVLW      188
	MOVWF      FARG_playNote_frequency_delay+0
	MOVLW      3
	MOVWF      FARG_playNote_frequency_delay+1
	MOVLW      44
	MOVWF      FARG_playNote_duration+0
	CALL       _playNote+0
;Tarea_2.c,202 :: 		}
L_end_victory_sound:
	RETURN
; end of _victory_sound

_main:

;Tarea_2.c,205 :: 		void main() {
;Tarea_2.c,211 :: 		BUZZER_TRIS = 0;        // RD0 como salida (buzzer)
	BCF        TRISD+0, 0
;Tarea_2.c,212 :: 		TRISD.TRISD1 = 1;       // RD1 como entrada (bot?n comida)
	BSF        TRISD+0, 1
;Tarea_2.c,213 :: 		TRISD.TRISD2 = 1;       // RD2 como entrada (bot?n game over)
	BSF        TRISD+0, 2
;Tarea_2.c,216 :: 		BUZZER = 0;             // Buzzer apagado
	BCF        PORTD+0, 0
;Tarea_2.c,219 :: 		PORTD = 0x00;           // Limpiar puerto D
	CLRF       PORTD+0
;Tarea_2.c,225 :: 		Delay_ms(500);          // Pausa inicial
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main53:
	DECFSZ     R13+0, 1
	GOTO       L_main53
	DECFSZ     R12+0, 1
	GOTO       L_main53
	DECFSZ     R11+0, 1
	GOTO       L_main53
	NOP
	NOP
;Tarea_2.c,228 :: 		startup_melody();       // Melod?a principal
	CALL       _startup_melody+0
;Tarea_2.c,232 :: 		Delay_ms(1000);         // Pausa antes del bucle principal
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main54:
	DECFSZ     R13+0, 1
	GOTO       L_main54
	DECFSZ     R12+0, 1
	GOTO       L_main54
	DECFSZ     R11+0, 1
	GOTO       L_main54
	NOP
	NOP
;Tarea_2.c,238 :: 		while (1) {
L_main55:
;Tarea_2.c,240 :: 		if (BTN_COMIDA == 1) {
	BTFSS      PORTD+0, 1
	GOTO       L_main57
;Tarea_2.c,241 :: 		waka_waka_sound();
	CALL       _waka_waka_sound+0
;Tarea_2.c,242 :: 		while (BTN_COMIDA == 1); // Anti-rebote simple
L_main58:
	BTFSS      PORTD+0, 1
	GOTO       L_main59
	GOTO       L_main58
L_main59:
;Tarea_2.c,243 :: 		Delay_ms(50);            // Debounce adicional
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main60:
	DECFSZ     R13+0, 1
	GOTO       L_main60
	DECFSZ     R12+0, 1
	GOTO       L_main60
	NOP
	NOP
;Tarea_2.c,244 :: 		}
L_main57:
;Tarea_2.c,247 :: 		if (BTN_GAMEOVER == 1) {
	BTFSS      PORTD+0, 2
	GOTO       L_main61
;Tarea_2.c,248 :: 		game_over_sound();
	CALL       _game_over_sound+0
;Tarea_2.c,249 :: 		while (BTN_GAMEOVER == 1); // Anti-rebote simple
L_main62:
	BTFSS      PORTD+0, 2
	GOTO       L_main63
	GOTO       L_main62
L_main63:
;Tarea_2.c,250 :: 		Delay_ms(50);              // Debounce adicional
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main64:
	DECFSZ     R13+0, 1
	GOTO       L_main64
	DECFSZ     R12+0, 1
	GOTO       L_main64
	NOP
	NOP
;Tarea_2.c,251 :: 		}
L_main61:
;Tarea_2.c,254 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main65:
	DECFSZ     R13+0, 1
	GOTO       L_main65
	DECFSZ     R12+0, 1
	GOTO       L_main65
	NOP
;Tarea_2.c,255 :: 		}
	GOTO       L_main55
;Tarea_2.c,256 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
