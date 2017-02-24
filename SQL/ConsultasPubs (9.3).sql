USE pubs

GO


-- 1.T�tulo y tipo de todos los libros en los que alguno de los autores vive en California (CA).

SELECT T.title, T.[type]
	FROM titles AS T
	INNER JOIN
	titleauthor AS TA
	ON T.title_id = TA.title_id
	INNER JOIN
	authors AS A
	ON TA.au_id = A.au_id
	WHERE A.[state] = 'CA'

-- 2. T�tulo y tipo de todos los libros en los que ninguno de los autores vive en California (CA).

SELECT T.title, T.[type]
	FROM titles AS T
	INNER JOIN
	titleauthor AS TA
	ON T.title_id = TA.title_id
	INNER JOIN
	authors AS A
	ON TA.au_id = A.au_id

EXCEPT

SELECT T.title, T.[type]
	FROM titles AS T
	INNER JOIN
	titleauthor AS TA
	ON T.title_id = TA.title_id
	INNER JOIN
	authors AS A
	ON TA.au_id = A.au_id
	WHERE A.[state] = 'CA'

-- 3. N�mero de libros en los que ha participado cada autor, incluidos los que no han publicado nada.

SELECT COUNT (TA.title_id) NumeroLibros, A.au_fname, A.au_lname
	FROM authors AS A
	LEFT JOIN
	titleauthor AS TA
	ON A.au_id = TA.au_id
	GROUP BY A.au_fname, A.au_lname

-- 4. N�mero de libros que ha publicado cada editorial, incluidas las que no han publicado ninguno.

SELECT COUNT (T.title_id) AS NumeroLibros, P.pub_name
	FROM publishers AS P
	LEFT JOIN
	titles AS T
	ON P.pub_id = T.pub_id
	GROUP BY P.pub_name

-- 5. N�mero de empleados de cada editorial.

SELECT COUNT (E.emp_id) AS NumeroEmpleados, P.pub_name
	FROM publishers AS P
	INNER JOIN
	employee AS E
	ON P.pub_id = E.pub_id
	GROUP BY pub_name

-- 6. Calcular la relaci�n entre n�mero de ejemplares publicados y n�mero de empleados de cada editorial, incluyendo el nombre de la misma.
GO

CREATE VIEW NumeroLibros AS
SELECT COUNT (T.title_id) AS NumeroLibros, P.pub_id
	FROM titles as T
	RIGHT JOIN
	publishers AS P
	ON T.pub_id = P.pub_id
	GROUP BY P.pub_id

GO

CREATE VIEW NumeroEmpleados AS
SELECT COUNT (E.emp_id) AS NumeroEmpleados, E.pub_id
	FROM employee as E
	INNER JOIN
	publishers AS P
	ON E.pub_id = P.pub_id
	GROUP BY E.pub_id

GO

SELECT P.pub_name, NL.NumeroLibros, NE.NumeroEmpleados, (CAST ((NL.NumeroLibros) AS DECIMAL (4,2))/CAST ((NE.NumeroEmpleados) AS DECIMAL (4,2))) AS Relacion
	FROM Publishers as P
	INNER JOIN
	NumeroLibros AS NL
	ON P.pub_id = NL.pub_id
	INNER JOIN
	NumeroEmpleados AS NE
	ON P.pub_id = NE.pub_id

-- 7. Nombre, Apellidos y ciudad de todos los autores que han trabajado para la editorial "Binnet & Hardley� o "Five Lakes Publishing�

SELECT A.au_fname, A.au_lname, A.city
	FROM authors AS A
	INNER JOIN
	titleauthor AS TA
	ON A.au_id = TA.au_id
	INNER JOIN
	titles AS T
	ON TA.title_id = T.title_id
	INNER JOIN
	publishers AS P
	ON T.pub_id = P.pub_id
	WHERE P.pub_name IN ('Binnet & Hardley', 'Five Lakes Publishing')

-- 8. Empleados que hayan trabajado en alguna editorial que haya publicado alg�n libro en el que alguno de los autores fuera Marjorie Green o Michael O'Leary.

SELECT DISTINCT E.fname, E.lname
	FROM employee as E
	INNER JOIN
	publishers AS P
	ON E.pub_id = P.pub_id
	INNER JOIN
	titles AS T
	ON P.pub_id = T.pub_id
	INNER JOIN
	titleauthor AS TA
	ON T.title_id = TA.title_id
	INNER JOIN
	authors AS A
	ON TA.au_id = A.au_id
	WHERE (A.au_fname = 'Marjorie' AND A.au_lname = 'Green') OR (A.au_fname = 'Michael' AND A.au_lname = 'O''Leary')

-- 9. N�mero de ejemplares vendidos de cada libro, especificando el t�tulo y el tipo.

SELECT (S.qty) AS NumeroEjemplaresVendidos
	FROM titles as T
	INNER JOIN
	sales AS S
	ON T.title_id = S.title_id

-- 10.  N�mero de ejemplares de todos sus libros que ha vendido cada autor.
-- 11.  N�mero de empleados de cada categor�a (jobs).
-- 12.  N�mero de empleados de cada categor�a (jobs) que tiene cada editorial, incluyendo aquellas categor�as en las que no haya ning�n empleado.
-- 13.  Autores que han escrito libros de dos o m�s tipos diferentes
-- 14.  Empleados que no trabajan en editoriales que han publicado libros cuya columna notes contenga la palabra "and