void config_clock(){
  while(HSERDY_bit == 0);//wait until clock is ready
}

void config_gpio(){
  IOPCEN_bit = 1;//enable clock for GPIOC
  IOPBEN_bit = 1;//enable clock for GPIOB
  GPIOC_CRH = 0x00300000;//GPIO C13 as output
  GPIOB_CRH = 0x80000000;//GPIO B15 as input
  GPIOB_ODR = 0;//with pull down internal resistor
  //GPIOB_ODR = 0x00008000;//with pull up internal resistor
}

void main(){
  long button;
  config_clock();
  config_gpio();

  while(1){
    //Read the state of a push button on GPIO B15
    button = GPIOB_IDR & 0x00008000;
    if(button == 0x00008000)//Display it in GPIO C13
      GPIOC_ODR = 0;
    else
      GPIOC_ODR = 0x00002000;
  }
}