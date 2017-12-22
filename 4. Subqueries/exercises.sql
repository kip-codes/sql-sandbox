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


/*
6. Write a query that returns customers who placed orders in 2007 but not in 2008.
-- Tables involved: Sales.Customers and Sales.Orders
 */

-- Get orders placed in 2008 ONLY
SELECT *
FROM Sales.Orders
WHERE YEAR(orderdate) = 2008

-- Get customers that placed orders in 2008 ONLY
SELECT Customers.custid
FROM Sales.Customers
  JOIN Sales.Orders
    ON Customers.custid = Orders.custid
WHERE YEAR(Orders.orderdate) = 2008

SELECT C.custid, C.companyname
FROM Sales.Customers C
   JOIN Sales.Orders O
    ON C.custid = O.custid
    AND YEAR(O.orderdate) = 2007
WHERE C.custid NOT IN
      (SELECT Customers.custid
      FROM Sales.Customers
        JOIN Sales.Orders
          ON Customers.custid = Orders.custid
      WHERE YEAR(Orders.orderdate) = 2008)
GROUP BY C.custid, C.companyname
-- CORRECT

-- SOLUTION FROM THE BOOK
SELECT custid, companyname
FROM Sales.Customers C
WHERE EXISTS
      (SELECT *
      FROM Sales.Orders O
      WHERE O.custid = C.custid
        AND O.orderdate >= '20070101'
        AND O.orderdate < '20080101')
      AND NOT EXISTS
      (SELECT *
      FROM Sales.Orders O
      WHERE O.custid = C.custid
        AND O.orderdate >= '20080101'
        AND O.orderdate < '20090101')
;
-- RUNTIME IS APPROXIMATELY THE SAME


/*
7. Write a query that returns customers who ordered product 12.
Tables involved: Sales.Customers, Sales.Orders, and Sales.OrderDetails
 */

-- Get orders with pid 12
SELECT orderid
FROM Sales.OrderDetails
WHERE productid = 12

-- Get cid based on oid
SELECT custid
FROM Sales.Orders
WHERE orderid IN
      (SELECT orderid
      FROM Sales.OrderDetails
      WHERE productid = 12)

-- Get customers based on cid
SELECT custid, companyname
FROM Sales.Customers
WHERE custid IN
      (SELECT custid
      FROM Sales.Orders
      WHERE orderid IN
            (SELECT orderid
            FROM Sales.OrderDetails
            WHERE productid = 12))
ORDER BY companyname
-- CORRECT!


/*
8. Write a query that calculates a running-total quantity for each customer and month.
-- Tables involved: Sales.CustOrders
 */

-- Get the running quantity
SELECT SUM(o2.qty) as runqty
FROM Sales.CustOrders as o2
GROUP BY o2.custid, o2.ordermonth
ORDER BY o2.custid

SELECT custid, ordermonth, qty,
  (SELECT SUM(o1.qty)
  FROM Sales.CustOrders as o1
  WHERE o1.custid = o2.custid AND o1.ordermonth <= o2.ordermonth) as runqty
FROM Sales.CustOrders as o2
ORDER BY o2.custid
-- CORRECT