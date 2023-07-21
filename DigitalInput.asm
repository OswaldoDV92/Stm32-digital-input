_config_clock:
;DigitalInput.c,1 :: 		void config_clock(){
;DigitalInput.c,2 :: 		while(HSERDY_bit == 0);//wait until clock is ready
L_config_clock0:
MOVW	R1, #lo_addr(HSERDY_bit+0)
MOVT	R1, #hi_addr(HSERDY_bit+0)
_LX	[R1, ByteOffset(HSERDY_bit+0)]
CMP	R0, #0
IT	NE
BNE	L_config_clock1
IT	AL
BAL	L_config_clock0
L_config_clock1:
;DigitalInput.c,3 :: 		}
L_end_config_clock:
BX	LR
; end of _config_clock
_config_gpio:
;DigitalInput.c,5 :: 		void config_gpio(){
;DigitalInput.c,6 :: 		IOPCEN_bit = 1;//enable clock for GPIOC
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(IOPCEN_bit+0)
MOVT	R0, #hi_addr(IOPCEN_bit+0)
_SX	[R0, ByteOffset(IOPCEN_bit+0)]
;DigitalInput.c,7 :: 		IOPBEN_bit = 1;//enable clock for GPIOB
MOVW	R0, #lo_addr(IOPBEN_bit+0)
MOVT	R0, #hi_addr(IOPBEN_bit+0)
_SX	[R0, ByteOffset(IOPBEN_bit+0)]
;DigitalInput.c,8 :: 		GPIOC_CRH = 0x00300000;//GPIO C13 as output
MOV	R1, #3145728
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;DigitalInput.c,9 :: 		GPIOB_CRH = 0x80000000;//GPIO B15 as input
MOV	R1, #-2147483648
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;DigitalInput.c,10 :: 		GPIOB_ODR = 0;//with pull down internal resistor
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;DigitalInput.c,12 :: 		}
L_end_config_gpio:
BX	LR
; end of _config_gpio
_main:
;DigitalInput.c,14 :: 		void main(){
;DigitalInput.c,16 :: 		config_clock();
BL	_config_clock+0
;DigitalInput.c,17 :: 		config_gpio();
BL	_config_gpio+0
;DigitalInput.c,19 :: 		while(1){
L_main2:
;DigitalInput.c,21 :: 		button = GPIOB_IDR & 0x00008000;
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32768
;DigitalInput.c,22 :: 		if(button == 0x00008000)
CMP	R0, #32768
IT	NE
BNE	L_main4
;DigitalInput.c,23 :: 		GPIOC_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_main5
L_main4:
;DigitalInput.c,25 :: 		GPIOC_ODR = 0x00002000;
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
L_main5:
;DigitalInput.c,26 :: 		}
IT	AL
BAL	L_main2
;DigitalInput.c,27 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
