
DATA colores; /*Le estoy diciendo a SAS que quiero una tabla de datos llamada colores: CREAR UNA TABLA  */
/* Le voy a contar a SAS que columnas quiero en mi tabla de datos */
INPUT id nombre $20.; /* Quiero 2 columnas.. id y nombre.. El nombre como es un texto le pongo el signo $ detrás */
/*Voy a decirle a SAS que quiero crear YO en manual los datos de la tabla*/
CARDS;
1 Blanco
2 Negro
3 Violeta
4 Amarillo
5 Azul
6 Verde
; /*Ya no quiero más datos*/
/*
Por defecto en SAS los textos tienen una longitud de 8 caracteres máximos.
Lo podemos cambiar
*/
RUN;

/*Quiero imprimir la tabla de colores*/
PROC PRINT DATA=WORK.colores;
RUN;
PROC PRINT DATA=colores;
RUN;
/*
PROC PRINT DATA=MILIB.colores; Si tuviera la libreria creada
RUN;
*/
/*
Tipos de datos en SAS.

Los programas que montemos van a trabajar con DATOS. E internamente SAS maneja 2 tipos de datos. SOLO:
- TEXTO
- NUMERO

Puedo pensar que me faltan.. por ejemplo: FECHAS.
Para SAS las fechas se representan internamente como NUMEROS.

!!!!!!!!! A nosotros NOS DAN IGUAL los tipos de datos internos de SAS. IMPORTANTE !!!!
========================================================================================

Qué significa esto?
- De cara a montar un programa, evidentemente yo necesito tener en cuenta si los datos se guardarán como número o como texto.
- En todo lo posible, SOLAMENTE TRABAJAREMOS CON DATOS DE TIPO NUMERO. Si es necesario recurriré a técnicas de CODIFICACION
  Luego os cuento por qué? IMPORTANTE !
- Desde el punto de vista del trabajo con los datos (su interpretación, análisis, estudio), 
  que un dato sea de tipo NUMERICO o TEXTO nos da igual. Nos importa otra clasificación, que hace LA ESTADISTICA!

Esta nueva clasificación que nos ofrece la estadístcia es la que CONDICIONARÁ TODAS LAS OPERACIONES QUE PODRE HACER SOBRE MIS DATOS:
- Cualitativos				NOMINALES     - NOMBRE (hombre=1/mujer=0)											CLASIFICAR
	- Cuasi-cuantitativos	ORDINALES     - NOMBRE + RELACION DE ORDEN ENTRE SI: (poco=0, algo=1, mucho=2)		CLASIFICAR + ORDENAR
- Cuantitativos				CUANTITATIVOS - NOMBRE + RELACION DE ORDEN + UNIDAD DE MEDIDA						CLASIFICAR + ORDENAR
											1 kilogramo, 2 kilogramos, 2.2 kilogramos								+ OPERAR
								- De razón			Es cuando el valor 0 tiene un significado distinto (absoluto)
									Operaciones: SUMAS y RESTAS. Y MULTIPLCIACIONES Y DIVISIONES
								- De intervalo		Es cuando el valor 0 tiene un significado como cualquier otro valor.. caso de existir
									Operaciones: SUMAS y RESTAS
Número de hijos de una familia: Cuantitativo ya que tiene una UNIDAD DE MEDIDA: "hijos".
El valor 0 hijos... es igual que el resto.. o es un valor ABSOLUTO: Es absoluto:
- No hay valor por debajo
- Y lo interpreto con una diferencia con respecto al resto. El valor 0 indica que NO APLICA O EXISTE LA PROPIEDAD QUE MIDO.

	- Si yo tengo 2 hijos y tu tienes 1 hijo.. Puedo decir que tengo EL DOBLE DE HIJOS QUE TU?
	- Si yo tengo 300 billetes en el banco y tu 600. Puedo decir que TENGO LA MITAD DE BILLETES QUE TU? SI

Temperatura en España en la última década: 18ºC
Tipo de dato? Cuantitativo, ya que tiene unidad de medida ºC. 
El valor 0 es absoluto? NO.. es esto dato más
	Si en Madrid hace 10 grados y en Barcelona 20.. En Barcelona hace el doble de calor que en Madrid?	NO TIENE SENTIDO
	Si en Madrid hace -10 grados y en Barcelona 20.. En Barcelona hace el ??? de calor que en Madrid? NO TIENE SENTIDO

Un dato Cuantitativo, por definiciúón es Ordinal,
Y otodo dato ordinal por definición es Nominal

Otro tema importante es que un dato puedo decicir cómo lo mido (en algunos casos).
El mismo dato lo puedo medir usando escalas NOMINALES, ORDINALES o CUANTITATIVAS:

- Hablando de los hijos de una familia:
    - NO / SI 
    - Ninguno, pocos, muchos.. demasiados
    - 0, 1, 2, 3, 4, 6, 14
    
   Si tengo una medición CUANTITATIVA DE UN DATO, la puedo representar como ORDINAL
   Si tengo una medición ORDINAL la puedo representar como NOMINAL

   Pero nunca al revés!
   
   En general me interesa siempre tener médidas que aporten la mayor cantidad posible de información: CUANTITATIVA > ORDINAL > CUALITATIVA

Qué tiene un dato CUANTITATIVO que lo comvierte en DATO CUANTITATIVO? NUMERO NO !!!!!! O al menos no es suficiente.
Qué tenga una UNIDAD DE MEDIDA ASOCIADA... Eso es lo que lo convierte en una CANTIDAD (contable)... y OPERABLE

CODIGOS POSTALES
	19200
	27880
	No tiene sentido sumar números porque sí!

NUMEROS DE PORTAL EN EL QUE VIVO
	 3
	89
  + --
	92 No tiene sentido sumar números porque sí!


* Por que me interesa representar la informacion como numeros y no como textos?

Habeis oido hablar de los bits y los bytes?

Los ordenadores representan la información en binario. No hablan en ceros y unos.. 
solo es una forma para nosotros humanos de entender cómo los ordenadores guardan los datos o los usan.

1 Bit es la canitdad más pequeña de información que podemos represntar en un sistema binario:
0 - hombre.   verde.   llueve.    cliente vip.      hay una incidencia
1 - mujer.    rojo.    no llueve. cliente normal.   no hay una incidencia

¿Qué significa el 0 y qué significa el 1? Lo que yo quiera.
En un bit solo podemos llegar a representar 2 datos (significados) diferentes.
Si necesito más significados.. empiezo a juntar bits

00 - pelirrojo
01 - moreno
10 - castaño
11 - rubio

Si necesito más de 4 significados... más bits:
000
001
010
011
100
101
110
111

Según bits, puedo ir guardando 2^n bits (significados distintos)
Normalmente los agrupamos de 8 en 8... A eso se le llama byte

0000 0000
0010 0101
...
1111 1111

Esto me da 256 significados posibles., Para que los destino esos significados:


0000 0000.    1        -127.    a
0010 0101.    127      -9       b
...
1111 1111.    256      128.     ?

Imaginad que quiero guardar el número del DNI: hasta 8 dígitos + una letra (pero la letra se calcula desde el número)

 23000022 / 23
          +----------
       22   1000000
		
	   RESTO: 0-22 


Cuánto ocupa un carácter al representarlo como bits? Depende del juego de caracteres que se use: ASCII, UTF-8
Eso son juegos de caracteres. Asignar a secuencias de bytes distintos caracteres

El problema es que en un Byte, cuántos caracteres podría representar? 256.. Nos vale con eso?
Depende. Si quiero poner los DNIs: 0-9 y 23 letras: 33 valores diferentes

Y si quiero representar un texto en chino? El albabeto de los chinos tiene más de 6000 caracteres diferentes.
La humanidad usa más de 170000 caracteres diferentes en los idiomas que usa: UNICODE

Para no liarnos... nuestro DNI, que usa caracteres muy basicos, lo podríamos guardar en 9 bytes. (8 números + 1 letra)
Y si solo guardo el número como número? En 1 bytes cuandos numeros entran diferentes? 256
Y en 2 bytes? 256*256 = 65000
Y en 4 bytes?  Más de 4 mil millones de números. Los DNIs son 99.999.999

Es decir, el mismo dato, si lo represento como texto ocupa 9 bytes... pero si lo guardo como numero ocupa 4 bytes.
Ahora multiplica por 1 millon de clientes: 9Mb -> 4Mb

Eso significa que cuando quiera leer el dato del disco, tardaré más del doble
Que cuando quiera mandarlo por red, tardaré más del doble de tiempo
Que cuando tenga que procesarlo, tardaré más del doble de tiempo
Que cuando quiera escribirlo a un fichero, tardará más del doble..
Y eso con un campo...Nuestras tablas tienen decenas o centenares de campos... IMAGINA TU !

Oye .. y el nombre de una persona? Lo codifico? Posiblemente NO.. Lo uso como texto.. Ese dato no lo usaré en operaciones: AGREGADO, ORDENACION, FILTRAR, MEDIA
Es más... en un análisis estadístico.. posiblemente el dato ni me interesa!

ESTADISTICA: Ciencia que estudia CONJUNTOS DE DATOS (POBLACIONES). No es una RAMA DE LAS MATEMATICAS... ni por el forro!!
Tiene que ver con las mates.. lo mismo que la física.. La física usa conceptos de mates...
Y la estadística... nada más!


HEMOS HABLADO DE cofificar los textos... VAMOS A POR ELLO

FORMA CUTRE !!! ( a veces es práctica.. pocas veces )... sirve también a otros propósitos.
*/


