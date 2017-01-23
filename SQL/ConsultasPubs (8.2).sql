USE pubs

GO

--1. Numero de libros que tratan de cada tema

SELECT COUNT (title_id) AS NumeroLibros, [type]
	FROM titles
	GROUP BY [type]

--2. N�mero de autores diferentes en cada ciudad y estado

SELECT DISTINCT COUNT (au_id) AS NumeroAutores, city, [state]
	FROM authors
	GROUP BY city, [state]

--3. Nombre, apellidos, nivel y antig�edad en la empresa de los empleados con un nivel entre 100 y 150.

SELECT fname, lname, job_lvl, YEAR (CURRENT_TIMESTAMP - hire_date)-1900 AS AntiguedadA�os
	FROM employee
	GROUP BY emp_id, job_lvl, fname, lname, hire_date
	HAVING job_lvl BETWEEN 100 AND 150

--4. N�mero de editoriales en cada pa�s. Incluye el pa�s.

SELECT COUNT (pub_id) AS NumeroEditoriales, country
	FROM publishers
	GROUP BY country


--5. N�mero de unidades vendidas de cada libro en cada a�o (title_id, unidades y a�o).

SELECT COUNT (ord_num) AS UnidadesVendidas, title_id, YEAR (ord_date) AS A�o
	FROM sales
	GROUP BY ord_date, title_id, ord_date

--6. N�mero de autores que han escrito cada libro (title_id y numero de autores).

SELECT title_id, COUNT (au_id) AS NumeroAutores
	FROM titleauthor
	GROUP BY title_id

/* 7. ID, Titulo, tipo y precio de los libros cuyo adelanto inicial (advance) tenga un valor superior a $7.000, 
   ordenado por tipo y t�tulo */

SELECT title_id, title, [type], price
	FROM titles
	GROUP BY title_id, title, [type], price, advance
	HAVING advance > 7000
	ORDER BY [type], title