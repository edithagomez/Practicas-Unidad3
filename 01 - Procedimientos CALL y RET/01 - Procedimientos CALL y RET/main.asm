; Materia: Lenguajes de interfaz
; Alumno(a): Gómez Sánchez Edith Alessandra
; Hora: 8:00 - 9:00 hrs
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 1 - Procedimientos CALL y RET
; Descripción: Demuestra la declaración y llamada múltiple a un procedimiento 
; local, mostrando el flujo de control mediante el registro EIP.

INCLUDE Irvine32.inc

.data
	mensajeInicio        BYTE "Inicio de programa.", 0
	mensajeProcedimiento BYTE "Estoy dentro del procedimiento.", 0
	mensajeFin           BYTE "Fin del programa.", 0

.code
main PROC
	; mostrar mensaje inicial 
	mov edx, OFFSET mensajeInicio
	call WriteString
	call Crlf

	call mensajeAviso ; primera llamada al procedimiento mensajeAviso
	
	mov eax, 10 ; instrucción intermedia para verificar el retorno correcto de EIP

	call mensajeAviso ; segunda llamada: EIP salta nuevamente a las instrucciones del procedimiento

	mov eax, 20 ; instrucción posterior a la segunda llamada

	; mostrar mensaje de cierre y finalizar el programa
	mov edx, OFFSET mensajeFin
	call WriteString
	call Crlf

	exit

main ENDP

mensajeAviso PROC ; imprime un mensaje informativo indicando que la ejecución se encuentra dentro del subprograma y regresa al llamador.
	mov edx, OFFSET mensajeProcedimiento
	call WriteString
	call Crlf
	ret ; recupera de la pila la dirección de retorno para EIP y vuelve tras el CALL
mensajeAviso ENDP

END main
