DROP TABLE Bridge_Tbl;

-- Create a Location Object
CREATE OR REPLACE TYPE Location_Typ
OID '261CED41A8480C15E055020C29956D0A' --SELECT SYS_OP_GUID() FROM DUAL; 
AS OBJECT 
  ( Country  VARCHAR(60)
  , State    VARCHAR(2)  -- State Abriveations ex MA
  , City     VARCHAR(60)
  , Lat      NUMBER(8,5) -- Latitute xxx.yyyyy
  , Lot      NUMBER(8,5) -- Longitude xxx.yyyyy
  );
/

--Create the Bridge table
CREATE TABLE Bridge_Tbl (
  Bridge_ID NUMBER(8) NOT NULL,
  Name VARCHAR(60),
  Year_Built DATE_INFO,
  Bridge_Location Location_Typ,
  PRIMARY KEY(Bridge_ID)
);
--Create a sequence to keep track of the Bridge_ID values
DROP SEQUENCE   Bridge_Seq;
CREATE SEQUENCE Bridge_Seq
  MINVALUE 0
  START WITH 0;

--Create a Trigger to maintain insert
CREATE OR REPLACE TRIGGER BridgeTrig
BEFORE INSERT ON Bridge_Tbl 
FOR EACH ROW
BEGIN
  SELECT Bridge_Seq.NEXTVAL
  INTO   :new.Bridge_ID
  FROM   dual;
END;
/

----Maintain insert routines to Bridge
CREATE OR REPLACE FUNCTION Insert_Bridge(
  Name IN Bridge_Tbl.Name%TYPE,
  Year IN VARCHAR,
  Country IN Bridge_Tbl.Bridge_Location.Country%Type,
  State IN Bridge_Tbl.Bridge_Location.State%Type,
  City IN Bridge_Tbl.Bridge_Location.City%Type,
  Lat IN Bridge_Tbl.Bridge_Location.Lat%Type,
  Lot IN Bridge_Tbl.Bridge_Location.Lot%Type 
  ) 
  
  RETURN VARCHAR AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('INFO' || Name || ',' || TO_DATE(Year,'YYYY-MM-DD') || ',' || Country || ',' || State || ',' || City || ',' || Lat || ',' || Lot);
  INSERT INTO bridge_tbl VALUES (0,Name, DATE_INFO(TO_DATE(Year,'YYYY-MM-DD')), location_typ(Country, State, City, Lat, Lot));
  
  RETURN 'SUCCESS';
  
  EXCEPTION
    WHEN others THEN
      RETURN 'FAIL';

END Insert_Bridge;
/

--Two methods of inserting data to the bridge table
--insert statments or function based
--INSERT INTO Bridge_Tbl VALUES (0, 'Sagamore Bridge', DATE_INFO(TO_DATE('1935-06-22','YYYY-MM-DD')), location_typ('USA','MA','Bourne','41.77628','-70.54326'));
--INSERT INTO Bridge_Tbl VALUES (0, 'Bourne Bridge', DATE_INFO(TO_DATE('1935-06-22','YYYY-MM-DD')), location_typ('USA','MA','Bourne','41.74781','-70.58963'));
--INSERT INTO Bridge_Tbl VALUES (0, 'Cape Cod Canal Railroad Bridge', DATE_INFO(TO_DATE('1935-06-22','YYYY-MM-DD')), location_typ('USA','MA','Bourne','41.74202','-70.61363'));

DECLARE
  Results VARCHAR2(100);
BEGIN
  Results := insert_bridge('Sagamore Bridge','1935-06-22','USA','MA','Bourne','41.77628','-70.54326');
  DBMS_OUTPUT.PUT_LINE('Insert Results = ' || Results);
  Results := insert_bridge('Sagamore Bridge','1935-06-22','USA','MA','Bourne','41.77628','-70.54326');
  DBMS_OUTPUT.PUT_LINE('Insert Results = ' || Results);
  Results := insert_bridge('Cape Cod Canal Railroad Bridge', '1935-06-22', 'USA','MA','Bourne','41.74202','-70.61363');
  DBMS_OUTPUT.PUT_LINE('Insert Results = ' || Results);
END;
/
--SELECT insert_bridge('Sagamore Bridge','1935-06-22','USA','MA','Bourne','41.77628','-70.54326') FROM DUAL;

--View of the bridge data
CREATE OR REPLACE VIEW  Bridge AS
select B.Bridge_ID AS BID
      ,B.name AS NAME
      ,B.Year_Built.Date_Val AS EST
      ,B.Year_Built.age() AS AGE_Y
      ,B.Bridge_Location.Country AS COUNTRY
      ,B.Bridge_Location.State AS STATE
      ,B.Bridge_Location.City AS CITY
      ,B.Bridge_Location.Lat AS LAT
      ,B.Bridge_Location.Lot AS LOT
      from Bridge_Tbl B;


--Populate with bridge data

Select * From Bridge;