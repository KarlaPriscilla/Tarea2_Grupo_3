#line 1 "C:/Desktop/Documentos-Karla/Semestre 9/SISTEMAS EMBEBIDOS/Tarea2/Tarea_2.c"
#line 22 "C:/Desktop/Documentos-Karla/Semestre 9/SISTEMAS EMBEBIDOS/Tarea2/Tarea_2.c"
void custom_delay_ms(unsigned int ms) {
 unsigned int i, j;
 for (i = 0; i < ms; i++) {
 for (j = 0; j < 1000; j++) {
 asm nop;
 }
 }
}

void custom_delay_us(unsigned int us) {
 unsigned int i;
 for (i = 0; i < us; i++) {
 asm nop;
 }
}


void beepPattern(unsigned short repeticiones, unsigned int onTime, unsigned int offTime) {
 unsigned short i;
 for (i = 0; i < repeticiones; i++) {
  PORTD.RD0  = 1;
 custom_delay_ms(onTime);

  PORTD.RD0  = 0;
 custom_delay_ms(offTime);
 }
}


void beepPattern_fixed(unsigned short repeticiones, unsigned char delay_type) {
 unsigned short i;
 for (i = 0; i < repeticiones; i++) {
  PORTD.RD0  = 1;
 switch(delay_type) {
 case 1: Delay_ms(50); break;
 case 2: Delay_ms(100); break;
 case 3: Delay_ms(150); break;
 default: Delay_ms(100); break;
 }
  PORTD.RD0  = 0;
 switch(delay_type) {
 case 1: Delay_ms(50); break;
 case 2: Delay_ms(100); break;
 case 3: Delay_ms(150); break;
 default: Delay_ms(100); break;
 }
 }
}


void playNote(unsigned int frequency_delay, unsigned short duration) {
 unsigned long cycles = (unsigned long)duration * 500UL / frequency_delay;
 unsigned long i;

 for (i = 0; i < cycles; i++) {
  PORTD.RD0  = 1;
 custom_delay_us(frequency_delay);
  PORTD.RD0  = 0;
 custom_delay_us(frequency_delay);
 }
}


void beep_short() {
 unsigned short i;
 for (i = 0; i < 2; i++) {
  PORTD.RD0  = 1;
 Delay_ms(50);
  PORTD.RD0  = 0;
 Delay_ms(100);
 }
}

void beep_long() {
 unsigned short i;
 for (i = 0; i < 3; i++) {
  PORTD.RD0  = 1;
 Delay_ms(150);
  PORTD.RD0  = 0;
 Delay_ms(150);
 }
}


void startup_melody() {

 playNote( 1014 , 200);
 playNote( 956 , 200);
 playNote( 1700 , 200);
 playNote( 1519 , 200);
 playNote( 1432 , 200);
 playNote( 1275 , 200);
 playNote( 1136 , 200);
 playNote( 1014 , 400);

 Delay_ms(100);


 playNote( 1136 , 150);
 playNote( 1275 , 150);
 playNote( 1432 , 150);
 playNote( 1519 , 150);
 playNote( 1700 , 150);
 playNote( 1915 , 300);

 Delay_ms(200);


 playNote( 1915 , 100);
 playNote( 1519 , 100);
 playNote( 1275 , 100);
 playNote( 956 , 400);
}


void retro_startup() {

 playNote( 1915 , 100);
 playNote( 1519 , 100);
 playNote( 1275 , 100);
 playNote( 956 , 200);

 Delay_ms(50);

 playNote( 1700 , 100);
 playNote( 1432 , 100);
 playNote( 1136 , 100);
 playNote( 1700 , 200);

 Delay_ms(100);


 playNote( 1275 , 150);
 playNote( 1136 , 150);
 playNote( 1014 , 150);
 playNote( 956 , 300);
 playNote( 1014 , 150);
 playNote( 1136 , 150);
 playNote( 1275 , 300);
}


void power_up_fanfare() {
 playNote( 1915 , 80);
 playNote( 1915 , 80);
 playNote( 1275 , 120);
 playNote( 1275 , 120);
 playNote( 1136 , 120);
 playNote( 1136 , 120);
 playNote( 1275 , 250);

 Delay_ms(100);

 playNote( 1432 , 120);
 playNote( 1432 , 120);
 playNote( 1519 , 120);
 playNote( 1519 , 120);
 playNote( 1700 , 120);
 playNote( 1700 , 120);
 playNote( 1915 , 250);
}


void waka_waka_sound() {
 beep_short();
}


void game_over_sound() {
 beep_long();
}


void victory_sound() {
 playNote( 1915 , 150);
 playNote( 1519 , 150);
 playNote( 1275 , 150);
 playNote( 956 , 300);
 playNote( 1275 , 150);
 playNote( 956 , 300);
}


void main() {





  TRISD.TRISD0  = 0;
 TRISD.TRISD1 = 1;
 TRISD.TRISD2 = 1;


  PORTD.RD0  = 0;


 PORTD = 0x00;





 Delay_ms(500);


 startup_melody();



 Delay_ms(1000);





 while (1) {

 if ( PORTD.RD1  == 1) {
 waka_waka_sound();
 while ( PORTD.RD1  == 1);
 Delay_ms(50);
 }


 if ( PORTD.RD2  == 1) {
 game_over_sound();
 while ( PORTD.RD2  == 1);
 Delay_ms(50);
 }


 Delay_ms(10);
 }
}
