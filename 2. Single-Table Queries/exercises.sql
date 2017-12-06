/*
1. Write a query against the Sales.Orders table that returns orders placed in June 2007.
-- Tables involved: TSQL2012 database and the Sales.Orders table
 */

USE TSQL2012
SELECT
  orderid,
  orderdate,
  custid,
  empid
FROM Sales.Orders
WHERE MONTH(orderdate) = 6 AND YEAR(orderdate) = 2007;


/*
2. Write a query against the Sales.Orders table that returns orders placed on the last day of the month.
-- Tables involved: TSQL2012 database and the Sales.Orders table
 */

USE TSQL2012
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);


/*
3.
 */