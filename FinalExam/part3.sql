--3) Write an SQL statement to create a view which finds all the scientific
-- names, common names and the price for marine fish and marine invertebrates
-- we have in stock in quantities greater than 5 and sort the result by
-- scientific name. (10 pts)

PROMPT ================================
PROMPT |        Running Part 3        |
PROMPT ================================

--Note: Run @table.sql @values.sql prior to see results
--If ORA-01031 error occurs, check create view permissions

CREATE VIEW sv AS
    SELECT mf.scientific_name AS sn ,mf.common_name, os.current_price FROM marine_fish mf
        JOIN aquatic_organism_stock os ON os.scientific_name = mf.scientific_name
        WHERE os.number_in_stock > 5
    UNION ALL
    SELECT mi.scientific_name AS sn,mi.common_name, os.current_price FROM marine_invertebrates mi
        JOIN aquatic_organism_stock os ON os.scientific_name = mi.scientific_name
        WHERE os.number_in_stock > 5
    ORDER BY sn;

PROMPT #Testing the view
select * from sv;

PROMPT #Dropping view
DROP VIEW sv;
