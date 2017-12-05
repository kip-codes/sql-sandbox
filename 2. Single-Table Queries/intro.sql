USE TSQL2012;

-- Elements of the SELECT statement

SELECT empid, YEAR(orderdate) AS orderyear, COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY empid, orderyear;


-- The FROM Clause

SELECT orderid, custid, empid, orderdate, freight
FROM Sales.Orders;


-- The WHERE Clause

SELECT custid, orderid, empid, orderdate, freight
FROM Sales.Orders
WHERE custid = 71;
