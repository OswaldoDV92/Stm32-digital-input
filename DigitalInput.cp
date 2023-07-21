#line 1 "C:/Users/amara/Documents/stm32/Mikro c/DigitalInput/DigitalInput.c"
void config_clock(){
 while(HSERDY_bit == 0);
}

void config_gpio(){
 IOPCEN_bit = 1;
 IOPBEN_bit = 1;
 GPIOC_CRH = 0x00300000;
 GPIOB_CRH = 0x80000000;
 GPIOB_ODR = 0;

}

void main(){
 long button;
 config_clock();
 config_gpio();

 while(1){

 button = GPIOB_IDR & 0x00008000;
 if(button == 0x00008000)
 GPIOC_ODR = 0;
 else
 GPIOC_ODR = 0x00002000;
 }
}
