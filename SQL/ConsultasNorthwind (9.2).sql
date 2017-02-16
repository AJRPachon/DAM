USE Northwind

GO

-- 1. N�mero de clientes de cada pa�s.

SELECT COUNT (CustomerID) AS NumeroClientes, Country
	FROM Customers
	GROUP BY Country

-- 2. N�mero de clientes diferentes que compran cada producto.

SELECT /* DISTINCT */COUNT (DISTINCT C.CustomerID) AS NumeroClientesDiferentes, P.ProductName
	FROM Customers AS C
	INNER JOIN
	Orders AS O
	ON C.CustomerID = O.CustomerID
	INNER JOIN
	[Order Details] AS OD
	ON O.OrderID = OD.OrderID
	INNER JOIN
	Products AS P
	ON OD.ProductID = P.ProductID
	GROUP BY P.ProductName

-- 3. N�mero de pa�ses diferentes en los que se vende cada producto.

SELECT COUNT (DISTINCT O.ShipCountry) AS NumeroPaisesDiferentes, P.ProductName
	FROM Customers AS C
	INNER JOIN
	Orders AS O
	ON C.CustomerID = O.CustomerID
	INNER JOIN
	[Order Details] AS OD
	ON O.OrderID = OD.OrderID
	INNER JOIN
	Products AS P
	ON OD.ProductID = P.ProductID
	GROUP BY P.ProductName

/* 4. Empleados que han vendido alguna vez �Gudbrandsdalsost�, �Lakkalik��ri�,
�Tourti�re� o �Boston Crab Meat�. */

SELECT E.FirstName
	FROM Employees AS E
	INNER JOIN
	Orders AS O
	ON E.EmployeeID = O.EmployeeID
	INNER JOIN
	[Order Details] AS OD
	ON O.OrderID = OD.OrderID
	INNER JOIN
	Products AS P
	ON OD.ProductID = P.ProductID
	WHERE P.ProductName IN ('Gudbrandsdalsost', 'Lakkalik��ri', 'Tourti�re', 'Boston Crab Meat')

--5. Empleados que no han vendido nunca �Chartreuse verte� ni �Ravioli Angelo�.

SELECT FirstName, LastName
	FROM Employees

EXCEPT

SELECT E.FirstName, E.LastName
	FROM Employees AS E
	INNER JOIN
	Orders AS O
	ON E.EmployeeID = O.EmployeeID
	INNER JOIN
	[Order Details] AS OD
	ON O.OrderID = OD.OrderID
	INNER JOIN
	Products AS P
	ON OD.ProductID = P.ProductID
	WHERE P.ProductName IN ('Chartreuse verte', 'Ravioli Angelo')

/* 6. N�mero de unidades de cada categor�a de producto que ha vendido cada
empleado. */

SELECT COUNT (OD.Quantity) AS NumeroUnidades, E.FirstName, E.LastName, C.CategoryName
	FROM Employees AS E
	INNER JOIN
	Orders AS O
	ON E.EmployeeID = O.EmployeeID
	INNER JOIN
	[Order Details] AS OD
	ON O.OrderID = OD.OrderID
	INNER JOIN
	Products AS P
	ON OD.ProductID = P.ProductID
	INNER JOIN
	Categories AS C
	ON P.CategoryID = C.CategoryID
	GROUP BY E.FirstName, E.LastName, C.CategoryName
	ORDER BY E.FirstName

-- 7. Total de ventas (US$) de cada categor�a en el a�o 97.

SELECT TotalVentasCategoria.TotalVentas, P.CategoryID, YEAR (O.OrderDate) AS A�o
	FROM Orders AS O
	INNER JOIN
	[Order Details] AS OD
	ON O.OrderID = OD.OrderID
	INNER JOIN
	Products AS P
	ON OD.ProductID = P.ProductID
	INNER JOIN
		(SELECT CAST (SUM (OD.Quantity * (OD.UnitPrice * (1 - OD.Discount))) AS DECIMAL (10, 2)) AS TotalVentas, C.CategoryID
			FROM Employees AS E
			INNER JOIN
			Orders AS O
			ON E.EmployeeID = O.EmployeeID
			INNER JOIN
			[Order Details] AS OD
			ON O.OrderID = OD.OrderID
			INNER JOIN
			Products AS P
			ON OD.ProductID = P.ProductID
			INNER JOIN
			Categories AS C
			ON P.CategoryID = C.CategoryID
			GROUP BY C.CategoryID) AS TotalVentasCategoria
	ON  P.CategoryID= TotalVentasCategoria.CategoryID
	WHERE YEAR (O.OrderDate) = 1997 
	GROUP BY YEAR (O.OrderDate), TotalVentasCategoria.TotalVentas, P.CategoryID
	ORDER BY P.CategoryID

