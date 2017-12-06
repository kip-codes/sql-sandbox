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
  YEAR(orderdate) AS orderyear,
  COUNT(*) AS numorders -- with the HAVING clause, count(*) == 1 will not be printed.
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY YEAR(orderdate);


-- The ORDER BY Clause
-- Presentation ordering is important because SQL does not guarantee table ordering
-- Tables are represented as sets without order relevance.
-- The ORDER BY phase is the only phase processed after SELECT, so can use alias.

SELECT
  empid,
  YEAR(orderdate) AS orderyear,
  COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY empid, orderyear;


SELECT empid, firstname, lastname, country
FROM HR.Employees
ORDER BY hiredate;


-- The TOP filter

SELECT TOP(5) orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

-- SELECT TOP(5) orderid, orderdate, custid, empid
-- FROM Sales.Orders
-- ORDER BY orderdate DESC, orderid DESC;

SELECT TOP(1) PERCENT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;  -- skip 50 rows, retrieve next 25


-- Windows Functions

SELECT orderid, custid, val,
  ROW_NUMBER() OVER(PARTITION BY custid
                    ORDER BY val) AS rownum
FROM Sales.OrderValues
ORDER BY custid, val;


-- Predicates and Operators

SELECT orderid, empid, orderdate
FROM Sales.Orders
WHERE orderid BETWEEN 10300 AND 10310; -- BETWEEN

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE N'D%'; -- LIKE | N stands for 'National' | % represents wild carat


-- Case Expressions

SELECT productid, productname, categoryid,
  CASE categoryid
    WHEN 1 THEN 'Beverages'
    WHEN 2 THEN 'Condiments'
    WHEN 3 THEN 'Confections'
    WHEN 4 THEN 'Dairy Products'
    WHEN 5 THEN 'Grains/Cereals'
    WHEN 6 THEN 'Meat/Poultry'
    WHEN 7 THEN 'Produce'
    WHEN 8 THEN 'Seafood'
    ELSE 'Unknown Category'
  END AS categoryname
FROM Production.Products
ORDER BY categoryname DESC;

