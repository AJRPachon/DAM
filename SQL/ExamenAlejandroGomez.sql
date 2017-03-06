USE LeoMetro

GO

/* 1. Indica el n�mero de trenes de cada clase que pasan al d�a por cada estaci�n */

SELECT COUNT (T.ID) AS NumeroTrenes, T.Tipo, DAY (Momento) AS Dia, R.estacion
	FROM LM_Recorridos AS R
	INNER JOIN
	LM_Trenes AS T
	ON R.Tren = T.ID
	GROUP BY T.Tipo, DAY (R.Momento), R.estacion
	ORDER BY Dia, estacion, Tipo

/* 2. Inserta un nuevo tren */
BEGIN TRANSACTION

INSERT INTO LM_Trenes (ID, Matricula, Tipo, Capacidad, FechaEntraServicio) -- Siguiendo con la l�nea de los trenes ya introducidos, he introducido uno de caracter�sticas similares.
VALUES (114, '3294GPT', 2, 60, '2011-10-02')

--ROLLBACK
COMMIT TRANSACTION

/* 3. Actualiza la tabla LM_Recorridos para que el nuevo tren insertado haya hecho ayer (1 de marzo) 
los mismos recorridos que realiz� el tren 104 el 27 de febrero. */
GO

CREATE VIEW RecorridosACopiar AS
SELECT *
	FROM LM_Recorridos
	WHERE Tren = 104 AND DATEPART (DAY, Momento) = 27 AND DATEPART (MONTH, Momento) = 02

GO

BEGIN TRANSACTION

INSERT INTO LM_Recorridos (Tren, Linea, estacion, Momento)
SELECT 114, Linea, estacion, DATEADD (DAY, 2, Momento) -- Lo he hecho con un DATEADD porque he supuesto que la hora debe ser la misma
	FROM RecorridosACopiar

--ROLLBACK
COMMIT

/* 4. Calcula la media de kil�metros al d�a que hace cada tren. Considera �nicamente los d�as que ha estado en servicio */
GO

CREATE VIEW DistanciaPorTrenPorDia AS
SELECT SUM (I.Distancia) AS DistanciaRecorrida, R.Tren, DAY (R.Momento) AS Dia
	FROM LM_Recorridos AS R
	INNER JOIN
	LM_Estaciones AS E
	ON R.estacion = E.ID
	INNER JOIN
	LM_Itinerarios AS I
	ON E.ID = I.estacionIni OR E.ID = I.estacionFin
	GROUP BY R.Tren, DAY (R.Momento)

GO

SELECT CAST (AVG (DistanciaRecorrida)AS DECIMAL (12,2)) AS MediaDistanciaRecorrida, Tren, Dia -- He reducido el tama�o de los decimales con el CAST AS DECIMAL porque quedaban muchos 0 sin valor.
	FROM DistanciaPorTrenPorDia
	GROUP BY Tren, Dia
	ORDER BY Tren, Dia


/* Ejercicio corregido */
GO
CREATE VIEW pepejava AS
SELECT SUM (I.Distancia) AS DistanciaRecorrida, R.Tren, DAY (R.Momento) AS Dia
	FROM LM_Recorridos AS R
	INNER JOIN
	LM_Estaciones AS E
	ON R.estacion = E.ID
	INNER JOIN
	LM_Itinerarios AS I
	ON E.ID = I.estacionIni OR E.ID = I.estacionFin
	INNER JOIN
	LM_Recorridos AS R2
	ON R.Momento = R2.Momento
	INNER JOIN
	LM_Recorridos AS R3
	ON R2.Momento = R3.Momento
	GROUP BY R.Tren, DAY (R.Momento)

SELECT CAST (AVG (DistanciaRecorrida)AS DECIMAL (12,2)) AS MediaDistanciaRecorrida, Tren, Dia -- He reducido el tama�o de los decimales con el CAST AS DECIMAL porque quedaban muchos 0 sin valor.
	FROM pepejava
	GROUP BY Tren, Dia
	ORDER BY Tren, Dia

/* 5. Calcula cu�l ha sido el intervalo de tiempo en que m�s personas registradas han estado en el metro al mismo tiempo.
Considera intervalos de una hora (de 12:00 a 12:59, de 13:00 a 13:59, etc). Si hay varios momentos con el n�mero m�ximo de 
personas, muestra el m�s reciente.) */

GO

CREATE VIEW NumeroPasajerosPorHora AS
SELECT COUNT (IDPasajero) AS NumeroPasajeros, DATEPART (DAY, Momento) AS Dia, DATEPART (HOUR, Momento) AS Hora -- Donde cada hora significa el intervalo de la hora X:00 a X:59
	FROM LM_Pasajeros AS P
	INNER JOIN
	LM_Viajes AS V
	ON P.ID = V.IDPasajero
	INNER JOIN
	LM_Estaciones AS E
	ON V.IDEstacionEntrada = E.ID OR V.IDEstacionSalida = E.ID
	INNER JOIN
	LM_Recorridos AS R
	ON E.ID = R.estacion
	GROUP BY DATEPART(DAY, Momento), DATEPART (HOUR, Momento)

GO

CREATE VIEW MaxPasajeros AS
SELECT MAX (NumeroPasajeros) AS NumeroPasajerosMaximo
	FROM NumeroPasajerosPorHora

GO

SELECT NumeroPasajerosMaximo,Dia, Hora
	FROM MaxPasajeros AS [MAX]
	INNER JOIN
	NumeroPasajerosPorHora AS PPH
	ON [MAX].NumeroPasajerosMaximo = PPH.NumeroPasajeros
