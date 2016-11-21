CREATE DATABASE BienalFlamenco1
GO
USE BienalFlamenco1
GO

CREATE TABLE empresas
(
	CIF SMALLINT,
	Nombre NVARCHAR (20) UNIQUE,
	Direcci�n NVARCHAR (30),

	CONSTRAINT PK_empresas Primary Key (CIF),
)

GO

CREATE TABLE trabajadores
(
	DNI SMALLINT,
	Nombre NVARCHAR (20) UNIQUE,
	Trabajo NVARCHAR (20),
)