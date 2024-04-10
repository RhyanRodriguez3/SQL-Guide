/*
SUMMARY: SQL Server Data Cleansing Project. Guide on the steps to cleaning data.

STEPS
    1: Count the rows and columns.
    2. Define columns and their values. Document unknowns.
    3. Find null or empty values in seemingly important data (numeric (prices, amnt, etc.), string).
    4. Then analyze data and make calculated columns.

SOURCE
https://www.youtube.com/watch?v=8rO7ztF4NtU&list=PLUaB-1hjhk8H48Pj32z4GZgGWyylqv85f&index=3
https://www.analystbuilder.com/courses/mysql-for-data-analytics - 
https://www.youtube.com/watch?v=X6-VNKe3XVM - Useful SQL concepts.
https://www.youtube.com/watch?v=8rO7ztF4NtU&list=PLUaB-1hjhk8H48Pj32z4GZgGWyylqv85f&index=3 - ALex the Analyst Data Cleansing project.
*/

The first thing I should do is see if I can keep up with the video

write the overall concepts
Write down the steps
Categorize the steps and concepts

CLEAN DATA
1. Import into SSMS from Excel
> DestInation is SQL SERVER NATIVE CLIENT 11
> Then rename the table

2. Once data is imported into SSMS
-> Get an overview of the data with a select * statement
-> Check data types per column and update data types of the dbo.table using UPDATE, SET, and CONVERT.
-> Find all NULLs using SELECT * FROM dbo.tbl WHERE column1 IS NULL 
--> TIPS: Use SELF JOIN and IS NULL to replace NULL values. Then use UPDATE and SET to update the table column values.
-> Break down long text strings into smaller units. (First Name, Last Name, Address.)
--> TIP: Use SUBSTRING and CHARINDEX to break the first delimiter. Use LEN(Column1) to get the second half of the string.
--> TIP: Use PARSENAME and REPLACE to find the delimiter and break it into seperate columns.
-> Count each unique value in every column. Bin and normalzie the values in each column. (ex: 'Y' = 'Yes' = 'y')
-> Remove Duplicates: Standard practice is to create temp tables then delete the duplicates.
--> Use a windows function ROW_NUMBER and partition by the group of unique values as identifiers. Create a CTE to delete the duplicates.
-> Delete unused column. TIP: USE DROP COLUMN(s)

/* =================================================================================================================================
-- STEP #1: Find nulls or other useless values in data. NULL is the absence of a value. Empty means the value has a string data type. 
==================================================================================================================================== */
SELECT *
FROM tbl1
WHERE Column1 IS NULL OR Column1 = "" -- Repeat for all columns to find all NULLs.

DELETE    -- Once you've identified the NULLs, delete them.
FROM tbl1
WHERE Column1 IS NULL    
    OR Column2 IS NULL    
    OR Column3 IS NULL
    OR Column4 IS NULL
    OR Column5 IS NULL


    
/* ===========================================================================================================================================================
STEP #2: Find rows where datatype is 'Invalid.' The idea here is getting a list of values in each column and handling NULLs, empty string, and binning values.
============================================================================================================================================================== */
SELECT * FROM tbl1 WHERE Column1 = 'Invalid';    -- Step1 is finding the columns with invalid data types.

SELECT DISTINCT Column1 FROM tbl1;    -- Step2 is getting a unique list of all values in that column.
SELECT DISTINCT [Column1] FROM tbl1 WHERE [Column1] LIKE 'Value%';    -- This pulls a list of all similar values in that column.
SELECT [Column1] FROM tbl1 WHERE [Column1] IN ('ValueBin1', 'ValueBin2', 'etc');    -- This finds values in that column. SELECT multiple columns to do comparisons.

UPDATE dbo.tbl1 SET [Column1] = 'Value1' WHERE [Column1] = 'Value1';    -- Step3: Update the column and bin similar values based on column comparisons.



/* =========================================================================
-- STEP #3: Wrangling Data is when you handling column values with functions.
=========================================================================== */
SELECT YEAR(DateColumn) FROM tbl1 ORDER BY YEAR(DateColumn);    -- This creates a column that parses the year from the date column.

-- Handling text/string values.
SELECT CONCAT(UPPER(SUBSTRING([Column1], 1, 1)), LOWER(SUBSTRING([Column1], 2, LEN(Column1)))) AS "Column Proper Case"    -- Transforms string into camel case.

SELECT TRIM([Column1]) FROM tbl1    -- The TRIM function removes white space. 

SELECT CAST(Column1 AS FLOAT) AS FloatColumn FROM tbl1 ORDER BY FloatColumn;    -- CAST function changes the data type of the column.

SELECT COALESCE(Column1, Column2) AS Column_Info FROM tbl1 ORDER BY Column_Info;    -- COALESCE returns non-null values from the specified columns. 
    
-- To rename a column
sp_rename 'dbo.tble.ColumnName','ColumnRename','COLUMN'

-- To wrangle the time column then update the table.
SELECT TimeColumn, SUBSTRING([TimeColumn],1,2),
    CASE
        WHEN SUBSTRING([TimeColumn], 1, 2) < '04' THEN 'Morning Shift'    -- The SUBSTRING function parses the values in the time column. You bin those values based on time format.
        WHEN SUBSTRING([TimeColumn], 1, 2) >= '04' AND SUBSTRING([TimeColumn], 1, 2) < '15' THEN 'Afternoon Shift'
        WHEN SUBSTRING([TimeColumn], 1, 2) >= '15' AND SUBSTRING([TimeColumn], 1, 2) < '22' THEN 'Evening Shift'
    ELSE [TimeColumn]
END AS Shift_Name
FROM tble
ORDER BY Shift_Name

UPDATE dbo.tbl
SET [TimeColumn] = (CASE
                        WHEN SUBSTRING([TimeColumn], 1, 2) < '04' THEN 'Morning Shift'    -- The SUBSTRING function parses the values in the time column. You bin those values based on time format.
                        WHEN SUBSTRING([TimeColumn], 1, 2) >= '04' AND SUBSTRING([TimeColumn], 1, 2) < '15' THEN 'Afternoon Shift'
                        WHEN SUBSTRING([TimeColumn], 1, 2) >= '15' AND SUBSTRING([TimeColumn], 1, 2) < '22' THEN 'Evening Shift'
                        ELSE [TimeColumn]
                    END AS Shift_Name
                    );



