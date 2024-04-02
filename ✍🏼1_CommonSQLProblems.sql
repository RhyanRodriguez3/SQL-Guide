/*
This is a repo of commonly asked Business Interview Q&A as well as codes for reuse.
The SQL used is MS SQL Server.
*/


-- How to find the nth highest value. Use Max() to find the highest value. Use a subquery to create a table for the second highest.
    SELECT DISTINCT MAX(ColumnName) FROM TableName tbl1 ORDER BY ColumnName DESC; -- I would first try to find a unique list of all values.

    SELECT TOP 5 * ColumnName FROM TableName tbl1 ORDER BY ColumnName DESC; -- This is my solution to getting a list of the top 5 values.

    SELECT TOP 1 ColumnName -- Another solution using subqueries to create a customizable list of top values.
    FROM (
         SELECT DISTINCT TOP 3 ColumnName FROM TableName tbl1 ORDER BY ColumnName DESC
         ) AS SubQueryResult1
    ORDER BY ColumnName

    WITH cteName AS -- Another solution using CTE to create a customizable query that creates a list of values.
        (
        SELECT ColumnName, 
          DENSE RANK() OVER(ORDER BY ColumnName DESC) AS RankedColumnName -- DENSE_RANK function creates a unique list 
        FROM TableName tbl1
        )
    SELECT TOP 1 ColumnName
    FROM cteName
    WHERE cteName.RankedColumn = 'N'

-- To get hierchical data use SELF JOIN, CTE, and Recursive CTE.
    WITH cteName AS (
                    SELECT ColumnName, 
                      DENSE RANK() OVER(ORDER BY ColumnName DESC) AS RankedColumnName -- DENSE_RANK function creates a unique list 
                    FROM TableName tbl1
                    )
        
-- Handling NULL or Empty string. NULL is the absence of a value. Empty means the value has a string data type.
    SELECT TableName.ColumnName
    FROM TableName tbl1
    WHERE ISNULL(ColumnName, '') = ''

-- Handle duplicate values
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
