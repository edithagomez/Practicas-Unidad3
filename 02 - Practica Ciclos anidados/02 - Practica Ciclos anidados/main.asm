; Materia: Lenguajes de interfaz
; Alumno(a): Gómez Sánchez Edith Alessandra
; Hora: 8:00 - 9:00 hrs
; Docente: Dr. José Luis Medina Jiménez
; Práctica: Práctica 2 - Llamadas anidadas entre procedimientos
; Descripción: Ilustra el encadenamiento de llamadas (main -> MetodoPadre -> MetodoHijo) 
; y el retorno ordenado mediante la pila del sistema.

INCLUDE Irvine32.inc

.data
	msgMain   BYTE " 1. Estamos en MAIN. Llamando a MetodoPadre", 0
	msgPadre1 BYTE " 2. Entrando a MetodoPadre. Llamando a MetodoHijo", 0
	msgHijo   BYTE " 3. Estamos dentro de MetodoHijo. Ejecutando codigo", 0
	msgPadre2 BYTE " 4. Regresamos a MetodoPadre. Terminando este metodo", 0
	msgFin    BYTE " 5. De vuelta en MAIN. Fin del programa.", 0

.code
main PROC
	; mensaje inicial en el procedimiento principal
	mov edx, OFFSET msgMain
	call WriteString
	call Crlf

	call MetodoPadre ; main invoca a MetodoPadre (call guarda dirección de retorno en pila)

	; al concluir MetodoPadre, el flujo vuelve aquí para cerrar el programa
	mov edx, OFFSET msgFin
	call WriteString
	call Crlf

	exit
main ENDP


MetodoPadre PROC ; imprime un mensaje, invoca a MetodoHijo y finaliza tras recuperar el control
	; imprime el primer mensaje del procedimiento padre
	mov edx, OFFSET msgPadre1
	call WriteString
	call Crlf

	; llamada anidada: un procedimiento invoca a otro procedimiento
	call MetodoHijo

	; al terminar MetodoHijo, el control regresa a esta instrucción
	mov edx, OFFSET msgPadre2
	call WriteString
	call Crlf

	ret ; extrae de la pila la dirección de retorno hacia main
MetodoPadre ENDP

MetodoHijo PROC ; ejecuta su tarea y devuelve el control a MetodoPadre
	; imprime el mensaje correspondiente al procedimiento hijo
	mov edx, OFFSET msgHijo
	call WriteString
	call Crlf

	ret ; extrae de la pila la dirección de retorno hacia MetodoPadre
MetodoHijo ENDP

END main