/* 8. Productos que han comprado m�s de un cliente del mismo pa�s, indicando el
nombre del producto, el pa�s y el n�mero de clientes distintos de ese pa�s que
lo han comprado. */

SELECT  P.ProductName, C.Country, COUNT (DISTINCT C.CustomerID) AS NumeroClientes
	FROM Customers AS C
		INNER JOIN
		Orders AS O
		ON C.CustomerID = O.CustomerID
		INNER JOIN
		[Order Details] AS OD
		ON O.OrderID = OD.OrderID
		INNER JOIN
		Products AS P
		ON OD.ProductID = P.ProductID
		INNER JOIN
		Categories AS CA
		ON P.CategoryID = CA.CategoryID
	GROUP BY P.ProductName, C.Country
	HAVING COUNT (DISTINCT C.CustomerID) > 1

-- 9. Total de ventas (US$) en cada pa�s cada a�o.

SELECT CAST (SUM (OD.Quantity * (OD.UnitPrice * (1- OD.Discount))) AS DECIMAL (12,2)) AS TotalVentas, YEAR (O.OrderDate) AS A�o, C.Country
	FROM Customers AS C
		INNER JOIN
		Orders AS O
		ON C.CustomerID = O.CustomerID
		INNER JOIN
		[Order Details] AS OD
		ON O.OrderID = OD.OrderID
	GROUP BY C.Country, YEAR (O.OrderDate)
	ORDER BY YEAR (O.OrderDate)

/* 10. Producto superventas de cada a�o, indicando a�o, nombre del producto,
categor�a y cifra total de ventas. */

SELECT MaxVentasA�o.Superventas, YEAR (O.OrderDate) AS A�o, P.ProductName, P.CategoryID
	FROM Products AS P
		INNER JOIN
		[Order Details] AS OD
		ON P.ProductID = OD.ProductID
		INNER JOIN
		Orders AS O
		ON OD.OrderID = O.OrderID
		INNER JOIN
		(SELECT MAX (TotalVentasA�o.TotalVentas) AS Superventas, YEAR (O.OrderDate) AS A�o
			FROM Products AS P
				INNER JOIN
				[Order Details] AS OD
				ON P.ProductID = OD.ProductID
				INNER JOIN
				Orders AS O
				ON OD.OrderID = O.OrderID
				INNER JOIN
				(SELECT SUM (OD.Quantity) AS TotalVentas, P.ProductID, YEAR (O.OrderDate) AS A�o
					FROM Products AS P
						INNER JOIN
						[Order Details] AS OD
						ON P.ProductID = OD.ProductID
						INNER JOIN
						Orders AS O
						ON OD.OrderID = O.OrderID
					GROUP BY YEAR (O.OrderDate), P.ProductID) AS TotalVentasA�o
				ON P.ProductID = TotalVentasA�o.ProductID
				GROUP BY YEAR (O.OrderDate), TotalVentasA�o.TotalVentas
				HAVING MAX (TotalVentasA�o.TotalVentas) = TotalVentasA�o.TotalVentas) AS MaxVentasA�o
		ON YEAR (O.OrderDate) = MaxVentasA�o.A�o


/* 11. Cifra de ventas de cada producto en el a�o 97 y su aumento o disminuci�n
respecto al a�o anterior en US $ y en %. */



-- 12. Mejor cliente (el que m�s nos compra) de cada pa�s.



--13. N�mero de productos diferentes que nos compra cada cliente.



-- 14. Clientes que nos compran m�s de cinco productos diferentes.



/* 15. Vendedores que han vendido una mayor cantidad que la media en US $ en el
a�o 97. */



/* 16. Empleados que hayan aumentado su cifra de ventas m�s de un 10% entre dos
a�os consecutivos, indicando el a�o en que se produjo el aumento. */