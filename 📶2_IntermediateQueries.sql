/*
This is a SQL guide for intermediate level queries. 
We will be going over subqueries, windows functions, handling NULL values and how to handle other common data problems.
For a list of all SQL functions and syntax, refer to the RDBMS documentation. 
*/

        
-- Subqueries is creating a query and using the results from that query as a substitute for the table. TIP: Instead of multiple OR clauses, use IN clause.
    SELECT TableName.ColumnName
    FROM TableName tbl1
    WHERE ColumnName IN (
                        SELECT DISTINCT TableName.ColumnName  -- A query run inside of another query.
                        FROM TableName tbl1
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
