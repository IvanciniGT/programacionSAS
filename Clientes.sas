
FILENAME MI_EXCEL '/home/ivanosunaayuste0/sasuser.v94/Datos/clientes.xls';

PROC IMPORT DATAFILE=MI_EXCEL
	DBMS=XLS
	OUT=WORK.Clientes;
	GETNAMES=YES;
RUN;

/*
Tengo los datos:

ID: (Númerico - NOMINAL)
NOMBRE: (Texto - NOMINAL)
FECHA_NACIMIENTO: (TEXTO-> Número(FECHA) - CUANTITIVA DE INTERVALO : RESTAS) * PROBLEMA: Lo reolvemos mediante: FORMATO DE ENTRADA
COMUNIDAD: (Numérico - NOMINAL)
SEXO: (TEXTO-> Número(codificar), NOMINAL) * PROBLEMA: Lo resolvemos mediante: FORMATO DE ENTRADA

NOTA: SAS tiene un pseudotipo de datos llamado DATE/FECHA... realmente por dentro lo guarda como un numero... 
Pero sabe que sobre ese numero puede hacer algunas operaciones concretas especiales... (Operaciones de fecha)
*/

/*Los datasets se guardan en librerías. Vamos a declar una: Datos*/



LIBNAME DATOS '/home/ivanosunaayuste0/sasuser.v94/Datos';

PROC FREQ data = WORK.Clientes;
  TABLE sexo;
RUN;





/* 
Esto requiere de mantenimiento. 
Cada vez que vengan datos nuevos HAY QUE MODIFICARLO.
Una cosa que si podremos hacer es que si SAS en nuevo fichero detecta que
hay valores que no están en el formato, me avise... y pare!
*/
PROC FORMAT;

VALUE sexo
	0 = 'Mujer'
	1 = 'Hombre'
;

INVALUE sexo
	'Mujer' = 0
	'Mujercita' = 0
	'Chica' = 0
	'Muujer' = 0
	OTHER = 1
;

RUN;



DATA DATOS.clientesProcesados;

SET WORK.Clientes;

/** FECHAS !!!!! **/
/* Arreglar el desastre de la fecha. SAS Tiene CIENTOS de formatos para fechas */
fnacimiento = input( 'F. Nacimiento'n , ANYDTDTE10.);
LABEL  fnacimiento = "Fecha de Nacimiento";
FORMAT fnacimiento DDMMYYD10.;
DROP   'F. Nacimiento'n;

/** SEXO **/
sexoNuevo = input( sexo, sexo. );
FORMAT sexoNuevo sexo.;
DROP   sexo;
RENAME sexoNuevo = sexo;

/* COMUNIDAD*/
FORMAT Comunidad comunidades.;

OUTPUT DATOS.clientesProcesados;

RUN;

/*
ESCRIBIMOS CODIGO <-> PROBAMOS -> OK -> REFACTORIZACION <-> PRUEBAS -> OK
*/


PROC PRINT data=DATOS.clientesProcesados LABEL;

RUN;

/*
Queremos llegar a saber:
- Por ejemplo si el sexo influye en el tipo de chuche -> Publicidad dirigida
- Por ejemplo si el color de la chuche la hace más apetecible
- Por ejmplo si en cada comunidad autónoma hay una predilección por cierto tipo de chuches

Para saber todas estas cosas... tendría que preguntar a TODOS LOS NINOS Y NIÑAS DE ESPAÑA ENTERA...
PRESENTES, PASADOS Y FUTUROS. Esto es un sin sentido

Solo pregunto a unos cuantos: MUESTRA (REPRESENTATIVA )

ALEATORIA??? ESTRATITIFICADA
Asegure que en la muestra tengo el mismo % de chicos y chicas que en la realidad del pais.
Asegure que en la muestra tenga datos representados de todas las comunidades autónomas:
En las mismas proporciones que a nivel del país?
 de toda españa.. y en murcia vive un 1%... Tengo un problema?
 
 Por cada persona de Murcia tengo que coger 50 personas de Madrid o de Andalucia o de Cataluña, para que sea proporcional a la población (representativo)
 Con 1 persona saco una estadística? Necesito un mínimo de personas: 200
 Murcia necesito 200 personas -> Madrid: 1000 personas??? En serio? No tengo tanta pasta!!!
 
 Como resuelvo esto?
 Bueno.. voy a coger de todas las comunidades la misma cantidad de gente.. Un mínimo viable (economicamente y desde el punto de vista de la estadística)

		Madrid : 200 personas x peso (en función de lo relevante que sea esa comunidad a mi estudio).
		Murcia:  200 personas
		Cataluña: 200 personas
		...
		------------------------
		        3400 personas
*/

PROC SORT data=DATOS.clientesProcesados;
	by Comunidad;
RUN;
PROC SORT data=DATOS.comunidadesProcesado;
	by Id;
RUN;

/*
Queremos juntas las dos tablas ComunidadesProcesado y ClientesProcesado.
Con el objetivo de Enriquecer la información de los clientes, añadiendo datos de la tabla comunidades:
- Peso
*/
DATA DATOS.clientesPonderados ;
MERGE 
	DATOS.clientesProcesados 
	DATOS.comunidadesProcesado (RENAME=(Id=Comunidad) DROP=Ventas );
BY 
	Comunidad; /*Le decimos el campo (o campos) que deben coincidir en las tablas para hacer el JOIN*/
RUN;

/* Cuando queremos hacer un MERGE mediante BY necesitamos que ambas tablas estén ordenadas por el campo del BY */














