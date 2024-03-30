-- Data sourced from RGRIFFIN Kaggle dataset "120 years of Olympic history: athletes and results"

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
SELECT * FROM TableName1; -- Test if the table was created. Then load/import records from the csv file as tables into db.

-- To import the records, use the import feature in your RDBMS. Troubleshoot values if import errors.
WITH t1 AS  -- Create a temp table to atomize the dataset and focus on specific parts of the question your looking for
    (SELECT COUNT(ColumnName1) AS NewColumnName1  -- Use DISTINCT to verify the query results first, then use the aggregate function
     FROM TableName
     WHERE YourCondition operator YourCondition 
     ORDER BY ColumnName DESC)
t2 AS -- Temp table created to divide the first part of the question into a specific dataset
  (SELECT ColumnName1, ColumnName2
     FROM TableName
     WHERE YourCondition operator YourCondition 
     ORDER BY ColumnName1 DESC)
t3 AS -- Temp table created to divide the second part of the question into a specific dataset
  (SELECT ColumnName1, COUNT(ColumnName2) AS NewColumnName2
  FROM t2
  GROUP BY columnname)
SELECT * -- Query that merges the datasets together to create the desired report
FROM t3 
JOIN t1 on t1.NewColumnName1 = t3.NewColumnName2;


SELECT * 
FROM TableName;
