USE WideWorldImportersDW
GO

/*Concatenating query result into one column to allow SSIS data flow to automate data extraction package and 
preventing manual "metadata error."*/

	SELECT CONCAT_WS
	(
		',',
		CAST(FS.[Invoice Date Key] AS nvarchar (40)),
		CAST(SUM(FS.Quantity) AS nvarchar (40)),
		CAST(SUM(FS.Profit) AS nvarchar (40)),
		CAST(SUM(FS.[Tax Amount]) AS nvarchar (40)),
		CAST(SUM(FS.[Total Including Tax]) AS nvarchar (40)),
		CAST(SUM(FS.[Total Excluding Tax]) AS nvarchar (40))
	) AS Result
	FROM [Fact].[Sale] FS
	GROUP BY FS.[Invoice Date Key]
	ORDER BY FS.[Invoice Date Key]



USE [Northwind]
GO

-- Stored Procedure: View each sale(s) rep's overall revenue generated ordered by country.

	/*
	11/10/2020	RS	Created Inital Procedure
	11/11/2020	RS	Added date parameters, handled nulls, and changed data type for o.OrderDate
	*/
	
	ALTER PROCEDURE [dbo].[CustomerOrderByCountry]
		@Country varchar(15),
		@DateFrom date,
		@DateTo date
	AS
	
	SELECT
		CONCAT(e.FirstName, ' ', e.LastName) Employee,
		C.ContactName Customer,
		SUM(O.Freight) OrderAmt,
		O.ShipCountry,
		CAST(O.OrderDate as date) OrderDate
	FROM Orders O
		INNER JOIN Customers C
			ON O.CustomerID = C.CustomerID
		INNER JOIN Employees E
			ON E.EmployeeID = O.EmployeeID
	WHERE (O.ShipCountry = @Country					-- Set parameter = NULL to allow end-user input to retrieve all dates as default.
			OR @Country IS NULL)
	 	AND (O.OrderDate BETWEEN @DateFrom AND @DateTo
				OR @DateFrom IS NULL
				OR @DateTo IS NULL)
	GROUP BY 
		E.FirstName, 
		E.LastName, 
		C.ContactName, 
		O.ShipCountry,
		O.OrderDate
	ORDER BY OrderAmt DESC
	
	

USE AdventureWorks2019
GO

-- Data Cleansing: Removes duplicate values from Production.TransactionHistory table.
	
	WITH  DuplicateValues AS  
 		( SELECT  PTH.TransactionID, 
		   	  PTH.ProductID, 
		  	  ROW_NUMBER() OVER ( PARTITION BY PTH.TransactionID, 
		   	  	PTH.ProductID ORDER BY PTH.TransactionID) AS Duplicates 
		  FROM  production.TransactionHistory PTH ) 
		  
  	DELETE  FROM DuplicateValues  
  	WHERE  Duplicates = 1  


