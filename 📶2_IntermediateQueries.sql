/*
This is a SQL guide for intermediate level queries. 
We will be going over subqueries and common windows functions.
For a list of all SQL functions and syntax, refer to the RDBMS documentation. 
*/

        
-- Subqueries is creating a query to reference another query's results. Can be used to combine data from other tables. 
    SELECT TableName.ColumnName  -- Subqueries can be used in the select clause to create another column. Usually used for grouped column functions.
    FROM TableName tbl1
    WHERE ColumnName IN ( -- TIP: Instead of multiple OR clauses, use IN clause.
                        SELECT DISTINCT ColumnName AS 'RenamedColumn' -- The inner query can only have 1 column to retrieve.
                        FROM TableName2 tbl2
                        WHERE ColumnName IS NOT NULL
                        )

-- Windows functions allow users to partition, or group based on columns values.  
        SELECT ColumnName1, FUNCTION(ColumnName) OVER(PARTITION BY ColumnName) -- Where the GROUP BY filters each ColumnName it uses the function on PARTITION is independant and uses the function on the total unfiltered column.
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
