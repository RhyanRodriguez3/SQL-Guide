/*
This is a SQL guide for intermediate level queries. 
We will be going over subqueries, handling NULL values, CTEs, Recursion, and windows functions.
*/


-- SELF JOIN is when you join a table to itself. Used for hierchical data, when you need to find data connected to other data values within the same table.
    SELECT TableName.ColumnName, TableName2.ColumnName
    FROM TableName tbl1
    INNER JOIN tbl1.IDColumnName = tbl2.IDColumnName


