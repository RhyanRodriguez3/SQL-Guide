/*
This is a repo of commonly asked Business Interview Q&A as well as codes for reuse.
The SQL used is MS SQL Server.
*/


-- How to find the nth highest value. This example showcases multiple solutions to get the same results.
    SELECT DISTINCT MAX(ColumnName) FROM TableName tbl1 ORDER BY ColumnName DESC; -- I would first try to find a unique list of all values.

    SELECT TOP 5 * ColumnName FROM TableName tbl1 ORDER BY ColumnName DESC; -- This is my solution to getting a list of the top 5 values.

    SELECT TOP 1 ColumnName -- This solution uses a subquery to create a customizable list of top values.
    FROM (
         SELECT DISTINCT TOP 3 ColumnName FROM TableName tbl1 ORDER BY ColumnName DESC
         ) AS SubQueryResult1
    ORDER BY ColumnName

    WITH cteName AS -- Another solution using CTE to create a customizable query that creates a list of values.
        (
        SELECT ColumnName, 
          DENSE RANK() OVER(ORDER BY ColumnName DESC) AS RankedColumnName -- DENSE_RANK function creates a unique list. Idk why you would do this rather than just create a list of top 1 and filter with the WHERE clause.
        FROM TableName tbl1
        )
    SELECT TOP 1 ColumnName
    FROM cteName
    WHERE cteName.RankedColumn = 'N'


-- Use a recursive CTE and SELF JOIN to pull hierchical data. 
    Declare @ID int ;
    Set @ID = 7; -- This creates a global variable.
    
    WITH cteName AS
        (
         Select PrimaryKeyColumn, ColumnNameID, ColumnNameID -- Anchor: Creates result set R0 used as the input for the recursive part.
         From Tble1
         Where ColumnName = @ID
         
         UNION ALL -- This query appends the below query results to the query above. 
         
         Select PrimaryKeyColumn, ColumnNameID, ColumnNameID -- Recursive Part: This query joins the CTE ID to the ColumnID using the anchor as input and repeats until it is null.
         From Tble1
         JOIN cteName
         ON Tble1.ColumnID = cteName.ColumnID
        )
    
    Select Tble1.ColumnName, ISNULL(E2.EmployeeName, 'YourCondition') AS FUNCTIONColumn
    From cteName E1
    LEFT Join cteName E2 -- This is the SELF JOIN section, which duplicates the columns so you can pull columns side by side.
    ON E1.ManagerID = E2.EmployeeId


-- Handling NULL or Empty string. NULL is the absence of a value. Empty means the value has a string data type. This query finds all null values and replaces it with an empty string.
    SELECT TableName.ColumnName
    FROM TableName tbl1
    WHERE ISNULL(ColumnName, '') = ''

-- To remove duplicate values, created a window function (usually ROW_NUM or DENSE_RANK) and partition the ID row group. 
    WITH cteName AS
        (
         Select *, ROW_NUMBER() OVER(PARTITION BY ColumnName ORDER BY ColumnName) AS RowNumColumn -- Creates result column that assigns sequential numbers to rank or number the ID column.
         From Tble1
         Where 
        )
    DELETE FROM cteName WHERE RowNumColumn > 1 -- This deletes all rows whose IDs repeat. To delete duplicates means the ID columns are the same.

-- To find employees fired in the last month. https://www.youtube.com/watch?v=mnJze9kTGYU&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=5
    
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
