/*********************************************************************
 *		TP Regularizador											 *
 * 																	 *
 * 		Materia: Electronica Digital II - 2017 (ECyT - UNSAM)		 *
 *																	 *
 * 		Autores: Wolovelsky, David	Archivo: Tp_regularizador.c		 *
 *				 Calcagno, Misael									 *
 *********************************************************************/

#include "Tp_regularizador.h"
#include "math.h"

//Variables globales

int cont0=0,cont1=0,cont2=0,cont3=0,cont4=0;
int j=0,i=0,k=0,l=0;

LED LED1;
LED LED2;
LED LED3;
LED LEDB;
LED LEDG;
LED LEDR;

unsigned int S0[points], S1[points], S2[points], S3[points];
unsigned int senial[points], buffer0[points], buffer1[points];
LLI_T LLI0, LLI1;
unsigned int DMA_CONTROL_MASK=0;
int pi = 3.14159654;

int *DMA_CONFIGG = (int *)(DMA_CONFIG_GRAL);
int *DMA_INTTCCLEARG = (int *)(DMA_INTTCCLEAR);

int *PTR_ENAIO2 =(int *)(ENAIO2);

void GPIO0_IRQHandler(){

	GPIO_pint->IST |= (1 << 0);			//clear de interrupcion
	
	if (cont0 == 0) {
		prende(LEDB.set, LEDB.pin);		//prendo el led
		for(i=0;i<points;i++){
			senial[i]=senial[i]+S0[i];
		}
		cont0++;							
	}else{
		apaga(LEDB.clr, LEDB.pin);		//apago el led
		for(i=0;i<points;i++){
			senial[i]=senial[i]-S0[i];
		}
		cont0=0;
	};	
};

void GPIO1_IRQHandler(){

	GPIO_pint->IST |= (1 << 1);			//clear de interrupcion
	
	if (cont1 == 0) {
		prende(LED1.set, LED1.pin);		//prendo el led	
		for(j=0;j<points;j++){
			senial[j]=senial[j]+S1[j];
		}
		cont1++;
	}else{
		apaga(LED1.clr, LED1.pin);		//apago el led
		for(j=0;j<points;j++){
			senial[j]=senial[j]-S1[j];
		}
		cont1=0;
	};	
};

void GPIO2_IRQHandler(){

	GPIO_pint->IST |= (1 << 2);			//clear de interrupcion
	
	if (cont2 == 0) {
		prende(LED2.set, LED2.pin);		//prendo el led	
		for(j=0;j<points;j++){
			senial[j]=senial[j]+S2[j];
		}
		cont2++;
	}else{
		apaga(LED2.clr, LED2.pin);		//apago el led
		for(j=0;j<points;j++){
			senial[j]=senial[j]-S2[j];
		}
		cont2=0;
	};	
};

void GPIO3_IRQHandler(){

	GPIO_pint->IST |= (1 << 3);			//clear de interrupcion
	
	if (cont3 == 0) {
		prende(LED3.set, LED3.pin);		//prendo el led	
		for(j=0;j<points;j++){
			senial[j]=senial[j]+S3[j];
		}	
		cont3++;		
	}else{
		apaga(LED3.clr, LED3.pin);		//apago el led
		for(j=0;j<points;j++){
			senial[j]=senial[j]-S3[j];
		}
		cont3=0;
	};	
};

void DMA_IRQHandler(){
	
	*DMA_INTTCCLEARG = 1;	// Clear de interrupciones DMA
	
	if(DMA0->LLI == ((unsigned int)&LLI0)){
		for(j=0;j<points;j++){
			buffer0[j]=senial[j];
		}
	}
	if(DMA0->LLI == ((unsigned int)&LLI1)){
		for(j=0;j<points;j++){
			buffer1[j]=senial[j];
		}
	}
}

