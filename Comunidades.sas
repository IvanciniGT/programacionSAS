
DATA comunidades;
INFILE '/home/ivanosunaayuste0/sasuser.v94/Datos/comunidades.txt';
INPUT
	Id					1-2
	NombreComunidad		$3-37
	Ventas				38-46;
RUN;


DATA ListadoComunidadesParaFormato;
SET comunidades;
DROP Ventas;
RENAME NombreComunidad = Label;
RENAME Id = Start;
type = "N";
fmtname = "comunidades";
RUN;


/* PROC FORMAT lo podíamos usar para crear formatos a manita.. dando los values o invalues de uno en uno
Pero también me permite generar formados desde tablas de datos.
Le puedo pasar una tabla y que me genere el formato en automático = GUAY !!!! Si los datos vienen bien.

El concepto es fácil:
*/

PROC FORMAT CNTLIN=ListadoComunidadesParaFormato;

/*
El problema es que la tabla que espera es muy particular.. no le vale cualquier cosa. 
Necesito pasarle una tabla con unas columnas concretas, que SAS define:
- fmtname: CON EL NOMBRE DEL FORMATO AL QUE SE APLICA UNA FILA DE LA TABLA
- type : "N" : Que le doy un valor para el formato VALUE
- Start: Identificador que asigno a cada DATO DEL FORMATO: 1= "Hombre"... El 1
- Label: Con el valor asociado al Start(al 1): "Hombre"
*/


PROC MEANS DATA= WORK.comunidades MIN;
    *MEAN MEDIAN MIN MAX STD VAR N NMISS Q1 Q3;
    VAR Ventas;
	OUTPUT OUT=WORK.estadisticasComunidad(DROP=_TYPE_ _FREQ_) MIN=Minimo;
RUN;

LIBNAME DATOS '/home/ivanosunaayuste0/sasuser.v94/Datos';

PROC SORT data=WORK.comunidades;
	by DESCENDING Ventas;
RUN;
/* 
MUCHO MUCHO MUCHO MUCHO Cuidado con las ordenaciones. Las computadoras son extremadamente INEFICIENTES ORDENANDO
CUANDO DIGO EXTREMADAMENTE me quedo MUY MUY MUY MUY CORTO
*/


DATA DATOS.comunidadesProcesado;
MERGE WORK.comunidades WORK.estadisticasComunidad;				/* ESTO VA FILA A FILA: ESTO ES MUY MUY MUY IMPORTANTE !!!! */

*RETAIN ventasAcumulado 0; /* Retén entre fila y fila el valor de ventasAcumulado... empezando en 0 */
RETAIN MinimoCalculado 0;

*ventasAcumulado = Ventas + ventasAcumulado;

IF NOT MISSING(Minimo) THEN MinimoCalculado = Minimo;
	/* Me indica si un dato no está establecido */

*minimo = min(Ventas)              ESTO NO FUNCIONA VER NOTA (1); 
peso = Ventas / MinimoCalculado; 
DROP MinimoCalculado Minimo;

FORMAT Id comunidades.;
DROP NombreComunidad;

OUTPUT DATOS.comunidadesProcesado;

RUN;

/*
ESTO MISMO SE PODRIA RESOLVER CON LAS MISMAS PALABRAS PERO DE OTRA FORMA:
Qué pasa si ordeno por Ventas ASC?
En la primera file me habría quedado el MINIMO DE VENTAS MURCIA... y ese dato lo podria retener.. en otra variable
Me habria quitado la necesidad de hacer primero el PROC MEANS y el MERGE
SERIA MAS EFICIENTE... Pero yo os queria contar: MEANS y lo de l MERGE de union fila a fila.

*/


/* 
NOTA (1)
La función mínimo trabaja a nivel de FILA. 
Me sirve, si tengo 10 columnas y quiero el valor minimo de esas columnas A NIVEL DE CADA FILA 

EN SQL 

SELECT *, Ventas / min(Ventas) as peso
FROM Ventas;

*/