DATA colores; /*Le estoy diciendo a SAS que quiero una tabla de datos llamada colores  */
/* Le voy a contar a SAS que columnas quiero en mi tabla de datos */
INPUT nombre $20.; /* Quiero 2 columnas.. id y nombre.. El nombre como es un texto le pongo el signo $ detrás */
/*Voy a decirle a SAS que quiero crear YO en manual los datos de la tabla*/
CARDS;
Blanco
Negro
Violeta
Amarillo
Azul
Verde
Morado
; /*Ya no quiero más datos*/
/*
Por defecto en SAS los textos tienen una longitud de 8 caracteres máximos.
Lo podemos cambiar
*/
RUN;


DATA coloresNormalizados;
SET colores; 
/* 
Vamos a ir metiendo en el conjunto de datos nuevo llamado COLORESNORMALIZADOS
los valores de este otro conjunto de datos.
Los datos se van a ir metidiendo de uno en uno... FILA A FILA. CLAVE EN TODO ESTO!!!
Y al procesarse cada fila yop puedo pedir acciones adicionales.
Las pondríamos a continuación:
1 Blanco
2 Negro
3 Negro
4 Amarillo
5 Azul
6 Verde
7 Morado
*/
IF nombre = 'Blanco' THEN codigo = 1;         /* CODIFICACION */
ELSE IF nombre = 'Negro' THEN codigo = 2;
ELSE IF nombre = 'Amarillo' THEN codigo = 3;
ELSE IF nombre = 'Violeta' THEN codigo = 4;
ELSE IF nombre = 'Azul' THEN codigo = 5;
ELSE codigo = 99;

