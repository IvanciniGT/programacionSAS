/* Derivado de Comunidades.sas (IvanciniGT/programacionSAS) */
/* Los datos de comunidades.txt se leen aquí en línea, con columnas fijas,
   preservando el INPUT posicional del script original. */

DATA comunidades;
INFILE CARDS TRUNCOVER;
INPUT
	Id					1-2
	NombreComunidad		$4-31
	Ventas				33-41;
CARDS;
 1 Andalucia                    138092
 2 Aragon                       36764
 3 Baleares                     21098
 4 Canarias                     24075
 5 Cantabria                    16435
 6 Castilla y Leon              86294
 7 Castilla La Mancha           121498
 8 Cataluna                     287643
 9 Comunidad Foral de Navarra   46343
10 Comunidad Valenciana         76209
11 Comunidad de Madrid          250495
12 Extremadura                  23845
13 Galicia                      65038
14 La Rioja                     37654
15 Pais Vasco                   89754
16 Principado de Asturias       35486
17 Region de Murcia             15039
;
RUN;

/* PROC MEANS me permite obtener el mínimo de Ventas y volcarlo a una tabla */
PROC MEANS DATA= WORK.comunidades MIN;
    VAR Ventas;
	OUTPUT OUT=WORK.estadisticasComunidad(DROP=_TYPE_ _FREQ_) MIN=Minimo;
RUN;

PROC SORT data=WORK.comunidades;
	by DESCENDING Ventas;
RUN;

/* MERGE fila a fila: retengo el mínimo calculado para ponderar cada comunidad */
DATA comunidadesProcesado;
MERGE WORK.comunidades WORK.estadisticasComunidad;

RETAIN MinimoCalculado 0;

IF NOT MISSING(Minimo) THEN MinimoCalculado = Minimo;
	/* Me indica si un dato no está establecido */

peso = Ventas / MinimoCalculado;
DROP MinimoCalculado Minimo;

DROP NombreComunidad;

OUTPUT comunidadesProcesado;

RUN;

PROC PRINT DATA=comunidadesProcesado;
RUN;
