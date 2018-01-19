USE TSQL2012;

/*
A query must meet three requirements to be valid to define a table expression of any kind:
1. Order is not guaranteed.
2. All column must have names.
3. All column names must be unique.
 */

-- USING ARGUMENTS

DECLARE @empid AS INT = 3;  -- Need to execute in the same process as where the variable is implemented
SELECT orderyear, COUNT(DISTINCT custid) AS numcusts
FROM (SELECT YEAR(orderdate) AS orderyear, custid
  FROM Sales.Orders
  WHERE empid = @empid) AS D
GROUP BY orderyear;

