--2) Write an SQL statement to add an existential constraint to make sure that
-- a marine invertebrate found in the aquatic_organism_stock table also exists
-- in the marine_invertebrate table. (10 pts)

PROMPT ================================
PROMPT |        Running Part 2        |
PROMPT ================================

--Version 1: Will give errors since marine_fish are not reverences as a constraint
--Note run @table.sql then @part2.sql followed by @values.sql
--Reset Table for no values since marine_fish cause errors
SET TERMOUT OFF
@table.sql
SET TERMOUT ON

ALTER TABLE aquatic_organism_stock
ADD CONSTRAINT stock_check
FOREIGN KEY (scientific_name) REFERENCES marine_invertebrates (scientific_name);

--Test
PROMPT #ADDING invertebrate
INSERT INTO marine_invertebrates VALUES ('Centrophorus','squaliform sharks','Centrophoridae',500.0,'carnivore','Caribbean');

PROMPT #Inserting non invertibrate into the stock;
INSERT INTO aquatic_organism_stock VALUES (3000,'Centrophorus',1,999.99);
SELECT * FROM aquatic_organism_stock;

--Insert a vertebrate with no foreign key test
PROMPT #Inserting vertebrate to show error with foreign key
PROMPT #Expecting ORA-02291 to occure

INSERT INTO marine_fish VALUES ('Chaetodon','butterfly fish','Percoidea',22.0,'sea anemones','Atlantic');
INSERT INTO aquatic_organism_stock VALUES (1000,'Chaetodon',10,8.99);

--Remove Constraint
ALTER TABLE aquatic_organism_stock
DROP CONSTRAINT stock_check;

--Put values back in
SET TERMOUT OFF
@values.sql
SET TERMOUT ON
