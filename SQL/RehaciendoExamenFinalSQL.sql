USE LeoFest

GO

/*
Ejercicio 1
Escribe un procedimiento almacenado que d� de baja a una banda, actualizando su fecha de disoluci�n y 
la fecha de abandono de todos sus componentes actuales. La fecha de disoluci�n y el ID de la banda se pasar�n como par�metros. 
Si no se especifica fecha, se tomar� la actual.
*/

CREATE PROCEDURE bajaBanda
	@IDBanda SMALLINT,
	@FechaDisolucion DATE = NULL

AS
	BEGIN
		IF (@FechaDisolucion IS NULL)
		BEGIN
			SET @FechaDisolucion = CAST (CURRENT_TIMESTAMP AS DATE)
		END

		BEGIN TRANSACTION

		UPDATE LFMusicosBandas
		SET FechaAbandono = @FechaDisolucion
		WHERE IDBanda = @IDBanda

		UPDATE LFBandas
		SET FechaDisolucion = @FechaDisolucion
		WHERE ID = @IDBanda

		COMMIT TRANSACTION
	END

/*
Ejercicio 2
Escribe una funci�n que reciba como par�metro un a�o y nos devuelva una tabla indicando cuantas canciones (temas) 
de cada estilo se han cantado en los distintos festivales celebrados a lo largo de ese a�o, el mismo dato para el a�o 
inmediatamente anterior y una cuarta columna en la que aparezca un s�mbolo "+� si ha aumentado el n�mero de canciones 
de ese estilo respecto al a�o anterior, un "-� si ha disminuido y un "=� si no var�a.

El resultado tendr� cuatro columnas: Estilo, n�mero de interpretaciones de ese estilo en el a�o anterior, 
n�mero de interpretaciones de ese estilo en el a�o que nos piden y s�mbolo que indique aumento o disminuci�n.

Puedes hacer otras funciones auxiliares a las que llames, pero no declarar vistas.
*/



/*
Ejercicio 3
Escribe un procedimiento TemaEjecutado y anote en la tabla LFBandasEdiciones que una banda ha interpretado ese tema en una 
edici�n concreta de un festival.

Los datos de entrada son: Titulo, IDAutor, Estilo (nombre del estilo), Duracion, El Id de un festival, el ordinal de la edici�n y 
el ID de una banda.

Si el tema es nuevo y no est� dado de alta en la base de datos, se insertar� en la tabla correspondiente. Si el estilo no existe, 
tambi�n se dar� de alta.
*/
GO

CREATE PROCEDURE TemaEjecutado2
	@Titulo VARCHAR (120),
	@IDAutor INT,
	@Estilo VARCHAR (30),
	@Duracion TIME (7),
	@IDFestival INT,
	@Ordinal TINYINT,
	@IDBanda SMALLINT
AS
	BEGIN
		BEGIN TRANSACTION

			IF NOT EXISTS (SELECT ID
							  FROM LFTemas
							  WHERE Titulo = @Titulo)
			BEGIN
				IF NOT EXISTS (SELECT ID FROM LFEstilos WHERE Estilo = @Estilo)
				BEGIN
					INSERT INTO LFEstilos (ID, Estilo)
					VALUES ((SELECT MAX (ID) + 1 
								FROM LFEstilos), @Estilo)
				END

				INSERT INTO LFTemas (ID,Titulo, IDAutor, IDEstilo, Duracion)
				VALUES (NEWID (), @Titulo, @IDAutor, (SELECT ID FROM LFEstilos WHERE Estilo = @Estilo), @Duracion)
			END

			INSERT INTO LFTemasBandasEdiciones(IDBanda, IDFestival, Ordinal, IDTema)
			VALUES (@IDBanda, @IDFestival, @Ordinal, (SELECT ID FROM LFTemas WHERE Titulo = @Titulo))

		COMMIT TRANSACTION
	END


/*
Ejercicio 4
Escribe un procedimiento almacenado que actualice la columna cach� de la tabla LFBandas de acuerdo a las siguientes reglas:

Se computar�n 105 � por cada miembro activo de la banda
Se a�adir�n 170 � por cada actuaci�n en los tres a�os anteriores
Esa cantidad se incrementar� un 5% si la banda toca alguno de los estilos Rock, Flamenco, Jazz o Blues y se 
decrementar� un 50% si toca Reggaeton o Hip-Hop
Nota: Valora la posibilidad de dise�ar funciones para comprobar las condiciones.
*/

