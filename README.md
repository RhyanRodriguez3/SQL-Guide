# **SQL Guide**
Contains SQL code for reuse and projects

## 1. Data Query Language (DQL)
Clauses/commands used for retrieving data from dbs. https://learnsql.com/blog/standard-sql-functions-cheat-sheet/standard-sql-functions-cheat-sheet-a4.pdf

- `SELECT` *Column1* Retrieves all data or specific columns from a db.
- `DISTINCT` Removes duplicate records from a column.
- `FROM` *TableName* Specify the source table.
- `WHERE` Filters rows based on specified conditions. Often uses operators 
> (*Operators are `=`, `>=` Greater than or equal to, `<` Less than, `<>` Not Equal, `AND` multiple conditions `BETWEEN` a range, `LIKE` Search for Patterns, `IN` Specify desired values*)
> (*Conditions for strings/text use wildcards `%` represents zero or multiple characters `_` represents a single character*)
> `GROUP BY` *Groups* rows with the same values into summary rows. Often used with aggregate functions.
- JOINS Combines data from multiple tables
> `INNER JOIN`
> 
> `LEFT JOIN`
> 
> `RIGHT JOIN` 
- `ORDER BY` Sorts the results based on specified criteria
- AGGREGATE FUNCTIONS group data. Every RDBMS uses different versions, simply search their aggregate function documentation.
> Examples include `SUM()` `AVG()` `MIN()` `MAX()` `COUNT()` `GROUP_CONCAT()()` `STDEV() / STDEV_SAMP() / STDEV_POP()` `VAR()` `COUNT()` `COUNT()`
- Limit commands *limit* the number of rows returned. Ex: `TOP` `LIMIT`


## 2. Database Definition Language (DDL)

- CREATE TABLE: Create a new table.
- ALTER TABLE: Modify an existing table's structure.
- DROP TABLE: Delete a table from the database.
- CREATE INDEX: Create an index on a table.
- DROP INDEX: Delete an index from the database.


## 3. Database Manipulation Language (DML): Commands used to add, modify, or delete data in tables.

- INSERT INTO: Insert new records into a table.
- `UPDATE` *TableName* `SET` *ColumnName1 = Condition*; Modify existing records in a table.
- `DELETE` *TableName* : Delete records from a table.
- TRUNCATE TABLE: Removes all records from a table in a database, but keeps the table and structure in place.


## 4. Database Control Language (DCL):

- GRANT: Give privileges to database users.
- REVOKE: Take back privileges from database users.


## 5. Transaction Control Language (TCL):

- COMMIT: Save changes made during the current transaction.
- ROLLBACK: Undo changes made during the current transaction.
- SAVEPOINT: Set a point within a transaction to which you can later roll back.


## 6. Schema Manipulation Language (SML):

- CREATE SCHEMA: Create a new schema.
- ALTER SCHEMA: Modify an existing schema.
- DROP SCHEMA: Delete a schema from the database.


## 7. Other Commands:

- USE: Select a particular database.
- SHOW: Display information about the database.
- DESCRIBE: Show the structure of a table.
- SET: Set or change settings of the SQL environment.

