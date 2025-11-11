// Proyecto Sistemas Embebidos - Comunicación entre Microcontroladores
// Equipo: 3
// Miembros: Karla Lopez, Cristhian Bastidas, Christopher Lema

// Definición de frecuencias musicales (periodos en microsegundos)
#define NOTA_DO    1915   // C4 - 261 Hz
#define NOTA_RE    1700   // D4 - 294 Hz
#define NOTA_MI    1519   // E4 - 330 Hz
#define NOTA_FA    1432   // F4 - 349 Hz
#define NOTA_SOL   1275   // G4 - 392 Hz
#define NOTA_LA    1136   // A4 - 440 Hz
#define NOTA_SI    1014   // B4 - 494 Hz
#define NOTA_DO_OCT 956   // C5 - 523 Hz

// Definición de pines
#define PIN_BUZZER      PORTD.RD0
#define TRIS_BUZZER     TRISD.TRISD0
#define BOTON_COMIDA    PORTD.RD1
#define BOTON_FIN       PORTD.RD2

// Retardo personalizado en milisegundos
void retardo_ms_custom(unsigned int tiempo_ms) {
    unsigned int i, j;
    for (i = 0; i < tiempo_ms; i++) {
        for (j = 0; j < 1000; j++) {
            asm nop;  // Ajustar según frecuencia del oscilador
        }
    }
}

// Retardo personalizado en microsegundos
void retardo_us_custom(unsigned int tiempo_us) {
    unsigned int i;
    for (i = 0; i < tiempo_us; i++) {
        asm nop;  // Ajustar según frecuencia del oscilador
    }
}

// Patrón de pitidos con tiempos personalizados
void emitir_pitido(unsigned short repeticiones, unsigned int tiempo_encendido, unsigned int tiempo_apagado) {
    unsigned short contador;
    for (contador = 0; contador < repeticiones; contador++) {
        PIN_BUZZER = 1;
        retardo_ms_custom(tiempo_encendido);
        PIN_BUZZER = 0;
        retardo_ms_custom(tiempo_apagado);
    }
}

// Patrón de pitidos con tiempos fijos (corto, medio, largo)
void emitir_pitido_fijo(unsigned short repeticiones, unsigned char tipo_retraso) {
    unsigned short contador;
    for (contador = 0; contador < repeticiones; contador++) {
        PIN_BUZZER = 1;
        switch(tipo_retraso) {
            case 1: Delay_ms(50); break;   // Corto
            case 2: Delay_ms(100); break;  // Medio
            case 3: Delay_ms(150); break;  // Largo
            default: Delay_ms(100); break;
        }
        PIN_BUZZER = 0;
        switch(tipo_retraso) {
            case 1: Delay_ms(50); break;
            case 2: Delay_ms(100); break;
            case 3: Delay_ms(150); break;
            default: Delay_ms(100); break;
        }
    }
}

// Reproducir nota musical con duración personalizada
void reproducir_nota(unsigned int periodo, unsigned short duracion) {
    unsigned long ciclos = (unsigned long)duracion * 500UL / periodo;
    unsigned long i;

    for (i = 0; i < ciclos; i++) {
        PIN_BUZZER = 1;
        retardo_us_custom(periodo);
        PIN_BUZZER = 0;
        retardo_us_custom(periodo);
    }
}

// Pitido corto
void pitido_corto() {
    unsigned short i;
    for (i = 0; i < 2; i++) {
        PIN_BUZZER = 1;
        Delay_ms(50);
        PIN_BUZZER = 0;
        Delay_ms(100);
    }
}

// Pitido largo
void pitido_largo() {
    unsigned short i;
    for (i = 0; i < 3; i++) {
        PIN_BUZZER = 1;
        Delay_ms(150);
        PIN_BUZZER = 0;
        Delay_ms(150);
    }
}

void melodia_bienvenida() {
    reproducir_nota(NOTA_DO, 180);
    reproducir_nota(NOTA_RE, 180);
    reproducir_nota(NOTA_MI, 250);

    Delay_ms(100);

    reproducir_nota(NOTA_MI, 150);
    reproducir_nota(NOTA_RE, 150);
    reproducir_nota(NOTA_DO, 300);
}

void melodia_victoria() {
    reproducir_nota(NOTA_DO_OCT, 150);
    reproducir_nota(NOTA_MI, 150);
    reproducir_nota(NOTA_SOL, 300);

    Delay_ms(120);

    reproducir_nota(NOTA_SOL, 200);
    reproducir_nota(NOTA_DO_OCT, 350);
}

void melodia_derrota() {
    reproducir_nota(NOTA_MI, 200);
    reproducir_nota(NOTA_RE, 200);
    reproducir_nota(NOTA_DO, 500);
}

// Sonido de comida
void sonido_comida() {
    pitido_corto();
}

// Sonido de fin de juego
void sonido_fin_juego() {
    pitido_largo();
}

// Función principal
void main() {
    // Configuración inicial de pines
    TRIS_BUZZER = 0;        // Configurar buzzer como salida
    TRISD.TRISD1 = 1;       // Botón comida como entrada
    TRISD.TRISD2 = 1;       // Botón fin juego como entrada

    PIN_BUZZER = 0;         // Apagar buzzer inicialmente
    PORTD = 0x00;           // Limpiar puerto D

    Delay_ms(500);          // Pausa inicial

    // Reproducir melodía de bienvenida
    melodia_bienvenida();

    Delay_ms(1000);         // Pausa antes del ciclo principal

    while (1) {
        // Detectar botón comida
        if (BOTON_COMIDA == 1) {
            sonido_comida();
            while (BOTON_COMIDA == 1); // Esperar a que se suelte el botón
            Delay_ms(50);               // Anti-rebote
        }

        // Detectar botón fin juego
        if (BOTON_FIN == 1) {
            sonido_fin_juego();
            while (BOTON_FIN == 1);    // Esperar a que se suelte el botón
            Delay_ms(50);              // Anti-rebote
        }

        Delay_ms(10); // Pequeña pausa para evitar saturar CPU
    }
}