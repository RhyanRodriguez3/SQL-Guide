/*
This is a SQL guide for advanced level queries. 
We will be going over merge queries and pivot queries, CTEs and temptables.
*/

-- How to handle duplicate rows.
WITH TableCTE AS
    (
    SELECT*,  ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) AS RowNumber
    FROM Employees
    )
DELETE FROM TableCTE WHERE RowNumber > 1 

    
-- Common Table Expressions are ...
    WITH cteTable
    AS
    (
        SELECT TableName.ColumnName, TableName2.ColumnName
        FROM TableName tbl1
        INNER JOIN tbl1.IDColumnName = tbl2.IDColumnName
    )
