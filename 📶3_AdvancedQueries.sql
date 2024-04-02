/*
This is a SQL guide for advanced level queries. 
We will be going over CTEs and temptables, recursive/hierachical queries, merge queries, and pivot queries. 
*/

-- How to handle duplicate rows.
WITH TableCTE AS
    (
    SELECT*,  ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) AS RowNumber
    FROM Employees
    )
DELETE FROM TableCTE WHERE RowNumber > 1 

    
-- Common Table Expressions are 
    WITH cteTable
    AS
    (
        SELECT TableName.ColumnName, TableName2.ColumnName
        FROM TableName tbl1
        INNER JOIN tbl1.IDColumnName = tbl2.IDColumnName
    )

-- Merge queries are ...
    MERGE INTO target_table USING source_table 
    ON merge_condition
    WHEN MATCHED THEN 
        UPDATE SET column1 = value1, column2 = value2,...
    WHEN NOT MATCHED THEN 
        INSERT (column1, column2,...) VALUES (value1, value2,...)
    WHEN NOT MATCHED BY SOURCE THEN
        DELETE;

https://www.youtube.com/watch?v=C7CPXeEvKN0
