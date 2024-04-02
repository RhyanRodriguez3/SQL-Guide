/*
This is a repo of commonly asked Business Interview Q&A as well as codes for reuse.
*/

-- Handling NULL or Empty string. NULL is the absence of a value. Empty means the value has a string data type.
    SELECT TableName.ColumnName
    FROM TableName tbl1
    WHERE ISNULL(ColumnName, '') = ''

        
/*  
To handle dates registered as text datatypes, use Isdate(). Other date functions below.
    CAST()
    CONVERT()
    GETDATE()
*/
    SELECT ISDATE(ColumnName)
    FROM TableName tbl1
    WHERE ISDATE(DateColumn) = 1 AND 
            CASE 
                WHEN ISDATE(DateColumn) = 1
                THEN CAST(NULL AS DateType)
                ELSE CAST(DateColumn AS DateType)
            END < 'XX/XX/XXXX'
