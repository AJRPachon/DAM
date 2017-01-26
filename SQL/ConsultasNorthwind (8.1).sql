USE Northwind

GO

/* 1. Nombre del pa�s y n�mero de clientes de cada pa�s, ordenados alfab�ticamente por el nombre del pa�s.*/

SELECT Country, (COUNT (CustomerID)) AS NumeroClientes
	FROM Customers 
	GROUP BY Country
	ORDER BY Country ASC

/* 2. ID de producto y n�mero de unidades vendidas de cada producto. */

SELECT ProductID, SUM (Quantity)
	FROM [Order Details]

--	select UnitsOnOrder, UnitsInStock, QuantityPerUnit from products
/* 3. ID del cliente y n�mero de pedidos que nos ha hecho. */

SELECT CustomerID, (COUNT (OrderID)) AS NumeroPedidos
	FROM Orders
	GROUP BY CustomerID

/* 4. ID del cliente, a�o y n�mero de pedidos que nos ha hecho cada a�o. */

SELECT CustomerID, OrderDate, (COUNT (OrderDate)) AS NumeroPedidos
	FROM Orders
	GROUP BY CustomerID, OrderDate

/* 5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. 
	  Si hay varios precios unitarios para el mismo producto tomaremos el mayor. */

SELECT ProductID, (MAX (UnitPrice)) AS UnitPriceMayor, SUM (UnitPrice*Quantity) AS TotalFacturado
	FROM [Order Details]
	GROUP BY ProductID
	ORDER BY TotalFacturado DESC

/* 6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor. */

SELECT SupplierID, SUM (UnitsInStock*UnitPrice) AS StockAcumuladoTotal 
	FROM Products
	GROUP BY SupplierID

/* 7. N�mero de pedidos registrados mes a mes de cada a�o. */

SELECT YEAR (OrderDate) AS [A�o], DATENAME (MONTH, OrderDate) AS [Mes], COUNT (OrderDate) AS NumeroPedidosRegistrados
	FROM Orders
	GROUP BY YEAR (OrderDate),  DATENAME (MONTH, OrderDate)
	ORDER BY YEAR (OrderDate),  DATENAME (MONTH, OrderDate)

/* 8. A�o y tiempo medio transcurrido entre la fecha de cada pedido (OrderDate) y la fecha en la que lo hemos 
	  enviado (ShipDate), en d�as para cada a�o. */

SELECT YEAR (OrderDate) AS A�o, AVG (DATEDIFF(DAY,OrderDate,ShippedDate)) AS TiempoMedioTranscurridoDias, DAY(ShippedDate) AS DiaEnvio
	FROM Orders
	GROUP BY YEAR (OrderDate)

/* 9. ID del distribuidor y n�mero de pedidos enviados a trav�s de ese distribuidor. */

SELECT ShipVia, COUNT (OrderID) AS NumeroPedidosEnviados 
	FROM Orders
	GROUP BY ShipVia

/* 10. ID de cada proveedor y n�mero de productos distintos que nos suministra. */

SELECT SupplierID, COUNT (ProductID) AS NumeroProductosDistintos
	FROM Products
	GROUP BY SupplierID

/* 11. Nombre y numero de categorias diferentes que suministra cada proveedor */

SELECT S.SupplierID, S.CompanyName, COUNT (DISTINCT P.CategoryID) AS NumeroCategorias
	FROM Products AS P
	INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID
	GROUP BY S.SupplierID, CompanyName