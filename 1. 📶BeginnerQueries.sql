/*
This is a SQL guide for beginner level queries. 
We will be going over statement structure (the syntax and major clauses) and aggregate functions for data manipulation.
*/

-- This is the basic structure to retreive data from the db.
SELECT ColumnNames(s) AS RenameColumn(s)
FROM TableName

-- JOIN clauses allow you to pull data from multiple tables. Know when to use each.
  
INNER JOIN TableName1 `AS` RenamedTable ON RenameTableName1.IDColumnName `=` *TableNameAbbr2.IDColumnName*

LEFT JOIN
RIGHT JOIN

ORDER BY` Sorts the results based on specified criteria
> 
> `WHERE` Filters rows based on specified conditions. Often uses operators 
>> (*Operators are `=`, `>=` Greater than or equal to, `<` Less than, `<>` Not Equal, `AND` multiple conditions `BETWEEN` a range, `LIKE` Search for Patterns, `IN` Specify desired values*)
> (*Conditions for strings/text use wildcards `%` represents zero or multiple characters `_` represents a single character*)
> Limit commands *limit* the number of rows returned. Ex: `TOP` `LIMIT`
</details>

<details>
  <summary>Aggregate Functions perform calculations on value sets and returns a single result. RDBMS uses different versions, simply search their aggregate function documentation.</summary>
<br />
very 

> `GROUP BY` 
> Examples include `SUM()` `AVG()` `MIN()` `MAX()` `COUNT()` `GROUP_CONCAT()()` `STDEV() / STDEV_SAMP() / STDEV_POP()` `VAR()` `COUNT()` `COUNT()`
>
> `GETDATE()` Autofill rows for a Date Column.
> 
> `DISTINCT` Removes duplicate records from a column.