-- Product Price Changes Report: Shows the price changes for purchasing cost and selling price per product, calculates average profit per product, ordered by product categories.

	SELECT DISTINCT 
		PPC.ProductCategoryID,
		PPSC.ProductSubcategoryID,
		PPCH.ProductID,
		MIN(ROUND(PPCH.StandardCost, 2)) OVER (PARTITION BY PPCH.ProductID) MinCost,
		MAX(ROUND(PPCH.StandardCost, 2)) OVER (PARTITION BY PPCH.ProductID) MaxCost,
		AVG(ROUND(PPCH.StandardCost, 2)) OVER (PARTITION BY PPCH.ProductID) AvgCost,
		MIN(ROUND(PPLPH.ListPrice, 2)) OVER (PARTITION BY PPLPH.ProductID) MinSellPrice,
		MAX(ROUND(PPLPH.ListPrice, 2)) OVER (PARTITION BY PPLPH.ProductID) MaxSellPrice,
		AVG(ROUND(PPLPH.ListPrice, 2)) OVER (PARTITION BY PPLPH.ProductID) AvgSellPrice,
		ROUND((AVG(ROUND(PPLPH.ListPrice, 2)) OVER (PARTITION BY PPLPH.ProductID) - AVG(ROUND(PPCH.StandardCost, 2)) OVER (PARTITION BY PPCH.ProductID)), 2) Profit
	FROM 
		[Production].[ProductCostHistory] PPCH
			INNER JOIN [Production].[Product] PP
				ON PPCH.ProductID = PP.ProductID
			INNER JOIN [Production].[ProductListPriceHistory] PPLPH
				ON PP.ProductID = PPLPH.ProductID
			INNER JOIN [Production].[ProductSubcategory] PPSC
				ON PPSC.ProductSubcategoryID = PP.ProductSubcategoryID
			INNER JOIN [Production].[ProductCategory] PPC
				ON PPSC.ProductCategoryID = PPC.ProductCategoryID
	GROUP BY 
		PPC.ProductCategoryID,
		PPSC.ProductSubcategoryID,
		PPCH.ProductID,
		PPCH.StandardCost,
		PPLPH.ListPrice,
		PPLPH.ProductID
	
	
-- Inventory Cost Report: Shows products (per store location) that fall below the stock quantity safety margin and calculates reorder costs. 

	SELECT 	PIn.LocationID,
		P.ProductID,
		P.Name,
		P.SafetyStockLevel,
		P.ReorderPoint,
		PIn.Quantity,
			(CASE
				WHEN PIn.Quantity < P.ReorderPoint THEN (P.ReorderPoint - PIn.Quantity)*P.StandardCost
			ELSE NULL
			END) ReorderCost,
		P.StandardCost,
		P.ListPrice,
		P.DaysToManufacture
	FROM [Production].[Product] P
		INNER JOIN [Production].[ProductInventory] PIn 
			ON P.ProductID = PIn.ProductID
	WHERE ListPrice > 0 
		AND PIn.Quantity < ReorderPoint 
	ORDER BY ListPrice DESC
	
	
-- How many Employees (EEs) are working in AdventureWorks2019? Showcases how I analyze new datasets. 

	/* 
	11/14/2020	RS	Taken from 'https://dataedo.com/download/AdventureWorks.pdf (page.17)'
				SP = Sales person, 
				EM = Employee (non-sales)
				IN = Individual (retail) Customer
	*/

	SELECT * FROM HumanResources.Employee		--290 rows returned, which means there are 290 EEs in total
	 			

	SELECT COUNT(*) as Total_Employees, 		--To identify all person classifications
		PersonType 
	FROM Person.Person 
	GROUP BY PersonType 				

	SELECT * 					--Returns all 290 EEs
	FROM Person.Person 
	WHERE PersonType IN ('EM', 'SP') 
	
	
-- Employee (EE): Reports full name of highest paid EEs, their Job Title, AnnualSalary and WorkShift.

	SELECT MIN(StartDate) FROM HumanResources.EmployeeDepartmentHistory	-- Error check to verify EEs with the earliest hire date.

	SELECT HRE.BusinessEntityID, 
		CONCAT_WS(' ', Title, FirstName, LastName) Employee, 
		HRE.JobTitle, 
		HRE.LoginID,
		((CONVERT(MONEY, HRP.Rate, 1)) * 2080) AnnualSalary,
		HRS.Name as WorkShift
	from HumanResources.Employee HRE
		INNER JOIN Person.Person P
			ON P.BusinessEntityID = HRE.BusinessEntityID
		INNER JOIN HumanResources.EmployeePayHistory HRP
			ON HRP.BusinessEntityID = P.BusinessEntityID
		INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
			ON HRP.BusinessEntityID = HREDH.BusinessEntityID
		INNER JOIN HumanResources.Shift HRS
			ON HREDH.ShiftID = HRS.ShiftID
	WHERE ((CONVERT(MONEY, HRP.Rate, 1)) * 2080) > '70000'
		AND StartDate > '2006-06-30'
	ORDER BY BusinessEntityID
	
	
