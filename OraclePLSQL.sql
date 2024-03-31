/*
Oracle uses PL/SQL (Procedural Language SQL), that allows users to add conditional statements, looping statements, user defined functions and procedures, exceptions, etc to create actual programs. 
The purpose of PL/SQL is designed to retrieve the value of the variable, from tables, manipulate the values inside the variable then store it back into the table.

There are three major sections in a PL/SQL block statement
  1. DECLARE section is used to declare variables, constants, and user defined procedures and functions. This is optional.
  2. BEGIN section is the written executable logical code. 
  3. EXCEPTION section contains executable code only when errors occur. Handles exceptions occurring during processing, used to place predefined or user defined exceptions. This is an optional section.
     END;
*/

/* First program in PL/SQL which prints variable results*/
DECLARE
  a number(2); -- 'a' is the variable. 'NUMBER' is the data type. '(2)' is the data type storage/size. For example, the highest data type size for this variable is 99.
  b number(2); 
  c number(2); 
BEGIN
  a:=2; -- Syntax ':=' is an assignment operator used to assign a value to a variable.
  b:=4; 
  c:=a+b;
  dbms_output.put_line('Welcome to Oracle PL/SQL!' || 'Value of c is ' || c); -- Syntax ';' is compulsory. [dbms_output.] is the name of a package. This package has multiple functions [put_line] is a function name used like a python printif function. [||] concatenates string.
END;
