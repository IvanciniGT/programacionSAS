/* Derivado de Introducción.sas (IvanciniGT/programacionSAS) */

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
RUN;

/*Quiero imprimir la tabla de colores*/
PROC PRINT DATA=WORK.colores;
RUN;
PROC PRINT DATA=colores;
RUN;
