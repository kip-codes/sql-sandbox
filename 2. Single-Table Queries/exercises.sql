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
-- CORRECT


/*
2. Write a query against the Sales.Orders table that returns orders placed on the last day of the month.
-- Tables involved: TSQL2012 database and the Sales.Orders table
 */

USE TSQL2012
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);
-- CORRECT


/*
3. Write a query against the HR.Employees table that returns employees with last name containing the letter 'a' twice
or more.
-- Tables involved: TSQL2012 database and the HR.Employees table
 */

USE TSQL2012
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE N'%a%a%'
-- CORRECT


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
-- CORRECT


/*
5. Write a query against the Sale.Orders table that returns the three shipped-to countries with the highest average
freight in 2007.
-- Tables involved: TSQL2012 database and the Sales.Orders table
 */

USE TSQL2012
SELECT TOP(3)
  shipcountry,
  SUM(freight) / COUNT(*) AS avgfreight
FROM Sales.Orders
WHERE YEAR(orderdate) = 2007
GROUP BY shipcountry
ORDER BY avgfreight DESC;
-- CORRECT


/*
6. Write a query against the Sales.Orders table that calculates row numbers for orders based on order date ordering
(using the order ID as the tiebreaker) for each customer separately.
-- Tables involved: TSQL2012 database and the Sales.Orders table
 */

USE TSQL2012
SELECT
  custid,
  orderdate,
  orderid,
  ROW_NUMBER() OVER(PARTITION BY custid
                    ORDER BY orderdate, orderid) AS rownum
FROM Sales.Orders
-- GROUP BY orderdate, custid, orderid -- Grouping is not needed
ORDER BY custid, rownum;
-- CORRECT


/*
7. Using the HR.Employees table, figure out the SELECT statement that returns for each employee the gender based on the
title of courtesy. For 'Ms.' and 'Mrs.' return 'Female'; for 'Mr.' return 'Male'; and in all other cases (for example,
'Dr.') return 'Unknown'.
-- Tables involved: TSQL2012 database and the HR.Employees table
 */

USE TSQL2012
SELECT
  empid,
  firstname,
  lastname,
  titleofcourtesy,
  CASE(titleofcourtesy)
    WHEN 'Mrs.' THEN 'Female'
    WHEN 'Ms.' THEN 'Female'
    WHEN 'Mr.' THEN 'Male'
    ELSE 'Unknown'
  END AS gender
FROM HR.Employees
-- CORRECT

-- Alernative solution
USE TSQL2012
SELECT
  empid,
  firstname,
  lastname,
  titleofcourtesy,
  CASE
    WHEN titleofcourtesy IN('Mrs.', 'Ms.') THEN 'Female'
    WHEN titleofcourtesy = 'Mr.' THEN 'Male'
    ELSE 'Unknown'
  END AS gender
FROM HR.Employees
-- CORRECT


/*
8. Write a query against the Sales.Customers table that returns for each customer the customer ID and region.
Sort the rows in the output by region, having NULL marks sort last (after non-NULL values).
Note that the default sort behavior for NULL marks in T-SQL is to sort first (before non-NULL values).
-- Tables involved: TSQL2012 database and the Sales.Customers table.
 */

USE TSQL2012
SELECT
  custid,
  region
FROM Sales.Customers
GROUP BY region, custid
ORDER BY
  CASE
    WHEN region IS NULL THEN 1
    ELSE 0
  END, region;
-- CORRECT

-- Turns out, GROUP BY is not necessary because there was no aggregate function in the SELECT clause.
