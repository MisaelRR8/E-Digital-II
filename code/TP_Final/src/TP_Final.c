/**********************************************************************************************
 * Aplicacion de prueba para imprimir sobre una terminal
 *
 * Materia: Electronica Digital II - 2016 (UNSAM)
 *
 * Documentacion:
 *    - UM10503 (LPC43xx ARM Cortex-M4/M0 multi-core microcontroller User Manual)
 *    - PINES UTILIZADOS DEL NXP LPC4337 JBD144 (Ing. Eric Pernia)
 **********************************************************************************************/

#include "Prueba_printf.h"

static char aux[256];		// para debugging (usada por printf)

// Programa principal
int main(void){

	// Inicio de la UART para debugging
	UART_Init();

	sprintf_mio(aux,"\r\n--- Hola, mundo! ---\r\n");
	DEBUGSTR(aux);

	while (1) {

	}

	return 0;
}
