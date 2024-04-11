/*
This is a SQL guide for advanced level queries. 
We will be going over CTEs and temptables, recursive/hierachical queries, merge queries, and pivot queries. 
*/

-- TRIGGERS: A block of code that defines a certain action when a certain operation is performed on the db.
CREATE TABLE TRIGGER_TEST (MESSAGE VARCHAR(100))
-- Apparently you have to use the CLI to create the trigger code.
DELIMITER $$    -- Normally, the SSMS delimiter is a semicolon, so $$ is used to defined the delimiter
CREATE
    TRIGGER YourTriggerName BEFORE INSERT
    ON table1
    FOR EACH ROW BEGIN
        INSERT INTO TRIGGER_TEST VALUES('added new employee');
    END$
DELIMITER;

    
-- Common Table Expressions are 
    WITH cteTable
    AS
    (
        SELECT TableName.ColumnName, TableName2.ColumnName
        FROM TableName tbl1
        INNER JOIN tbl1.IDColumnName = tbl2.IDColumnName
    )




    
1. TIP
- TIP: Use CTE rather than subqueries. 
- Sorting is a costly activity. Don't premature sort in a query.
- TIP: Don't repeat yourself
        

https://www.youtube.com/watch?v=UC7uvOqcUTs&list=PLUaB-1hjhk8GjfgvWlreA6BvTvazz8RHG
https://www.youtube.com/watch?v=C7CPXeEvKN0
