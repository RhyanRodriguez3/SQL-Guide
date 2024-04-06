/*
This is a no-bs project to get me ready using SQL to query and manipulate databases.
Download SSMS or use web browser SQL lite: https://sqliteonline.com/syntax/all_functions
Dataset #1: https://www.kaggle.com/datasets/atharvaarya25/financials/data
https://www.youtube.com/watch?v=EKOWoInn46A
*/

-- Download the data as a CSV file and save it online.

Table 1 could possibly have duplicates Write a query to read unique records from Table 1.
Display average GPA by college and academic year
Display the top 3 students within each college
Write a python query to read csv and pandas. 
Look up temp tables
stored procedures
EdX data science course
-- View csv files in excel. Reuse this code to create tables.   
DROP TABLE IF EXISTS TableName1;
CREATE TABLE IF NOT EXISTS TableName1 
(
  ColumnName1  INT,
  ColumnName2  VARCHAR,
  ColumnName3  VARCHAR,
  ColumnName4  DataType,
  ColumnName5  DataType,
  ColumnName6  DataType,
  ColumnName7  DataType,
  ColumnName8  DataType,
  ColumnName9  DataType,
);
SELECT * FROM TableName1; -- Test if the table was created. Then load/import records from the csv file as tables into db. TIP! ALWATS verify the query results first, then use functions
-- To import the records, use the import feature in your RDBMS. Troubleshoot values if import errors.


-- Turn data type str into int and rename new column 
SELECT *, Column1, CAST(REPLACE(Price,'$','')), AS UNSIGNED) AS [NewColumnName]
FROM table_name;


/* JOINS
Inner Joins are best for only keeping the columns from both tables
Left and right joins are best for keeping only the similar columns and one table
Full outer joins combine and pull all the table column.
*/


/* When problem solving, ask yourself "What variables does the client want to know? Where are those variables in the dataset? How can I manipulate the dataset to provide answers and automate the report?" */
WITH t1 AS  -- Create a temp table to atomize the dataset and focus on specific parts of the question your looking for
    (SELECT COUNT(ColumnName1) AS NewColumnName1  -- Creates a calculated column, which renames the column and computes the values in the sourced column
     FROM TableName
     WHERE YourCondition operator YourCondition  -- A WHERE clause is used to filter the column for desired values
     ORDER BY ColumnName DESC)
t2 AS -- Temp table created to divide the first part of the question into a specific dataset
  (SELECT ColumnName1, ColumnName2
     FROM TableName
     WHERE YourCondition operator YourCondition 
     ORDER BY ColumnName1 DESC)  -- ORDER BY sorts the values
t3 AS -- Temp table created to divide the second part of the question into a specific dataset
  (SELECT ColumnName1, COUNT(ColumnName2) AS NewColumnName2
  FROM t2
  GROUP BY columnname)  -- The GROUP BY clause is used to aggregate filtered values
SELECT * -- Query that merges the datasets together to create the desired report which answers the problem
FROM t3 
JOIN t1 on t1.NewColumnName1 = t3.NewColumnName2;


/* How can I manipulate the dataset to create measures and provide answers?" */
WITH T1 AS
  (SELECT ColumnName4, COUNT(ColumnName7) AS NewColumnName7 -- Create a new column and declare what is contained in that calculated column
  FROM TableName;
  WHERE YourCondition operator YourCondition
  GROUP BY ColumnName4
  ORDER BY COUNT(ColumnName7) DESC),
T2 AS
  (SELECT *, RANK() OVER(ORDER BY NewColumnName7 DESC) AS RNK
  FROM TableName;)