-- Best-Selling Products Report: Ranks the most profitable product, ordered by category.
	
	SELECT DISTINCT 
		SSOD.ProductID,
		PPS.ProductSubcategoryID,
		PPS.Name ProductSubcategoryID,
		ROW_NUMBER() OVER 
			(PARTITION BY PPS.ProductSubcategoryID ORDER BY (ProdP.ListPrice * SUM(OrderQty)) DESC) ProductRank,
		ProdP.Name ProductName,
		ProdP.ListPrice,
		SUM(OrderQty) UnitsSold,
		(ProdP.ListPrice * SUM(OrderQty)) SalesRevenue,
		RANK() OVER 
			(PARTITION BY PPS.ProductSubcategoryID 
			ORDER BY (ProdP.ListPrice * SUM(OrderQty)) DESC) ProfitTier,	-- Ranks which products are the most profitable. (RANK function skips rows)
		DENSE_RANK() OVER 
			(PARTITION BY PPS.ProductSubcategoryID 
			ORDER BY (ProdP.ListPrice * SUM(OrderQty)) DESC) ProfitRank,	-- DENSE_RANK allows for repeated rows and returns consectutive values
		PERCENT_RANK() OVER
			(ORDER BY (ProdP.ListPrice * SUM(OrderQty))) PercentPriceRank 	-- Ranks the most profitable Product by percentage 
	FROM Sales.SalesOrderDetail SSOD
		INNER JOIN Production.Product ProdP
			ON SSOD.ProductID = ProdP.ProductID
		INNER JOIN Production.ProductSubcategory PPS
			ON ProdP.ProductSubcategoryID = PPS.ProductSubcategoryID
	--WHERE PPS.ProductSubcategoryID = 1				-- Creates a filter for user to input values by ProductSubcategoryID
									-- SELECT DISTINCT * FROM  Production.ProductSubcategory PPS [Creates list of all ProductSubcategories]
	GROUP BY SSOD.ProductID,
		ProdP.Name,
		ProdP.ListPrice,
		PPS.Name,
		PPS.ProductSubcategoryID
	ORDER BY SalesRevenue DESC, 
		PPS.ProductSubcategoryID ASC


-- Territory Sales Report: Shows current sales based on region to compare previous year sales and expected future sales.

	SELECT
		SP.TerritoryID,
		ST.Name,
		CAST(SP.ModifiedDate AS date) SalesDate,
		SP.BusinessEntityID,
		SP.SalesYTD,
		LAG(SP.SalesYTD, 1, 0) OVER (PARTITION BY SP.TerritoryID ORDER BY SP.TerritoryID DESC) PrevQuota,
		LEAD(SP.SalesYTD, 1, 0) OVER (PARTITION BY SP.TerritoryID ORDER BY SP.TerritoryID DESC) ProjectedQuota
	FROM [Sales].[SalesPerson] SP
		INNER JOIN [Sales].[SalesTerritory] ST
			ON SP.TerritoryID = ST.TerritoryID
	ORDER BY SP.TerritoryID