int main(void) {

	/**Configuración LEDs**/
	
	
	LED1.conf=(int *)((SCU_BASE)+(SFSP2_10));
	LED1.dir=(int *)((GPIO_BASE)+(GPIO_PORT0_DIR_OFFSET));
	LED1.clr=(int *)((GPIO_BASE)+(GPIO_PORT0_CLR_OFFSET));
	LED1.set=(int *)((GPIO_BASE)+(GPIO_PORT0_SET_OFFSET));
	LED1.pin=14;
	
	LED2.conf=(int *)((SCU_BASE)+(SFSP2_11));
	LED2.dir=(int *)((GPIO_BASE)+(GPIO_PORT1_DIR_OFFSET));
	LED2.clr=(int *)((GPIO_BASE)+(GPIO_PORT1_CLR_OFFSET));
	LED2.set=(int *)((GPIO_BASE)+(GPIO_PORT1_SET_OFFSET));
	LED2.pin=11;
	
	LED3.conf=(int *)((SCU_BASE)+(SFSP2_12));
	LED3.dir=(int *)((GPIO_BASE)+(GPIO_PORT1_DIR_OFFSET));
	LED3.clr=(int *)((GPIO_BASE)+(GPIO_PORT1_CLR_OFFSET));
	LED3.set=(int *)((GPIO_BASE)+(GPIO_PORT1_SET_OFFSET));
	LED3.pin=12;
		
	LEDB.conf=(int *)((SCU_BASE)+(SFSP2_2));
	LEDB.dir=(int *)((GPIO_BASE)+(GPIO_PORT5_DIR_OFFSET));
	LEDB.clr=(int *)((GPIO_BASE)+(GPIO_PORT5_CLR_OFFSET));
	LEDB.set=(int *)((GPIO_BASE)+(GPIO_PORT5_SET_OFFSET));
	LEDB.pin = 2;
	
	LEDG.conf = (int *)((SCU_BASE)+(SFSP2_1));
	LEDG.dir = (int *)((GPIO_BASE)+(GPIO_PORT5_DIR_OFFSET));
	LEDG.clr = (int *)((GPIO_BASE)+(GPIO_PORT5_CLR_OFFSET));
	LEDG.set = (int *)((GPIO_BASE)+(GPIO_PORT5_SET_OFFSET));
	LEDG.pin = 1;
	
	LEDR.conf = (int *)((SCU_BASE)+(SFSP2_0));
	LEDR.dir = (int *)((GPIO_BASE)+(GPIO_PORT5_DIR_OFFSET));
	LEDR.clr = (int *)((GPIO_BASE)+(GPIO_PORT5_CLR_OFFSET));
	LEDR.set = (int *)((GPIO_BASE)+(GPIO_PORT5_SET_OFFSET));
	LEDR.pin = 0;

	*(LED1.conf)=(0x1 << 4) | (0x0);
	*(LED2.conf)=(0x1 << 4) | (0x0);
	*(LED3.conf)=(0x1 << 4) | (0x0);
	*(LEDB.conf)=(0x1 << 4) | (0x4);
	*(LEDG.conf)=(0x1 << 4) | (0x4);
	*(LEDR.conf)=(0x1 << 4) | (0x4);
	
	*(LED1.dir)	|=	(1 << LED1.pin);
	*(LED2.dir)	|=	(1 << LED2.pin);
	*(LED3.dir)	|=	(1 << LED3.pin);
	*(LEDB.dir)	|=	(1 << LEDB.pin);
	*(LEDG.dir)	|=	(1 << LEDG.pin);
	*(LEDR.dir)	|=	(1 << LEDR.pin);
	
	/**Configuración teclas**/
	
	TEC TEC1;
	TEC1.conf = (int *)((SCU_BASE)+(SFSP1_0));
	TEC1.dir = (int *)((GPIO_BASE)+(GPIO_PORT0_DIR_OFFSET));
	TEC1.clr = (int *)((GPIO_BASE)+(GPIO_PORT0_CLR_OFFSET));
	TEC1.set = (int *)((GPIO_BASE)+(GPIO_PORT0_SET_OFFSET));
	TEC1.pin = 4;
	TEC1.reg = (int *)((GPIO_BASE)+(GPIO0_4));
	
	TEC TEC2;
	TEC2.conf = (int *)((SCU_BASE)+(SFSP1_1));
	TEC2.dir = (int *)((GPIO_BASE)+(GPIO_PORT0_DIR_OFFSET));
	TEC2.clr = (int *)((GPIO_BASE)+(GPIO_PORT0_CLR_OFFSET));
	TEC2.set = (int *)((GPIO_BASE)+(GPIO_PORT0_SET_OFFSET));
	TEC2.pin = 8;
	TEC2.reg = (int *)((GPIO_BASE)+(GPIO0_8));
	
	TEC TEC3;
	TEC3.conf = (int *)((SCU_BASE)+(SFSP1_2));
	TEC3.dir = (int *)((GPIO_BASE)+(GPIO_PORT0_DIR_OFFSET));
	TEC3.clr = (int *)((GPIO_BASE)+(GPIO_PORT0_CLR_OFFSET));
	TEC3.set = (int *)((GPIO_BASE)+(GPIO_PORT0_SET_OFFSET));
	TEC3.pin = 9;
	TEC3.reg = (int *)((GPIO_BASE)+(GPIO0_9));
	
	TEC TEC4;
	TEC4.conf = (int *)((SCU_BASE)+(SFSP1_6));
	TEC4.dir = (int *)((GPIO_BASE)+(GPIO_PORT1_DIR_OFFSET));
	TEC4.clr = (int *)((GPIO_BASE)+(GPIO_PORT1_CLR_OFFSET));
	TEC4.set = (int *)((GPIO_BASE)+(GPIO_PORT1_SET_OFFSET));
	TEC4.pin = 9;
	TEC4.reg = (int *)((GPIO_BASE)+(GPIO1_9));
	
	
	*(TEC1.conf)=(0x1 << 4) | (0x1 << 6);
	*(TEC2.conf)=(0x1 << 4) | (0x1 << 6);
	*(TEC3.conf)=(0x1 << 4) | (0x1 << 6);
	*(TEC4.conf)=(0x1 << 4) | (0x1 << 6);
	
	/**Interrupciones**/
	
	NVIC_s NVIC;
	NVIC.ISER0=(int *)((NVIC_BASE)+(ISER0_B));
	NVIC.ISER1=(int *)((NVIC_BASE)+(ISER1_B));
	NVIC.ICER0=(int *)((NVIC_BASE)+(ICER0_B));
	NVIC.ICER1=(int *)((NVIC_BASE)+(ICER1_B));
	
	*(NVIC.ISER0) = (1 << 2);
	*(NVIC.ISER1) = (1 << 0)|	//PIN_INT0 GPIO pin interrupt 0
					(1 << 1)|	//PIN_INT1 GPIO pin interrupt 1
					(1 << 2)|	//PIN_INT2 GPIO pin interrupt 2
					(1 << 3);	//PIN_INT3 GPIO pin interrupt 3
					
	//Pin interrupt select register
	int *pint=(int *)(SCU_pint_BASE);
	*pint=	(0x4)|						//GPIO0_4
			(0x8 << 8)|					//GPIO0_8
			(0x9 << 16)|				//GPIO0_9
			(0x9 << 24)|
			(0x1 << 29);				//GPIO1_9
	
	//GPIO pin interupts
	
	GPIO_pint->ISEL=(0x0);
	GPIO_pint->IENF= (1 << 0)|	
					 (1 << 1)|	
					 (1 << 2)|	
					 (1 << 3);		
	GPIO_pint->SIENF=	(1 << 0)|	
						(1 << 1)|	
						(1 << 2)|	
						(1 << 3);	
	GPIO_pint->IENR=(0x0);
	GPIO_pint->SIENR=(0x0);
	
	/**Configuro el DAC**/

	DAC->CTRL = (0x0 << 0)|(0x1 << 1)|(0x1 << 2)|(0x1 << 3);
	DAC->CNTVAL = (819);
	*PTR_ENAIO2 = 1; 	

	/** DMA **/
	
	*DMA_CONFIGG = 1;	//Config. general
	
	DMA_CONTROL_MASK =	 	( 0x80 	<<  0 )		//TRANSFERSIZE
						|	( 0x00 	<< 12 )		//SBSIZE
						|	( 0x00 	<< 15 )		//DBSIZE
						|	( 0x02	<< 18 )		//SWIDTH
						|	( 0x02	<< 21 )		//DWIDTH
						|	( 0x00 	<< 24 )		//S	
						|	( 0x01 	<< 25 )		//D
						|	( 0x01 	<< 26 )		//SI
						|	( 0x00 	<< 27 )		//DI	
						|	( 0x00 	<< 28 )		//PROT1
						|	( 0x00 	<< 29 )		//PROT2
						|	( 0x00 	<< 30 )		//PROT3
						|	( 0x01 	<< 31 );	//I
	
	/** Señales **/
	
	//2KHz
	for (j=0; j<points; j++){	
	S0[j]=0;
	}	
	for(j=0;j<points;j++){
		S0[j] = 127+(127*sin(2*2*pi*j/254));
	}
	for(j=0;j<points;j++){
		S0[j] = (S0[j] << 6 ) | (1<<16);
	}
	
	//4KHz
	for (k=0; k<points; k++){	
	S1[k]=0;
	}
	for (k=0; k<points; k++){
		S1[k] = 127+(127*sin((4*2*pi*k)/254));
	}
	for (k=0; k<points; k++){
		S1[k] = (S1[k] << 6 ) | (1<<16);
	}
	
	//8KHz
	for (l=0; l<points; l++){	
	S2[l]=0;
	}
	for (l=0; l<points; l++){
		S2[l] = 127+(127*sin((8*2*pi*l)/254));
	}
	for (l=0; l<points; l++){
		S2[l] = (S2[l] << 6 ) | (1<<16);
	}
	
	//16KHz
	for (i=0; i<points; i++){	
	S3[i]=0;
	}
	for (i=0; i<points; i++){
		S3[i] = 127+(127*sin((16*2*pi*i)/254));
	}
	for (i=0; i<points; i++){
		S3[i] = (S3[i] << 6 ) | (1<<16);
	}
	
	/** LLI **/
	
	LLI0.source = (unsigned int) &buffer0[0];
	LLI0.destination = (unsigned int) &DAC->CR;
	LLI0.next = (unsigned int) &LLI1;
	LLI0.control = DMA_CONTROL_MASK;
	
	LLI1.source = (unsigned int) &buffer1[0];
	LLI1.destination = (unsigned int) &DAC->CR;
	LLI1.next = (unsigned int) &LLI0;
	LLI1.control = DMA_CONTROL_MASK;
	
	DMA0->SRCADDR	= (unsigned int) &buffer0[0];
	DMA0->DESTADDR	= (unsigned int) &DAC->CR;
	DMA0->LLI		= (unsigned int) &LLI1;
	DMA0->CNTRL		= (unsigned int) DMA_CONTROL_MASK;
	DMA0->CONFIG 	=	( 0x1 <<  0 )	// E Channel enable
				//  |	( 0x0 <<  1 )	// SRCPERIPHERAL (ignorado)
					|	( 0xF <<  6 )	// DESTPERIPHERAL DAC
					|	( 0x1 << 11 )	// FLOWCNTRL m2p (DMA control)
					|	( 0x0 << 14 )	// IE
					|	( 0x1 << 15 )	// ITC
					|	( 0x0 << 16 )	// L		
					|	( 0x0 << 18 );	// H enable DMA request

	while (1) {

	}

	return 0;
}




