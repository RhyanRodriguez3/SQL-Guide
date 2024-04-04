/*
There are many RDBMS, but this is how the DB engine works.

SQL query optimization involves using indexes, avoiding unnecessary columns or rows in the SELECT statement, optimizing WHERE clauses, and using appropriate JOIN types.

OLAP(data warehouse) vs OLTP(db)
Dimensional modeling focuses on designing data models for analytical purposes, emphasizing easy querying and reporting. Relational modeling, on the other hand, is typically used for transactional databases.

Staging tables are temporary tables used to hold data extracted from source systems before it is transformed and loaded into the data warehouse.

Star schema consists of one or more fact tables referencing any number of dimension tables. Snowflake schema is a variation of the star schema where dimensions are normalized into multiple related tables.
Fact tables contain measurable and quantitative data about a business process, while dimension tables contain descriptive information related to the data in the fact table.
*/