-- Customers Report: Demographic data of all 18k customers.

	/*
	
	11/14/2020	RS	Encountered ERROR with STRING_SPLIT function. SS does not recognize it as a built-in function
	11/20/2020	RS	Original script contained 18,484 customers. Adding PA.City and COALESCE(PA.AddressLine1, PA.AddressLine2) Address created 18,505.
				May indicate that 21 customers have multiple addresses.

	*/

	SELECT DISTINCT
		PP.BusinessEntityID,
		(CASE
			WHEN PersonType = 'IN' THEN 'Customer'
			WHEN PersonType = 'EM' THEN 'Employee'
			WHEN PersonType = 'SP' THEN 'SalesRep'
			ELSE NULL
		END) PersonType,
		CONCAT(PP.Title, PP.FirstName, ' ', COALESCE(PP.MiddleName, PP.LastName), ' ', PP.LastName) Customer,
		CONCAT(SUBSTRING(PP.FirstName, 1, 1), (SUBSTRING(PP.LastName, 1, 1))) Initials,
		SOUNDEX(PE.EmailAddress) EmailID,
		PE.EmailAddress,
		PPP.PhoneNumber,
		PATINDEX('%@%', PE.EmailAddress) '@Position',			-- Use PATINDEX() whenever you need to specify a pattern to search for.
		CHARINDEX('@', PE.EmailAddress, 3) '@Position',			-- Use CHARINDEX() when you want to specify a starting position within the string to search.
		PA.City,
		COALESCE(PA.AddressLine1, PA.AddressLine2) Address
		--STRING_SPLIT(PE.EmailAddress , '@')				-- Error. Verified DB is in Compatibility level 140 but server still does not recognize the function.
	FROM [Person].[Person] PP
		INNER JOIN [Person].[EmailAddress]	PE
			ON PE.BusinessEntityID = PP.BusinessEntityID
		INNER JOIN [Person].[PersonPhone] PPP
			ON PP.BusinessEntityID = PPP.BusinessEntityID
		INNER JOIN [Person].[BusinessEntityAddress] PBEA
			ON PP.BusinessEntityID = PBEA.BusinessEntityID
		INNER JOIN [Person].[Address] PA
			ON PBEA.AddressID = PA.AddressID
	WHERE PersonType = 'IN'
	ORDER BY BusinessEntityID


-- Quantity Sold Report: Shows which products are selling at higher than average amounts.

	SELECT *
	FROM
		(SELECT DISTINCT SSOD.ProductID,			
			ProdP.Name ProductName,
			ProdP.ListPrice,
			SUM(OrderQty) UnitsSold,
			(ProdP.ListPrice * SUM(OrderQty)) SalesRevenue,
			PERCENT_RANK() OVER(ORDER BY (ProdP.ListPrice * SUM(OrderQty))) PercentRankOfSalesRevenue 
		FROM Sales.SalesOrderDetail SSOD
			INNER JOIN Production.Product ProdP
				ON SSOD.ProductID = ProdP.ProductID
		GROUP BY SSOD.ProductID,
			ProdP.Name,
			ProdP.ListPrice) BestSellingProducts
	WHERE UnitsSold >= (SELECT AVG(UnitsSold) AvgUnitsSold				--This subquery calculates which products are selling at higher than avg amounts as AvgQuanityAmnt 
				FROM (SELECT DISTINCT SSOD.ProductID,
						SUM(OrderQty) UnitsSold
					FROM Sales.SalesOrderDetail SSOD
					GROUP BY SSOD.ProductID) as AvgQuanityAmnt)
  		 AND
		SalesRevenue >= (SELECT AVG(salesrevenue) 
				FROM	(SELECT DISTINCT SSOD.ProductID,		--This subquery calculates which products generated the most sales revenue on avg as AvgHighestProfitProducts
							ProdP.Name ProductName,
							ProdP.ListPrice,
							SUM(OrderQty) UnitsSold,
							(ProdP.ListPrice * SUM(OrderQty)) SalesRevenue
					FROM Sales.SalesOrderDetail SSOD
						INNER JOIN Production.Product ProdP
							ON SSOD.ProductID = ProdP.ProductID
					GROUP BY SSOD.ProductID,
							ProdP.Name,
							ProdP.ListPrice) AvgHighestProfitProducts)
	ORDER BY PercentRankOfSalesRevenue DESC


-- Showcases UNION.

	SELECT TOP 500 AddressID FROM [Person].[Address]
	UNION 
	SELECT TOP 500 AddressTypeID from [Person].[AddressType]
	
	
	
