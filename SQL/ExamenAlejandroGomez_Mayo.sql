USE LeoFest

GO
/* 1. Escribe un procedimiento almacenado que de de baja a una banda, actualizando su fecha de disoluci�n y fecha
de abandono de todos sus componentes actuales. La fecha de disoluci�n y el ID de la banda se pasar�n por par�metros. Si no se
especifica fecha, se tomar� la actual.*/

BEGIN TRANSACTION

GO

CREATE PROCEDURE darBajaBanda
	@IDBanda SMALLINT,
	@FechaDisolucion DATE = NULL

AS
	BEGIN
	
		IF @FechaDisolucion IS NULL
		BEGIN
			SET @FechaDisolucion = CAST (CURRENT_TIMESTAMP AS DATE)	
		END

			BEGIN TRANSACTION

			UPDATE LFMusicosBandas
			SET FechaAbandono = @FechaDisolucion
			WHERE IDBanda = @IDBanda

			COMMIT TRANSACTION

			BEGIN TRANSACTION

			UPDATE LFBandas
			SET FechaDisolucion = @FechaDisolucion
			WHERE ID = @IDBanda

			COMMIT TRANSACTION

	END

--ROLLBACK
COMMIT TRANSACTION

BEGIN TRANSACTION


EXECUTE darBajaBanda 1

--ROLLBACK
COMMIT TRANSACTION

-- Utilizo transacciones al crear el procedimiento y al ejecutarlo para hacer pruebas sin alterar la base de datos.

GO

/* 2. Escribe una funci�n que reciba como par�metro un a�o y nos devuelva una tabla indicando cuantas canciones (temas) de 
cada estilo se han cantado en los distintos festivales celebrados a lo largo de ese a�o, el mismo dato para el a�o 
inmediatamente anterior y una cuarta columna en la que aparezca un s�mbolo "+� si ha aumentado el n�mero de canciones 
de ese estilo respecto al a�o anterior, un "-� si ha disminuido y un "=� si no var�a.

El resultado tendr� cuatro columnas: Estilo, n�mero de interpretaciones de ese estilo en el a�o anterior, n�mero de 
interpretaciones de ese estilo en el a�o que nos piden y s�mbolo que indique aumento o disminuci�n.

Puedes hacer otras funciones auxiliares a las que llames, pero no declarar vistas.*/

GO

/* Breve comentario: Funcionalidad que calcula el numero de interpretaciones del a�o anterior
   Entradas: Ninguna
   Salidas: Una tabla*/

CREATE FUNCTION NumeroInterpretacionesA�oAnterior ()
RETURNS @resultado TABLE (
							numeroInterpretaciones INT,
							Estilo VARCHAR (30)
						 )
AS

	BEGIN
		
		INSERT INTO @resultado (numeroInterpretaciones, Estilo)
		SELECT COUNT (IDTema), T.IDEstilo
			FROM LFTemas AS T 
			INNER JOIN
			LFTemasBandasEdiciones AS TBE
			ON TBE.IDTema = T.ID
			INNER JOIN
			LFEdiciones AS E
			ON TBE.IDFestival = E.IDFestival AND TBE.Ordinal = E.Ordinal
			WHERE FechaHoraInicio BETWEEN DATEFROMPARTS (((YEAR (CURRENT_TIMESTAMP)) - 1), 1, 1) 
			AND DATEFROMPARTS (((YEAR (CURRENT_TIMESTAMP)) - 1), 12, 31) -- Entre el primer dia del a�o anterior y el ultimo
			GROUP BY T.IDEstilo
			ORDER BY T.IDEstilo

		RETURN

	END

GO

/* Breve comentario: Funcionalidad que calcula el numero de interpretaciones de un a�o concreto
   Entradas: El a�o deseado (INT)
   Salidas: Una tabla*/

CREATE FUNCTION NumeroInterpretacionesA�oConcreto (@A�o INT)
RETURNS @resultado TABLE (
							numeroInterpretaciones INT,
							Estilo VARCHAR (30)
						 )
