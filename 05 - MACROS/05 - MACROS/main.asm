; Materia: Lenguajes de interfaz
; Alumno(a): Gómez Sánchez Edith Alessandra
; Hora: 8:00 - 9:00 hrs
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 5 - Definición y expansión de macros en MASM
; Descripción: Implementa dos macros parametrizadas: una para desplegar 
; cadenas en consola y otra para multiplicar dos enteros de 8 bits.

INCLUDE Irvine32.inc

MostrarMensaje MACRO texto ; imprime una cadena terminada en cero seguida de un salto de línea
	mov edx, OFFSET texto
	call WriteString
	call Crlf
ENDM


; multiplica dos operandos sin signo de 8 bits usando MUL BL y almacena el resultado de 16 bits en la variable destino
MULTIPLICAR MACRO factor1, factor2, resultado
	mov al, factor1 ; cargar el multiplicando en AL
	mov bl, factor2 ; cargar el multiplicador en BL
	mul bl ; multiplicación sin signo: AX = AL * BL
	mov resultado, ax ; guardar el producto de 16 bits en resultado
ENDM

.data
	mensajeBienvenida BYTE "Bienvenido al programa", 0
	msgResultado BYTE "El resultado de la multiplicacion es: ", 0
	MensajeFin BYTE "Hasta luego", 0

	numA BYTE 6 ; primer factor (6)
	numB BYTE 7 ; segundo factor (7)
	res DW ? ; variable de 16 bits para almacenar el producto

.code
main PROC
	
	MostrarMensaje mensajeBienvenida ; invocar macro para imprimir bienvenida

	MULTIPLICAR numA, numB, res ; invocar macro para calcular numA * numB y guardarlo en res

	; imprimir etiqueta del resultado
	mov edx, OFFSET msgResultado
	call WriteString

	; cargar resultado de 16 bits extendido a 32 bits e imprimir en decimal
	movzx eax, res
	call WriteDec
	call Crlf

	; invocar macro para imprimir despedida
	MostrarMensaje MensajeFin

	exit
main ENDP

END main
