/*
This is a SQL guide for beginner level queries. 
We will be going over statement structure (the syntax and major clauses) and basic functions for data manipulation.
*/


-- This is the basic statement structure to retreive data from the db.
        SELECT ColumnNames(s) AS RenameColumn(s)
        FROM TableName
        JOIN TableName1 AS RenamedTable ON RenamedTable1.IDColumnName = RenamedTable2.IDColumnName
          /*
          JOIN clauses allow you to pull data from multiple tables.
          INNER JOIN only pulls rows from table columns whose ID match, and exclude values that don't.
          LEFT/RIGHT JOINs pull rows based on the original table columns. 
          FULL OUTER JOIN pulls all table columns and rows.
          */
        WHERE YourCondition -- Filters rows based on specified conditions. You define the conditions with operators. 
          /*
          Operators: 
            '=', '>=' (Greater than or equal to), '<>' (Not Equal), 
            'AND' (Specify multiple conditions), 'BETWEEN' (Specify a range), 'LIKE' (Search for Patterns), 'IN' (Specify your desired values)
          String/text values are:
            '%' wildcard which represents zero or multiple characters, '_' represents a single character*
          */
        GROUP BY ColumnName(s) -- Used to group rows that have the same values into summary rows. Often followed by a function.
        HAVING FUNCTION(ColumnName) -- The HAVING clause replaces the WHERE clause when you need to specify a function as a condition.
        ORDER BY ColumnNameYouWantSorted ON SpecifiedCriteria -- Sort the query result.
        LIMIT;


-- SELF JOIN is when you join a table to itself. Used for hierchical data, when you need to find data connected to other data values within the same table.
    SELECT TableName.ColumnName, TableName2.ColumnName
    FROM TableName tbl1
    INNER JOIN tbl1.IDColumnName = tbl2.IDColumnName

            
-- Functions are calculations to handle dataset values. For a list of all SQL functions and syntax, refer to the RDBMS' documentation. The ones below are the most commonly used.
        FUNCTIONS
                SUM(), AVG(), MIN(), MAX(), COUNT(), STDEV() / STDEV_SAMP() / STDEV_POP(), VAR()
                HAVING -- Used to replace the WHERE clause for aggreate functions.
                GROUP_CONCAT()
                DISTINCT Removes duplicate records from a column.




