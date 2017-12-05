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

SELECT orderid, empid, orderdate, freight
FROM Sales.Orders
WHERE custid = 71;

-- The GROUP BY Clause

SELECT empid, YEAR(orderdate) as orderyear
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate);

SELECT
  empid,
  YEAR(orderdate) AS orderyear, -- conversion, not aggregate function
  SUM(freight) AS totalfreight,
  COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate);