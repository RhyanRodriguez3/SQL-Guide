
/* ====================================
   Understand the SQL execution order. 
   ==================================== */

SELECT          --> Step #6: Then it finds the columns you input.
FROM      --> Step #1: The engine finds which tables you are pulling from. 
JOIN ON    --> Step #2: Then joins those tables based on the IDColumns. TIP: This has the greatest impact on query performance!
WHERE       --> Step #3: Then it filters the table based on your conditions. Avoid having the engine look through each row, so avoid using functions or calculation here and specify values when possible so the engine can locate it in its index.
GROUP BY     --> Step #4: Then it groups rows.
HAVING        --> Step #5: Then it filters the grouped rows based on your condition.
ORDER BY         --> Step #7: Consider using a smaller result set to further optimize this step. Avoid sorting large datasets.
LIMIT             --> Step #8

"Each SQL engine has a query optimization plan that defines how it processes queries. It contains index, memory, and algorithms. WIP"
/*
There are many RDBMS, but this is how the DB engine works.
a.	BONUS Database Mgmt: 
i.	How to install and configure and security? Metadata resources? Schedule tasks? Disaster recovery? What are bug fixes? code deployment? 
SQL query optimization involves using indexes, avoiding unnecessary columns or rows in the SELECT statement, optimizing WHERE clauses, and using appropriate JOIN types.


OLAP(data warehouse) vs OLTP(db)
Dimensional modeling focuses on designing data models for analytical purposes, emphasizing easy querying and reporting. Relational modeling, on the other hand, is typically used for transactional databases.

Staging tables are temporary tables used to hold data extracted from source systems before it is transformed and loaded into the data warehouse.

Star schema consists of one or more fact tables referencing any number of dimension tables. Snowflake schema is a variation of the star schema where dimensions are normalized into multiple related tables.
Fact tables contain measurable and quantitative data about a business process, while dimension tables contain descriptive information related to the data in the fact table.
*/

-- Identify what data type the SQL engine has for each column. REFER TO DOCUMENTATION.
SELECT name, sql 
FROM sqlite_master
WHERE type='table'
ORDER BY name;

RDBMS works using hash index and B Tree Data structures.
B tree is used to store and retrive large amount of data on disk.
   
<details>
  <summary><ins>SOURCES</ins></summary>

### 😤📺 Youtube University! Support these channels! 

> https://www.youtube.com/@ByteByteGo -->Roadmap for Learning SQL
> 
> 
> 
> 
> 
  
</details>

