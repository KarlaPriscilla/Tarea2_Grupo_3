// Proyecto Sistemas Embebidos - Comunicación entre Microcontroladores
// Equipo: 3
// Miembros: Karla Lopez, Cristhian Bastidas, Christopher Lema

#include <avr/io.h>
#include <util/delay.h>

// Definición de pines (Puerto B y D)
#define PIN_DATOS PB3    // Pin 11
#define PIN_CARGA PB2    // Pin 10
#define PIN_RELOJ PB5    // Pin 13
#define INDICADOR_COMIDA PD5  // Pin Arduino 5
#define INDICADOR_FIN PD4     // Pin Arduino 4

// Configuración inicial de pines como salida o entrada
void inicializar_pines() {
    DDRB |= (1 << PIN_DATOS) | (1 << PIN_CARGA) | (1 << PIN_RELOJ);
    DDRD |= (1 << INDICADOR_COMIDA) | (1 << INDICADOR_FIN);
}

void configurar_pulsadores() {
    DDRB &= ~((1 << PB0) | (1 << PB1));  // PB0 y PB1 como entrada
    DDRD &= ~((1 << PD7) | (1 << PD6));  // PD7 y PD6 como entrada
    PORTB |= (1 << PB0) | (1 << PB1);    // Activar pull-up en PB0 y PB1
    PORTD |= (1 << PD7) | (1 << PD6);    // Activar pull-up en PD7 y PD6
}

// Funciones para detectar pulsación de botones
uint8_t boton_presionado_pin9() {
    return !(PINB & (1 << PB1));
}

uint8_t boton_presionado_pin8() {
    return !(PINB & (1 << PB0));
}

uint8_t boton_presionado_pin7() {
    return !(PIND & (1 << PD7));
}

uint8_t boton_presionado_pin6() {
    return !(PIND & (1 << PD6));
}

// Señalización de evento comida
void indicar_comida() {
    PORTD |= (1 << INDICADOR_COMIDA);
    _delay_ms(50);
    PORTD &= ~(1 << INDICADOR_COMIDA);
}

// Señalización de evento fin de juego
void indicar_fin_juego() {
    PORTD |= (1 << INDICADOR_FIN);
    _delay_ms(100);
    PORTD &= ~(1 << INDICADOR_FIN);
}

// Envío de datos bit a bit al MAX7219
void enviar_bits(uint8_t dato) {
    for (int8_t i = 7; i >= 0; i--) {
        PORTB &= ~(1 << PIN_RELOJ);
        if ((dato >> i) & 0x01)
            PORTB |= (1 << PIN_DATOS);
        else
            PORTB &= ~(1 << PIN_DATOS);
        PORTB |= (1 << PIN_RELOJ);
    }
}

// Enviar comando y dato al MAX7219
void enviar_a_MAX7219(uint8_t direccion, uint8_t valor) {
    PORTB &= ~(1 << PIN_CARGA);
    enviar_bits(direccion);
    enviar_bits(valor);
    PORTB |= (1 << PIN_CARGA);
}

// Inicialización del MAX7219
void configurar_MAX7219() {
    enviar_a_MAX7219(0x09, 0x00);
    enviar_a_MAX7219(0x0A, 0x08);
    enviar_a_MAX7219(0x0B, 0x07);
    enviar_a_MAX7219(0x0C, 0x01);
    enviar_a_MAX7219(0x0F, 0x00);
}

