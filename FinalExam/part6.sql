--6) Write an SQL trigger, on the marine_fish table, which fires after a new
-- fish is added to the marine_fish table, causing the insertion of new
-- organisms by inserting a new tuple in the add_fish table (with data derived
-- from the existing table and the date as todays). (30 points)

PROMPT ================================
PROMPT |        Running Part 6        |
PROMPT ================================

--Note: Run @table.sql @values.sql prior to see results

--Version 1: will insert new fish to add_fish table if marine_fish is inserted. 
--Note: scientific_name is unique which insert occurs if duplicate will result in error(unique constraint)
CREATE OR REPLACE TRIGGER add_fish_update AFTER INSERT ON marine_fish FOR EACH ROW
DECLARE
    time TIMESTAMP := SYSTIMESTAMP;
BEGIN
    INSERT INTO add_fish 
    VALUES (:new.scientific_name, time);
END;
/

--Version 2: Check if the fish was previously added, if so it will not update add_fish.
--CREATE OR REPLACE TRIGGER add_fish_update AFTER INSERT ON marine_fish FOR EACH ROW
--DECLARE
--    time TIMESTAMP := SYSTIMESTAMP;
--    species NUMBER;
--BEGIN
--    SELECT count(scientific_name) INTO species
--    FROM add_fish
--    WHERE add_fish.scientific_name = :new.scientific_name;
--    IF species = 0 THEN
--        INSERT INTO add_fish 
--        VALUES (:new.scientific_name, time);
--    END IF;
--END;
--/

--Test Example
PROMPT #Inserting Fish (Stomiidae) into marine_fish
INSERT INTO marine_fish VALUES ('Stomiidae','barbeled dragonfishes','Stomiiformes',15.0,'algae','Atlantic');
PROMPT #Checking add_fish table for new entry
select * from add_fish;
