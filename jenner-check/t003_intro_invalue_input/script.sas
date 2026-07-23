/* Derivado de Introducción.sas (IvanciniGT/programacionSAS) */

DATA colores;
INPUT nombre $20.;
CARDS;
Blanco
Negro
Violeta
Amarillo
Azul
Verde
Morado
;
RUN;

/* Los formatos son guays... porque se pueden aplicar bidireccionalmente. */
PROC FORMAT;
value nombresColores    /* AQUI ES COMO QUIERO VER UN DATO TABLA -> PANTALLA */
1 = 'Blanco'
2 = 'Negro'
3 = 'Amarillo'
4 = 'Violeta'
5 = 'Azul'
99 = 'Otro';

invalue nombresColores   /* COMO QUIERO QUE SE INTERPRETE UN DATO PARA GUARDARLO INTERNAMENTE DATO -> TABLA */
'Blanco' = 1
'Negro' = 2
'Amarillo' = 3
'Violeta' = 4
'Azul' = 5
OTHER = 99;
RUN;

DATA coloresNormalizados;
SET colores;
codigo = input( nombre, nombresColores. ); /* Lee el campo nombre, interpretandolo segun el formato que te indico */
otracolumna = 2;
FORMAT codigo nombresColores.;				/* AQUI ESTAMOS APLICANDO EL VALUE: Como represento el dato que está guardado.*/
KEEP codigo;
RENAME codigo=color;
RUN;

PROC PRINT data=coloresNormalizados;
RUN;
