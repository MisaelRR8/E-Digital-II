/*********************************************************************
 *		TP Regularizador											 *
 * 																	 *
 * 		Materia: Electronica Digital II - 2017 (ECyT - UNSAM)		 *
 *																	 *
 * 		Autores: Wolovelsky, David	Archivo: Funciones.c			 *
 *				 Calcagno, Misael									 *
 *********************************************************************/
#include "Tp_regularizador.h"


void apaga(int *ptr, int pinL){
	
	*ptr |= (1 << pinL);
};

void prende(int *ptr, int pinL){
	
	*ptr |= (1 << pinL);
};

