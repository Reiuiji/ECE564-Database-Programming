--Extra Credit: Define a cursor which can be used to examine the marine
-- invertebrate stored in our aquatic_organism_stock table and possible
-- others. The cursor should allow us to see an invertebrate’s common_name,
-- stock_id and number_in_stock. (+10 points)

--Cursor Test
--Enable dbms output to terminal
SET SERVEROUTPUT ON

PROMPT ================================
PROMPT |        Running Part 7        |
PROMPT |         Extra Credit         |
PROMPT ================================

--Reset tables to default
SET TERMOUT OFF
@table.sql
@values.sql
SET TERMOUT ON


DECLARE

    CURSOR iv_cursor IS
        SELECT mi.common_name AS common_name, aos.stock_id AS stock_id, aos.number_in_stock AS number_in_stock
        FROM aquatic_organism_stock aos, marine_invertebrates mi
        WHERE mi.scientific_name = aos.scientific_name;

    cursor_num iv_cursor%ROWTYPE;

BEGIN

	DBMS_OUTPUT.PUT_LINE('#Running cursor');
    OPEN iv_cursor;
    LOOP
        FETCH iv_cursor INTO cursor_num;
        EXIT WHEN iv_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(cursor_num.common_name || ', ' || cursor_num.stock_id  || ', ' || cursor_num.number_in_stock);
    END LOOP;

	DBMS_OUTPUT.PUT_LINE('#Cursor complete');

    CLOSE iv_cursor;
END;
/
