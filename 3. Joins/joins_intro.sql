USE TSQL2012;

-- Introducing CROSS JOINS

SELECT c.custid, e.empid
FROM Sales.Customers AS c  -- Renaming to something shorter
  CROSS JOIN HR.Employees AS e
-- This will perform a Cartesian Product, taking every entry in c and joining it to every row in e.


-- SELF CROSS JOINS: joining a table with itself to compare its contents

SELECT
  e1.empid, e1.firstname, e1.lastname
  , e2.empid, e2.firstname, e2.lastname
FROM HR.Employees AS e1
  CROSS JOIN HR.Employees AS e2




USE TSQL2012;
IF OBJECT_ID('dbo.Digits', 'U') IS NOT NULL DROP TABLE dbo.Digits;
CREATE TABLE dbo.Digits(
  digit INT NOT NULL PRIMARY KEY
);

INSERT INTO dbo.Digits(digit)
    VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

SELECT * FROM dbo.Digits

-- Sequence of integers in range 1 through 1,000
SELECT (d3.digit * 100 + d2.digit * 10 + d1.digit + 1) AS n
FROM dbo.Digits AS d1
  CROSS JOIN dbo.Digits AS d2
  CROSS JOIN dbo.Digits AS d3
ORDER BY n;



-- INNER JOINS
SELECT e.empid, e.firstname, e.lastname, o.orderid
FROM HR.Employees AS e
  JOIN Sales.Orders AS o
    ON e.empid = o.empid


-- COMPOSITE JOINS
SELECT c.custid, o.orderid, od.productid, od.qty
FROM Sales.Customers AS c
  LEFT OUTER JOIN Sales.Orders AS o
    ON c.custid = o.custid
  LEFT OUTER JOIN Sales.OrderDetails AS od
    ON o.orderid = od.orderid
ORDER BY o.orderid