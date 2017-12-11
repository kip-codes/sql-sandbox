/*
1. Write a query that returns all orders placed on the last day of activity that can be found in the Orders table.
-- Tables involved: Sales.Orders
 */

USE TSQL2012;
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders as o
WHERE orderdate =
      (SELECT MAX(orderdate)
        FROM Sales.Orders
      )


