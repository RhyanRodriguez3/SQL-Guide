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
        ORDER BY ColumnNameYouWantSorted ON SpecifiedCriteria
        LIMIT or TOP;


-- Aggregate functions are calculations on data that return a summary row. RDBMS functions very, so simply your RDBMS' aggregate function documentation.
        SELECT ColumnNames(s) AS RenameColumn(s)
        FROM TableName
        JOIN TableName1 AS RenamedTable ON RenamedTable1.IDColumnName = RenamedTable2.IDColumnName
        WHERE YourCondition
        GROUP BY 
SUM(), AVG(), MIN(), MAX(), COUNT(), ()` `STDEV() / STDEV_SAMP() / STDEV_POP()` `VAR()` `COUNT()` `COUNT()`
GETDATE() Autofill rows for a Date Column.
GROUP_CONCAT()
DISTINCT Removes duplicate records from a column.


-- Handling Date Columns
        SELECT ColumnNames(s) AS RenameColumn(s)
        FROM TableName
        WHERE CAST(DateColumn AS Date) = 'SpecifiedDate'







