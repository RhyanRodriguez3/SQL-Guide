/*
This is a SQL guide for beginner level queries. 
We will be going over statement structure (the syntax and major clauses) and aggregate functions for data manipulation.
*/


-- This is the basic statement structure to retreive data from the db.
        SELECT ColumnNames(s) AS RenameColumn(s)
        FROM TableName
        JOIN TableName1 AS RenamedTable ON RenamedTable1.IDColumnName = RenamedTable2.IDColumnName
          /*
          JOIN clauses allow you to pull data from multiple tables.
          INNER JOIN only pulls rows from tables that match, and exclude values that don't.
          LEFT/RIGHT JOINs pull rows based on the original table columns. 
          FULL OUTER JOIN pulls all table columns.
          */
        WHERE YourCondition -- Filters rows based on specified conditions. You define the conditions with operators. 
          /*
          Operators: 
            '=', '>=' (Greater than or equal to), '<>' Not Equal, 
            'AND' (Specify multiple conditions), 'BETWEEN' (Specify a range), 'LIKE' (Search for Patterns), 'IN' (Specify your desired values)
          Strings/text values are
            '%' wildcard which represents zero or multiple characters, '_' represents a single character*
          */
        GROUP BY ColumnName(s) -- Used to group rows that have the same values into summary rows.
        ORDER BY ColumnNameYouWantSorted ON SpecifiedCriteria -- Sort the query result.
        LIMIT / TOP;


-- Functions are calculations to handle dataset values. For a list of all SQL functions and syntax, refer to the RDBMS documentation. The ones below are the most commonly used.
        FUNCTIONS
                SUM(), AVG(), MIN(), MAX(), COUNT(), STDEV() / STDEV_SAMP() / STDEV_POP(), VAR()
                HAVING -- Used to replace the WHERE clause for aggreate functions.
                GROUP_CONCAT()
                DISTINCT Removes duplicate records from a column.




