/*
This is a repo of commonly asked Business Interview Q&A as well as codes for reuse.
The SQL used is MS SQL Server.
*/


-- How to find nulls or other useless values in data. NULL is the absence of a value. Empty means the value has a string data type. 
    SELECT *
    FROM TableName tbl1
    WHERE ColumnName IS NULL OR ColumnName = ''  -- I'd repeat this for all columns. Still looking if this is the only way to do this.

        
-- How to handle replacing NULLs and empty strings.
    SELECT ColumnName,
        ISNULL(ColumnName, 'YourValue') AS YourColumn, -- ISNULL function only works on one expression while the COALESCE function works on multiple.
        COALESCE(ColumnName1, ColumnName2, ColumnName3, 'YourValue') AS YourColumn
    FROM TableName tbl1

        
-- To remove duplicate values, create a window function (usually ROW_NUM or DENSE_RANK) and partition the ID column. Use a CTE because you don't want to delete the db rows.
    WITH cteName AS
        (
         Select *, ROW_NUMBER() OVER(PARTITION BY IDColumn ORDER BY IDColumn) AS YourColumnName -- Creates calccolumn that assigns sequential numbers to rank or number the ID column.
         From Tble1 
        )
    DELETE FROM cteName WHERE RowNumColumn > 1 -- This deletes all rows whose IDs repeat. To delete duplicates means the ID columns are the same.

    -- To find duplicate records
    SELECT IDColumn, COUNT(*)
    FROM Tble1
    GROUP BY IDColumn
    HAVING COUNT(*) > 1;

        
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


-- To find employees fired in the last month. Replace the YEAR function with your date time frame. GETDATE results in todays date.
    Select *, DATEDIFF(YEAR, DateColumn, GETDATE()) AS YourDateColumn
    From Tble1
    Where DATEDIFF(YEAR, DateColumn, GETDATE()) BETWEEN 1 and 30
    ORDER BY DateColumn DESC


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

-- To analyze the dataset. Major aggregate functions and windows functions perform operations on specific columns.
    SELECT Column1, FUNCTION(*) AS YourColumn
    FROM tble1
    JOIN tble2 ON tble2.IDColumn = tble1.IDColumn
    GROUP BY Column1 DESC


-- To manipulate string values using LIKE, CHARINDEX, LEFT, RIGHT, SUBSTRING.
    SELECT * FROM tble1 WHERE Column1 LIKE 'M%' -- Results in all columns that begin with M
    SELECT * FROM tble1 WHERE Column1 LEFT(Column1, 1) = 'M' -- Results in columns where the 1st letter starts with M
    SELECT * FROM tble1 WHERE Column1 SUBSTRING(Colum1, 1, 1) = 'M'


-- To seperate numbers and strings. Create a User Defined Function (UDF). https://www.youtube.com/watch?v=dcRVNM0yv9o&list=PL6n9fhu94yhXcztdLO7i6mdyaegC8CJwR&index=20
    CREATE FUNCTION YourUDFName
    (
    @INPUT VARCHAR(amnt)
    )
    RETURNS VARCHAR(amnt)
    AS
    BEGIN
        DECLARE @AlphabetIndex INT = PATINDEX('%[0-9]%', @INPUT)
        BEGIN
            WHILE @AlphabetIndex > 0
            BEGIN
                SET @INPUT = STUFF(@INPUT, @AlphabetIndex, -1, '')
                SET @INPUT = PATINDEX('%[0-9]%', @INPUT)
            END
        END
        RETURN ISNULL(@INPUT, 0)
    END
        


-- Handling date related questions
    CAST(DateColumn AS DATE) AS YourColumn -- Used to convert a date column to a date type
    YEAR(DateColumn), MONTH(DateColumn), DAY(DateColumn) -- Parses the date by month, day, and year.
    GETDATE() -- Generates todays date
    CAST(DateColumn AS DATE) AS YourColumn -- Used to convert a date column to a date type


-- To turn month columns into quarters. https://www.youtube.com/watch?v=Xe0bVqjqRGE
    SELECT 
        YEAR(DateColumn) AS YearColumn
        ,MONTH(DateColumn) AS MonthColumn
        ,DAY(DateColumn) AS DayColumn,
        ,DATEPART(QUARTER, DateColumn) AS QtrColumn
    FROM tble1
    GROUP BY YearColumn, MonthColumn, DayColumn, QtrColumn
    ORDER BY DateColumn DESC
        
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
