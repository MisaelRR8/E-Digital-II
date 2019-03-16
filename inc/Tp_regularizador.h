/*********************************************************************
 *		TP Regularizador											 *
 * 																	 *
 * 		Materia: Electronica Digital II - 2017 (ECyT - UNSAM)		 *
 *																	 *
 * 		Autores: Wolovelsky, David	Archivo: Tp_regularizador.h		 *
 *				 Calcagno, Misael									 *
 *********************************************************************/

/**SCU**/

#define SCU_BASE	0x40086000	// Direccion del System Control Unit

/**Numero de puntos**/

#define points 		512

/**LEDs**/

//LED 1
#define	SFSP2_10	0x128	// Offset del registro de configurcion del pin
//LED 2
#define	SFSP2_11	0x12C	// Offset del registro de configurcion del pin
//LED 3
#define	SFSP2_12	0x130	// Offset del registro de configurcion del pin
//LED RGB
#define	SFSP2_0		0x100	// Offset del registro de configurcion del pin
#define	SFSP2_1		0x104	// Offset del registro de configurcion del pin
#define	SFSP2_2		0x108	// Offset del registro de configurcion del pin

/**Teclas**/
#define SFSP1_0		0x080	//TEC_1
#define SFSP1_1		0x084	//TEC_2
#define SFSP1_2		0x088	//TEC_3
#define SFSP1_6		0x098	//TEC_4

#define GPIO0_4		0x004	//Register TEC_1
#define GPIO0_8		0x008	//Register TEC_2
#define GPIO0_9		0x009	//Register TEC_3
#define GPIO1_9		0x029	//Register TEC_4

/**GPIO**/

#define GPIO_BASE				0x400F4000	// Direccion del GPIO

#define	GPIO_PORT0_DIR_OFFSET	0x2000	// Offset del registro de direccion (DIR) del puerto 0
#define GPIO_PORT0_CLR_OFFSET	0x2280	// Offset del registro clear (CLR) del puerto 0
#define GPIO_PORT0_SET_OFFSET	0x2200	// Offset del registro set (SET) del puerto 0

#define	GPIO_PORT1_DIR_OFFSET	0x2004	// Offset del registro de direccion (DIR) del puerto 1
#define GPIO_PORT1_CLR_OFFSET	0x2284	// Offset del registro clear (CLR) del puerto 1
#define GPIO_PORT1_SET_OFFSET	0x2204	// Offset del registro set (SET) del puerto 1

#define	GPIO_PORT5_DIR_OFFSET	0x2014	// Offset del registro de direccion (DIR) del puerto 1
#define GPIO_PORT5_CLR_OFFSET	0x2294	// Offset del registro clear (CLR) del puerto 1
#define GPIO_PORT5_SET_OFFSET	0x2214	// Offset del registro set (SET) del puerto 1

#define GPIO_pint				((GPIO_pint_s *)GPIO_pint_BASE)

/**NVIC**/

#define NVIC_BASE		0xE000E000
#define ISER0_B			0x100
#define ISER1_B			0x104
#define ICER0_B			0x180
#define ICER1_B			0x184

/**DAC**/

#define DAC_BASE		0x400E1000
#define ENAIO2			0x40086C90		// habilitar la salida analogica
#define DAC				((DAC_s *)DAC_BASE)

/**DMA**/

#define DMA0			((DMA_s *)DMA_SRCADDR0)

#define DMA_SRCADDR0	0x40002100	// DMA Channel 0 Source Address Register

#define DMA_CONFIG_GRAL		0x40002030	// config general del DMA
#define DMA_INTSTAT_GRAL	0x40002000	// DMA Interrupt Status register
#define DMA_ENABLEDCHANELS	0x4000201C	// DMA canales habilitados

#define DMA_INTSTAT			0x40002000	// DMA Interrupt Status Register
#define DMA_INTTCCLEAR		0x40002008	// DMA Interrupt Terminal Count Request Clear Register

/** SCU pin interrupts **/

#define SCU_pint_BASE	0x40086E00

/** GPIO pin interrupts **/

#define GPIO_pint_BASE	0x40087000

/* LEDs */

typedef struct LED{
	int *conf;
	int *dir;
	int *clr;
	int *set;
	int pin;
}LED;

/* Tecla */

typedef struct tecla{
	int *conf;
	int *dir;
	int *clr;
	int *set;
	int pin;
	int *reg;
}TEC;

/* NVIC */

typedef struct NVIC{
	int *ISER0;
	int *ISER1;
	int *ICER0;
	int *ICER1;
}NVIC_s;

/* Interruptciones */
typedef struct{
	unsigned int ISEL;
	unsigned int IENR;
	unsigned int SIENR;
	unsigned int CIENR;
	unsigned int IENF;
	unsigned int SIENF;
	unsigned int CIENF;
	unsigned int RISE;
	unsigned int FALL;
	unsigned int IST;
}GPIO_pint_s;

/* DAC */

typedef struct{
	unsigned int CR;
	unsigned int CTRL;
	unsigned int CNTVAL;
}DAC_s;

/* DMA structure */

typedef struct{
	unsigned int SRCADDR;
	unsigned int DESTADDR;
	unsigned int LLI;
	unsigned int CNTRL;
	unsigned int CONFIG;
}DMA_s;

/* LLI */

typedef struct LLI_T {
 unsigned int  source;		
 unsigned int  destination; 
 unsigned int  next;        
 unsigned int  control;     
}LLI_T;

/* Funciones */

void apaga(int *ptr, int pinL);
void prende(int *ptr, int pinL);
void GPIO0_IRQHandler();
void GPIO1_IRQHandler();
void GPIO2_IRQHandler();
void GPIO3_IRQHandler();
void DMA_IRQHandler();