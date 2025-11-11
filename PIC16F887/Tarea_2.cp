#line 1 "C:/Desktop/Documentos-Karla/Semestre 9/SISTEMAS EMBEBIDOS/Tarea2/Mikro c/Tarea_2.c"
#line 22 "C:/Desktop/Documentos-Karla/Semestre 9/SISTEMAS EMBEBIDOS/Tarea2/Mikro c/Tarea_2.c"
void retardo_ms_custom(unsigned int tiempo_ms) {
 unsigned int i, j;
 for (i = 0; i < tiempo_ms; i++) {
 for (j = 0; j < 1000; j++) {
 asm nop;
 }
 }
}


void retardo_us_custom(unsigned int tiempo_us) {
 unsigned int i;
 for (i = 0; i < tiempo_us; i++) {
 asm nop;
 }
}


void emitir_pitido(unsigned short repeticiones, unsigned int tiempo_encendido, unsigned int tiempo_apagado) {
 unsigned short contador;
 for (contador = 0; contador < repeticiones; contador++) {
  PORTD.RD0  = 1;
 retardo_ms_custom(tiempo_encendido);
  PORTD.RD0  = 0;
 retardo_ms_custom(tiempo_apagado);
 }
}


void emitir_pitido_fijo(unsigned short repeticiones, unsigned char tipo_retraso) {
 unsigned short contador;
 for (contador = 0; contador < repeticiones; contador++) {
  PORTD.RD0  = 1;
 switch(tipo_retraso) {
 case 1: Delay_ms(50); break;
 case 2: Delay_ms(100); break;
 case 3: Delay_ms(150); break;
 default: Delay_ms(100); break;
 }
  PORTD.RD0  = 0;
 switch(tipo_retraso) {
 case 1: Delay_ms(50); break;
 case 2: Delay_ms(100); break;
 case 3: Delay_ms(150); break;
 default: Delay_ms(100); break;
 }
 }
}


void reproducir_nota(unsigned int periodo, unsigned short duracion) {
 unsigned long ciclos = (unsigned long)duracion * 500UL / periodo;
 unsigned long i;

 for (i = 0; i < ciclos; i++) {
  PORTD.RD0  = 1;
 retardo_us_custom(periodo);
  PORTD.RD0  = 0;
 retardo_us_custom(periodo);
 }
}


void pitido_corto() {
 unsigned short i;
 for (i = 0; i < 2; i++) {
  PORTD.RD0  = 1;
 Delay_ms(50);
  PORTD.RD0  = 0;
 Delay_ms(100);
 }
}


void pitido_largo() {
 unsigned short i;
 for (i = 0; i < 3; i++) {
  PORTD.RD0  = 1;
 Delay_ms(150);
  PORTD.RD0  = 0;
 Delay_ms(150);
 }
}


void melodia_bienvenida() {
 reproducir_nota( 1915 , 180);
 reproducir_nota( 1519 , 180);
 reproducir_nota( 1275 , 180);
 reproducir_nota( 956 , 360);

 Delay_ms(120);

 reproducir_nota( 1275 , 150);
 reproducir_nota( 1432 , 150);
 reproducir_nota( 1519 , 150);
 reproducir_nota( 1700 , 150);
 reproducir_nota( 1915 , 300);

 Delay_ms(200);

 reproducir_nota( 1915 , 100);
 reproducir_nota( 1700 , 100);
 reproducir_nota( 1519 , 100);
 reproducir_nota( 1432 , 400);
}


void melodia_victoria() {
 reproducir_nota( 1275 , 200);
 reproducir_nota( 1136 , 200);
 reproducir_nota( 1014 , 200);
 reproducir_nota( 956 , 400);

 Delay_ms(150);

 reproducir_nota( 956 , 150);
 reproducir_nota( 1014 , 150);
 reproducir_nota( 1136 , 150);
 reproducir_nota( 1275 , 300);
}


void melodia_derrota() {
 reproducir_nota( 956 , 300);
 reproducir_nota( 1014 , 300);
 reproducir_nota( 1136 , 300);
 reproducir_nota( 1275 , 300);
 reproducir_nota( 1432 , 300);
 reproducir_nota( 1519 , 300);
 reproducir_nota( 1700 , 300);
 reproducir_nota( 1915 , 600);
}


void sonido_comida() {
 pitido_corto();
}


void sonido_fin_juego() {
 pitido_largo();
}


void main() {

  TRISD.TRISD0  = 0;
 TRISD.TRISD1 = 1;
 TRISD.TRISD2 = 1;

  PORTD.RD0  = 0;
 PORTD = 0x00;

 Delay_ms(500);


 melodia_bienvenida();

 Delay_ms(1000);

 while (1) {

 if ( PORTD.RD1  == 1) {
 sonido_comida();
 while ( PORTD.RD1  == 1);
 Delay_ms(50);
 }


 if ( PORTD.RD2  == 1) {
 sonido_fin_juego();
 while ( PORTD.RD2  == 1);
 Delay_ms(50);
 }

 Delay_ms(10);
 }
}
