
_retardo_ms_custom:

;Tarea_2.c,22 :: 		void retardo_ms_custom(unsigned int tiempo_ms) {
;Tarea_2.c,24 :: 		for (i = 0; i < tiempo_ms; i++) {
	CLRF       R1+0
	CLRF       R1+1
L_retardo_ms_custom0:
	MOVF       FARG_retardo_ms_custom_tiempo_ms+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__retardo_ms_custom64
	MOVF       FARG_retardo_ms_custom_tiempo_ms+0, 0
	SUBWF      R1+0, 0
L__retardo_ms_custom64:
	BTFSC      STATUS+0, 0
	GOTO       L_retardo_ms_custom1
;Tarea_2.c,25 :: 		for (j = 0; j < 1000; j++) {
	CLRF       R3+0
	CLRF       R3+1
L_retardo_ms_custom3:
	MOVLW      3
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__retardo_ms_custom65
	MOVLW      232
	SUBWF      R3+0, 0
L__retardo_ms_custom65:
	BTFSC      STATUS+0, 0
	GOTO       L_retardo_ms_custom4
;Tarea_2.c,26 :: 		asm nop;  // Ajustar según frecuencia del oscilador
	NOP
;Tarea_2.c,25 :: 		for (j = 0; j < 1000; j++) {
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;Tarea_2.c,27 :: 		}
	GOTO       L_retardo_ms_custom3
L_retardo_ms_custom4:
;Tarea_2.c,24 :: 		for (i = 0; i < tiempo_ms; i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;Tarea_2.c,28 :: 		}
	GOTO       L_retardo_ms_custom0
L_retardo_ms_custom1:
;Tarea_2.c,29 :: 		}
L_end_retardo_ms_custom:
	RETURN
; end of _retardo_ms_custom

_retardo_us_custom:

;Tarea_2.c,32 :: 		void retardo_us_custom(unsigned int tiempo_us) {
;Tarea_2.c,34 :: 		for (i = 0; i < tiempo_us; i++) {
	CLRF       R1+0
	CLRF       R1+1
L_retardo_us_custom6:
	MOVF       FARG_retardo_us_custom_tiempo_us+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__retardo_us_custom67
	MOVF       FARG_retardo_us_custom_tiempo_us+0, 0
	SUBWF      R1+0, 0
L__retardo_us_custom67:
	BTFSC      STATUS+0, 0
	GOTO       L_retardo_us_custom7
;Tarea_2.c,35 :: 		asm nop;  // Ajustar según frecuencia del oscilador
	NOP
;Tarea_2.c,34 :: 		for (i = 0; i < tiempo_us; i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;Tarea_2.c,36 :: 		}
	GOTO       L_retardo_us_custom6
L_retardo_us_custom7:
;Tarea_2.c,37 :: 		}
L_end_retardo_us_custom:
	RETURN
; end of _retardo_us_custom

_emitir_pitido:

;Tarea_2.c,40 :: 		void emitir_pitido(unsigned short repeticiones, unsigned int tiempo_encendido, unsigned int tiempo_apagado) {
;Tarea_2.c,42 :: 		for (contador = 0; contador < repeticiones; contador++) {
	CLRF       emitir_pitido_contador_L0+0
L_emitir_pitido9:
	MOVF       FARG_emitir_pitido_repeticiones+0, 0
	SUBWF      emitir_pitido_contador_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_emitir_pitido10
;Tarea_2.c,43 :: 		PIN_BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,44 :: 		retardo_ms_custom(tiempo_encendido);
	MOVF       FARG_emitir_pitido_tiempo_encendido+0, 0
	MOVWF      FARG_retardo_ms_custom_tiempo_ms+0
	MOVF       FARG_emitir_pitido_tiempo_encendido+1, 0
	MOVWF      FARG_retardo_ms_custom_tiempo_ms+1
	CALL       _retardo_ms_custom+0
;Tarea_2.c,45 :: 		PIN_BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,46 :: 		retardo_ms_custom(tiempo_apagado);
	MOVF       FARG_emitir_pitido_tiempo_apagado+0, 0
	MOVWF      FARG_retardo_ms_custom_tiempo_ms+0
	MOVF       FARG_emitir_pitido_tiempo_apagado+1, 0
	MOVWF      FARG_retardo_ms_custom_tiempo_ms+1
	CALL       _retardo_ms_custom+0
;Tarea_2.c,42 :: 		for (contador = 0; contador < repeticiones; contador++) {
	INCF       emitir_pitido_contador_L0+0, 1
;Tarea_2.c,47 :: 		}
	GOTO       L_emitir_pitido9
L_emitir_pitido10:
;Tarea_2.c,48 :: 		}
L_end_emitir_pitido:
	RETURN
; end of _emitir_pitido

_emitir_pitido_fijo:

;Tarea_2.c,51 :: 		void emitir_pitido_fijo(unsigned short repeticiones, unsigned char tipo_retraso) {
;Tarea_2.c,53 :: 		for (contador = 0; contador < repeticiones; contador++) {
	CLRF       R1+0
L_emitir_pitido_fijo12:
	MOVF       FARG_emitir_pitido_fijo_repeticiones+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_emitir_pitido_fijo13
;Tarea_2.c,54 :: 		PIN_BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,55 :: 		switch(tipo_retraso) {
	GOTO       L_emitir_pitido_fijo15
;Tarea_2.c,56 :: 		case 1: Delay_ms(50); break;   // Corto
L_emitir_pitido_fijo17:
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_emitir_pitido_fijo18:
	DECFSZ     R13+0, 1
	GOTO       L_emitir_pitido_fijo18
	DECFSZ     R12+0, 1
	GOTO       L_emitir_pitido_fijo18
	NOP
	NOP
	GOTO       L_emitir_pitido_fijo16
;Tarea_2.c,57 :: 		case 2: Delay_ms(100); break;  // Medio
L_emitir_pitido_fijo19:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_emitir_pitido_fijo20:
	DECFSZ     R13+0, 1
	GOTO       L_emitir_pitido_fijo20
	DECFSZ     R12+0, 1
	GOTO       L_emitir_pitido_fijo20
	DECFSZ     R11+0, 1
	GOTO       L_emitir_pitido_fijo20
	NOP
	GOTO       L_emitir_pitido_fijo16
;Tarea_2.c,58 :: 		case 3: Delay_ms(150); break;  // Largo
L_emitir_pitido_fijo21:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_emitir_pitido_fijo22:
	DECFSZ     R13+0, 1
	GOTO       L_emitir_pitido_fijo22
	DECFSZ     R12+0, 1
	GOTO       L_emitir_pitido_fijo22
	DECFSZ     R11+0, 1
	GOTO       L_emitir_pitido_fijo22
	GOTO       L_emitir_pitido_fijo16
;Tarea_2.c,59 :: 		default: Delay_ms(100); break;
L_emitir_pitido_fijo23:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_emitir_pitido_fijo24:
	DECFSZ     R13+0, 1
	GOTO       L_emitir_pitido_fijo24
	DECFSZ     R12+0, 1
	GOTO       L_emitir_pitido_fijo24
	DECFSZ     R11+0, 1
	GOTO       L_emitir_pitido_fijo24
	NOP
	GOTO       L_emitir_pitido_fijo16
;Tarea_2.c,60 :: 		}
L_emitir_pitido_fijo15:
	MOVF       FARG_emitir_pitido_fijo_tipo_retraso+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_emitir_pitido_fijo17
	MOVF       FARG_emitir_pitido_fijo_tipo_retraso+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_emitir_pitido_fijo19
	MOVF       FARG_emitir_pitido_fijo_tipo_retraso+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_emitir_pitido_fijo21
	GOTO       L_emitir_pitido_fijo23
L_emitir_pitido_fijo16:
;Tarea_2.c,61 :: 		PIN_BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,62 :: 		switch(tipo_retraso) {
	GOTO       L_emitir_pitido_fijo25
;Tarea_2.c,63 :: 		case 1: Delay_ms(50); break;
L_emitir_pitido_fijo27:
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_emitir_pitido_fijo28:
	DECFSZ     R13+0, 1
	GOTO       L_emitir_pitido_fijo28
	DECFSZ     R12+0, 1
	GOTO       L_emitir_pitido_fijo28
	NOP
	NOP
	GOTO       L_emitir_pitido_fijo26
;Tarea_2.c,64 :: 		case 2: Delay_ms(100); break;
L_emitir_pitido_fijo29:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_emitir_pitido_fijo30:
	DECFSZ     R13+0, 1
	GOTO       L_emitir_pitido_fijo30
	DECFSZ     R12+0, 1
	GOTO       L_emitir_pitido_fijo30
	DECFSZ     R11+0, 1
	GOTO       L_emitir_pitido_fijo30
	NOP
	GOTO       L_emitir_pitido_fijo26
;Tarea_2.c,65 :: 		case 3: Delay_ms(150); break;
L_emitir_pitido_fijo31:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_emitir_pitido_fijo32:
	DECFSZ     R13+0, 1
	GOTO       L_emitir_pitido_fijo32
	DECFSZ     R12+0, 1
	GOTO       L_emitir_pitido_fijo32
	DECFSZ     R11+0, 1
	GOTO       L_emitir_pitido_fijo32
	GOTO       L_emitir_pitido_fijo26
;Tarea_2.c,66 :: 		default: Delay_ms(100); break;
L_emitir_pitido_fijo33:
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_emitir_pitido_fijo34:
	DECFSZ     R13+0, 1
	GOTO       L_emitir_pitido_fijo34
	DECFSZ     R12+0, 1
	GOTO       L_emitir_pitido_fijo34
	DECFSZ     R11+0, 1
	GOTO       L_emitir_pitido_fijo34
	NOP
	GOTO       L_emitir_pitido_fijo26
;Tarea_2.c,67 :: 		}
L_emitir_pitido_fijo25:
	MOVF       FARG_emitir_pitido_fijo_tipo_retraso+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_emitir_pitido_fijo27
	MOVF       FARG_emitir_pitido_fijo_tipo_retraso+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_emitir_pitido_fijo29
	MOVF       FARG_emitir_pitido_fijo_tipo_retraso+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_emitir_pitido_fijo31
	GOTO       L_emitir_pitido_fijo33
L_emitir_pitido_fijo26:
;Tarea_2.c,53 :: 		for (contador = 0; contador < repeticiones; contador++) {
	INCF       R1+0, 1
;Tarea_2.c,68 :: 		}
	GOTO       L_emitir_pitido_fijo12
L_emitir_pitido_fijo13:
;Tarea_2.c,69 :: 		}
L_end_emitir_pitido_fijo:
	RETURN
; end of _emitir_pitido_fijo

_reproducir_nota:

;Tarea_2.c,72 :: 		void reproducir_nota(unsigned int periodo, unsigned short duracion) {
;Tarea_2.c,73 :: 		unsigned long ciclos = (unsigned long)duracion * 500UL / periodo;
	MOVF       FARG_reproducir_nota_duracion+0, 0
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
	MOVF       FARG_reproducir_nota_periodo+0, 0
	MOVWF      R4+0
	MOVF       FARG_reproducir_nota_periodo+1, 0
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      reproducir_nota_ciclos_L0+0
	MOVF       R0+1, 0
	MOVWF      reproducir_nota_ciclos_L0+1
	MOVF       R0+2, 0
	MOVWF      reproducir_nota_ciclos_L0+2
	MOVF       R0+3, 0
	MOVWF      reproducir_nota_ciclos_L0+3
;Tarea_2.c,76 :: 		for (i = 0; i < ciclos; i++) {
	CLRF       reproducir_nota_i_L0+0
	CLRF       reproducir_nota_i_L0+1
	CLRF       reproducir_nota_i_L0+2
	CLRF       reproducir_nota_i_L0+3
L_reproducir_nota35:
	MOVF       reproducir_nota_ciclos_L0+3, 0
	SUBWF      reproducir_nota_i_L0+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__reproducir_nota71
	MOVF       reproducir_nota_ciclos_L0+2, 0
	SUBWF      reproducir_nota_i_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__reproducir_nota71
	MOVF       reproducir_nota_ciclos_L0+1, 0
	SUBWF      reproducir_nota_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__reproducir_nota71
	MOVF       reproducir_nota_ciclos_L0+0, 0
	SUBWF      reproducir_nota_i_L0+0, 0
L__reproducir_nota71:
	BTFSC      STATUS+0, 0
	GOTO       L_reproducir_nota36
;Tarea_2.c,77 :: 		PIN_BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,78 :: 		retardo_us_custom(periodo);
	MOVF       FARG_reproducir_nota_periodo+0, 0
	MOVWF      FARG_retardo_us_custom_tiempo_us+0
	MOVF       FARG_reproducir_nota_periodo+1, 0
	MOVWF      FARG_retardo_us_custom_tiempo_us+1
	CALL       _retardo_us_custom+0
;Tarea_2.c,79 :: 		PIN_BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,80 :: 		retardo_us_custom(periodo);
	MOVF       FARG_reproducir_nota_periodo+0, 0
	MOVWF      FARG_retardo_us_custom_tiempo_us+0
	MOVF       FARG_reproducir_nota_periodo+1, 0
	MOVWF      FARG_retardo_us_custom_tiempo_us+1
	CALL       _retardo_us_custom+0
;Tarea_2.c,76 :: 		for (i = 0; i < ciclos; i++) {
	MOVF       reproducir_nota_i_L0+0, 0
	MOVWF      R0+0
	MOVF       reproducir_nota_i_L0+1, 0
	MOVWF      R0+1
	MOVF       reproducir_nota_i_L0+2, 0
	MOVWF      R0+2
	MOVF       reproducir_nota_i_L0+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      reproducir_nota_i_L0+0
	MOVF       R0+1, 0
	MOVWF      reproducir_nota_i_L0+1
	MOVF       R0+2, 0
	MOVWF      reproducir_nota_i_L0+2
	MOVF       R0+3, 0
	MOVWF      reproducir_nota_i_L0+3
;Tarea_2.c,81 :: 		}
	GOTO       L_reproducir_nota35
L_reproducir_nota36:
;Tarea_2.c,82 :: 		}
L_end_reproducir_nota:
	RETURN
; end of _reproducir_nota

_pitido_corto:

;Tarea_2.c,85 :: 		void pitido_corto() {
;Tarea_2.c,87 :: 		for (i = 0; i < 2; i++) {
	CLRF       R1+0
L_pitido_corto38:
	MOVLW      2
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_pitido_corto39
;Tarea_2.c,88 :: 		PIN_BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,89 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_pitido_corto41:
	DECFSZ     R13+0, 1
	GOTO       L_pitido_corto41
	DECFSZ     R12+0, 1
	GOTO       L_pitido_corto41
	NOP
	NOP
;Tarea_2.c,90 :: 		PIN_BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,91 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_pitido_corto42:
	DECFSZ     R13+0, 1
	GOTO       L_pitido_corto42
	DECFSZ     R12+0, 1
	GOTO       L_pitido_corto42
	DECFSZ     R11+0, 1
	GOTO       L_pitido_corto42
	NOP
;Tarea_2.c,87 :: 		for (i = 0; i < 2; i++) {
	INCF       R1+0, 1
;Tarea_2.c,92 :: 		}
	GOTO       L_pitido_corto38
L_pitido_corto39:
;Tarea_2.c,93 :: 		}
L_end_pitido_corto:
	RETURN
; end of _pitido_corto

_pitido_largo:

;Tarea_2.c,96 :: 		void pitido_largo() {
;Tarea_2.c,98 :: 		for (i = 0; i < 3; i++) {
	CLRF       R1+0
L_pitido_largo43:
	MOVLW      3
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_pitido_largo44
;Tarea_2.c,99 :: 		PIN_BUZZER = 1;
	BSF        PORTD+0, 0
;Tarea_2.c,100 :: 		Delay_ms(150);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_pitido_largo46:
	DECFSZ     R13+0, 1
	GOTO       L_pitido_largo46
	DECFSZ     R12+0, 1
	GOTO       L_pitido_largo46
	DECFSZ     R11+0, 1
	GOTO       L_pitido_largo46
;Tarea_2.c,101 :: 		PIN_BUZZER = 0;
	BCF        PORTD+0, 0
;Tarea_2.c,102 :: 		Delay_ms(150);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_pitido_largo47:
	DECFSZ     R13+0, 1
	GOTO       L_pitido_largo47
	DECFSZ     R12+0, 1
	GOTO       L_pitido_largo47
	DECFSZ     R11+0, 1
	GOTO       L_pitido_largo47
;Tarea_2.c,98 :: 		for (i = 0; i < 3; i++) {
	INCF       R1+0, 1
;Tarea_2.c,103 :: 		}
	GOTO       L_pitido_largo43
L_pitido_largo44:
;Tarea_2.c,104 :: 		}
L_end_pitido_largo:
	RETURN
; end of _pitido_largo

_melodia_bienvenida:

;Tarea_2.c,106 :: 		void melodia_bienvenida() {
;Tarea_2.c,107 :: 		reproducir_nota(NOTA_DO, 180);
	MOVLW      123
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      7
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      180
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,108 :: 		reproducir_nota(NOTA_RE, 180);
	MOVLW      164
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      6
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      180
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,109 :: 		reproducir_nota(NOTA_MI, 250);
	MOVLW      239
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      5
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      250
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,111 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_melodia_bienvenida48:
	DECFSZ     R13+0, 1
	GOTO       L_melodia_bienvenida48
	DECFSZ     R12+0, 1
	GOTO       L_melodia_bienvenida48
	DECFSZ     R11+0, 1
	GOTO       L_melodia_bienvenida48
	NOP
;Tarea_2.c,113 :: 		reproducir_nota(NOTA_MI, 150);
	MOVLW      239
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      5
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      150
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,114 :: 		reproducir_nota(NOTA_RE, 150);
	MOVLW      164
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      6
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      150
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,115 :: 		reproducir_nota(NOTA_DO, 300);
	MOVLW      123
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      7
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      44
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,116 :: 		}
L_end_melodia_bienvenida:
	RETURN
; end of _melodia_bienvenida

_melodia_victoria:

;Tarea_2.c,118 :: 		void melodia_victoria() {
;Tarea_2.c,119 :: 		reproducir_nota(NOTA_DO_OCT, 150);
	MOVLW      188
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      3
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      150
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,120 :: 		reproducir_nota(NOTA_MI, 150);
	MOVLW      239
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      5
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      150
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,121 :: 		reproducir_nota(NOTA_SOL, 300);
	MOVLW      251
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      4
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      44
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,123 :: 		Delay_ms(120);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      56
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_melodia_victoria49:
	DECFSZ     R13+0, 1
	GOTO       L_melodia_victoria49
	DECFSZ     R12+0, 1
	GOTO       L_melodia_victoria49
	DECFSZ     R11+0, 1
	GOTO       L_melodia_victoria49
;Tarea_2.c,125 :: 		reproducir_nota(NOTA_SOL, 200);
	MOVLW      251
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      4
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      200
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,126 :: 		reproducir_nota(NOTA_DO_OCT, 350);
	MOVLW      188
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      3
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      94
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,127 :: 		}
L_end_melodia_victoria:
	RETURN
; end of _melodia_victoria

_melodia_derrota:

;Tarea_2.c,129 :: 		void melodia_derrota() {
;Tarea_2.c,130 :: 		reproducir_nota(NOTA_MI, 200);
	MOVLW      239
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      5
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      200
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,131 :: 		reproducir_nota(NOTA_RE, 200);
	MOVLW      164
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      6
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      200
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,132 :: 		reproducir_nota(NOTA_DO, 500);
	MOVLW      123
	MOVWF      FARG_reproducir_nota_periodo+0
	MOVLW      7
	MOVWF      FARG_reproducir_nota_periodo+1
	MOVLW      244
	MOVWF      FARG_reproducir_nota_duracion+0
	CALL       _reproducir_nota+0
;Tarea_2.c,133 :: 		}
L_end_melodia_derrota:
	RETURN
; end of _melodia_derrota

_sonido_comida:

;Tarea_2.c,136 :: 		void sonido_comida() {
;Tarea_2.c,137 :: 		pitido_corto();
	CALL       _pitido_corto+0
;Tarea_2.c,138 :: 		}
L_end_sonido_comida:
	RETURN
; end of _sonido_comida

_sonido_fin_juego:

;Tarea_2.c,141 :: 		void sonido_fin_juego() {
;Tarea_2.c,142 :: 		pitido_largo();
	CALL       _pitido_largo+0
;Tarea_2.c,143 :: 		}
L_end_sonido_fin_juego:
	RETURN
; end of _sonido_fin_juego

_main:

;Tarea_2.c,146 :: 		void main() {
;Tarea_2.c,148 :: 		TRIS_BUZZER = 0;        // Configurar buzzer como salida
	BCF        TRISD+0, 0
;Tarea_2.c,149 :: 		TRISD.TRISD1 = 1;       // Botón comida como entrada
	BSF        TRISD+0, 1
;Tarea_2.c,150 :: 		TRISD.TRISD2 = 1;       // Botón fin juego como entrada
	BSF        TRISD+0, 2
;Tarea_2.c,152 :: 		PIN_BUZZER = 0;         // Apagar buzzer inicialmente
	BCF        PORTD+0, 0
;Tarea_2.c,153 :: 		PORTD = 0x00;           // Limpiar puerto D
	CLRF       PORTD+0
;Tarea_2.c,155 :: 		Delay_ms(500);          // Pausa inicial
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main50:
	DECFSZ     R13+0, 1
	GOTO       L_main50
	DECFSZ     R12+0, 1
	GOTO       L_main50
	DECFSZ     R11+0, 1
	GOTO       L_main50
	NOP
	NOP
;Tarea_2.c,158 :: 		melodia_bienvenida();
	CALL       _melodia_bienvenida+0
;Tarea_2.c,160 :: 		Delay_ms(1000);         // Pausa antes del ciclo principal
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main51:
	DECFSZ     R13+0, 1
	GOTO       L_main51
	DECFSZ     R12+0, 1
	GOTO       L_main51
	DECFSZ     R11+0, 1
	GOTO       L_main51
	NOP
	NOP
;Tarea_2.c,162 :: 		while (1) {
L_main52:
;Tarea_2.c,164 :: 		if (BOTON_COMIDA == 1) {
	BTFSS      PORTD+0, 1
	GOTO       L_main54
;Tarea_2.c,165 :: 		sonido_comida();
	CALL       _sonido_comida+0
;Tarea_2.c,166 :: 		while (BOTON_COMIDA == 1); // Esperar a que se suelte el botón
L_main55:
	BTFSS      PORTD+0, 1
	GOTO       L_main56
	GOTO       L_main55
L_main56:
;Tarea_2.c,167 :: 		Delay_ms(50);               // Anti-rebote
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main57:
	DECFSZ     R13+0, 1
	GOTO       L_main57
	DECFSZ     R12+0, 1
	GOTO       L_main57
	NOP
	NOP
;Tarea_2.c,168 :: 		}
L_main54:
;Tarea_2.c,171 :: 		if (BOTON_FIN == 1) {
	BTFSS      PORTD+0, 2
	GOTO       L_main58
;Tarea_2.c,172 :: 		sonido_fin_juego();
	CALL       _sonido_fin_juego+0
;Tarea_2.c,173 :: 		while (BOTON_FIN == 1);    // Esperar a que se suelte el botón
L_main59:
	BTFSS      PORTD+0, 2
	GOTO       L_main60
	GOTO       L_main59
L_main60:
;Tarea_2.c,174 :: 		Delay_ms(50);              // Anti-rebote
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main61:
	DECFSZ     R13+0, 1
	GOTO       L_main61
	DECFSZ     R12+0, 1
	GOTO       L_main61
	NOP
	NOP
;Tarea_2.c,175 :: 		}
L_main58:
;Tarea_2.c,177 :: 		Delay_ms(10); // Pequeña pausa para evitar saturar CPU
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main62:
	DECFSZ     R13+0, 1
	GOTO       L_main62
	DECFSZ     R12+0, 1
	GOTO       L_main62
	NOP
;Tarea_2.c,178 :: 		}
	GOTO       L_main52
;Tarea_2.c,179 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