otrocampo = 33;								 /* CREACION DE NUEVOS DATOS */
otromas = codigo*2-otrocampo;
*DROP nombre;			/* DICE LAS QUE SE QUITAN */
*DROP otrocampo;
KEEP codigo;            /* DICE LAS QUE SE QUEDAN */

RUN;

/*
PARA COMPUTADORA, es guay tener solo numeritos...
PERO COMO YO SOY HUMANO... y no quiero ver numeritos... haré una cosa

SALE EL CONECPTO DE FORMATO!
Nos permiten cambiar la forma en la que un dato se repsenta por pantalla.
Hay formatos para números... TOTAL.DECIMALES				8.2
Hay formatos que cambian su comportamiento en base al dato que nos regala SAS: BEST12.
Todo formato al que nos refiramos por su nombre, acaba con un PUNTO.
*/

PROC PRINT data=coloresNormalizados;
FORMAT codigo BEST12.; /*En total se mostrarían hasta 8 digitos.. punto incluido... reservando 2 para decimales.*/
RUN;

/*
NOSOTROS PODEMOS DEFINIR NUESTROS PROPIOS FORMATOS. Y NOS INTERESA MUCHO
*/

PROC FORMAT;
value nombresColores
1 = 'Blanco'			/* En este caso, a cada valor, le asocio lo que debe representarse por pantalla */
2 = 'Negro'
3 = 'Amarillo'
4 = 'Violeta'
5 = 'Azul'
99 = 'Otro';
RUN;

