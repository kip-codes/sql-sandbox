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

USE TSQL2012;
SELECT s1.empid, s1.orderdate, s1.orderid, s1.custid
FROM Sales.Orders as s1
  JOIN
    (SELECT empid, MAX(orderdate) as maxorderdate
    FROM Sales.Orders
    GROUP BY empid) as s2
  ON s2.empid = s1.empid
    AND s1.orderdate = s2.maxorderdate
-- CORRECT
-- Need to improve on organizing code


/*
2-1. Write a query that calculates a row number for each order based on orderdate, orderid ordering
-- Tables involved: Sales.Orders
 */

USE TSQL2012;
SELECT orderid, orderdate, custid, empid
  ,row_number() OVER (ORDER BY orderdate, orderid) as rownum
FROM Sales.Orders;
-- CORRECT!


/*
2-2. Write a query that returns rows with row numbers 11 through 20 based on the row number definition in Exercise 2-1.
Use a common table expression (CTE) to encapsulate the code from Exercise 2-1.
-- Tables involved: Sales.Orders
 */

