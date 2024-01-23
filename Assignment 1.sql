--Write a query to get a Product list (id, name, unit price) where current products cost less than $20

SELECT ProductID, ProductName, UnitPrice FROM Products WHERE (UnitPrice < 20) AND (Discontinued = 0);


--Write a query trodu o get Product list (id, name, unit price) where products cost between $15 and $25

SELECT ProductID, ProductName, UnitPrice from Products Where UnitPrice Between 15.00 and 25.00


--Write a query to get Product list (name, unit price) of above average price.

Select ProductId, ProductName, UnitPrice from Products Where UnitPrice > ( Select AVG(UnitPrice) from Products)


--Write a query to get Product list (name, unit price) of ten most expensive products 

Select TOP(10) ProductId, ProductName, UnitPrice from Products ORDER BY UnitPrice DESC


--Write a query to count current and discontinued products 

SELECT COUNT(CASE WHEN Discontinued = 0 THEN 1 END) AS CurrentProducts, COUNT(CASE WHEN Discontinued = 1 THEN 1 END) AS DiscontinuedProducts FROM Products;


--Write a query to get Product list (name, units on order, units in stock) of stock is less	 than the quantity on order 

SELECT ProductName, UnitsOnOrder, UnitsInStock from Products Where UnitsInStock < UnitsOnOrder

