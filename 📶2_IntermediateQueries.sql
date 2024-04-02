/*
This is a SQL guide for intermediate level queries. 
We will be going over subqueries, CTEs/Recursive JOINS, handling NULL values, and windows functions.
For a list of all SQL functions and syntax, refer to the RDBMS documentation. 
*/


-- Handling NULL or Empty string. NULL is the absence of a value. Empty is a string data type.
    SELECT TableName.ColumnName
    FROM TableName tbl1
    WHERE ISNULL(ColumnName, '') = ''

        
/*  
To handle dates registered as text datatypes, use Isdate(). Other date functions below.
    CAST()
    CONVERT()
    GETDATE()
*/
    SELECT ISDATE(ColumnName)
    FROM TableName tbl1
    WHERE ISDATE(DateColumn) = 1 AND 
            CASE 
                WHEN ISDATE(DateColumn) = 1
                THEN CAST(NULL AS DateType)
                ELSE CAST(DateColumn AS DateType)
            END < 'XX/XX/XXXX'


-- SELF JOIN is when you join a table to itself. Used for hierchical data, when you need to find data connected to other data values within the same table.
    SELECT TableName.ColumnName, TableName2.ColumnName
    FROM TableName tbl1
    INNER JOIN tbl1.IDColumnName = tbl2.IDColumnName

        
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
