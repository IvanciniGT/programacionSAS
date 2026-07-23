/* Derivado de Introducción.sas (IvanciniGT/programacionSAS) */

DATA colores; /*Le estoy diciendo a SAS que quiero una tabla de datos llamada colores  */
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

DATA coloresNormalizados;
SET colores;
IF nombre = 'Blanco' THEN codigo = 1;         /* CODIFICACION */
ELSE IF nombre = 'Negro' THEN codigo = 2;
ELSE IF nombre = 'Amarillo' THEN codigo = 3;
ELSE IF nombre = 'Violeta' THEN codigo = 4;
ELSE IF nombre = 'Azul' THEN codigo = 5;
ELSE codigo = 99;

otrocampo = 33;                              /* CREACION DE NUEVOS DATOS */
otromas = codigo*2-otrocampo;
KEEP codigo;            /* DICE LAS QUE SE QUEDAN */

RUN;

/* Formato de salida por defecto */
PROC PRINT data=coloresNormalizados;
FORMAT codigo BEST12.;
RUN;

/* NOSOTROS PODEMOS DEFINIR NUESTROS PROPIOS FORMATOS. Y NOS INTERESA MUCHO */
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
