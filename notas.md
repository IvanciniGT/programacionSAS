Variables:

NOMINALES: Me permiten clasificar los datos.
   ^
ORDINALES: Me permiten clasificar y ordenar los datos.
   ^
CUANTITATIVAS: Me permiten clasificar, ordenar y medir los datos (operaciones matemáticas)


# Estadística es una ciencia para el estudio de poblaciones.

PROBLEMA? Tener datos está bien... pero entender los datos que tengo es otra cosa.
Y a priori es complejo! MUY COMPLEJO!

4000 Nóminas de todo el mundo!

Entender los datos parte de RESUMIRLOS:
1- Tabla de frecuencias (Agrupar datos...) Contabilizar agrupadamente los datos 
    que comparten una característica común: SALARIO
           Cuántas? = FRECUENCIA ABSOLUTA | FRECUENCIA RELATIVA(%) | FRECUENCIAS ACUMULADAS (ABS|REL)
    800    17
    817,98  3
    1329    4
    1500    2
    2000    1
    2500    1
    3000    1

    ....
    10 - 1000

    Para montar esta tabla necesito una variable que me permita agrupar los datos /clasificarlos: NOMINAL

    Para calcular frecuencias absolutas (o relativa) necesito una variable NOMINAL!
    Para calcular frecuencias acumuladas necesito una variable ORDINAL!
    Puedo calcularlo sin una variable ordinal? Sí, pero no tiene sentido!
                                                Matemáticamente sí
                                                Estadísticamente no

2- Representar los datos de forma gráfica: (Si quiero representar 1 variable)
   - Barras / Lineas / Area         NOMINAL
   - Sectores(tarta, circular)      NOMINAL
   - Boxplot                        ORDINAL
   - Histograma                     CUANTITATIVA

3- Resumir los datos aún más.. a un número!
   - Medidas de posición: Cuartiles, Percentiles
   - Medidas de tendencia central (Por donde van los tiros): 
     - Media                           CUANTITATIVA   |  Nunca nunca puedo dar una medida de tendencia central
     - Mediana                         ORDINAL        |  sin dar su correspondiente medida de dispersión
     - Moda                            NOMINAL
   - Medidas de dispersión: (Cuánto cambian las cosas con respecto al por donde van los tiros)
     - Desviación típica               CUANTITATIVA
     - Rango intercuartílico           ORDINAL
   - Medidas de Asimetría              CUANTITATIVA
   - Curtosis                          CUANTITATIVA


ESTO LO DICE LA ESTADÍSTICA!
- MEDIA > Desviación típica
- MEDIANA > Rango intercuartílico

De lo contrario llevas a equívocos!

   En el banco tengo 2000 personas de 2000€ / mes y otras 2000 personas de 8000€ / mes.
   La media sería: 5000€ / mes
   Pregunta: Este dato es representativo de la realidad del banco? NO ES REPRESENTATIVO DE LA REALIDAD
      Por qué? Porque la mayoría de las personas no gana 5000€ / mes.
      Es un dato correcto desde el punto de vista matemático es correcto.

   MEDIA = 5000€ / mes con una desviación típica de 3000€.
   COMO SE INTERPRETA ESO? Se interpreta según la ley de Chebyshev:
      Abriendo un rango de 1 desviación típica alrededor de la media [2000€, 8000€] obtengo un intervalo
      donde tengo garantizado que están al menos el 50% de los datos.
      Dicho de otra forma, el intervalo más representativo donde está la mayor parte de los datos es [2000€, 8000€].

   Salario son 1500€ con una desv. tipica de 500: [1000€, 2000€] está la mayor parte de la gente.
   Salario son 1500€ con una desv. tipica de 100: [1400€, 1600€] está la mayor parte de la gente.

   En el banco A tengo 2000 personas de 2000€ / mes y otras 2000 personas de 8000€ / mes.
      Media? 5000€ / mes
   En el banco B tengo 4000 personas de 5000€ / mes
      Media? 5000€ / mes


---
Cuando trabajamos con SAS, podemos extraer datos de:
- Ficheros EXCEL
- Ficheros TXT o CSV
- Ficheros SAS (sas7bdat)
- BBDD (Oracle)

BENEFICIO POTENCIAL DE USAR SQL para extraer datos:
Tenemos un lenguaje que se llama SAS BASE.
Hay un lenguaje extendido que se llama SAS SQL:
```sas
PROC SQL;
   SELECT * FROM DATOS
   ORDER BY SALARIO;
QUIT;
```

Cuando los datos provienen de una BBDD, el lenguaje SQL puede ser más eficiente que SAS BASE.
Especialmente si tenemos ORDER BY (y otras palabras malignas de SQL: UNION, GROUP BY, DISTINCT, etc. - todas estas se basan en un ORDENAMIENTO de los datos).

Las BBDD saben muy bien que las ordenaciones MATAN el rendimiento TOTALMENTE!
Y por eso cuando trabajamos con BBDD usamos INDICES.

Qué es un índice? Es una COPIA PREORDENADA DE LOS DATOS.