PROC PRINT data=coloresNormalizados;
FORMAT codigo nombresColores.;
RUN;

DATA coloresNormalizados;
SET coloresNormalizados;
FORMAT codigo nombresColores.;
RUN; 

/* 
ASI QUEREMOS TRABAJAR CON SAS! 
DATOS NUMERICOS PARA SAS
FORMATOS COMO TEXTO APARA HUMANOS

Los formatos son guays... Purque se pueden aplicar bidireccionalmente.
Arriba os dije que ibamos a codificar de forma CUTRE

Ahora viene la guay! Que no siempre es aplciable.
*/

PROC FORMAT;
value nombresColores    /* AQUI ES COMO QUIERO VER UN DATO TABLA -> PANTALLA */
1 = 'Blanco'			/* En este caso, a cada valor, le asocio lo que debe representarse por pantalla */
2 = 'Negro'
3 = 'Amarillo'
4 = 'Violeta'
5 = 'Azul'
99 = 'Otro';

invalue nombresColores   /* COMO QUIERO QUE SE INTERPRETE UN DATO PARA GUARDARLO INTERNAMENTE DATO1 -> TABLA */
'Blanco' = 1			/* En este caso, a cada valor, le asocio lo que debe representarse por pantalla */
'Negro' = 2
'Amarillo' = 3
'Violeta' = 4
'Azul' = 5
OTHER = 99;
RUN;


DATA coloresNormalizados;
SET colores; 
codigo = input( nombre, nombresColores. ); /* Lee el campo nombre, interpretandolo segun el formato que te indico */
otracolumna = 2;							/* AQUI ARRIBA estamos aplicando el INVALUE: Como se interpreta el dato para su almacenamiento*/
FORMAT codigo nombresColores.;				/* AQUI ESTAMOS APLICANDO EL VALUE: Como represento el dato que está guardado.*/ 
KEEP codigo;
RENAME codigo=color;

RUN;

DATA personas;
INPUT edad nombre $;
CARDS;
25 Federico
33 Lucas
44 Menchu
88 Fermin
17 Juanito
55 Juanita
;
RUN; 


/* 
value: FORMATOS DE SALIDA: Lo mismo que hay en EXCEL... Como quiero ver un dato. 
Una cosa es el DATO... y otra cosa COMO QUIERO VER EL DATO.
Imagina una fecha: 10 de enero de 2025. ESTO ES UNA DATO!
Cómo quiero ver el dato? Dependerá de mi escenario de uso.. Dónode lo quiera representar:
- 10 de enero de 2025
- 10-01-2025
- 2025/01/10

La representación de un dato se realiza mediante un FORMATO!, en concreto mediante un FORMATO DE SALIDA!
Iguan me pasa con los números: NUMERO 1236000, que podria representar como:
- 1236000
- 1.236.000
- 1236x10^3


IGUAL QUE HAY FORMATOS PARA DECIDIR COMO VOY A REPRESENTAR un dato, 
hay FORMATOS PARA DECIDIR COMO DEBE INTERPRETARSE UN DATO. Por ejemplo:
Imagina que lees en un documento:
- 10/01/2025... Qué dato encierra esta reprentación:  10 de enero de 2025
													   1 de octubre de 2025													
Entonces en este caso me tiene que explicar cómo interpretar el dato:
  - dd/mm/yyyy
  - mm/dd/yyyy
  
Estos son los invalue: FORMATOS DE ENTRADA... Me ayudan a entender el dato que debo interpretar al leer una representación de un dato.
*/

