/*
1-1. Write a query that generates five copies of each employee row.
-- Tables involved: HR.Employees and dbo.Nums
 */

USE TSQL2012;
SELECT empid, firstname, lastname, n
FROM HR.Employees
  JOIN dbo.Nums
    ON n <= 5
ORDER BY empid;
-- CORRECT


/*
1-2. Write a query that returns a row for each employee and day in the range June 12, 2009 through June 16, 2009
-- Tables involved: HR.Employees and dbo.Nums
 */

USE TSQL2012;
SELECT empid, DATEADD(DAY, n-1, '20090612') AS dt
FROM HR.Employees
  JOIN dbo.Nums
    ON n <= DATEDIFF(DAY, '20090612', '20090616') + 1
ORDER BY empid;
-- CORRECT
-- Solution uses WHERE with a CROSS JOIN instead of JOIN ON, but gives same results