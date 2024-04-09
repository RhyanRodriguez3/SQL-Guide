/*
Understand how to analyze a data set. Go over use cases for temp tables, stored procedures, CTE, and Pivot queries. I'm sure its not that mu..uhhfkn complicated.
*/

-- To transform rows into columns (transpose) use PIVOT queries.
    SELECT ColumnValue1, ColumnValue2 -- Use a select statement to create the structure and name the columns as the values of the rows you want transposed
    (
        Select Column1, Column2
          'Column2Value' + CAST(ROW_NUMBER() OVER(PARTITION BY Column1 ORDER BY Column1)) AS DataType(amnt) AS YourColumn
        FROM tble1
    ) Temp
    PIVOT
    (
        MAX(City)
        FOR YourColumnName IN (ColumnsYouWantTransposed)
    )

-- Use a recursive CTE and SELF JOIN to pull hierchical data. 
-- Handle data functions
