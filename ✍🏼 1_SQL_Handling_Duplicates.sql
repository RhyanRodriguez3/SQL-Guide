/* ===================================================
Guide on how to handle duplicates in a table with SQL.

Beginner questions I was asked at my first Junior BI Engineer Role.

Table 1 could possibly have duplicates Write a query to read unique records from Table 1.
Display average GPA by college and academic year
Display the top 3 students within each college
Write a python query to read csv and pandas. 
=====================================================*/

"The problem is that there are two types of duplicates. The solution is to create a new ID column that is unique"

-- Duplicate #1 - Columns have the same row values. REFER TO SOLUTIONS 1, 2, and 3.
-- Duplicate #2 - ALL ROWS are the same in the table. Use DISTINCT and REFER TO SOLUTION 2.


-- Here is the sample data.
DROP TABLE IF EXISTS cars;
CREATE TABLE cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
INSERT INTO cars VALUES (1, 'Model S', 'Tesla', 'Blue', 2018);
INSERT INTO cars VALUES (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
INSERT INTO cars VALUES (3, 'iX', 'BMW', 'Red', 2022);
INSERT INTO cars VALUES (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
INSERT INTO cars VALUES (5, 'Model S', 'Tesla', 'Silver', 2018);   -- Rerun these queries to insert deleted rows back into table.
INSERT INTO cars VALUES (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);  -- Rerun these queries to insert deleted rows back into table.


SELECT * FROM cars ORDER BY model, brand;

/* ===========================================================================================================
Duplicate Type #1 SOLUTION 1: IF THE TABLE HAS AN ID COLUMN, create a new ID column dependent on the ID column. 
============================================================================================================ */
DELETE FROM cars	-- Step #4: If the dataset already has unique ID, create a SELECT statement to find the ones you want to delete.
WHERE id IN ( 
	     SELECT MAX(id) AS Max_ID   -- Step #3: MAX agg function picks the largest values that have counts > 1.
	     FROM cars	
	     GROUP BY model, brand    -- Step #1: Define the duplicate values in the columns, then group them. The table collapses into summary rows with those values.
	     HAVING COUNT(*) > 1    -- Step #2: This counts all the grouped rows in a new column.
	    ); 


--> SOLUTION 2: IF the duplicates have a unique ID column, use the MIN aggregate function.
------------------------------------------------------------------------------------------
DELETE FROM cars
WHERE id NOT IN ( SELECT MIN(id) AS MinID    -- Step #2: The MIN aggregate function counts the smallest unique values from the ID column to create a new ID column.
                  FROM cars
                  GROUP BY model, brand    -- Step #1: This part groups values from column(s). 
		  ORDER BY MinID ASC
		);


"The previous solutions only work IF the table already has an ID column. They wont work when every row is the same."


/* =======================================================================================
Duplicate Type #2 SOLUTION 1: Create a new ID column using the ROW_NUMBER window function.
======================================================================================= */
DELETE FROM cars
WHERE id IN ( SELECT id
              FROM (SELECT *
                   , ROW_NUMBER() OVER(PARTITION BY model, brand ORDER BY id) AS NewID_ModelBrand    -- Step #1: ROW_NUMBER() numbers each row based on the partitioned columns. 
                   FROM cars) x
              WHERE x.NewID_ModelBrand > 1); -- Step #2: The new column 'RowNum' has now become the ID column, so any value greater than 1 are duplicates. 


-- BEST SOLUTION: Create a temp CTE and remove the duplicates from it.
WITH CTE1 AS
    (
    SELECT *
	,  ROW_NUMBER() OVER(PARTITION BY model, brand) AS NewID_ModelBrand
    FROM Employees
    )
DELETE FROM CTE1 WHERE NewID_ModelBrand > 1 	

	


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* EXTRA Solution (For the interviewer) */


--> eSOLUTION #1: Delete using SELF JOIN, which joins the table into itself.
----------------------------------------------------------------------------
DELETE FROM cars
WHERE id IN ( SELECT c1.id   
              FROM cars c1
              JOIN cars c2    -- TIP: When JOIN not specified, defaults to INNER JOIN.
		ON c1.model = c2.model AND c1.brand = c2.brand    -- Step #1: This part joins the table into itself using column values as IDs, then attaches the column.								     
              WHERE c1.id > c2.id    -- Step #2: This performs the operation on each row and returns rows that result NO. NO means the grouped values return duplicates.
	     );    


--> SOLUTION 5: Create a backup table, drop the original table, then rename the backup as the original. 
-------------------------------------------------------------------------------------------------------
-- Deleting the entire table is faster than using the DELETE statement. Only meant for a dev/testing environment.
DROP TABLE IF EXISTS cars_bkp;    

-- [CREATE TABLE IF NOT EXISTS] is not allowed in SSMS. This part creates a backup table. LOOK UP HOW TO MAKE A BACKUP TABLE USING SSMS.
CREATE TABLE cars_bkp
AS				-- ERROR. REFER TO DOCUMENTATION.
SELECT * FROM cars WHERE 1=2;    -- Step #1: This returns 0 records since 1=2 is false. Thisp part imports the original table values instead of copying the CREATE TABLE statement.

INSERT INTO cars_bkp    
SELECT * FROM cars
WHERE id IN ( SELECT MIN(id)    -- -- Step #2: This part creates a result set of unique rows. Refer to SOLUTION 4.
              FROM cars
              GROUP BY model, brand);

DROP TABLE cars;
ALTER TABLE cars_bkp RENAME to cars;   --  LOOK UP HOW TO RENAME COLUMNS IN SSMS. After deleting the orginal table, this part renames the backup table as the original.


--> SOLUTION 6: Using backup table without dropping the original table.
--------------------------------------------------------------------------
DROP TABLE IF EXISTS cars_bkp;
CREATE TABLE cars_bkp
AS
SELECT * FROM cars WHERE 1=2; 

INSERT INTO cars_bkp    
SELECT * FROM cars
WHERE id IN ( SELECT MIN(id)   
              FROM cars
              GROUP BY model, brand);

TRUNCATE TABLE cars;    -- TRUNCATE TABLE allows you to delete all the rows in the table but does not delete the table itself.

INSERT INTO cars
SELECT * FROM cars_bkp;    -- This part allows you to insert all values from the backup table into the original table.

DROP TABLE cars_bkp;


--> SOLUTION 3: Create a backup table and use distinct.
-------------------------------------------------------
SELECT * INTO cars_bkp FROM cars;    -- STEP #1: This creates a back up table by importing all data from the original table. table from 

SELECT DISTINCT * FROM cars_bkp;    -- STEP #2: Since the table has every row duplicated, a DISTINCT clause will remove duplicates.

DROP TABLE cars;    -- STEP #3: This part deletes the original table then renames the backup table to the original table name. REFER TO RDBMS documentation.
ALTER TABLE cars_bkp RENAME TO cars;    


--> SOLUTION 3: Create a backup table without dropping the original table.
---------------------------------------------------------------------------
-- SELECT * FROM cars_bkp ORDER BY id;
SELECT * INTO cars_bkp FROM cars;    -- STEP #1: This creates a back up table by importing all data from the original table. table from 

SELECT * FROM cars_bkp;    -- STEP #2: Since the table has every row duplicated, a DISTINCT clause will remove duplicates.

TRUNCATE TABLE cars_bkp;
INSERT INTO cars SELECT * from cars_bkp

DROP TABLE cars_bkp;
