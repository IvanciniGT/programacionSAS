/* Derivado de Introducción.sas (IvanciniGT/programacionSAS) */

PROC FORMAT;
value rangosEdad
1 = 'Joven'
2 = 'Adulto'
3 = 'Tercera edad';
RUN;

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

/* Al declarar una tabla nueva puedo ponerle DROPs, KEEPs y RENAMEs */
DATA personasMayores personasMenores(DROP=edad RENAME=(nombre=persona));

SET personas;
IF edad <=20 THEN rangoEdad = 1;
ELSE IF edad > 20 AND edad <=70 THEN rangoEdad = 2;
ELSE rangoEdad = 3;

/* FILTRO */
IF rangoEdad > 1 THEN DO;
		OUTPUT personasMayores;
	END;
ELSE OUTPUT personasMenores;

FORMAT rangoEdad rangosEdad.;
RUN;

PROC PRINT DATA=personasMayores;
RUN;
PROC PRINT DATA=personasMenores;
RUN;
