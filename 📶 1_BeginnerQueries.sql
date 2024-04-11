/*
This is a SQL guide for beginner level queries. 
We will be going over statement structure (the syntax and major clauses) and basic functions for data manipulation.
Beginner SQL means being able to import, structure, and clean data.

Beginner is basic knowledge. Intermediate is applicable knowledge. Advanced is just problem solving. 

RDBMS such as Oracle and MS SQL Server have different versions of the language but it was standardized by ANSI. Understand the language concepts and you can apply them to any RDBMS.
*/

step1 FROM 
step2 GROUP BY 
step3 HAVING
step4 WHERE
-- This is the basic statement structure to retreive data from the db.
        SELECT ColumnNames(s) AS RenameColumn(s)
        FROM TableName
        JOIN TableName1 AS RenamedTable ON RenamedTable1.IDColumnName = RenamedTable2.IDColumnName
            JOIN TableName3 AS RenamedTable3 ON RenamedTable2.IDColumnName = RenamedTable3.IDColumnName -- To JOIN more than one table, simply repeat the statement and connect the ID columns.
          /*
          JOIN clauses allow you to pull data from multiple tables.
          INNER JOIN only pulls rows from table columns whose ID match, and exclude values that don't.
          LEFT/RIGHT JOINs pull rows based on the original table columns. 
          FULL OUTER JOIN pulls all table columns and rows.
          */
        WHERE YourCondition -- Filters rows based on specified conditions. You define the conditions with operators. You cannot use the WHERE clause with aggregate functions.
          /*
          Operators: 
            '=', '>=' (Greater than or equal to), '<>' (Not Equal), 
            'AND' (Specify multiple conditions), 'BETWEEN' (Specify a range), 'LIKE' (Search for Patterns), 'IN' (Specify your desired values)
          String/text values are:
            '%' wildcard which represents zero or multiple characters, '_' represents a single character*
          */
        GROUP BY ColumnName(s) -- The GROUP BY clause groups rows that have the same values into summary rows. Often followed by a function.
        HAVING FUNCTION(ColumnName) -- The HAVING clause filters rows based on GROUPS. Cannot use without GROUP BY clause.
        ORDER BY ColumnNameYouWantSorted ON SpecifiedCriteria -- Sort the query result.
        LIMIT;


-- SELF JOIN is when you join a table to itself. Used for hierchical data, when you need to find data IDs connected to other columns within the same table and creating duplicate columns.
    SELECT TableName.ColumnName, TableName2.ColumnName
    FROM TableName tbl1
    INNER JOIN tbl1.IDColumnName = tbl2.IDColumnName;


-- UNION statement appends rows from separate tables with double SELECT statements.
    SELECT * FROM TableName1 WHERE YourCondition, 'YourBin' AS BinName  -- This creates a column with your string value as the entire column's value.
    UNION -- DISTINCT is default or you can use ALL to append it all
    SELECT * FROM TableName2 WHERE YourCondition, 'YourBin' AS BinName;        


-- Functions are built-in calculations. For a list of all SQL functions and syntax, refer to your RDBMS' documentation. The ones below are the most commonly used.
        
        String Functions -- Deals with string/text columns values
            LENGTH(ColumnName), UPPER(), 'L or R'TRIM(), LEFT(), RIGHT()
            CONCAT() /*used to combine column values*/ , 
            FORMAT() /* Used to change the format of the value*/
            SUBSTRING(), -- This is great for finding values in columns
            REPLACE() -- To replace string characters in column values
                
        Aggregate Functions -- Deals with column value calculations 
            SUM(), AVG(), MIN(), MAX(), COUNT(), STDEV() / STDEV_SAMP() / STDEV_POP(), VAR()
            GROUP_CONCAT()
            DISTINCT Removes duplicate records from a column.

-- CASE statements are used like IF statements in excel.
        SELECT ColumnName
          CASE 
            WHEN ColumnName YourCondition THEN YourCondition
            WHEN ColumnName2 YourCondition THEN YourCondition -- You can create multiple when conditions
          END AS NameCreatedColumn
        FROM ColumnName;

-- Constraints are NOT NULL, UNIQUE, DEFAULT '', AUTO_INCREMENT for primary keys. Constraints are specified after you create the table and establish the column data types.
CREATE TABLE tble1
(
        IDColumn INT AUTO_INCREMENT
        , PRIMARY KEY(IDColumn)
        , Column1 VARCHAR(30) NOT NULL
        , Column2 FLOAT UNIQUE
        , Column3 TEXT DEFAULT 'YourValue'
)

-- To find patterns in text string use wild cards % and _.

Databases are a collection of data in the form of tables.

The language can be broken down into key words, clauses, to statement. 

A statement is a combo of key words, table names, and column names.
SELECT Column1
FROM Table1;    -- ";" is the RDBMS delimiter to end a statement.

Aggregate functions are AVG and the funciton in the select clause. Aggregates work on the group, instead of the whole query;
GROUP BY Column1 is run first. It groups rows.

WHERE statements happen before the group by.
HAVING occurs after the gorup by 

SQL in 60min - https://www.youtube.com/watch?v=p3qvj9hO_Bo
