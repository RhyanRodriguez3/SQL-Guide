/*
This is a SQL guide for intermediate level queries. 
We will be going over subqueries, windows functions, handling NULL values and how to handle other common data problems.
For a list of all SQL functions and syntax, refer to the RDBMS documentation. 
*/

        
-- Subqueries is creating a query to reference another query's results. Can be used to combine data from other tables. 
    SELECT TableName.ColumnName  -- Subqueries can be used in the select clause to create another column. Usually used for column total functions.
    FROM TableName tbl1
    WHERE ColumnName IN ( -- TIP: Instead of multiple OR clauses, use IN clause.
                        SELECT DISTINCT ColumnName AS 'RenamedColumn' -- The inner query can only have 1 column to retrieve.
                        FROM TableName2 tbl2
                        WHERE ColumnName IS NOT NULL
                        )


-- Comomon Table Expressions are  JOIN is when you join a table to itself. Used for hierchical data, when you need to find data connected to other data values within the same table.
    WITH cteTable
    AS
    (
        SELECT TableName.ColumnName, TableName2.ColumnName
        FROM TableName tbl1
        INNER JOIN tbl1.IDColumnName = tbl2.IDColumnName
    )
