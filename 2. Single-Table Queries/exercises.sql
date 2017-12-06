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
3. Write a query against the HR.Employees table that returns employees with last name containing the letter 'a' twice
or more.
-- Tables involved: TSQL2012 database and the HR.Employees table
 */

USE TSQL2012
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE N'%a%a%'


/*
4. Write a query against the Sales.OrderDetails table that returns orders with total value greater than 10,000,
sorted by total value.
-- Tables involved: TSQL2012 database and the Sales.OrderDetails table
 */

-- The following query is incorrect because it calculates the value per order
USE TSQL2012
SELECT
  orderid,
  (qty * unitprice) AS totalvalue
FROM Sales.OrderDetails
WHERE (qty * unitprice) > 10000
ORDER BY totalvalue DESC;

SELECT
  orderid,
  SUM(qty * unitprice) AS totalvalue  -- Adds up all of the order costs for an ID
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty*unitprice) > 10000  -- Checks, by orderid, which totalvalues > 10,000
ORDER BY totalvalue DESC;