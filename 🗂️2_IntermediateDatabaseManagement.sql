/*
How to create tables and use basic DDL, DML, and DCL.
*/

<details>
  <summary>WIP</summary>
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
</details>

<details>
  <summary>Other</summary>
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

</details>
