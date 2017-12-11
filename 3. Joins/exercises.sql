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


/*
2. Return United States customers, and for each customer return the total number of orders and total quantities.
-- Tables involved: Sales.Customers, Sales.ORders, and Sales.OrderDetails
 */

USE TSQL2012;
SELECT c.custid, COUNT(DISTINCT o.orderid) as numorders, SUM(od.qty) as totalqty
FROM Sales.Customers as c
  JOIN Sales.Orders as o
    ON c.custid = o.custid
  JOIN Sales.OrderDetails as od
    ON o.orderid = od.orderid
WHERE c.country = 'USA'
GROUP BY c.custid
ORDER BY c.custid;
-- CORRECT
-- NEED TO REVIEW DISTINCT
-- DISTINCT prevents double counting from the orders --> orderdetails join.


/*
3. Return customers and their orders, including customers who placed no orders.
-- Tables involved: Sales.Customers and Sales.Orders
 */

USE TSQL2012;
SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
  LEFT JOIN Sales.Orders AS o
    ON c.custid = o.custid
-- CORRECT


/*
4.
 */