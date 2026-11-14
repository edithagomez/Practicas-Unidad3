; Materia: Lenguajes de interfaz
; Alumno(a): Gómez Sánchez Edith Alessandra
; Hora: 8:00 - 9:00 hrs
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 4 - Paso de parámetros por pila y marco de pila (EBP)
; Descripción: Demuestra el paso de argumentos mediante la pila, el acceso a parámetros 
; usando EBP, la preservación de registros (EBX) y la limpieza automática de la pila con RET 8

INCLUDE Irvine32.inc

.data

.code
main PROC
	mov ebx, 10 ; cargar valor de prueba en EBX para verificar su preservación
	push 1 ; segundo parámetro apilado (quedará en [EBP + 12])
	push 2 ; primer parámetro apilado  (quedará en [EBP + 8])
	call sumarPila ; apila dirección de retorno y salta al procedimiento
	nop ; instrucción de apoyo para inspección en el depurador
	exit
main ENDP

; crea un marco de pila con EBP, recupera los dos enteros apilados por main, 
; los multiplica con IMUL y restaura tanto el registro EBX como el puntero de pila (limpiando 8 bytes)
sumarPila PROC
	push ebp ; guardar el EBP anterior para establecer el marco de pila
	mov ebp, esp ; fijar EBP como referencia base fija en la cima de la pila
	push ebx ; respaldar EBX en la pila para no alterar su valor en main

	mov eax, [ebp + 8] ; acceder al primer parámetro apilado antes del CALL (valor 2)
	mov ebx, [ebp + 12] ; acceder al segundo parámetro apilado (valor 1)
	imul eax, ebx ; multiplicación con signo: EAX = EAX * EBX (2 * 1 = 2)

	pop ebx ; restaurar el valor original de EBX (10)
	pop ebp ; restaurar el puntero base EBP del llamador
	ret 8 ; retornar a main y liberar los 8 bytes (2 DWORD) de parámetros
sumarPila ENDP

END main