AS

	BEGIN
		
		INSERT INTO @resultado (numeroInterpretaciones, Estilo)
		SELECT COUNT (IDTema), T.IDEstilo
			FROM LFTemas AS T 
			INNER JOIN
			LFTemasBandasEdiciones AS TBE
			ON TBE.IDTema = T.ID
			INNER JOIN
			LFEdiciones AS E
			ON TBE.IDFestival = E.IDFestival AND TBE.Ordinal = E.Ordinal
			WHERE FechaHoraInicio BETWEEN DATEFROMPARTS (@A�o, 1, 1) 
			AND DATEFROMPARTS (@A�o, 12, 31) -- Entre el primer dia del a�o deseado y el ultimo
			GROUP BY T.IDEstilo
			ORDER BY T.IDEstilo

		RETURN

	END

GO

/* Breve comentario: Funcionalidad que calcula indica el simbolo de aumento
   Entradas: Ninguna
   Salidas: Una tabla*/

CREATE FUNCTION simboloAumento ()
RETURNS @resultado TABLE (
							Simbolo CHAR (1),
							Estilo VARCHAR (30)
						 )
AS

	BEGIN
	DECLARE @Estilo INT

	SET @Estilo = 1

	WHILE (@Estilo IN (SELECT ID
						FROM LFEstilos)) --Mientras queden estilos existentes

	BEGIN

	-- Sacamos todos los s�mbolos dependiendo de si la diferencia es mayor, menor o igual

		-- Menor
		IF ((SELECT numeroInterpretaciones 
				FROM dbo.NumeroInterpretacionesA�oAnterior () 
				WHERE Estilo = @Estilo)
				> 
				(SELECT numeroInterpretaciones 
					FROM dbo.NumeroInterpretacionesA�oConcreto (YEAR (CURRENT_TIMESTAMP))
					WHERE Estilo = @Estilo))

			BEGIN
		
				INSERT INTO @resultado (Simbolo, Estilo)
				SELECT DISTINCT '-', IDEstilo
					FROM LFTemas
					ORDER BY IDEstilo

			END

			-- Mayor
		ELSE IF ((SELECT numeroInterpretaciones 
				FROM dbo.NumeroInterpretacionesA�oAnterior () 
				WHERE Estilo = @Estilo)
				< 
				(SELECT numeroInterpretaciones 
					FROM dbo.NumeroInterpretacionesA�oConcreto (YEAR (CURRENT_TIMESTAMP))
					WHERE Estilo = @Estilo))

			BEGIN
		
				INSERT INTO @resultado (Simbolo, Estilo)
				SELECT DISTINCT '+', IDEstilo
					FROM LFTemas
					ORDER BY IDEstilo

			END

			-- Igual
			ELSE

			BEGIN
		
				INSERT INTO @resultado (Simbolo, Estilo)
				SELECT DISTINCT '=', IDEstilo
					FROM LFTemas
					ORDER BY IDEstilo

			END

	SET @Estilo = @Estilo + 1 --Aumentar el contador de estilo

	END
			

		RETURN

	END

GO


-- Funcion principal

CREATE FUNCTION tablaCanciones (@A�o INT)
RETURNS @resultado TABLE (
							Estilo VARCHAR (30),
							NumeroInterpretacionesA�oAnterior INT,
							NumeroInterpretacionesA�oConcreto INT,
							Simbolo CHAR (1)
						) 
AS

	BEGIN

		INSERT INTO @resultado (Estilo, NumeroInterpretacionesA�oAnterior, NumeroInterpretacionesA�oConcreto, Simbolo)
		SELECT E.Estilo, NAA.numeroInterpretaciones, NAC.numeroInterpretaciones, S.Simbolo
			FROM LFEstilos AS E
			LEFT JOIN
			NumeroInterpretacionesA�oAnterior () AS NAA
			ON E.ID = NAA.Estilo
			LEFT JOIN
			NumeroInterpretacionesA�oConcreto (@A�o) AS NAC
			ON E.Estilo = NAC.Estilo
			LEFT JOIN
			simboloAumento () AS S
			ON E.Estilo = S.Estilo

		RETURN
	END

GO

SELECT * FROM dbo.tablaCanciones (2016)


SELECT * FROM dbo.NumeroInterpretacionesA�oAnterior () -- Prueba funcionalidad NumeroInterpretacionesA�oAnterior
SELECT * FROM dbo.NumeroInterpretacionesA�oConcreto (2017) -- Prueba funcionalidad NumeroInterpretacionesA�oConcreto
SELECT * FROM dbo.simboloAumento () -- Prueba funcionalidad simboloAumento. Me da fallo, por lo que sospecho son los JOIN.


