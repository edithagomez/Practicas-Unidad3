# Prácticas Unidad 3 - Lenguajes de interfaz

**Alumna:** Gómez Sánchez Edith Alessandra  
**Materia:** Lenguajes de interfaz  
**Horario:** 8:00 - 9:00 hrs  
**Docente:** Dr. José Luis Medina Jiménez  

---

## Práctica 1: Llamadas a procedimientos (`CALL` y `RET`)

Este programa muestra cómo funciona la llamada básica a un procedimiento en lenguaje ensamblador utilizando las instrucciones `CALL` y `RET`. Desde el bloque principal (`main`), primero se imprime un mensaje de inicio y después se manda llamar dos veces al procedimiento `mensajeAviso`, intercalando las asignaciones `10` y `20` en el registro `EAX` para observar cómo el flujo salta al subprograma y regresa exactamente a la instrucción siguiente antes de mostrar el mensaje final.

Al ejecutarlo en Visual Studio con MASM, se comprobó en la consola que los mensajes aparecieron en el orden esperado: primero el texto de inicio, dos veces seguidas el mensaje `"Estoy dentro del procedimiento"` y finalmente el cierre del programa. Además, al revisarlo paso a paso con el depurador, se verificó en la ventana de registros que `EAX` tomó primero el valor `10` y luego `20`, confirmando que la dirección de retorno se recuperó correctamente de la pila en ambas llamadas.

---

## Práctica 2: Llamadas anidadas entre procedimientos

Este código ejemplifica cómo un procedimiento puede invocar a otro procedimiento dentro de sí mismo. La ejecución inicia en `main`, desde donde se manda llamar a `MetodoPadre`, y este a su vez llama a `MetodoHijo`. De esta forma se demuestra el comportamiento de la pila del sistema al guardar las direcciones de retorno: al terminar `MetodoHijo`, el control regresa primero a `MetodoPadre` para terminar sus instrucciones y posteriormente vuelve a `main` para finalizar el programa.

Para comprobar su funcionamiento se ejecutó el programa en Visual Studio y se revisó la salida en consola, verificando que los cinco mensajes numerados se imprimieran en orden consecutivo del 1 al 5, lo que confirma que el flujo entró y salió de cada nivel de procedimiento sin alterarse.

---

## Práctica 3: Validación de entrada de texto

Este programa solicita al usuario que escriba un texto por teclado, lee la cadena con `ReadString` y pasa la longitud obtenida al procedimiento `ValidarNoVacia`. Dicho procedimiento compara la cantidad de caracteres contra cero y devuelve un `1` en el registro `EAX` si se escribió algo, o un `0` si la cadena quedó vacía, para que el programa principal decida qué mensaje mostrar en pantalla.

La comprobación se realizó haciendo dos pruebas directamente en la consola. En la primera ejecución se presionó únicamente la tecla Enter sin escribir texto y el programa desplegó `"Entrada vacia"`; en la segunda ejecución se escribió una frase de prueba y la consola mostró `"Entrada no vacia"`, verificando así que ambas condiciones funcionaran correctamente.

---

## Práctica 4: Paso de parámetros por pila y limpieza con `RET`

Este programa demuestra cómo pasar datos a un procedimiento utilizando la pila en lugar de variables globales. Antes de llamar a `sumarPila`, se guarda un valor de prueba (`10`) en `EBX` y se apilan los números `1` y `2`. Dentro del procedimiento se establece un marco de pila con `EBP` para leer ambos parámetros, se multiplican mediante `IMUL`, se restaura el valor original de `EBX` y se utiliza `ret 8` para regresar a `main` limpiando al mismo tiempo los dos argumentos de la pila.

Dado que este programa no muestra mensajes en pantalla, su ejecución se comprobó mediante el depurador de Visual Studio colocando un punto de interrupción en la instrucción `nop`. En la ventana de registros se verificó que `EAX` almacenó el resultado `2` (producto de `2` por `1`), que `EBX` conservó intacto su valor inicial de `10` y que el puntero de pila `ESP` volvió a su dirección original después de ejecutarse `ret 8`.

---

## Práctica 5: Definición y uso de macros

Este código muestra cómo crear y utilizar macros en MASM para reutilizar bloques de instrucciones. Se definen dos macros: `MostrarMensaje`, que recibe la etiqueta de una cadena y la imprime en consola con salto de línea, y `MULTIPLICAR`, que recibe dos números de 8 bits (`6` y `7`), los multiplica usando `MUL` y guarda el resultado en la variable `res` para después mostrarlo en formato decimal.

Al compilar y correr el programa en Visual Studio, se comprobó en la consola que se imprimiera primero el mensaje de bienvenida, enseguida la leyenda `"El resultado de la multiplicacion es: 42"` y por último el mensaje de despedida, confirmando que ambas macros se expandieron y ejecutaron sin errores.
