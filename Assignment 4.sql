--1. Create a stored procedure in the Northwind database that will calculate the average 
--value of Freight for a specified customer.Then, a business rule will be added that will 
--be triggered before every Update and Insert command in the Orders controller,and 
--will use the stored procedure to verify that the Freight does not exceed the average 
--freight. If it does, a message will be displayed and the command will be cancelled.

EXEC CalculateAvgFreight @CustomerID = VINET

UPDATE Orders 
SET Freight = 150.09
where OrderId = 10248

--USE [niyatikaneriya_db]
--GO
--/****** Object:  StoredProcedure [dbo].[CalculateAvgFreight]    Script Date: 24-01-2024 17:55:13 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER PROCEDURE [dbo].[CalculateAvgFreight] 
--	-- Add the parameters for the stored procedure here
--	@CustomerID nvarchar(5)
--AS
--BEGIN
--	DECLARE @AvgFreight money;

--	SELECT @AvgFreight = AVG(Freight)
--	FROM Orders
--	WHERE CustomerID = @CustomerID;

--    -- Insert statements for procedure here
--	SELECT @AvgFreight AS 'AverageFreight' , @CustomerId as 'Customerid';
--END;

--USE [niyatikaneriya_db]
--GO
--/****** Object:  Trigger [dbo].[CheckFreight]    Script Date: 24-01-2024 17:59:34 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO

----IF EXISTS(
----  SELECT *
----    FROM sys.triggers
----   WHERE name = N'<trigger_name, sysname, table_alter_drop_safety>'
----     AND parent_class_desc = N'DATABASE'
----)
----	DROP TRIGGER <trigger_name, sysname, table_alter_drop_safety> ON DATABASE
----GO

--ALTER TRIGGER [dbo].[CheckFreight]
--ON [dbo].[Orders]
--AFTER INSERT, UPDATE
--AS
--BEGIN
--    IF EXISTS (
--        SELECT 1
--        FROM inserted i
--        JOIN Orders o ON i.OrderID = o.OrderID
--        WHERE i.Freight > (SELECT AVG(Freight) FROM Orders)
--    )
--    BEGIN
--       --RAISEERROR('Freight exceeds average for the specified customer.', 16, 1);
--       --PRINT 'Freight exceeds average for the specified customer.';
--	     THROW 50000, 'Freight exceeds average for the specified customer.', 1;
--       ROLLBACK;
--    END
--END;



--2. write a SQL query to Create Stored procedure in the Northwind database to retrieve 
--Employee Sales by Country

EXEC EmployeeSalesByCountry

--USE [niyatikaneriya_db]
--GO
--/****** Object:  StoredProcedure [dbo].[EmployeeSalesByCountry]    Script Date: 24-01-2024 17:55:50 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
--ALTER PROCEDURE [dbo].[EmployeeSalesByCountry]	
--AS
--BEGIN
--	 SELECT 
--        E.EmployeeID,
--        E.FirstName,
--        E.LastName,
--       O.ShipCountry,
--        SUM(CONVERT(decimal(14,2), OD.Quantity*(1-OD.Discount)*OD.UnitPrice)) AS TotalSales
--    FROM 
--        Employees E
--    LEFT JOIN 
--        Orders O ON E.EmployeeID = O.EmployeeID
--	LEFT JOIN 
--		[Order Details] OD ON OD.OrderID = O.OrderID
--    GROUP BY 
--        E.EmployeeID, E.FirstName, E.LastName, O.ShipCountry
--	ORDER BY E.EmployeeID
--END


--3. write a SQL query to Create Stored procedure in the Northwind database to retrieve 
--Sales by Year

--EXEC SalesByYears

--USE [niyatikaneriya_db]
--GO
--/****** Object:  StoredProcedure [dbo].[SalesByYears]    Script Date: 24-01-2024 17:56:38 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
--ALTER PROCEDURE [dbo].[SalesByYears] 

--AS
--BEGIN
	
--	SELECT Year(O.OrderDate) AS Years , 
--        SUM(CONVERT(decimal(14,2), OD.Quantity*(1-OD.Discount)*OD.UnitPrice)) AS TotalSales
--    FROM Employees E
--    LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
--	LEFT JOIN [Order Details] OD ON OD.OrderID = O.OrderID
--    GROUP BY Year(O.OrderDate)
--	ORDER BY Year(O.OrderDate)
   
--END

--4. write a SQL query to Create Stored procedure in the Northwind database to retrieve 
--Sales By Category

EXEC SalesByCategory

--USE [niyatikaneriya_db]
--GO
--/****** Object:  StoredProcedure [dbo].[SalesByCategory]    Script Date: 24-01-2024 17:57:18 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
--ALTER PROCEDURE [dbo].[SalesByCategory] 
--AS
--BEGIN
--	select distinct a.CategoryID, 
--    a.CategoryName,  
--   -- b.ProductName, 
--    sum(round(y.UnitPrice * y.Quantity * (1 - y.Discount), 2)) as ProductSales
--	from [Order Details] y
--	inner join Orders d on d.OrderID = y.OrderID
--	inner join Products b on b.ProductID = y.ProductID
--	inner join Categories a on a.CategoryID = b.CategoryID
--	group by a.CategoryID, a.CategoryName
--	order by a.CategoryName, ProductSales;
--END

--5. write a SQL query to Create Stored procedure in the Northwind database to retrieve 
--Ten Most Expensive Products

EXEC TenMostExpensiveProducts

--USE [niyatikaneriya_db]
--GO
--/****** Object:  StoredProcedure [dbo].[TenMostExpensiveProducts]    Script Date: 24-01-2024 17:57:47 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
--ALTER PROCEDURE [dbo].[TenMostExpensiveProducts]
--AS
--BEGIN
--	Select TOP(10) ProductId, ProductName, UnitPrice 
--	from Products 
--	ORDER BY UnitPrice 
--	DESC
--END


--6. write a SQL query to Create Stored procedure in the Northwind database to insert 
--Customer Order Details 

EXEC InsertCustomerOrderDetails @OrderId = 10248 , @ProductID = 1, @UnitPrice = 18.00, @Quantity = 5, @Discount = 0

--USE [niyatikaneriya_db]
--GO
--/****** Object:  StoredProcedure [dbo].[InsertCustomerOrderDetails]    Script Date: 24-01-2024 17:58:12 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
--ALTER PROCEDURE [dbo].[InsertCustomerOrderDetails]
--	@OrderId INT,
--	@ProductID INT,
--	@UnitPrice money ,
--	@Quantity smallint,
--	@Discount real
--AS
--BEGIN
--	INSERT INTO [Order Details] (OrderId,ProductID,UnitPrice,Quantity,Discount)
--	VALUES(@OrderId,@ProductID,@UnitPrice,@Quantity,@Discount)
--END

--7. write a SQL query to Create Stored procedure in the Northwind database to update 
--Customer Order Details

EXEC UpdateCustomerOrderDetails @OrderId = 10248 , @ProductID = 1, @NewUnitPrice = 18.00, @NewQuantity = 15, @NewDiscount = 0

--USE [niyatikaneriya_db]
--GO
--/****** Object:  StoredProcedure [dbo].[UpdateCustomerOrderDetails]    Script Date: 24-01-2024 17:58:42 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
--ALTER PROCEDURE [dbo].[UpdateCustomerOrderDetails]
--    @OrderID int,
--    @ProductID int,
--    @NewUnitPrice money,
--    @NewQuantity smallint,
--    @NewDiscount real
--AS
--BEGIN
--    UPDATE [Order Details]
--    SET UnitPrice = @NewUnitPrice,
--        Quantity = @NewQuantity,
--        Discount = @NewDiscount
--    WHERE OrderID = @OrderID AND ProductID = @ProductID;
--END;




