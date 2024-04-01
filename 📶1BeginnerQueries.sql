/*
This is a SQL guide for beginner level queries. 
We will be going over statement structure (the syntax and major clauses) and aggregate functions for data manipulation.
*/

-- This is the basic structure to retreive data from the db.
SELECT ColumnNames(s) AS RenameColumn(s)
FROM TableName
JOIN TableName1 AS RenamedTable ON RenamedTable1.IDColumnName = RenamedTable2.IDColumnName
  /*
  JOIN clauses allow you to pull data from multiple tables.
  INNER JOIN only pulls records from tables that match, and exclude values that don't.
  LEFT/RIGHT JOINs pull records based on the original table columns. 
  FULL OUTER JOIN pulls all table columns.
  */
WHERE -- Filters rows based on specified conditions. Often uses operators 
/*Operators are `=`, `>=` Greater than or equal to, `<` Less than, `<>` Not Equal, `AND` multiple conditions `BETWEEN` a range, `LIKE` Search for Patterns, `IN` Specify desired values*)
> (*Conditions for strings/text use wildcards `%` represents zero or multiple characters `_` represents a single character*)
*/
  


  
ORDER BY` Sorts the results based on specified criteria
LIMIT commands *limit* the number of rows returned. Ex: `TOP` `LIMIT`



Aggregate Functions perform calculations on value sets and returns a single result. RDBMS uses different versions, simply search their aggregate function documentation
GROUP BY
Examples include `SUM()` `AVG()` `MIN()` `MAX()` `COUNT()` `GROUP_CONCAT()()` `STDEV() / STDEV_SAMP() / STDEV_POP()` `VAR()` `COUNT()` `COUNT()`
GETDATE() Autofill rows for a Date Column.
DISTINCT Removes duplicate records from a column.