PROC FORMAT;
value rangosEdad     /* FORMATOS DE SALIDA: Lo mismo que hay en EXCEL... Como quiero ver un dato. */
1 = 'Joven'		
2 = 'Adulto'
3 = 'Tercera edad';

invalue rangosEdad  
0 - <20 = 1		
20 - 70 = 2
OTHER = 3;
RUN;

PROC FORMAT;
value rangosEdadSiglas  
1 = 'J'		
2 = 'A'
3 = 'T';
RUN;

DATA personas; /* Quiero generar una nueva tabla personas.. PERO YA EXISTE UNA? No pasa nada, la reescribo */
SET personas;
rangoEdad = input(edad, rangosEdad.);
FORMAT rangoEdad rangosEdad.;
RUN;
/*
Ahora no solo hemos hecho una codificación de los datos.. Además hemos hecho una agrupación de los mismos...
He cambiado la forma de medir la variable:
- edad: Cuantitativa
		v
- rangoEdad: Ordinal (cuasicuanti) 
*/


/*
SINTAXIS		// Como hacer un condicional o una pregunta
MORFOLOGIA		// Como se forman distintos tipos de palabras y cuales son
SEMANTICA		// LO QUE SIGNIFICAN CIERTAS PALABRAS
*/



DATA personas;
INPUT edad nombre $;
CARDS;
25 Federico
33 Lucas
44 Menchu
88 Fermin
17 Juanito
55 Juanita
;
RUN; 

DATA personasMayores personasMenores(DROP=edad RENAME=(nombre=persona));

SET personas;
IF edad <=20 THEN rangoEdad = 1;
ELSE IF edad > 20 AND edad <=70 THEN rangoEdad = 2;
ELSE rangoEdad = 3;

/* FILTRO */
IF rangoEdad > 1 THEN DO;
		OUTPUT personasMayores;
	END;
ELSE OUTPUT personasMenores;

FORMAT rangoEdad rangosEdad.;
RUN;
/*
Al declarar una tabla nueva puedo ponerle DROPs, KEEPs y RENAMEs
*/

/*
Algunos, estáis acostumbrados a SQL... Cómo haría eso en SQL?
SELECT 
	*, 
 	CASE 
 		WHEN edad<=20 THEN 1 
 		WHEN edad > 20 AND edad<=70 THEN 2 
 		ELSE 3
 	END as rangoEdad	
FROM 
	personas 
WHERE 
	rangoEdad > 1;


SELECT 
	*, 
 	CASE 
 		WHEN edad<=20 THEN 1 
 		WHEN edad > 20 AND edad<=70 THEN 2 
 		ELSE 3
 	END as rangoEdad	
FROM 
	personas 
WHERE 
	rangoEdad = 1;

*/

/*
De hecho, para ser más precisos:
Si SAS detecta que en entre un DATA... y un RUN no hay una etiqueta OUTPUT, el añade una linea como esa al final:
OUTPUT TABLA_NUEVA_DEFINIDA_EN_EL_DATA ;

Qué hace esa linea?
- DATA   ? Crear una tabla nueva
- SET    ? Procesar fila a fila los datos de una tabla
- OUTPUT ? Guardar el resultado de procesar UNA FILA (según se defina entre el SET y el OUTPUT) 
           en una tabla de DESTINO
*/

/*

Todo lo que estamos haciendo hasta ahora es PREPARACION DE NUESTROS ARCHIVOS:

- Filtrar filas 		(IF + OUTPUT) 
- Filtrar columnas      (DROP - KEEP)
- Renombrar columnas    (RENAME)
- Crear columnas nuevas (columnaNueva=????)
- Hacer agrupaciones datos (IFs - INFORMATs)
- Codificar datos        (IFs - INFORMATs)
- Visualizar datos de manera más bonita (FORMATs)

PREPARAR LOS DATOS es la CLAVE. De lo que tenga que hacer con los datos, el 70%-80% del tiempo he de 
invertirlo a preparar los datos!

   			GUADALAJARA ---> BARCELONA
   				Coche y pa'lla 3 horas -> Zaragoza
	MADRID <-
    ------------------------------------------------------------------> 3 horas Barcelona	 

*/
