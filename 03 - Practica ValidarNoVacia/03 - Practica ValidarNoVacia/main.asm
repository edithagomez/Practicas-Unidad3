; Materia: Lenguajes de interfaz
; Alumno(a): Gómez Sánchez Edith Alessandra
; Hora: 8:00 - 9:00 hrs
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 3 - Validación de entrada de texto mediante procedimiento
; Descripción: Solicita una cadena al usuario y evalúa mediante un procedimiento 
; dedicado si la entrada está vacía o contiene datos.

INCLUDE Irvine32.inc

.data
	mensajeEntrada BYTE "Ingrese un texto: ", 0
	entradaValida BYTE "Entrada no vacia", 0
	entradaInvalida BYTE "Entrada vacia", 0
	buffer BYTE 100 DUP(0) ; bufer de 100 bytes para almacenar la cadena

.code
main PROC
	; solicitar texto al usuario
	mov edx, OFFSET mensajeEntrada
	call WriteString

	; leer cadena desde teclado (ReadString devuelve la longitud en EAX)
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	call ReadString
	mov ecx, eax ; transferir la longitud leída a ECX como parámetro

	call ValidarNoVacia ; llamar al procedimiento de validación

	; evaluar el resultado booleano devuelto en EAX (0 = vacía, 1 = válida)
	test eax, eax
	jz mostrarInvalida ; si EAX es 0 (ZF=1), saltar a mensaje de entrada vacía

	; caso entrada válida
	mov edx, OFFSET entradaValida
	call WriteString
	call Crlf
	jmp fin

mostrarInvalida:
	; caso entrada vacía
	mov edx, OFFSET entradaInvalida
	call WriteString
	call Crlf

fin:
	exit
main ENDP



; Devuelve: ;
;                

ValidarNoVacia PROC ; verifica si la longitud de una cadena es distinta de cero
	; recibe: ECX = longitud de la cadena ingresada
	; devuelve:
	; EAX = 1 si la cadena tiene al menos un carácter
	; EAX = 0 si la cadena está vacía
	cmp ecx, 0 ; comparar longitud con 0
	je esVacia ; si es igual a 0, saltar a etiqueta esVacia

	mov eax, 1 ; retornar 1 (entrada válida)
	ret

esVacia:
	mov eax, 0 ; retornar 0 (entrada vacía)
	ret
ValidarNoVacia ENDP

END main