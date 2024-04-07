/*
Project: Learn how to clean raw data with SQL and analyze data with SQL. 
Use web browser SQL lite (https://sqliteonline.com/syntax/all_functions)
Dataset: https://www.kaggle.com/datasets/atharvaarya25/financials/data
*/

/* =================================================================
STEP 1: Download the data as a CSV file then import into SQL server. 
    LESSON: Get comfortable being unsure of the data and guessing if what your doing is wrong. Write your questions down and logically problem solve.
==================================================================== */

/* ======================================================================
STEP 2: Create a table and import the csv dataset values into SQL server.
    LESSON #1: Troubleshoot the import. Test whether I can convert the data types and conduct regular EDA as usual or if I have to correct the import.
    LESSON #2: Count total rows and define columns to identify the useless/excess data.
========================================================================= */

-- There main data types are numeric, string, and date. TIP: Use a SELECT ALL to verify import.
DROP TABLE IF EXISTS YourTableName;
CREATE TABLE YourTableName 
(
  Segment TEXT -- Get comfortable not knowing what a column name means, and make assumptions of its values.
  ,Country TEXT
  ,Product VARCHAR(100)
  ,UnitsSold INT
  ,Sales INT
  ,DateColumn DATE -- You can parse and manipulate the date column.
);

-- To update the data type of a column and rename a column.
ALTER TABLE YourTableName ALTER COLUMN ColumnName YourDataType(YourSize) NOT NULL
ALTER TABLE YourTableName RENAME COLUMN ColumnName TO YourRenamedColumnName

-- Count total table rows. Manually count the columns, REFER TO DOCUMENTATION.
SELECT COUNT(*) 
FROM YourTable;

-- Find nulls or '' then replace values.
SELECT * 
from YourTable
WHERE YourColumn(s) is NULL OR '';

SELECT ISNULL(column_name,'Value if Null') -- This works for single columns
SELECT COALESCE(column_name(s),'Value if Null') -- This works for multiple columns

-- Find duplicates. Use DISTINCT.
SELECT IDColumn, COUNT(IDColumn)
FROM YourTable
GROUP BY IDColumn
HAVING COUNT(IDColumn) > 1 

DELETE FROM YourTable  -- Deletes duplicates from the table.
WHERE IDColumn > 1  

Table 1 could possibly have duplicates Write a query to read unique records from Table 1.
Display average GPA by college and academic year
Display the top 3 students within each college
Write a python query to read csv and pandas. 
Look up temp tables
stored procedures
EdX data science course
