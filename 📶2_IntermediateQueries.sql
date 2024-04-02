/*
This is a SQL guide for intermediate level queries. 
We will be going over subqueries and common windows functions.
For a list of all SQL functions and syntax, refer to the RDBMS documentation. 
*/

        
-- Subqueries are nested queries used for filtering, joining, or aggregating data within a larger query.
    SELECT TableName.ColumnName  -- Subqueries can also be used in the select clause to create calculated columns.
    FROM TableName tbl1
    WHERE ColumnName IN ( 
                        SELECT DISTINCT ColumnName AS 'RenamedColumn' -- The inner query results in a smaller table.
                        FROM TableName2 tbl2
                        WHERE ColumnName IS NOT NULL
                        )

-- Windows functions allow users to partition instead of using GROUP BY to filters rows ber ColumnName.
        SELECT ColumnName1, 
            FUNCTION(ColumnName) 
                    OVER(    -- The OVER clause creates a window. A window is a subset of rows
                        PARTITION BY ColumnName    -- The PARTITION BY clause groups rows.
                        ) AS RenamePartitionCalcColumn  
        FROM TableName tbl1
        JOIN TableName tbl2 ON tbl.ID = tbl2.ID

-- Rolling total is a windows functions that adds values from previous rows.
        SELECT ColumnName1, FUNCTION(ColumnName) OVER(PARTITION BY ColumnName ORDER BY ColumnName) AS RollingTotalColumn
        FROM TableName tbl1
        JOIN TableName tbl2 ON tbl.ID = tbl2.ID
            
-- Row_Num is a windows functions that indexes/assigns unique IDs to every row.
        SELECT ColumnName1
        ROW_NUMBER() OVER(PARTITION BY ColumnName ORDER BY ColumnName DESC) AS RowNumColumn
        RANK() OVER(PARTITION BY ColumnName ORDER BY ColumnName DESC) AS RankColumn
        FROM TableName tbl1
        JOIN TableName tbl2 ON tbl.ID = tbl2.ID
