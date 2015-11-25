--1) Write an SQL statement which returns the fish scientific name, the average
-- number in stock and the average stock value (number in stock * price) for
-- the fish species (e.g. Chaetodon “butterfly fish” or Scaridae “parrot fish”)
-- for all the marine fish we have in stock. (10 pts)

PROMPT ================================
PROMPT |        Running Part 1        |
PROMPT ================================

--Note: Run @table.sql @values.sql prior to see results
-- Assume only Stock for fish species for avg num in stock & stock value

SELECT scientific_name, AVG(number_in_stock) AS stock_num , AVG(number_in_stock*current_price) AS stock_value
FROM aquatic_organism_stock
WHERE number_in_stock > 0
AND NOT EXISTS ( -- Select any organism other than invertebrates
    SELECT * FROM marine_invertebrates
    WHERE marine_invertebrates.scientific_name = aquatic_organism_stock.scientific_name)
GROUP BY aquatic_organism_stock.scientific_name;


--total sum of available stock of all fish species
SELECT SUM(number_in_stock*current_price) AS Total_Stock_Value
FROM aquatic_organism_stock
WHERE number_in_stock > 0
AND NOT EXISTS ( -- Select any organism other than invertebrates
    SELECT * FROM marine_invertebrates
    WHERE marine_invertebrates.scientific_name = aquatic_organism_stock.scientific_name);