/* 3. Escribe un procedimiento TemaEjecutado y anote en la tabla LFBandasEdiciones que una banda ha interpretado ese 
tema en una edici�n concreta de un festival.

Los datos de entrada son: Titulo, IDAutor, Estilo (nombre del estilo), Duracion, El Id de un festival, el ordinal de la 
edici�n, el ID de una banda y una fecha/hora.

Si el tema es nuevo y no est� dado de alta en la base de datos, se insertar� en la tabla correspondiente. 
Si el estilo no existe, tambi�n se dar� de alta.*/

BEGIN TRANSACTION

GO

CREATE PROCEDURE TemaEjecutado
	@Titulo VARCHAR (120),
	@IDAutor INT,
	@Estilo VARCHAR (30),
	@Duracion TIME,
	@IDFestival INT,
	@Ordinal TINYINT,
	@IDBanda SMALLINT

AS

	BEGIN

		-- Si el estilo introducido no existe, lo creamos

		IF NOT EXISTS (SELECT ID
						  FROM LFEstilos
						  WHERE Estilo = @Estilo)

				BEGIN

					BEGIN TRANSACTION
					
					INSERT INTO LFEstilos (ID, Estilo)
					VALUES ((SELECT TOP 1 ID
								FROM LFEstilos
								ORDER BY ID DESC) + 1, @Estilo) --Insertamos el estilo nuevo siguiendo el orden de ID ya establecido. Puesto que no es identity hay que hacerlo a mano.

					COMMIT TRANSACTION

				END

		-- Si el tema introducido no existe, lo creamos.

		IF NOT EXISTS (SELECT ID
						FROM LFTemas
						WHERE Titulo = @Titulo)

				BEGIN

					BEGIN TRANSACTION

					INSERT INTO LFTemas (ID, Titulo, IDAutor, IDEstilo, Duracion)
					VALUES (NEWID (), @Titulo, @IDAutor, (SELECT ID
															FROM LFEstilos
															WHERE Estilo = @Estilo), @Duracion) -- Utilizo el NEWID () ya que la clave primera de LFTemas es un Uniqueidentifier.

					COMMIT TRANSACTION

				END

		-- A continuaci�n comprobamos el caso en el que si exista la canci�n pero el estilo no, asignandole el estilo el Tema en caso de que no lo tenga.
		IF NOT EXISTS (SELECT IDEstilo
							FROM LFTemas
							WHERE Titulo = @Titulo)
					BEGIN

						BEGIN TRANSACTION

						UPDATE LFTemas
						SET IDEstilo = (SELECT ID
											FROM LFEstilos
											WHERE Estilo = @Estilo)
						WHERE Titulo = @Titulo

						COMMIT TRANSACTION

					END

		BEGIN TRANSACTION

		INSERT INTO LFTemasBandasEdiciones (IDBanda, IDFestival, Ordinal, IDTema)
		VALUES (@IDBanda, @IDFestival, @Ordinal, (SELECT ID
													FROM LFTemas
													WHERE Titulo = @Titulo))

		COMMIT TRANSACTION

	END

ROLLBACK
COMMIT TRANSACTION

GO

BEGIN TRANSACTION

EXECUTE TemaEjecutado 'Never gonna give you up', 1, 'Swing', '3:40', 1, 1, 1

ROLLBACK
COMMIT TRANSACTION

/* 4. Escribe un procedimiento almacenado que actualice la columna cach� de la tabla LFBandas de acuerdo a las siguientes reglas:

Se computar�n 105 � por cada miembro activo de la banda
Se a�adir�n 170 � por cada actuaci�n en los tres a�os anteriores
Esa cantidad se incrementar� un 5% si la banda toca alguno de los estilos Rock, Flamenco, Jazz o Blues y se 
decrementar� un 50% si toca Reggaeton o Hip-Hop*/

GO

/* Breve comentario: Esta funcion se encarga de calcular el c�mputo correspondiente al numero de miembros activos en la banda.
   Entradas: El ID de la banda (SMALLINT)
   Salidas: El dinero correspondiente (SMALLMONEY)*/