// Fuente de caracteres para matriz LED
const uint8_t tabla_fuente[][5] = {
    {0x7E, 0x09, 0x09, 0x09, 0x7E}, // A
    {0x7F, 0x49, 0x49, 0x49, 0x36}, // B
    {0x3E, 0x41, 0x41, 0x41, 0x22}, // C
    {0x7F, 0x41, 0x41, 0x41, 0x3E}, // D
    {0x7F, 0x49, 0x49, 0x49, 0x41}, // E
    {0x7F, 0x09, 0x09, 0x09, 0x01}, // F
    {0x3E, 0x41, 0x49, 0x49, 0x7A}, // G
    {0x7F, 0x08, 0x08, 0x08, 0x7F}, // H
    {0x00, 0x41, 0x7F, 0x41, 0x00}, // I
    {0x20, 0x40, 0x41, 0x3F, 0x01}, // J
    {0x7F, 0x08, 0x14, 0x22, 0x41}, // K
    {0x7F, 0x40, 0x40, 0x40, 0x40}, // L
    {0x7F, 0x02, 0x04, 0x02, 0x7F}, // M
    {0x7F, 0x04, 0x08, 0x10, 0x7F}, // N
    {0x3E, 0x41, 0x41, 0x41, 0x3E}, // O
    {0x7F, 0x09, 0x09, 0x09, 0x06}, // P
    {0x3E, 0x41, 0x51, 0x21, 0x5E}, // Q
    {0x7F, 0x09, 0x19, 0x29, 0x46}, // R
    {0x46, 0x49, 0x49, 0x49, 0x31}, // S
    {0x01, 0x01, 0x7F, 0x01, 0x01}, // T
    {0x3F, 0x40, 0x40, 0x40, 0x3F}, // U
    {0x1F, 0x20, 0x40, 0x20, 0x1F}, // V
    {0x7F, 0x20, 0x18, 0x20, 0x7F}, // W
    {0x63, 0x14, 0x08, 0x14, 0x63}, // X
    {0x07, 0x08, 0x70, 0x08, 0x07}, // Y
    {0x61, 0x51, 0x49, 0x45, 0x43}, // Z
    {0x00, 0x00, 0x00, 0x00, 0x00}, // espacio
    {0x08, 0x08, 0x08, 0x08, 0x08}, // -
    {0x08, 0x00, 0x08, 0x00, 0x00}, // :
    {0x14, 0x14, 0x14, 0x14, 0x14}  // =
};

// Mensaje para mostrar niveles
const char texto_niveles[] = " NIVEL: A=FACIL B=MEDIO C=DIFICIL ";

// Función para obtener índice de carácter en tabla
int indice_caracter(char c) {
    if (c >= 'A' && c <= 'Z') return c - 'A';
    if (c == ' ') return 26;
    if (c == '-') return 27;
    if (c == ':') return 28;
    if (c == '=') return 29;
    return 26;
}

// Función para desplazar texto en matriz LED
void desplazar_texto(const char *cadena) {
    uint8_t buffer[300] = {0};
    uint16_t pos_buffer = 0;

    for (uint8_t i = 0; cadena[i] != '\0'; i++) {
        int idx = indice_caracter(cadena[i]);
        for (uint8_t j = 0; j < 5; j++) buffer[pos_buffer++] = tabla_fuente[idx][j];
        buffer[pos_buffer++] = 0x00;
    }

    for (uint16_t pos = 0; pos < pos_buffer - 8; pos++) {
        if (boton_presionado_pin9() || boton_presionado_pin8() || boton_presionado_pin7() || boton_presionado_pin6())
            return;

        for (uint8_t fila = 0; fila < 8; fila++) {
            uint8_t salida = 0;
            for (uint8_t bit = 0; bit < 8; bit++) {
                if (buffer[pos + bit] & (1 << fila)) salida |= (1 << bit);
            }
            enviar_a_MAX7219(fila + 1, salida);
        }
        _delay_ms(100);
    }
}

// Apagar matriz LED
void limpiar_matriz() {
    for (uint8_t i = 1; i <= 8; i++) {
        enviar_a_MAX7219(i, 0x00);
    }
}

// Generador LFSR para números aleatorios 0-7
uint8_t registro_lfsr = 0xAC;

