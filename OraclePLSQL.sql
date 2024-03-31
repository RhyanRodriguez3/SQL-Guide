/*
Oracle uses PL/SQL (Procedural Language SQL), that allows users to add conditional statements, looping statements, user defined functions and procedures, exceptions, etc to create actual programs.

There are three major sections in a PL/SQL block statement
  1. DECLARE section is used to declare variables, constants, and user defined procedures and functions. This is optional.
  2. BEGIN section is the written executable logical code. 
  3. EXCEPTION section contains executable code only when errors occur. Handles exceptions occurring during processing, used to place predefined or user defined exceptions. This is an optional section.
     END;

Use
*/
DECLARE
  a NUMBER(2); -- 'a' is the variable. 'NUMBER' is the data type. '(2)' is the data type storage/size. For example, the highest data type size for this variable is 99.
BEGIN
  a:=2; -- Syntax ':=' is an assignment operator used to assign a value to a variable.
  dbms_output.put.line('Value of a is ' || a); -- Syntax ';' is compulsory. [dbms_output.] is the name of a package. This package has multiple functions [put_line] is a function name used like a python printif function.
END;
