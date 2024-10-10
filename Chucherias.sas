
LIBNAME DATOS  '/home/ivanosunaayuste0/sasuser.v94/Datos';


PROC FREQ data = DATOS.chucherias;
  TABLE color / out = ListadoColores  (DROP=PERCENT COUNT);
RUN;
PROC FREQ data = DATOS.chucherias;
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
PROC FORMAT CNTLIN=ListadoProductos;

/* Junto la tabla de productos (chucherias) con la tabla listado de colores para traer el campo ID (start)*/

PROC SORT DATA=DATOS.chucherias;
BY Producto;

DATA WORK.chucherias (DROP=Producto RENAME=(start=Producto)) ;
MERGE  
	DATOS.chucherias 
	ListadoProductos (RENAME=(Label=Producto) DROP=fmtname type);
BY 
	Producto;
FORMAT start productos.;
RUN;

/* Junto la tabla de colores (chucherias) con la tabla listado de colores para traer el campo ID (start)*/

PROC SORT DATA=WORK.chucherias;
BY Color;

DATA WORK.chucherias (DROP=Color RENAME=(start=Color)) ;
MERGE  
	WORK.chucherias 
	ListadoColores (RENAME=(Label=Color) DROP=fmtname type);
BY 
	Color;
FORMAT start colores.;
RUN;


DATA DATOS.chucheriasProcesado;
SET WORK.chucherias;

/*Fecha*/
fechaVenta = input( Fecha , ANYDTDTE10.);
LABEL  fechaVenta = "Fecha de venta";
FORMAT fechaVenta DDMMYYD10.;
DROP   Fecha;
/*Producto*/
/*Color*/

OUTPUT DATOS.chucheriasProcesado;
RUN;


/*
Enriquecer esta tabla con la información de cada comprador para cada operación(venta)
*/
PROC SORT DATA=DATOS.chucheriasProcesado;
BY Cliente;
PROC SORT DATA=DATOS.clientesPonderados;
BY Identificador;

DATA DATOS.final;
MERGE 
	DATOS.chucheriasProcesado 
	DATOS.clientesPonderados (RENAME=(Identificador=cliente));
BY
	Cliente;
RUN;


PROC FREQ data = DATOS.final;
  TABLE cliente / out= compras_por_cliente;
RUN;

PROC MEANS DATA= WORK.compras_por_cliente N;
    *MEAN MEDIAN MIN MAX STD VAR N NMISS Q1 Q3;
    VAR cliente;

RUN;

PROC MEANS DATA= DATOS.clientesPonderados N;
    *MEAN MEDIAN MIN MAX STD VAR N NMISS Q1 Q3;
    VAR Identificador;

RUN;




PROC MEANS DATA= WORK.chucherias N;
    *MEAN MEDIAN MIN MAX STD VAR N NMISS Q1 Q3;
    VAR cliente;

RUN;

PROC MEANS DATA= DATOS.final N;
    *MEAN MEDIAN MIN MAX STD VAR N NMISS Q1 Q3;
    VAR Cliente;

RUN;


DATA ClientesSinCompras;
SET DATOS.final;
IF MISSING(Producto) THEN OUTPUT ClientesSinCompras;
RUN;

/* Porcentaje de botellas vendidas sobre el total de productos venidos

RESULTADO = NUMERO DE BOTALLAS / TOTAL (1000 / 1002)

*/


PROC SORT DATA=DATOS.chucheriasProcesado;
BY Cliente;
PROC SORT DATA=DATOS.clientesPonderados;
BY Identificador;


DATA 
	DATOS.ventasConoSinPersonasRegistradas 
	DATOS.ventasConPersonaRegistrada 
	DATOS.personasConOSinVentaRegistrada 
	DATOS.todos DATOS.clientesSinVenta 
	DATOS.ventasSinClienteRegistrado;
MERGE 
	DATOS.chucheriasProcesado (in=ventas) /* LEFT */ 	
	DATOS.clientesPonderados (in=clientes RENAME=(Identificador=cliente)); /* RIGHT*/
BY
	Cliente;

/* Esos "in" son variables que me indican si una fila está en una tabla o no.*/
OUTPUT DATOS.todos;                 /* FULL OUTER JOIN */
IF ventas THEN OUTPUT DATOS.ventasConoSinPersonasRegistradas;  /* Si el dato está en la tabla de ventas: LEFT OUTER JOIN*/
IF clientes THEN OUTPUT DATOS.personasConOSinVentaRegistrada;  /* Si el dato está en la tabla de ventas: RIGHT OUTER JOIN*/
IF ventas and clientes THEN OUTPUT DATOS.ventasConPersonaRegistrada; /* INNER JOIN */
IF cliente and not ventas THEN OUTPUT DATOS.clientesSinVenta;
IF not cliente and ventas THEN OUTPUT DATOS.ventasSinClienteRegistrado;

RUN;







