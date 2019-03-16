;*********************************************************************
;*		TP Regularizador											 *
;* 																	 *
;* 		Materia: Electronica Digital II - 2017 (ECyT - UNSAM)		 *
;*																	 *
;* 		Autores: Wolovelsky, David	Archivo: Tp_regularizador.s		 *
;*				 Calcagno, Misael									 *
;*********************************************************************/
	.cpu cortex-m4
	.eabi_attribute 27, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"Tp_regularizador.c"
	.section	.text.GPIO0_IRQHandler,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	GPIO0_IRQHandler
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	GPIO0_IRQHandler, %function
GPIO0_IRQHandler:									; Declaración de la función (#36)
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L10									; Carga del registro GPIO_pint_BASE
	ldr	r2, .L10+4									; Carga LEDB
	push	{r3, r4, r5, lr}						;
	ldr	r3, [r1, #36]								; Carga GPIO_pint->IST
	ldr	r4, .L10+8									; Carga LANCHOR0 (cont0)
	orr	r3, r3, #1									; Or igual (#38)
	str	r3, [r1, #36]								; 
	ldr	r3, [r4]									; Carga LANCHOR0 (cont0)
	ldr	r1, [r2, #16]								; Carga LEDB.pin
	cbnz	r3, .L2									; If (#40), si es igual a 0 sigue, si no salta a .L2
	ldr	r0, [r2, #12]								; Carga LEDB.set
	bl	prende										; Llamado a la función prende (#41)
	ldr	r3, .L10+12									; carga la señal senial[] en r3
	ldr	r1, .L10+16									; carga la señal S0[] en r1
	add	r5, r3, #2048								; r5 va al último valor de senial
.L3:												; for (#42)
	ldr	r2, [r3, #4]!								; 
	ldr	r0, [r1, #4]!								; carga la señal senial[] en r0
	cmp	r5, r3										; condición del for (#42)
	add	r2, r2, r0									; suma (#43)
	str	r2, [r3]									;
	bne	.L3											; si no es igual vuelve a arrancar el for
	ldr	r3, [r4]									; carga cont0 en r3
	ldr	r2, .L10+20									; carga LANCHOR1 en r2
	adds	r3, r3, #1								; se incrementa el cont1 (#45)
	mov	r1, #512									
	str	r3, [r4]									; Guarda cont0
	str	r1, [r2]									; Guarda el contador j
	pop	{r3, r4, r5, pc}							; termina la función GPIO0_IRQHandler salteando el else
.L2:												; else (#46)
	ldr	r0, [r2, #8]								; carga LEDB.clr
	bl	apaga										; llama a la función apaga (#47)
	ldr	r3, .L10+12									; carga la señal senial[] en r3
	ldr	r1, .L10+16									; carga la señal S0[] en r1
	add	r5, r3, #2048								; r5 va al último valor de senial		
.L5:												; for (#48)
	ldr	r2, [r3, #4]!								;
	ldr	r0, [r1, #4]!								; carga la señal senial[] en r0
	cmp	r3, r5										; condición del for (#48)
	sub	r2, r2, r0									; resta (#49)
	str	r2, [r3]									;
	bne	.L5											; si no es igual vuelve a arrancar el for
	ldr	r2, .L10+20									; carga LANCHOR1 en r2
	mov	r1, #512
	movs	r3, #0									; vuelve a 0 a cont1 (#51)
	str	r1, [r2]
	str	r3, [r4]
	pop	{r3, r4, r5, pc}							; termina la función GPIO0_IRQHandler
.L11:
	.align	2
.L10:
	.word	1074294784								; GPIO_pint_BASE
	.word	LEDB
	.word	.LANCHOR0
	.word	senial-4
	.word	S0-4
	.word	.LANCHOR1
	.size	GPIO0_IRQHandler, .-GPIO0_IRQHandler
	.section	.text.GPIO1_IRQHandler,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	GPIO1_IRQHandler
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	GPIO1_IRQHandler, %function
GPIO1_IRQHandler:									; Idéntico a lo descripto para GPIO0_IRQHandler
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L20
	ldr	r2, .L20+4
	push	{r3, r4, r5, lr}
	ldr	r3, [r1, #36]
	ldr	r4, .L20+8
	orr	r3, r3, #2
	str	r3, [r1, #36]
	ldr	r3, [r4]
	ldr	r1, [r2, #16]
	cbnz	r3, .L13
	ldr	r0, [r2, #12]
	bl	prende
	ldr	r3, .L20+12
	ldr	r1, .L20+16
	add	r5, r3, #2048
.L14:
	ldr	r2, [r3, #4]!
	ldr	r0, [r1, #4]!
	cmp	r5, r3
	add	r2, r2, r0
	str	r2, [r3]
	bne	.L14
	ldr	r3, [r4]
	ldr	r2, .L20+20
	adds	r3, r3, #1
	mov	r1, #512
	str	r3, [r4]
	str	r1, [r2]
	pop	{r3, r4, r5, pc}
.L13:
	ldr	r0, [r2, #8]
	bl	apaga
	ldr	r3, .L20+12
	ldr	r1, .L20+16
	add	r5, r3, #2048
.L16:
	ldr	r2, [r3, #4]!
	ldr	r0, [r1, #4]!
	cmp	r3, r5
	sub	r2, r2, r0
	str	r2, [r3]
	bne	.L16
	ldr	r2, .L20+20
	mov	r1, #512
	movs	r3, #0
	str	r1, [r2]
	str	r3, [r4]
	pop	{r3, r4, r5, pc}
.L21:
	.align	2
.L20:
	.word	1074294784
	.word	LED1
	.word	.LANCHOR2
	.word	senial-4
	.word	S1-4
	.word	.LANCHOR3
	.size	GPIO1_IRQHandler, .-GPIO1_IRQHandler
	.section	.text.GPIO2_IRQHandler,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	GPIO2_IRQHandler
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	GPIO2_IRQHandler, %function
GPIO2_IRQHandler:									; Idéntico a lo descripto para GPIO0_IRQHandler
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L30
	ldr	r2, .L30+4
	push	{r3, r4, r5, lr}
	ldr	r3, [r1, #36]
	ldr	r4, .L30+8
	orr	r3, r3, #4
	str	r3, [r1, #36]
	ldr	r3, [r4]
	ldr	r1, [r2, #16]
	cbnz	r3, .L23
	ldr	r0, [r2, #12]
	bl	prende
	ldr	r3, .L30+12
	ldr	r1, .L30+16
	add	r5, r3, #2048
.L24:
	ldr	r2, [r3, #4]!
	ldr	r0, [r1, #4]!
	cmp	r5, r3
	add	r2, r2, r0
	str	r2, [r3]
	bne	.L24
	ldr	r3, [r4]
	ldr	r2, .L30+20
	adds	r3, r3, #1
	mov	r1, #512
	str	r3, [r4]
	str	r1, [r2]
	pop	{r3, r4, r5, pc}
.L23:
	ldr	r0, [r2, #8]
	bl	apaga
	ldr	r3, .L30+12
	ldr	r1, .L30+16
	add	r5, r3, #2048
.L26:
	ldr	r2, [r3, #4]!
	ldr	r0, [r1, #4]!
	cmp	r3, r5
	sub	r2, r2, r0
	str	r2, [r3]
	bne	.L26
	ldr	r2, .L30+20
	mov	r1, #512
	movs	r3, #0
	str	r1, [r2]
	str	r3, [r4]
	pop	{r3, r4, r5, pc}
.L31:
	.align	2
.L30:
	.word	1074294784
	.word	LED2
	.word	.LANCHOR4
	.word	senial-4
	.word	S2-4
	.word	.LANCHOR3
	.size	GPIO2_IRQHandler, .-GPIO2_IRQHandler
	.section	.text.GPIO3_IRQHandler,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	GPIO3_IRQHandler
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	GPIO3_IRQHandler, %function
GPIO3_IRQHandler:									; Idéntico a lo descripto para GPIO0_IRQHandler
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L40
	ldr	r2, .L40+4
	push	{r3, r4, r5, lr}
	ldr	r3, [r1, #36]
	ldr	r4, .L40+8
	orr	r3, r3, #8
	str	r3, [r1, #36]
	ldr	r3, [r4]
	ldr	r1, [r2, #16]
	cbnz	r3, .L33
	ldr	r0, [r2, #12]
	bl	prende
	ldr	r3, .L40+12
	ldr	r1, .L40+16
	add	r5, r3, #2048
.L34:
	ldr	r2, [r3, #4]!
	ldr	r0, [r1, #4]!
	cmp	r5, r3
	add	r2, r2, r0
	str	r2, [r3]
	bne	.L34
	ldr	r3, [r4]
	ldr	r2, .L40+20
	adds	r3, r3, #1
	mov	r1, #512
	str	r3, [r4]
	str	r1, [r2]
	pop	{r3, r4, r5, pc}
.L33:
	ldr	r0, [r2, #8]
	bl	apaga
	ldr	r3, .L40+12
	ldr	r1, .L40+16
	add	r5, r3, #2048
.L36:
	ldr	r2, [r3, #4]!
	ldr	r0, [r1, #4]!
	cmp	r3, r5
	sub	r2, r2, r0
	str	r2, [r3]
	bne	.L36
	ldr	r2, .L40+20
	mov	r1, #512
	movs	r3, #0
	str	r1, [r2]
	str	r3, [r4]
	pop	{r3, r4, r5, pc}
.L41:
	.align	2
.L40:
	.word	1074294784
	.word	LED3
	.word	.LANCHOR5
	.word	senial-4
	.word	S3-4
	.word	.LANCHOR3
	.size	GPIO3_IRQHandler, .-GPIO3_IRQHandler
	.section	.text.DMA_IRQHandler,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DMA_IRQHandler
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	DMA_IRQHandler, %function
DMA_IRQHandler:										; Declaración de la función (#112)
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L51									; r2=LANCHOR6
	ldr	r3, .L51+4									; Carga del registro DMA_SRCADDR0
	ldr	r1, [r2]									; r1=r2=LANCHOR6
	ldr	r2, .L51+8									; Carga de LLI0
	movs	r0, #1									; r0=1 
	str	r0, [r1]									; clear de interrupción (#114)
	ldr	r3, [r3, #8]								; Carga de LLI1								
	cmp	r3, r2										; If que compara DMA0->LL1 con &LLI0 (#116) 
	beq	.L49										; Si es distinto sigue
.L43:
	ldr	r2, .L51+12									; Carga LLI1
	cmp	r3, r2										; Compara r3 con LLI
	beq	.L50										; Si es igual salta a .L50, si no sale
.L42:
	bx	lr											; sale de la función
.L50:
	ldr	r3, .L51+16									; Carga de senial[]
	ldr	r2, .L51+20									; Carga de buffer1[]
	add	r0, r3, #2048								;
.L46:												; for (#122)
	ldr	r1, [r3, #4]!								; Carga de LLI1
	str	r1, [r2, #4]!								; Carga buffer1[] en senial[] (#123)
	cmp	r3, r0										; Condición del for (#122)
	bne	.L46										; si no es igual vuelve a arrancar el for
	ldr	r3, .L51+24									; carga LANCHOR3 (contador j)
	mov	r2, #512									; 
	str	r2, [r3]									;
	b	.L42										; Sale de la función
.L49:
	ldr	r3, .L51+16									; Carga de senial[]
	ldr	r2, .L51+28									; Carga de buffer0[]
	add	r0, r3, #2048								;							
.L44:												; for (#117)
	ldr	r1, [r3, #4]!								; 
	str	r1, [r2, #4]!								; Carga buffer0[] en senial[] (#118)
	cmp	r3, r0										; Condición del for (#117)
	bne	.L44										; si no es igual vuelve a arrancar el for
	ldr	r2, .L51+24									; Carga LANCHOR3 (contador j)
	ldr	r3, .L51+4									; Carga de DMA_SRCADDR0
	mov	r1, #512
	str	r1, [r2]
	ldr	r3, [r3, #8]								; Carga DMA->LLI en r3
	b	.L43										; Sale de la función
.L52:
	.align	2
.L51:
	.word	.LANCHOR6
	.word	1073750272								; DMA_SRCADDR0
	.word	LLI0
	.word	LLI1
	.word	senial-4
	.word	buffer1-4
	.word	.LANCHOR3
	.word	buffer0-4
	.size	DMA_IRQHandler, .-DMA_IRQHandler
	.global	__aeabi_dmul
	.global	__aeabi_dadd
	.global	__aeabi_d2uiz
	.global	__aeabi_i2d
	.section	.text.startup.main,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	r0, .L88+8									; carga LEDG
	ldr	r7, .L88+12									; carga SCU_BASE+SFSP2_1
	ldr	r1, .L88+16									; carga LEDR
	ldr	r8, .L88+108								; carga LED1
	ldr	r9, .L88+112								; carga GPIO_BASE+GPIO_PORT0_CLR_OFFSET 
	ldr	r2, .L88+20									; carga GPIO_BASE+GPIO_PORT0_SET_OFFSET
	ldr	r5, .L88+24									; carga LED2
	ldr	r3, .L88+28									; carga LED3
	ldr	r4, .L88+32									; carga LEDB
	str	r7, [r0]									; (#157)
	ldr	fp, .L88+116								; carga SCU_BASE+SFSP2_10
	ldr	lr, .L88+120								; carga SCU_BASE+SFSP2_11
	ldr	r10, .L88+124								; carga SCU_BASE+SFSP2_12
	ldr	ip, .L88+128								; carga SCU_BASE+SFSP2_2
	str	fp, [r8]									; (#133)
	subs	r7, r7, #4								; carga SCU_BASE+SFSP2_0
	strd	r9, r2, [r8, #8]						; carga SCU_BASE+SFSP2_10
	str	r7, [r1]									; (#163)
	mov	r9, #16										; 
	ldr	r7, .L88+36									; carga GPIO_BASE+GPIO_PORT0_DIR_OFFSET
	str	lr, [r5]									; (#139)
	str	r10, [r3]									; (#145)
	str	r7, [r8, #4]								; (#134)
	str	ip, [r4]									; (#151)
	str	r9, [fp]									; (#169)
	str	r9, [lr]									; (#170)
	mov	lr, #11										
	str	lr, [r5, #16]								; (#143)
	mov	lr, #12										 
	str	lr, [r3, #16]								; (#149)
	mov	lr, #2										
	str	lr, [r4, #16]								; (#155)
	mov	lr, #14										
	str	lr, [r8, #16]								; (#137)
	ldr	r8, .L88+132								; carga GPIO_BASE+GPIO_PORT1_CLR_OFFSET
	ldr	r6, .L88+40									; carga GPIO_BASE+GPIO_PORT1_DIR_OFFSET
	str	r8, [r5, #8]								; (#141)
	str	r8, [r3, #8]								; (#147)
	add	fp, fp, #458752								; 0x400F6128
	sub	r8, r8, #128								; 0x400F6204 GPIO_BASE+GPIO_PORT1_SET_OFFSET
	sub	r2, r2, #492								; 0x400F6014 GPIO_BASE+GPIO_PORT5_DIR_OFFSET
	add	fp, fp, #364								; 0x400F6294 GPIO_BASE+GPIO_PORT5_CLR_OFFSET
	str	r6, [r5, #4]								; (#140)
	str	r6, [r3, #4]								; (#146)
	str	r8, [r5, #12]								; (#142)
	str	r8, [r3, #12]								; (#148)
	ldr	r5, .L88+44									; carga GPIO_BASE+GPIO_PORT5_SET_OFFSET
	str	r2, [r4, #4]								; (#152)
	mov	r8, #1
	movs	r3, #0
	str	r2, [r0, #4]								; (#158)
	str	r2, [r1, #4]								; (#164)
	str	fp, [r4, #8]								; (#153)
	str	fp, [r0, #8]								; (#159)
	str	fp, [r1, #8]								; (#165)
	str	r5, [r4, #12]								; (#154)
	str	r5, [r0, #12]								; (#160)
	str	r5, [r1, #12]								; (#166)
	str	r8, [r0, #16]								; (#161)
	str	r3, [r1, #16]								; (#167)
	str	r9, [r10]									; (#171)
	ldr	r4, [r7]									; carga GPIO_BASE+GPIO_PORT0_DIR_OFFSET
	ldr	r9, .L88+104								; carga DAC_BASE
	ldr	r0, [r6]									; carga GPIO_BASE+GPIO_PORT1_DIR_OFFSET
	ldr	r1, [r2]									; carga GPIO_BASE+GPIO_PORT0_SET_OFFSET
	str	lr, [r9, #4]								; (#261)
	sub	r7, r7, #456704								; 
	subw	r7, r7, #1788							; 0x40086104 SCU_BASE+SFSP2_1
	mov	lr, #20										
	str	lr, [ip]									; (#172)
	str	lr, [r7]									; (#173)
	str	lr, [r7, #-4]								; (#174)
	ldr	r7, .L88+36									; carga GPIO_BASE+GPIO_PORT0_DIR_OFFSET 
	ldr	r5, .L88+48									; carga GPIO_pint_BASE
	ldr	r10, .L88+136								; carga NVIC_BASE+ISER1_B
	ldr	lr, .L88+140								; carga SCU_BASE+SFSP1_2
	orr	r4, r4, #16384								; (#176) 
	orr	r0, r0, #6144								; (#177) & (#178)
	str	r4, [r7]									; 
	orr	r1, r1, #7									; (#179) & (#180) & (#181)
	str	r0, [r6]
	movw	r6, #819
	str	r1, [r2]
	movs	r0, #15
	str	r6, [r9, #8]								; (#262)
	sub	fp, fp, #458752								; 0x40086294
	strd	r3, r3, [r5]							; (#247)
	strd	r0, r0, [r5, #16]						; (#248)
	str	r3, [r5, #8]								; (#257)
	ldr	r4, .L88+52									; carga SCU_pint_BASE
	str	r0, [r10]									; (#232)
	ldr	r5, .L88+56									; carga LANCHOR8
	ldr	r0, .L88+60									; carga SCU_BASE+SFSP1_6
	ldr	r7, .L88+64									; carga NVIC_BASE+ISER0_B
	ldr	r6, .L88+68									; carga LANCHOR7
	ldr	r9, .L88+144								; carga 0x29090804
	sub	fp, fp, #528								; 0x40086084 SCU_BASE+SFSP1_1
	movs	r2, #80									 
	movs	r1, #4
	str	r2, [ip, #-136]								; (#218)
	str	r2, [fp]									; (#219)
	str	r2, [lr]									; (#220)
	str	r2, [r0]									; (#221)
	str	r1, [r7]									; (#231)
	ldr	r0, [r5]									; carga LANCHOR8
	str	r9, [r4]									; (#239)
	ldr	r5, .L88+72									; carga S0
	ldr	r4, [r6]									; carga LANCHOR7
	ldr	r2, .L88+76									; carga LANCHOR9
	ldr	r1, .L88+80									; carga 0x86480080
	str	r8, [r4]									; 1 a LANCHOR7
	str	r8, [r0]									; 1 a LANCHOR8
	add	r0, r5, #2048								; Va al último elemento de S0
	str	r1, [r2]									; 
	mov	r8, r5										; r8 apunta a la primera posición									
.L54:												; for (#288)
	str	r3, [r8, #4]!								; inicializa todos los valores en 0
	cmp	r8, r0										; condición del for (#288)
	bne	.L54
	ldr	r3, .L88+84									; carga LANCHOR10
	ldr	r7, .L88+72									; carga S0
	ldr	r4, [r3]									; carga LANCHOR10
	lsl	r9, r4, #2									;
	movs	r0, #0
	movs	r1, #0
	adr	fp, .L88
	ldrd	r10, [fp]
	mov	r6, r9
	b	.L56
.L84:												; for (#291)
	bl	__aeabi_i2d
	add	r6, r6, r9									; suma (#292)
	bl	sin
.L56:
	mov	r2, r10
	mov	r3, fp
	bl	__aeabi_dmul
	mov	r2, r10
	mov	r3, fp
	bl	__aeabi_dadd
	bl	__aeabi_d2uiz
	ldr	r3, .L88+88
	str	r0, [r7, #4]!
	smull	r2, r3, r3, r6
	add	r3, r3, r6
	asrs	r0, r6, #31
	cmp	r7, r8										; condición del for (#291)
	rsb	r0, r0, r3, asr #7
	bne	.L84
.L55:												; for (#294)
	ldr	r3, [r5, #4]!
	lsls	r3, r3, #6								; (S0[j] << 6) 	(#295)
	orr	r3, r3, #65536								; or (1<<16) 	(#295)
	cmp	r7, r5										; condición del for (#294)
	str	r3, [r5]
	bne	.L55
	ldr	r5, .L88+92
	movs	r2, #0
	add	r3, r5, #2048
	mov	r8, r5
.L57:												; for (#299)
	str	r2, [r8, #4]!								; inicializa todos los valores en 0
	cmp	r3, r8										; condición del for (#299)
	bne	.L57
	lsl	r9, r4, #3
	movs	r0, #0
	movs	r1, #0
	adr	fp, .L88
	ldrd	r10, [fp]
	ldr	r7, .L88+92
	mov	r6, r9
	b	.L59
.L85:												; for (#302)
	bl	__aeabi_i2d
	add	r6, r6, r9									; suma (#303)
	bl	sin
.L59:
	mov	r2, r10
	mov	r3, fp
	bl	__aeabi_dmul
	mov	r2, r10
	mov	r3, fp
	bl	__aeabi_dadd
	bl	__aeabi_d2uiz
	ldr	r3, .L88+88
	str	r0, [r7, #4]!
	smull	r2, r3, r3, r6
	add	r3, r3, r6
	asrs	r0, r6, #31
	cmp	r8, r7										; condición del for (#302)
	rsb	r0, r0, r3, asr #7
	bne	.L85
.L58:												; for (#305)
	ldr	r3, [r5, #4]!
	lsls	r3, r3, #6
	orr	r3, r3, #65536
	cmp	r7, r5
	str	r3, [r5]
	bne	.L58
	ldr	r5, .L88+96
	movs	r2, #0
	add	r3, r5, #2048
	mov	r8, r5
.L60:												; for (#310)
	str	r2, [r8, #4]!								; inicializa todos los valores en 0
	cmp	r3, r8
	bne	.L60
	lsl	r9, r4, #4
	movs	r0, #0
	movs	r1, #0
	adr	fp, .L88
	ldrd	r10, [fp]
	ldr	r7, .L88+96
	mov	r6, r9
	b	.L62
.L86:												; for (#313)
	bl	__aeabi_i2d
	add	r6, r6, r9									; suma (#314)
	bl	sin
.L62:
	mov	r2, r10
	mov	r3, fp
	bl	__aeabi_dmul
	mov	r2, r10
	mov	r3, fp
	bl	__aeabi_dadd
	bl	__aeabi_d2uiz
	ldr	r3, .L88+88
	str	r0, [r7, #4]!
	smull	r2, r3, r3, r6
	add	r3, r3, r6
	asrs	r0, r6, #31
	cmp	r7, r8
	rsb	r0, r0, r3, asr #7
	bne	.L86
.L61:												; for (#316)
	ldr	r3, [r5, #4]!
	lsls	r3, r3, #6
	orr	r3, r3, #65536
	cmp	r7, r5
	str	r3, [r5]
	bne	.L61
	ldr	r5, .L88+100
	movs	r2, #0
	add	r3, r5, #2048
	mov	r9, r5
.L63:												; for (#321)
	str	r2, [r9, #4]!								; inicializa todos los valores en 0
	cmp	r3, r9
	bne	.L63
	lsl	r10, r4, #5
	movs	r0, #0
	movs	r1, #0
	adr	r7, .L88
	ldrd	r6, [r7]
	ldr	r4, .L88+100
	ldr	fp, .L88+88
	mov	r8, r10
	b	.L65
.L89:
	.align	3
.L88:
	.word	0
	.word	1080016896								; 0x405FC000
	.word	LEDG
	.word	1074290948								; SCU_BASE+SFSP2_1
	.word	LEDR
	.word	1074749952								; GPIO_BASE+GPIO_PORT0_SET_OFFSET
	.word	LED2
	.word	LED3
	.word	LEDB
	.word	1074749440								; GPIO_BASE+GPIO_PORT0_DIR_OFFSET
	.word	1074749444								; GPIO_BASE+GPIO_PORT1_DIR_OFFSET
	.word	1074749972								; GPIO_BASE+GPIO_PORT5_SET_OFFSET
	.word	1074294784								; GPIO_pint_BASE
	.word	1074294272								; SCU_pint_BASE
	.word	.LANCHOR8
	.word	1074290840								; SCU_BASE+SFSP1_6
	.word	-536813312								; NVIC_BASE+ISER0_B
	.word	.LANCHOR7
	.word	S0-4
	.word	.LANCHOR9
	.word	-2042101632								; 0x86480080
	.word	.LANCHOR10
	.word	-2130574327								; 0x81020409
	.word	S1-4
	.word	S2-4
	.word	S3-4
	.word	1074663424								; DAC_BASE
	.word	LED1
	.word	1074750080								; GPIO_BASE+GPIO_PORT0_CLR_OFFSET
	.word	1074290984								; SCU_BASE+SFSP2_10
	.word	1074290988								; SCU_BASE+SFSP2_11
	.word	1074290992								; SCU_BASE+SFSP2_12
	.word	1074290952								; SCU_BASE+SFSP2_2
	.word	1074750084								; GPIO_BASE+GPIO_PORT1_CLR_OFFSET
	.word	-536813308								; NVIC_BASE+ISER1_B
	.word	1074290824								; SCU_BASE+SFSP1_2
	.word	688457732								; 0x29090804
	
.L87:												; for (#324)
	bl	__aeabi_i2d
	add	r8, r8, r10									; suma (#325)
	bl	sin
.L65:
	mov	r2, r6
	mov	r3, r7
	bl	__aeabi_dmul
	mov	r2, r6
	mov	r3, r7
	bl	__aeabi_dadd
	bl	__aeabi_d2uiz
	str	r0, [r4, #4]!
	smull	r2, r3, fp, r8
	add	r3, r3, r8
	asr	r0, r8, #31
	cmp	r9, r4
	rsb	r0, r0, r3, asr #7
	bne	.L87
.L64:												; for (#327)
	ldr	r3, [r5, #4]!
	lsls	r3, r3, #6
	orr	r3, r3, #65536
	cmp	r5, r4
	str	r3, [r5]
	bne	.L64
	ldr	r3, .L90									; carga LLI1
	ldr	r1, .L90+4									; carga LLI0
	ldr	r2, .L90+8									; carga DMA_SRCADDR0
	ldr	r0, .L90+12									; carga buffer0
	ldr	r5, .L90+16									; carga buffer1
	str	r0, [r1]									; (#333)
	str	r5, [r3]									; (#338)
	str	r3, [r1, #8]								; (#335)
	str	r1, [r3, #8]								; (#340)
	ldr	r4, .L90+20									; carga DAC_BASE
	str	r0, [r2]									; (#343)
	movw	r5, #35777								; 
	ldr	r0, .L90+24									; carga 0x86480080
	str	r3, [r2, #8]								; (#345)
	str	r5, [r2, #16]								; (#347)
	str	r4, [r1, #4]								; (#334)
	str	r4, [r3, #4]								; (#339)
	str	r4, [r2, #4]								; (#344)
	str	r0, [r1, #12]								; (#336)
	str	r0, [r3, #12]								; (#341)
	str	r0, [r2, #12]								; (#346)
.L66:												; while (#356)
	b	.L66
.L91:
	.align	2
.L90:
	.word	LLI1
	.word	LLI0
	.word	1073750272								; DMA_SRCADDR0
	.word	buffer0
	.word	buffer1
	.word	1074663424								; DAC_BASE
	.word	-2042101632								; 0x86480080
	.size	main, .-main
	.global	PTR_ENAIO2
	.global	DMA_INTTCCLEARG
	.global	DMA_CONFIGG
	.global	pi
	.global	DMA_CONTROL_MASK
	.comm	LLI1,16,4
	.comm	LLI0,16,4
	.comm	buffer1,2048,4
	.comm	buffer0,2048,4
	.comm	senial,2048,4
	.comm	S3,2048,4
	.comm	S2,2048,4
	.comm	S1,2048,4
	.comm	S0,2048,4
	.comm	LEDR,20,4
	.comm	LEDG,20,4
	.comm	LEDB,20,4
	.comm	LED3,20,4
	.comm	LED2,20,4
	.comm	LED1,20,4
	.global	l
	.global	k
	.global	i
	.global	j
	.global	cont4
	.global	cont3
	.global	cont2
	.global	cont1
	.global	cont0
	.section	.bss.DMA_CONTROL_MASK,"aw",%nobits
	.align	2
	.set	.LANCHOR9,. + 0
	.type	DMA_CONTROL_MASK, %object
	.size	DMA_CONTROL_MASK, 4
DMA_CONTROL_MASK:
	.space	4
	.section	.bss.cont0,"aw",%nobits
	.align	2
	.set	.LANCHOR0,. + 0
	.type	cont0, %object
	.size	cont0, 4
cont0:
	.space	4
	.section	.bss.cont1,"aw",%nobits
	.align	2
	.set	.LANCHOR2,. + 0
	.type	cont1, %object
	.size	cont1, 4
cont1:
	.space	4
	.section	.bss.cont2,"aw",%nobits
	.align	2
	.set	.LANCHOR4,. + 0
	.type	cont2, %object
	.size	cont2, 4
cont2:
	.space	4
	.section	.bss.cont3,"aw",%nobits
	.align	2
	.set	.LANCHOR5,. + 0
	.type	cont3, %object
	.size	cont3, 4
cont3:
	.space	4
	.section	.bss.cont4,"aw",%nobits
	.align	2
	.type	cont4, %object
	.size	cont4, 4
cont4:
	.space	4
	.section	.bss.i,"aw",%nobits
	.align	2
	.set	.LANCHOR1,. + 0
	.type	i, %object
	.size	i, 4
i:
	.space	4
	.section	.bss.j,"aw",%nobits
	.align	2
	.set	.LANCHOR3,. + 0
	.type	j, %object
	.size	j, 4
j:
	.space	4
	.section	.bss.k,"aw",%nobits
	.align	2
	.set	.LANCHOR11,. + 0
	.type	k, %object
	.size	k, 4
k:
	.space	4
	.section	.bss.l,"aw",%nobits
	.align	2
	.set	.LANCHOR12,. + 0
	.type	l, %object
	.size	l, 4
l:
	.space	4
	.section	.data.DMA_CONFIGG,"aw",%progbits
	.align	2
	.set	.LANCHOR8,. + 0
	.type	DMA_CONFIGG, %object
	.size	DMA_CONFIGG, 4
DMA_CONFIGG:
	.word	1073750064
	.section	.data.DMA_INTTCCLEARG,"aw",%progbits
	.align	2
	.set	.LANCHOR6,. + 0
	.type	DMA_INTTCCLEARG, %object
	.size	DMA_INTTCCLEARG, 4
DMA_INTTCCLEARG:
	.word	1073750024
	.section	.data.PTR_ENAIO2,"aw",%progbits
	.align	2
	.set	.LANCHOR7,. + 0
	.type	PTR_ENAIO2, %object
	.size	PTR_ENAIO2, 4
PTR_ENAIO2:
	.word	1074293904
	.section	.data.pi,"aw",%progbits
	.align	2
	.set	.LANCHOR10,. + 0
	.type	pi, %object
	.size	pi, 4
pi:
	.word	3
	.ident	"GCC: (GNU Tools for Arm Embedded Processors 7-2017-q4-major) 7.2.1 20170904 (release) [ARM/embedded-7-branch revision 255204]"
