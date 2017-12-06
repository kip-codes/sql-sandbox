USE TSQL2012;  -- A USE statement needs to be run at some point prior to querying to reference the DB

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
-- Always group by the true column name, not the alias.

SELECT empid, YEAR(orderdate) as orderyear
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate);

-- Aggregate functions do not need to be added to the GROUP BY selection.

SELECT
  empid,
  YEAR(orderdate) AS orderyear, -- conversion, not aggregate function
  SUM(freight) AS totalfreight, -- aggregate
  COUNT(*) AS numorders -- aggregate
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate);


-- Exploring DISTINCT
-- COUNT(DISTINCT custid) will aggregate all unique customer ID's, because repeated custids do not matter when counting
-- for the number of customers an employee serves.

SELECT
  empid,
  YEAR(orderdate) AS orderyear,
  COUNT(DISTINCT custid) AS numcusts
FROM Sales.Orders
GROUP BY empid, YEAR(orderdate);


-- The HAVING Clause
-- The HAVING phrase filters only groups (employee id and order year) with more than one row (tuple)
-- HAVING will take the group and COUNT will tally up distinct pairings of employee id and order year.
-- COUNT(*) > 1 implies that a particular employee in a given year has had more tha 1 order completed.

SELECT
  empid,
  YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY empid