uint8_t generar_aleatorio() {
    registro_lfsr ^= (registro_lfsr << 7);
    registro_lfsr ^= (registro_lfsr >> 5);
    registro_lfsr ^= (registro_lfsr << 3);
    return registro_lfsr & 0x07;
}

// Mostrar mensaje de fin de juego
void mostrar_fin_juego() {
    const char *mensaje_fin = "  GAME OVER  ";
    uint8_t buffer[300] = {0};
    uint16_t pos_buffer = 0;

    for (uint8_t i = 0; mensaje_fin[i] != '\0'; i++) {
        int idx = indice_caracter(mensaje_fin[i]);
        for (uint8_t j = 0; j < 5; j++) buffer[pos_buffer++] = tabla_fuente[idx][j];
        buffer[pos_buffer++] = 0x00;
    }

    for (uint16_t pos = 0; pos < pos_buffer - 8; pos++) {
        for (uint8_t fila = 0; fila < 8; fila++) {
            uint8_t salida = 0;
            for (uint8_t bit = 0; bit < 8; bit++) {
                if (buffer[pos + bit] & (1 << fila)) salida |= (1 << bit);
            }
            enviar_a_MAX7219(fila + 1, salida);
        }
        _delay_ms(100);
    }
    indicar_fin_juego();

    _delay_ms(1000);
    limpiar_matriz();
}

// Juego nivel fácil
void juego_facil() {
    typedef struct {
        uint8_t x;
        uint8_t y;
    } Segmento;

    Segmento serpiente[64];
    uint8_t longitud = 2;
    serpiente[0] = (Segmento){4, 3};
    serpiente[1] = (Segmento){3, 3};
    serpiente[2] = (Segmento){2, 3};
    serpiente[3] = (Segmento){1, 3};

    uint8_t direccion = 1;
    uint8_t ultima_direccion = 1;

    Segmento comida;
    comida.x = generar_aleatorio();
    comida.y = generar_aleatorio();

    while (1) {
        // Lectura de botones para cambiar dirección
        if (boton_presionado_pin8() && ultima_direccion != 1) direccion = 0;
        if (boton_presionado_pin7() && ultima_direccion != 0) direccion = 1;
        if (boton_presionado_pin9() && ultima_direccion != 3) direccion = 2;
        if (boton_presionado_pin6() && ultima_direccion != 2) direccion = 3;

        ultima_direccion = direccion;

        // Mover cuerpo de la serpiente
        for (int i = longitud - 1; i > 0; i--) {
            serpiente[i] = serpiente[i - 1];
        }

        // Mover cabeza según dirección
        switch (direccion) {
            case 0: serpiente[0].x = (serpiente[0].x == 0) ? 7 : serpiente[0].x - 1; break;
            case 1: serpiente[0].x = (serpiente[0].x + 1) % 8; break;
            case 2: serpiente[0].y = (serpiente[0].y == 0) ? 7 : serpiente[0].y - 1; break;
            case 3: serpiente[0].y = (serpiente[0].y + 1) % 8; break;
        }

        // Verificar colisión con el cuerpo
        for (uint8_t i = 1; i < longitud; i++) {
            if (serpiente[0].x == serpiente[i].x && serpiente[0].y == serpiente[i].y) {
                mostrar_fin_juego();
                return;
            }
        }

        // Verificar si la serpiente comió
        if (serpiente[0].x == comida.x && serpiente[0].y == comida.y) {
            if (longitud < 64) longitud++;
            indicar_comida();
            comida.x = generar_aleatorio();
            comida.y = generar_aleatorio();
        }

        // Preparar buffer para matriz LED
        uint8_t buffer[8] = {0};

        // Dibujar cuerpo de la serpiente
        for (uint8_t i = 0; i < longitud; i++) {
            buffer[serpiente[i].y] |= (1 << serpiente[i].x);
        }

        // Dibujar comida
        buffer[comida.y] |= (1 << comida.x);

        // Enviar datos a matriz LED
        for (uint8_t fila = 0; fila < 8; fila++) {
            enviar_a_MAX7219(fila + 1, buffer[fila]);
        }

        _delay_ms(400);
    }
}

