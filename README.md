# **SQL Guide**
SQL is used to manipulate data (DQL) and databases (DDL, DML, and DCL). There are many RDBMSs such as Oracle which uses PL/SQL, MS SQL Server, MySQL, and MariaDB.

## 1. Data Query Language (DQL)
Commands to retrieve and manipulate data from db. Shows functions and create custom measures and Calc Columns. https://learnsql.com/blog/standard-sql-functions-cheat-sheet/standard-sql-functions-cheat-sheet-a4.pdf
https://www.youtube.com/watch?v=9Pzj7Aj25lw&list=PLD20298E653A970F8

- `SELECT` *ColumnName1* Retrieves all data or specific columns from a db.
- FUNCTIONS (AGGREGATE) Perform a calculation on sets of values and returns a single result. Every RDBMS uses different versions, simply search their aggregate function documentation.
> Examples include `SUM()` `AVG()` `MIN()` `MAX()` `COUNT()` `GROUP_CONCAT()()` `STDEV() / STDEV_SAMP() / STDEV_POP()` `VAR()` `COUNT()` `COUNT()`
>
> `GETDATE()` Autofill rows for a Date Column.
> 
> `DISTINCT` Removes duplicate records from a column.
- `FROM` *TableName* Specify the source table.
> `GROUP BY` *Groups* rows with the same values into summary rows. Often used with aggregate functions.
- JOINS Combines data from multiple tables
> `SELECT` * `FROM` *TableName1* `AS` *TableNameAbbr1*
>
> `INNER JOIN` *TableName2* `AS` *TableNameAbbr2* `ON` *TableNameAbbr1.IDColumnName* `=` *TableNameAbbr2.IDColumnName*
> 
> `LEFT JOIN`
> 
> `RIGHT JOIN` 
- `ORDER BY` Sorts the results based on specified criteria
- `WHERE` Filters rows based on specified conditions. Often uses operators 
> (*Operators are `=`, `>=` Greater than or equal to, `<` Less than, `<>` Not Equal, `AND` multiple conditions `BETWEEN` a range, `LIKE` Search for Patterns, `IN` Specify desired values*)
> (*Conditions for strings/text use wildcards `%` represents zero or multiple characters `_` represents a single character*)
- Limit commands *limit* the number of rows returned. Ex: `TOP` `LIMIT`


## 2. Data Definition & Manipulation Language (DDL) & Data Manipulation Language (DML)
Manipulate the database tables. Commands to add, modify, and delete data in tables. Create a data table from scratch and manage the engine

- Create a new table: `CREATE TABLE();` *ColumnName1 DataType(CharAmnt)*
> *It is good practice to have the first column be ID*: `PRIMARY KEY` `IDENTITY(1,1),`
- Created indexes on columns to retrieve data quickly from db `CREATE UNIQUE INDEX` *index_name* `ON` *table_name (column1, column2, ...)*; `DROP INDEX` *index_name ON table_name*;
- Change row values in a column: `UPDATE` *TableName* `SET` *ColumnName1 = Condition*;
- Add columns to a table: `ALTER TABLE` *TableName* `ADD` *NewColumnName DataType(CharAmnt)*
- > *With multiple tables, it is good practice to have foreign Keys on ID columns*: `ALTER TABLE` *TableName* `ADD` `FOREIGN KEY()` *NewColumnName* `REFERENCES` *TableName(IDColumn)*
- Add rows to a table `INSERT INTO` *TableName (ColumnName1,ColumnName1, etc)* `VALUES();`
- Delete row values from a table, but doesn't delete the table structure: `DELETE` *TableName*; 
- Deletes a table from the db: `DROP TABLE` *TableName*; 
- CREATE INDEX: Create an index on a table.
- DROP INDEX: Delete an index from the database. 
- TRUNCATE TABLE: Removes all records from a table in a database, but keeps the table and structure in place.


## 3. Database Control Language (DCL)

- GRANT: Give privileges to database users.
- REVOKE: Take back privileges from database users.


## 4. Transaction Control Language (TCL):

- COMMIT: Save changes made during the current transaction.
- ROLLBACK: Undo changes made during the current transaction.
- SAVEPOINT: Set a point within a transaction to which you can later roll back.


## 5. Schema Manipulation Language (SML):

- CREATE SCHEMA: Create a new schema.
- ALTER SCHEMA: Modify an existing schema.
- DROP SCHEMA: Delete a schema from the database.


## 7. Other Commands:

- USE: Select a particular database.
- SHOW: Display information about the database.
- DESCRIBE: Show the structure of a table.
- SET: Set or change settings of the SQL environment.

