/*
This is a SQL guide for intermediate level queries. 
We will be going over subqueries and common windows functions.
For a list of all SQL functions and syntax, refer to the RDBMS documentation.

SOURCES
Alex the Analyst - https://www.youtube.com/channel/UC7cs8q-gJRlGwj4A8OmCmXg/playlists
Colt Steele - https://www.youtube.com/watch?v=y1KCM8vbYe4&t=310s
*/
Self Join for heirechical data. To relate one event to another.
Running totals with and without windows functions.
Find nulls with SUM(CASE WHEN())
Pros and Cons of Indexing. Understand system design.
Know the difference between WHERE and HAVING.

-- Subqueries are nested queries used for filtering, joining, or aggregating data within a larger query.
    SELECT TableName.ColumnName  -- Subqueries can also be used in the select clause to create calculated columns.
    FROM TableName tbl1
    WHERE ColumnName IN ( 
                        SELECT DISTINCT ColumnName AS 'RenamedColumn' -- The inner query results in a smaller table.
                        FROM TableName2 tbl2
                        WHERE ColumnName IS NOT NULL
                        )
        
-- Common Table Expressions (CTE)s are a named result set used to manipulate complex subqueried data. Often used as a substitute for temp tables.
WITH cteName AS    -- TIP: CTE is not stored anywhere so it must be rerun.
(
 InputQuery
)
SELECT * FROM cteName    -- SELECT must be used right after the CTE.


-- Temp Table is created  Used in Stored Procedures
DROP TABLE IF EXISTS #Temp_tableName    -- Temp Tables are created, so you will receive an error so run this.
CREATE TABLE #Temp_tableName
(
    Column1, DataType    -- These are the columns structure you want to add data into.
    Column2, DataType
    Column3, DataType
)

INSERT INTO #temp_tableName SELECT * FROM OriginalTbl


-- WINDOW FUNCTIONS perform aggregate operations on groups of rows, and produce results for each row.
-- Create a windows functions useing the OVER() function. Windows functions perform aggregate operations on groups of rows. This allow users to partition based on row groups, as opposed to GROUP BY, which filters rows per column.
        SELECT ColumnName1, 
            WINDOW FUNCTION(ColumnName) 
                    OVER(    -- The OVER clause creates a window. A window is a subset of rows
                        PARTITION BY ColumnName    -- The PARTITION BY clause specifies the row group you want the function to perform on.
                        ORDER BY ColumnName  -- You can use the ORDER BY clause to sort rows within each window.
                        ) AS RenamePartitionCalcColumn   -- This is just another calculated column.
        FROM TableName tbl1
        JOIN TableName tbl2 ON tbl.ID = tbl2.ID

            
-- There are some function which can only be used with window function(s). Refer to your RDBMS documentation for a full list. Common ones below:
        LAG() -- Retrieve / use the previous row within the partition
        LEAD() -- 
        RANK() -- Rank of row value within the partition. When there are duplicate values, it skips over them.
        DENSE_RANK()
        PERCENT_RANK
        ROW_NUMBER()
        LAST_VALUE()
        CUME_DIST()

-- Rolling total is a windows functions that adds values from previous rows.
        SELECT ColumnName1, FUNCTION(ColumnName) OVER(PARTITION BY ColumnName ORDER BY ColumnName) AS RollingTotalColumn
        FROM TableName tbl1
        JOIN TableName tbl2 ON tbl.ID = tbl2.ID
            
-- Row_Num is a windows functions that indexes/assigns unique IDs to every row.
        SELECT ColumnName1,
            ROW_NUMBER() OVER(PARTITION BY ColumnName ORDER BY ColumnName DESC) AS RowNumColumn
            RANK() OVER(PARTITION BY ColumnName ORDER BY ColumnName DESC) AS RankColumn
        FROM TableName tbl1
        JOIN TableName tbl2 ON tbl.ID = tbl2.ID