// Juego nivel medio
void juego_medio() {
    typedef struct {
        uint8_t x;
        uint8_t y;
    } Segmento;

    Segmento serpiente[64];
    uint8_t longitud = 2;
    serpiente[0] = (Segmento){4, 3};
    serpiente[1] = (Segmento){3, 3};
    serpiente[2] = (Segmento){2, 3};
    serpiente[3] = (Segmento){1, 3};

    uint8_t direccion = 1;
    uint8_t ultima_direccion = 1;

    Segmento comida;
    comida.x = generar_aleatorio();
    comida.y = generar_aleatorio();

    while (1) {
        // Lectura de botones para cambiar dirección
        if (boton_presionado_pin8() && ultima_direccion != 1) direccion = 0;
        if (boton_presionado_pin7() && ultima_direccion != 0) direccion = 1;
        if (boton_presionado_pin9() && ultima_direccion != 3) direccion = 2;
        if (boton_presionado_pin6() && ultima_direccion != 2) direccion = 3;

        ultima_direccion = direccion;

        // Mover cuerpo de la serpiente
        for (int i = longitud - 1; i > 0; i--) {
            serpiente[i] = serpiente[i - 1];
        }

        // Mover cabeza según dirección
        switch (direccion) {
            case 0: serpiente[0].x = (serpiente[0].x == 0) ? 7 : serpiente[0].x - 1; break;
            case 1: serpiente[0].x = (serpiente[0].x + 1) % 8; break;
            case 2: serpiente[0].y = (serpiente[0].y == 0) ? 7 : serpiente[0].y - 1; break;
            case 3: serpiente[0].y = (serpiente[0].y + 1) % 8; break;
        }

        // Verificar colisión con el cuerpo
        for (uint8_t i = 1; i < longitud; i++) {
            if (serpiente[0].x == serpiente[i].x && serpiente[0].y == serpiente[i].y) {
                mostrar_fin_juego();
                return;
            }
        }

        // Verificar si la serpiente comió
        if (serpiente[0].x == comida.x && serpiente[0].y == comida.y) {
            if (longitud < 64) longitud++;
            indicar_comida();
            comida.x = generar_aleatorio();
            comida.y = generar_aleatorio();
        }

        // Preparar buffer para matriz LED
        uint8_t buffer[8] = {0};

        // Dibujar cuerpo de la serpiente
        for (uint8_t i = 0; i < longitud; i++) {
            buffer[serpiente[i].y] |= (1 << serpiente[i].x);
        }

        // Dibujar comida
        buffer[comida.y] |= (1 << comida.x);

        // Enviar datos a matriz LED
        for (uint8_t fila = 0; fila < 8; fila++) {
            enviar_a_MAX7219(fila + 1, buffer[fila]);
        }

        _delay_ms(200);
    }
}