CREATE FUNCTION miembrosActivos (@IDBanda SMALLINT)
RETURNS SMALLMONEY AS

	BEGIN
		DECLARE @Resultado SMALLMONEY

		SELECT @Resultado = (COUNT (IDMusico)) * 105
			FROM LFMusicosBandas
			WHERE IDBanda = @IDBanda AND (FechaAbandono IS NULL) -- Los miembros deben de estar activos, por lo tanto no tienen FechaAbandono

		RETURN @Resultado

	END

GO

/* Breve comentario: Esta funcion se encarga de calcular el c�mputo correspondiente al numero de actuaciones en los ultimos 3 a�os.
   Entradas: El ID de la banda (SMALLINT)
   Salidas: El dinero correspondiente (SMALLMONEY)*/

CREATE FUNCTION numeroActuaciones (@IDBanda SMALLINT)
RETURNS SMALLMONEY AS

	BEGIN
		DECLARE @Resultado SMALLMONEY

		SELECT @Resultado = (COUNT (IDBanda)) * 170
			FROM LFBandasEdiciones AS BE
			INNER JOIN
			LFEdiciones AS E
			ON BE.IDFestival = E.IDFestival AND BE.Ordinal = E.Ordinal
			WHERE IDBanda = @IDBanda AND FechaHoraInicio BETWEEN CAST (CURRENT_TIMESTAMP AS SMALLDATETIME) 
			AND CAST (DATEFROMPARTS (((YEAR (CURRENT_TIMESTAMP)) - 3), MONTH (CURRENT_TIMESTAMP), DAY (CURRENT_TIMESTAMP)) AS SMALLDATETIME)
			-- Utilizo DATEFROMPARTS para conseguir la fecha de 3 a�os antes de la actual.

		RETURN @Resultado

	END

GO


CREATE PROCEDURE actualizarCache
	@IDBanda SMALLINT

AS

	BEGIN
	DECLARE @NuevoCache SMALLMONEY

	SET @NuevoCache = dbo.miembrosActivos (@IDBanda) -- A�adimos al resultado el dinero extra del numero de miembros activos.
	SET @NuevoCache = @NuevoCache + dbo.numeroActuaciones (@IDBanda) -- A�adimos al resultado el dinero extra del numero de actuaciones en los ultimos 3 a�os.

	-- Comprobamos si el estilo de la banda es alguno de estos 4 para a�adirle el porcentaje extra.

	IF EXISTS (SELECT *
				FROM LFBandasEstilos
				WHERE IDEstilo IN (SELECT ID
									 FROM LFEstilos
									 WHERE Estilo IN ('Rock', 'Flamenco', 'Jazz', 'Blues')))

			BEGIN

				SET @NuevoCache = @NuevoCache + ((@NuevoCache * 5)/100)

			END

	-- Comprobamos si el estilo de la banda es alguno de estos 2 para a�adirle el procentaje extra.

	IF EXISTS (SELECT *
				FROM LFBandasEstilos
				WHERE IDEstilo IN (SELECT ID
									 FROM LFEstilos
									 WHERE Estilo IN ('Reggaeton', 'Hip-Hop')))
									 
			BEGIN

				SET @NuevoCache = @NuevoCache - ((@NuevoCache * 50)/100)

			END

	BEGIN TRANSACTION

	UPDATE LFBandas
	SET CacheMinimo = @NuevoCache
	WHERE ID = @IDBanda

	COMMIT TRANSACTION

	END

GO

BEGIN TRANSACTION

EXECUTE actualizarCache 6

SELECT dbo.miembrosActivos(6) -- Ejemplo comprobando la funcionalidad miembrosActivos
SELECT dbo.numeroActuaciones (3) -- Ejemplo comprobando la funcionalidad numeroActuaciones

ROLLBACK
COMMIT TRANSACTION


SELECT * FROM LFBandas
SELECT * FROM LFBandasEstilos
SELECT * FROM LFMusicosBandas WHERE IDBanda = 6
SELECT * FROM LFBandasEdiciones WHERE IDFestival = 1 AND Ordinal = 9
SELECT * FROM LFEdiciones WHERE IDFestival = 1 AND Ordinal = 9
SELECT * FROM LFEstilos WHERE ID = 27
SELECT * FROM LFTemas
SELECT * FROM LFMusicos
SELECT * FROM LFFestivales
SELECT * FROM LFTemasBandasEdiciones
