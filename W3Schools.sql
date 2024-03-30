/*Data Manipulation: Create a table that only includes the columns you want, 
returns the opposite codition, filters records, and sorts records.*/

SELECT DISTINCT Column1, Column2, Column3 as NewColumn3Name,
FROM table_name
WHERE NOT condition1 AND (column2 LIKE 'condition1' OR column2 LIKE 'condition2')
ORDER BY column1 ASC, column2 DESC;

-- Turn data type str into int and rename new column 
SELECT *, Column1, CAST(REPLACE(Price,'$','')), AS UNSIGNED) AS [NewColumnName]
FROM table_name;

-- Insert multiple new records in a table.
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...),
(value1, value2, value3, ...);

/*
Joins
Inner Joins are best for only keeping the columns from both tables
Left and right joins are best for keeping only the similar columns and one table
Full outer joins combine and pull all the table column.
*/
