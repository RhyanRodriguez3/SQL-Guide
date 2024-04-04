/*
There are many RDBMS, but this is how the DB engine works.

SQL query optimization involves using indexes, avoiding unnecessary columns or rows in the SELECT statement, optimizing WHERE clauses, and using appropriate JOIN types.

OLAP(data warehouse) vs OLTP(db)
Dimensional modeling focuses on designing data models for analytical purposes, emphasizing easy querying and reporting. Relational modeling, on the other hand, is typically used for transactional databases.

Staging tables are temporary tables used to hold data extracted from source systems before it is transformed and loaded into the data warehouse.

Star schema consists of one or more fact tables referencing any number of dimension tables. Snowflake schema is a variation of the star schema where dimensions are normalized into multiple related tables.
Fact tables contain measurable and quantitative data about a business process, while dimension tables contain descriptive information related to the data in the fact table.
*/

BEHAVIORAL QUESTIONS
/*
BI Engineer Interview Prep
Understand the ETL process and have three stories that show each skill and your impact. 
You want to be prepared with past experience where you've applied the concepts.
  1. Reimbursement project: Had to deal with claims data where some of the rows were duplicates and had no unique identifiers, so I created one to and deleted the duplicate data for an accurate report.
  2. MediCal project: Had to face two deadline with different deliverables, where one project deadline was shortened, so I had to communicate with the director and walk him through the projects as well as design a data model which would match invoices to dispenses based on month.
  3. Variance and liason between each medical. Talk about quanitfying ambiguous questions to recommend metrics that may be useful to them.
  4. One of my biggest weaknesses is the querying, there are a lot of different versions of SQL so I used to have the problem of being wasting time just to remember the exact syntax and fucntions, so I got better at documentation.

- I enjoy data cleansing and documentation but it can be daunting with multiple tasks.
- One time I was in 2 projects that had compeltely different data requirements and data types.
Know enough beginner and intermediate SQL coding to clean and analyze data. Then show findings and possible business steps based on results.
*/

TOOL DOCUMENTATION
/*
a.	Oracle Analytics Service and Tableau
i.	Tableau Walkthroughs - https://www.youtube.com/watch?v=TPMlZxRRaBQ&pp=ygUTVGFibGVhdSB3YWxrdGhyb3VnaA%3D%3D
ii.	Oracle Analytics RPD
iii.	PeopleSoft Financials, HCM,

b.	AWS ETL (Andre Brown w/ FreeCodeCamp)
i.	AWS Glue is…
 https://www.youtube.com/watch?v=dQnRP6X8QAU
ii.	Snowflake https://www.youtube.com/watch?v=xCCkHZf1-aI
*/
