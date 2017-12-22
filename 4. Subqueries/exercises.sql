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
ORDER BY orderid DESC
-- CORRECT


/*
2. Write a query that returns all orders placed by the customer(s) who placed the highest number of orders.
Note that more than one customer might have the same number of orders.
-- Tables involved: Sales.Orders
 */

-- Select cust with highest count of orders
SELECT TOP 1 custid, COUNT(DISTINCT orderid) as numorders
FROM Sales.Orders
GROUP BY custid
ORDER BY numorders DESC

USE TSQL2012;
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders as o
WHERE custid IN
      (SELECT TOP 1 custid
      FROM Sales.Orders
      GROUP BY custid
      ORDER BY count(orderid) DESC
      )
-- CORRECT !!


/*
3. Write a query that returns employees who did not place orders on or after May 1, 2008.
-- Tables involved: HR.Employees and Sales.Orders
 */

-- Get orders placed on or after May 1, 2008
SELECT empid
FROM Sales.Orders
WHERE orderdate > '20080501'

SELECT e.empid, e.firstname as FirstName, e.lastname as lastname
FROM HR.Employees as E
WHERE E.empid NOT IN
      (SELECT O.empid
      FROM Sales.Orders as O
      WHERE O.empid = E.empid AND O.orderdate >= '20080501'  -- Do not need to match empid because of IN condition
      )
ORDER BY empid
-- CORRECT


/*
4. Write a query that returns countries where there are customers but not employees.
-- Tables involved: Sales.Customers and HR.Employees
 */

SELECT DISTINCT C.country
FROM Sales.Customers as C
WHERE C.country NOT IN
      (SELECT E.country FROM HR.Employees as E)
ORDER BY C.country
-- CORRECT


/*
5. Write a query that returns for each customer all orders placed on the customer's last day of activity.
-- Tables involved: Sales.Orders
 */

-- Get the order on last day of activity for each customer. this will be our unique identifier!
SELECT MAX(orderdate)
FROM Sales.Orders
-- WHERE custid matches the row we're analyzing


SELECT DISTINCT o1.custid, o1.orderid, o1.orderdate, o1.empid
FROM Sales.Orders o1
WHERE o1.orderdate =
      (SELECT MAX(o2.orderdate)
      FROM Sales.Orders o2  -- Make a copy of the same table to make self-comparisons.
      WHERE o2.custid = o1.custid)
ORDER BY o1.custid
-- CORRECT