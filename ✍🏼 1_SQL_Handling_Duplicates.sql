/* ====================================================== 
Guide on how to handle duplicates in a data set with SQL.

There are two types of duplicates. The idea is to create an ID column that is unique. 
#1 - Duplicates where row values are the same based on COLUMNS. To solve, create a unique ID column based on grouped values. REFER TO SOLUTIONS 1, 3, and 4.
#2 - Duplicates where ALL ROWS are the exact same in the table, including the ID column. To solve, use DISTINCT. REFER TO SOLUTIONS 2.
========================================================= */

-- Sample Data
drop table if exists cars;
create table cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018); -- Rerun these queries to insert deleted rows back into table.
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021); -- Rerun these queries to insert deleted rows back into table.


SELECT * FROM cars ORDER BY model, brand;

/* ========================
Duplicate Type #1 Solutions
========================= */

--> SOLUTION 1: Delete using Unique identifier. 
-----------------------------------------------
DELETE FROM cars	-- Step #2: If the dataset already has unique ID, create a SELECT statement to find the ones you want to delete.
WHERE id IN ( 
	     SELECT model, brand, COUNT(*) AS CountOfID    -- Aggregate function used to count each row.
	     FROM cars	
	     GROUP BY model, brand    -- Step #1: Define the duplicate values in the columns, then group them.
	     HAVING COUNT(*) > 1    -- This part counts all the grouped table rows.
	     ORDER BY CountOfID
	    ); 


--> SOLUTION 2: Delete using SELF JOIN, which joins the table into itself.
--------------------------------------------------------------------------
DELETE FROM cars
WHERE id IN ( SELECT c1.id   
              FROM cars c1
              JOIN cars c2    -- TIP: When JOIN not specified, defaults to INNER JOIN.
		ON c1.model = c2.model AND c1.brand = c2.brand    -- Step #1: This part joins the table into itself using column values as IDs, then attaches the column.								     
              WHERE c1.id > c2.id    -- Step #2: This performs the operation on each row and returns rows that result NO. NO means the grouped values return duplicates.
	     );    


--> SOLUTION 3: Using the ROW_NUMBER Window function.
-----------------------------------------------------
DELETE FROM cars
WHERE id IN ( SELECT id
              FROM (SELECT *
                   , ROW_NUMBER() OVER(PARTITION BY model, brand ORDER BY id) AS RowNum    -- Step #1: Use a window function to number each row then order based on partitioned columns. 
                   FROM cars) x
              WHERE x.RowNum > 1); -- Step #2: The new column 'RowNum' has now become the ID column, so any value greater than 1 should be the duplicates. 


--> SOLUTION 4: Using MIN function. This deletes MULTIPLE duplicate records.
----------------------------------------------------------------------------
DELETE FROM cars
WHERE id not in ( SELECT MIN(id) AS MinID    -- Step #2: This part used the MIN function to create a column that returns the smallest ID column values.
                  FROM cars
                  GROUP BY model, brand    -- Step #1: This part filters the table based on these columns. 
		  ORDER BY MinID ASC
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



/* ========================
Duplicate Type #2 Solutions
========================= */
"The previous solutions will not work in this scenario because if you try to delete the data based on the ID column, you will delete the entire row."


--> SOLUTION 1: Delete using CTID. A CTID is a pseudo column that the RDBMS internally creates with every record. 
-----------------------------------------------------------------------------------------------------------------
SELECT * FROM cars ORDER BY id;

DELETE FROM cars	
WHERE ctid IN ( 
		SELECT MAX(ctid) AS CountOfCTID    -- SSMS does not have CTID. CTID only works in Postgres SQL! Oracle calls it RowID.
		FROM cars	
		GROUP BY model, brand   
		HAVING COUNT(*) > 1    
		ORDER BY CountOfCTID
	       );
			

--> SOLUTION 2: Create a temporary unique id column. This solution works in ANY RDBMS. Same concept as CTID but you use row_number instead.
-------------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE cars 
	ADD row_num Int IDENTITY(1,1) NOT NULL    -- Step #1: This part creates an ID column that counts each row.

DELETE FROM cars	
WHERE row_num IN ( 
		  SELECT MAX(row_num) AS CountOfRow_Num    -- Step #2: REFER TO SOLUTION #1 for syntax. The MAX function selects the highest values of your new ID row_num.
		  FROM cars	
		  GROUP BY model, brand   
		  HAVING COUNT(*) > 1   
		  ORDER BY CountOfRow_Num
		 );

ALTER TABLE cars 
	DROP COLUMN row_num;


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
