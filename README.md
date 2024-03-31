# **SQL Guide**
Contains SQL code for reuse and projects

## 1. Data Query Language (DQL): Used for retrieving data from dbs.
- SELECT *Column1*: Retrieves all data or specific columns from a db.
- DISTINCT: Removes duplicate records from a column.
- FROM *TableName*: The specified source table.
- WHERE *InputCondition InputOperator InputCondition*
>(*Operators are =, >= Greater than or equal to, < less than, <> Not Equal, **BETWEEN** range, LIKE InputPattern, IN SpecifiedValues*)

## 2. Data Definition Language (DDL)
- CREATE TABLE: Create a new table.
- ALTER TABLE: Modify an existing table's structure.
- DROP TABLE: Delete a table from the database.
- CREATE INDEX: Create an index on a table.
- DROP INDEX: Delete an index from the database.

## 3. Data Manipulation Language (DML)
- INSERT INTO: Insert new records into a table.
- UPDATE: Modify existing records in a table.
- DELETE FROM: Delete records from a table.
- TRUNCATE TABLE: Removes all records from a table in a database, but keeps the table and structure in place.

## 4. Data Control Language (DCL):
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
