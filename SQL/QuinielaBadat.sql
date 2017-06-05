CREATE DATABASE Quinielas

GO

USE Quinielas

GO

CREATE TABLE Temporadas
(
	ID INT NOT NULL,
	Numero INT NOT NULL,

	CONSTRAINT PK_Temporadas PRIMARY KEY (ID)
)



GO

CREATE TABLE Jornadas
(
	ID INT NOT NULL,
	Fecha DATE NOT NULL,
	IDTemporada INT

	CONSTRAINT PK_Jornadas PRIMARY KEY (ID),
	CONSTRAINT FK_Jornadas_Temporadas FOREIGN KEY (IDTemporada) REFERENCES Temporadas (ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Sorteos
(
	ID INT NOT NULL,
	Estado BIT NOT NULL,

	CONSTRAINT PK_Sorteo PRIMARY KEY (ID)
)

GO
CREATE TABLE Boletos
(
	ID INT NOT NULL,
	IDJornada INT NOT NULL,
	IDSorteo INT NOT NULL,
	NumeroApuestas INT NOT NULL,

	CONSTRAINT PK_Boletos PRIMARY KEY (ID), -- Pensar m�s atributos
	CONSTRAINT FK_Boletos_Jornadas FOREIGN KEY (IDJornada) REFERENCES Jornadas (ID) ON UPDATE CASCADE ON DELETE NO ACTION,
	CONSTRAINT FK_Boletos_Sorteos FOREIGN KEY (IDSorteo) REFERENCES Sorteos (ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

GO


CREATE TABLE Partidos
(
	ID INT NOT NULL,
	Equipo1 VARCHAR (50) NOT NULL,
	Equipo2 VARCHAR (50) NOT NULL,
	Resultado VARCHAR (3) NULL,
	IDJornada INT NOT NULL,
	
	CONSTRAINT PK_Partidos PRIMARY KEY (ID),
	CONSTRAINT FK_Partidos_Jornadas FOREIGN KEY (IDJornada) REFERENCES Jornadas (ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

GO


GO

CREATE TABLE Apuestas
(
	ID INT NOT NULL,
	IDBoleto INT NOT NULL,
	Valor DECIMAL (6,2) NOT NULL,
	Tipo VARCHAR (7) NOT NULL,
	Prediccion1 VARCHAR (3) NOT NULL,
	Prediccion2 VARCHAR (3) NOT NULL,
	Prediccion3 VARCHAR (3) NOT NULL,
	Prediccion4 VARCHAR (3) NOT NULL,
	Prediccion5 VARCHAR (3) NOT NULL,
	Prediccion6 VARCHAR (3) NOT NULL,
	Prediccion7 VARCHAR (3) NOT NULL,
	Prediccion8 VARCHAR (3) NOT NULL,
	Prediccion9 VARCHAR (3) NOT NULL,
	Prediccion10 VARCHAR (3) NOT NULL,
	Prediccion11 VARCHAR (3) NOT NULL,
	Prediccion12 VARCHAR (3) NOT NULL,
	Prediccion13 VARCHAR (3) NOT NULL,
	Prediccion14 VARCHAR (3) NOT NULL,
	PrediccionPleno VARCHAR (4) NOT NULL,

	CONSTRAINT PK_Apuesta PRIMARY KEY (ID, IDBoleto),
	CONSTRAINT FK_Apuestas_Boletos FOREIGN KEY (IDBoleto) REFERENCES Boletos (ID) ON UPDATE CASCADE ON DELETE CASCADE
)

GO

CREATE TABLE Boletos_Partidos
(
	IDBoleto INT NOT NULL,
	IDPartido INT NOT NULL,

	CONSTRAINT PK_Boletos_Partidos PRIMARY KEY (IDBoleto, IDPartido),
	CONSTRAINT FK_Boletos_Partidos_Boletos FOREIGN KEY (IDBoleto) REFERENCES Boletos (ID) ON UPDATE CASCADE ON DELETE NO ACTION,
	CONSTRAINT FK_Boletos_Partidos_Partidos FOREIGN KEY (IDPartido) REFERENCES Partidos (ID) ON UPDATE NO ACTION ON DELETE NO ACTION --Cambiar estos dos update y cascade
)

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Tipo CHECK (Tipo IN ('Simple', 'Multiple'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion1 CHECK (Prediccion1 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion2 CHECK (Prediccion2 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion3 CHECK (Prediccion3 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion4 CHECK (Prediccion4 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion5 CHECK (Prediccion5 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion6 CHECK (Prediccion6 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion7 CHECK (Prediccion7 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion8 CHECK (Prediccion8 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion9 CHECK (Prediccion9 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion10 CHECK (Prediccion10 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion11 CHECK (Prediccion11 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion12 CHECK (Prediccion12 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion13 CHECK (Prediccion13 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion14 CHECK (Prediccion14 IN ('1', 'X', '2', '1X', '12', 'X2', '1X2'))
ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Prediccion15 CHECK (PrediccionPleno IN ('0', '1', '2', 'M', '01', '02', '0M', 
																									'12', '1M', '2M', '012', '01M', '12M', '012M'))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud1 CHECK ((Tipo = 'Simple' AND LEN (Prediccion1) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion1) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud2 CHECK ((Tipo = 'Simple' AND LEN (Prediccion2) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion2) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud3 CHECK ((Tipo = 'Simple' AND LEN (Prediccion3) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion3) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud4 CHECK ((Tipo = 'Simple' AND LEN (Prediccion4) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion4) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud5 CHECK ((Tipo = 'Simple' AND LEN (Prediccion5) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion5) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud6 CHECK ((Tipo = 'Simple' AND LEN (Prediccion6) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion6) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud7 CHECK ((Tipo = 'Simple' AND LEN (Prediccion7) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion7) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud8 CHECK ((Tipo = 'Simple' AND LEN (Prediccion8) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion8) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud9 CHECK ((Tipo = 'Simple' AND LEN (Prediccion9) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion9) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud10 CHECK ((Tipo = 'Simple' AND LEN (Prediccion10) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion10) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud11 CHECK ((Tipo = 'Simple' AND LEN (Prediccion11) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion11) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud12 CHECK ((Tipo = 'Simple' AND LEN (Prediccion12) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion12) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud13 CHECK ((Tipo = 'Simple' AND LEN (Prediccion13) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion13) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_Longitud14 CHECK ((Tipo = 'Simple' AND LEN (Prediccion14) = 1) 
																	OR (Tipo = 'Multiple' AND LEN (Prediccion14) IN (2, 3)))

ALTER TABLE Apuestas ADD CONSTRAINT CK_Apuestas_LongitudPleno CHECK ((Tipo = 'Simple' AND LEN (PrediccionPleno) = 1)
																	OR (Tipo = 'Multiple' AND LEN (PrediccionPleno) IN (2, 3, 4)))

ALTER TABLE Boletos ADD CONSTRAINT CK_Boletos_NumeroApuesta CHECK (NumeroApuesta > 0 AND NumeroApuesta < 9)

GO

CREATE TRIGGER numeroApuestas ON Apuestas
AFTER INSERT AS

IF EXISTS (SELECT I.Tipo
				FROM inserted AS I
				INNER JOIN
				Boletos AS B
				ON I.IDBoleto = B.ID
				WHERE B.NumeroApuestas > 1 AND I.Tipo = 'Multiple')
BEGIN
	ROLLBACK
END

GO