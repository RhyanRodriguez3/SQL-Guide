/*
This is a repo of commonly asked Business Interview Q&A as well as codes for reuse.
The SQL used is MS SQL Server.
*/

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
SELECT TRIM([Column1]) FROM tbl1    -- The TRIM function removes white space. 

UPDATE dbo.tbl1 SET [Column1] = 'Value1' WHERE [Column1] = 'Value1';    -- Step3: Update the column and bin similar values based on column comparisons.



/* =========================================================================
-- STEP #3: Warngling Data is when you handling column values with functions.
=========================================================================== */
SELECT YEAR(DateColumn) FROM tbl1 ORDER BY YEAR(DateColumn);    -- This creates a column that parses the year from the date column.

-- This transforms the string value to a camel case.
SELECT CONCAT(UPPER(SUBSTRING([Column1], 1, 1)), LOWER(SUBSTRING([Column1], 2, LEN(Column1)))) AS "Column Proper Case"

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