// Juego nivel difícil
void juego_dificil() {
    typedef struct {
        uint8_t x;
        uint8_t y;
    } Segmento;

    Segmento serpiente[64];
    uint8_t longitud = 2;
    serpiente[0] = (Segmento){4, 3};
    serpiente[1] = (Segmento){3, 3};

    uint8_t direccion = 1;
    uint8_t ultima_direccion = 1;

    Segmento comida1, comida2;
    comida1.x = generar_aleatorio();
    comida1.y = generar_aleatorio();
    comida2.x = generar_aleatorio();
    comida2.y = generar_aleatorio();

    while (1) {
        // Lectura de botones para cambiar dirección
        if (boton_presionado_pin8() && ultima_direccion != 1) direccion = 0;
        if (boton_presionado_pin7() && ultima_direccion != 0) direccion = 1;
        if (boton_presionado_pin9() && ultima_direccion != 3) direccion = 2;
        if (boton_presionado_pin6() && ultima_direccion != 2) direccion = 3;

        ultima_direccion = direccion;

        // Mover cuerpo de la serpiente
        for (int i = longitud - 1; i > 0; i--) {
            serpiente[i] = serpiente[i - 1];
        }

        // Mover cabeza según dirección
        switch (direccion) {
            case 0: serpiente[0].x = (serpiente[0].x == 0) ? 7 : serpiente[0].x - 1; break;
            case 1: serpiente[0].x = (serpiente[0].x + 1) % 8; break;
            case 2: serpiente[0].y = (serpiente[0].y == 0) ? 7 : serpiente[0].y - 1; break;
            case 3: serpiente[0].y = (serpiente[0].y + 1) % 8; break;
        }

        // Verificar colisión con el cuerpo
        for (uint8_t i = 1; i < longitud; i++) {
            if (serpiente[0].x == serpiente[i].x && serpiente[0].y == serpiente[i].y) {
                mostrar_fin_juego();
                return;
            }
        }

        // Verificar si la serpiente comió comida1
        if (serpiente[0].x == comida1.x && serpiente[0].y == comida1.y) {
            if (longitud < 64) longitud++;
            indicar_comida();
            comida1.x = generar_aleatorio();
            comida1.y = generar_aleatorio();
        }

        // Verificar si la serpiente comió comida2
        if (serpiente[0].x == comida2.x && serpiente[0].y == comida2.y) {
            if (longitud < 64) longitud++;
            indicar_comida();
            comida2.x = generar_aleatorio();
            comida2.y = generar_aleatorio();
        }

        // Preparar buffer para matriz LED
        uint8_t buffer[8] = {0};

        // Dibujar cuerpo de la serpiente
        for (uint8_t i = 0; i < longitud; i++) {
            buffer[serpiente[i].y] |= (1 << serpiente[i].x);
        }

        // Dibujar ambas comidas
        buffer[comida1.y] |= (1 << comida1.x);
        buffer[comida2.y] |= (1 << comida2.x);

        // Enviar datos a matriz LED
        for (uint8_t fila = 0; fila < 8; fila++) {
            enviar_a_MAX7219(fila + 1, buffer[fila]);
        }

        _delay_ms(100);
    }
}

// Mostrar mensaje final
void mostrar_mensaje_final() {
    const char *mensaje_fin = "FIN";
    uint8_t buffer[300] = {0};
    uint16_t pos_buffer = 0;

    for (uint8_t i = 0; mensaje_fin[i] != '\0'; i++) {
        int idx = indice_caracter(mensaje_fin[i]);
        for (uint8_t j = 0; j < 5; j++) buffer[pos_buffer++] = tabla_fuente[idx][j];
        buffer[pos_buffer++] = 0x00;
    }

    for (uint16_t pos = 0; pos < pos_buffer - 8; pos++) {
        for (uint8_t fila = 0; fila < 8; fila++) {
            uint8_t salida = 0;
            for (uint8_t bit = 0; bit < 8; bit++) {
                if (buffer[pos + bit] & (1 << fila)) salida |= (1 << bit);
            }
            enviar_a_MAX7219(fila + 1, salida);
        }
        _delay_ms(100);
    }

    _delay_ms(1000);
    limpiar_matriz();
}

int main(void) {
    inicializar_pines();
    configurar_MAX7219();
    configurar_pulsadores();

    while (1) {
        desplazar_texto(texto_niveles);
        if (boton_presionado_pin9()) {
            juego_facil();
            break;
        }
        if (boton_presionado_pin8()) {
            juego_medio();
            break;
        }
        if (boton_presionado_pin7()) {
            juego_dificil();
            break;
        }
        if (boton_presionado_pin6()) {
            mostrar_mensaje_final();
            break;
        }
    }

    while (1); // Bucle infinito para finalizar
}