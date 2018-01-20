USE TSQL2012;

/*
A query must meet three requirements to be valid to define a table expression of any kind:
1. Order is not guaranteed.
2. All column must have names.
3. All column names must be unique.
 */

-- USING ARGUMENTS

-- Returns the number of distinct customers per year whose orders were handled by the input employee (@empid).
DECLARE @empid AS INT = 3;  -- Need to execute in the same process as where the variable is implemented
SELECT orderyear, COUNT(DISTINCT custid) AS numcusts
FROM (SELECT YEAR(orderdate) AS orderyear, custid
  FROM Sales.Orders
  WHERE empid = @empid) AS D
GROUP BY orderyear;


-- NESTING

-- Selects year of order and customer id
SELECT YEAR(orderdate) AS orderyear, custid
FROM Sales.Orders

-- From those entries, count the distinct customer ids, which will give you the number of customers.
SELECT orderyear, COUNT(DISTINCT custid) AS numcusts
FROM (SELECT YEAR(orderdate) AS orderyear, custid
      FROM Sales.Orders) AS D1
GROUP BY orderyear

-- Including a count of customer ids, select entries where the number of customers > 70 for that year.
SELECT orderyear, numcusts
FROM (SELECT orderyear, COUNT(DISTINCT custid) AS numcusts
      FROM (SELECT YEAR(orderdate) AS orderyear, custid
            FROM Sales.Orders) AS D1
      GROUP BY orderyear) AS D2
WHERE numcusts > 70;

-- Shorter way of providing the same output.
-- Nesting is a problematic aspect of derived tables!
SELECT YEAR(orderdate) AS orderyear, COUNT(DISTINCT custid) AS numcusts
FROM Sales.Orders
GROUP BY YEAR(orderdate)
HAVING COUNT(DISTINCT custid) > 70;