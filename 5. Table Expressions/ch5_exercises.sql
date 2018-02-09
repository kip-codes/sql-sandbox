/*
1-1. Write a query that returns the meximum value in the orderdate column for each employee.
-- Tables involved: Sales.Orders
 */

USE TSQL2012;
SELECT empid, MAX(orderdate) as maxorderdate
FROM Sales.Orders
GROUP BY empid;
-- CORRECT


/*
1-2. Encapsulate the query from Exercise 1-1 in a derived table. Write a join query between the derived table
and the Orders table to return teh orders with the maximum order date for each employee.
-- Tables involved: Sales.Orders
 */

