/* Derivado de Chucherias.sas (IvanciniGT/programacionSAS) */
/* Los datos de DATOS.chucherias se representan aquí en línea, con la misma
   forma (Producto, Color, Cliente) que usa el script original. */

DATA chucherias;
INPUT Producto $ Color $ Cliente;
CARDS;
Botella Azul 1
Botella Rojo 2
Chicle Verde 1
Piruleta Azul 3
Chicle Rojo 2
Botella Verde 4
Piruleta Amarillo 1
Chicle Azul 3
;
RUN;

PROC FREQ data = chucherias;
  TABLE color / out = ListadoColores  (DROP=PERCENT COUNT);
RUN;
PROC FREQ data = chucherias;
  TABLE producto / out = ListadoProductos (DROP=PERCENT COUNT);
RUN;

DATA ListadoColores;
SET ListadoColores;
fmtname = 'colores';
type = "N";
Start = _N_;
RENAME Color = Label;
RUN;

DATA ListadoProductos;
SET ListadoProductos;
fmtname = 'productos';
type = "N";
Start = _N_;
RENAME Producto = Label;
RUN;

PROC FORMAT CNTLIN=ListadoColores;
RUN;
PROC FORMAT CNTLIN=ListadoProductos;
RUN;

/* Junto la tabla de productos (chucherias) con la tabla listado de productos para traer el campo ID (start)*/
PROC SORT DATA=chucherias;
BY Producto;
RUN;

DATA WORK.chucherias (DROP=Producto RENAME=(start=Producto)) ;
MERGE
	chucherias
	ListadoProductos (RENAME=(Label=Producto) DROP=fmtname type);
BY
	Producto;
FORMAT start productos.;
RUN;

/* Junto la tabla de colores (chucherias) con la tabla listado de colores para traer el campo ID (start)*/
PROC SORT DATA=WORK.chucherias;
BY Color;
RUN;

DATA WORK.chucherias (DROP=Color RENAME=(start=Color)) ;
MERGE
	WORK.chucherias
	ListadoColores (RENAME=(Label=Color) DROP=fmtname type);
BY
	Color;
FORMAT start colores.;
RUN;

PROC PRINT DATA=WORK.chucherias;
RUN;
