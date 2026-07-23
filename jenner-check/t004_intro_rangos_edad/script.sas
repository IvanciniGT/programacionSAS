/* Derivado de Introducción.sas (IvanciniGT/programacionSAS) */

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

/* invalue: FORMATOS DE ENTRADA... Me ayudan a entender el dato que debo interpretar
   al leer una representación de un dato. Aquí, además de codificar, agrupamos por rangos. */
PROC FORMAT;
value rangosEdad     /* FORMATOS DE SALIDA: Como quiero ver un dato. */
1 = 'Joven'
2 = 'Adulto'
3 = 'Tercera edad';

invalue rangosEdad
0 - <20 = 1
20 - 70 = 2
OTHER = 3;
RUN;

DATA personas; /* Quiero generar una nueva tabla personas.. PERO YA EXISTE UNA? No pasa nada, la reescribo */
SET personas;
rangoEdad = input(edad, rangosEdad.);
FORMAT rangoEdad rangosEdad.;
RUN;

/*
He cambiado la forma de medir la variable:
- edad: Cuantitativa
- rangoEdad: Ordinal (cuasicuanti)
*/
PROC PRINT DATA=personas;
RUN;
