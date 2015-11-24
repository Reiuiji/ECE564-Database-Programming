--5) 1) Write a simple SQL procedure which returns a marine fish record (a
-- tuple (row)) along with a flag (0 if no record is found, 1 if a valid record
-- returned) if a given fish exists in our aquatic_organism_stock table, using
-- an inputted common name. (30 points)

--Enable dbms output to terminal
SET SERVEROUTPUT ON

PROMPT ================================
PROMPT |        Running Part 5        |
PROMPT ================================

--Note: No sql Dependencies

CREATE OR REPLACE PROCEDURE valid_record_check(
  p_scientific_name IN VARCHAR,
  flag OUT NUMBER) IS
  stock_count NUMBER;
BEGIN
  SELECT count(scientific_name) INTO stock_count
  FROM aquatic_organism_stock
  WHERE aquatic_organism_stock.scientific_name = p_scientific_name;
  
  IF stock_count = 0 THEN
    flag :=0;
  ELSE
    flag :=1;
  END IF;
  
END valid_record_check;
/

CREATE OR REPLACE PROCEDURE fish_exist(
  p_common_name IN marine_fish.common_name%TYPE,
  p_fish_info OUT marine_fish%ROWTYPE,
  flag OUT NUMBER ) IS
BEGIN
  SELECT * INTO p_fish_info
  FROM marine_fish mf
  WHERE mf.common_name = p_common_name;
  
  valid_record_check(p_fish_info.scientific_name, flag);
  
  EXCEPTION
  WHEN OTHERS THEN
  p_fish_info := NULL;
  flag := 0;
  
END fish_exist;
/

CREATE OR REPLACE procedure fish_print(
  p_common_name IN marine_fish.common_name%TYPE,
  p_fish_record IN marine_fish%ROWTYPE,
  flag IN NUMBER) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Common Name: ' || p_common_name);
    IF flag = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Fish Record(tuple): ' || p_fish_record.scientific_name || ', ' || p_fish_record.common_name || ', ' || p_fish_record.fish_species || ', ' || p_fish_record.max_size || ', ' || p_fish_record.food_preference || ', ' || p_fish_record.geographic_range);
        DBMS_OUTPUT.PUT_LINE('Flag: ' || flag);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fish ''' || p_common_name || ''' does not exist.');
    END IF;
END fish_print;
/

--PROMPT Valid test for flag (Check Dbms Output)
--
--DECLARE
--    scientific_name marine_fish.scientific_name%TYPE;
--    flag NUMBER;
--BEGIN
--    scientific_name := 'Chaetodon';
--    valid_record_check(scientific_name,flag);
--    DBMS_OUTPUT.PUT_LINE('Valid test for flag');
--    DBMS_OUTPUT.PUT_LINE('Scientific Name: ' || scientific_name);
--    DBMS_OUTPUT.PUT_LINE('Flag Output: ' || flag);
--END;
--/

PROMPT #Test procedure fish exist (Check Dbms Output)

DECLARE
    common_name marine_fish.common_name%TYPE;
    fish_record marine_fish%ROWTYPE;
    flag NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('#Test procedure fish exist');
    common_name := 'butterfly fish';
    fish_exist(common_name,fish_record,flag);
    fish_print(common_name,fish_record,flag);

END;
/

PROMPT #Test procedure fish does not exist (Check Dbms Output)

DECLARE
    common_name marine_fish.common_name%TYPE;
    fish_record marine_fish%ROWTYPE;
    flag NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('#Test procedure fish does not exist');
    common_name := 'bannerfishes';
    fish_exist(common_name,fish_record,flag);
    fish_print(common_name,fish_record,flag);

END;
/
