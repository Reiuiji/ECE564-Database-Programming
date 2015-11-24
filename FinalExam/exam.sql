--Exam run sql script
PROMPT ==========================================
PROMPT |              Running Exam              |
PROMPT ==========================================

--Generate tables
PROMPT #Generating Tables
SET TERMOUT OFF
@table.sql
SET TERMOUT ON
PROMPT #Table Generation Complete

--Insert values
PROMPT #Populating Values
SET TERMOUT OFF
@values.sql
SET TERMOUT ON
PROMPT #Value Pupulating Complete

--uncomment to show all values for test
--PROMPT #Showing all values in the Tables
--@showall.sql

PROMPT #Init complete, running exam sections
--1)
@part1.sql

--2)
@part2.sql

--3)
@part3.sql

--4)
@part4.sql

--5)
@part5.sql

--6)
@part6.sql

--7) extra
@part7.sql
