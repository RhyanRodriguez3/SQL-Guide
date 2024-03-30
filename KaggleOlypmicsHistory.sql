-- Data sourced from RGRIFFIN Kaggle dataset "120 years of Olympic history: athletes and results"

-- View csv files in excel. Load each csv file as tables into db. Reuse this code to create tables. 
DROP TABLE IF EXISTS OlympicHistory;
CREATE TABLE IF NOT EXISTS OlympicHistory 
(
  ColumnName1  INT,
  ColumnName2  VARCHAR,
  ColumnName3  VARCHAR,
  ColumnName4  VARCHAR,
  ColumnName5  VARCHAR,
  ColumnName6  VARCHAR,
  ColumnName7  VARCHAR,
  ColumnName8  VARCHAR,
  ColumnName9  VARCHAR,
);

SELECT * FROM tablenames; -- Test if the table was created with a SELECT * FROM tablenames;

-- To import the records, use the import feature in your RDBMS. Troubleshoot values if import errors.

WITH t1 AS  -- This creates a temp table
    (SELECT COUNT(GAMES) AS TotalSummerGames  -- Use DISTINCT to verify the query results first, then use the aggregate function
     FROM OlympicHistory
     WHERE Season = 'Summer' 
     ORDER BY columnname DESC)
t2 AS
  (SELECT ColumnName1, ColumnName2
     FROM TableName
     WHERE Season = 'Summer' 
     ORDER BY columnname DESC)
t3 AS
  (SELECT ColumnName1, COUNT(ColumnName2) AS NewColumnName2
  FROM t2
  GROUP BY columnname)

SELECT * 
FROM t3 
JOIN t1 on t1.TotalSummerGames = t3.NewColumnName2;
