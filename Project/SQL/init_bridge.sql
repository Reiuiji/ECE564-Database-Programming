--
-- Bridge Init Script
--

-- Location Object to handle all geographical information
CREATE OR REPLACE TYPE Location_Typ
AS OBJECT 
  ( Country  VARCHAR(60) -- Country ex USA
  , State    VARCHAR(2)  -- State Abbreviations ex MA
  , City     VARCHAR(60) -- City/Town
  , Lat      NUMBER(8,5) -- Latitude xxx.yyyyy
  , Lot      NUMBER(8,5) -- Longitude xxx.yyyyy
  );
/

-- Date Object which will handle date of when the bridge was created
--   as well to calculate the age
CREATE TYPE Date_Info AS OBJECT
  ( Date_Val Date
  , MEMBER FUNCTION Age  RETURN NUMBER
  , MEMBER FUNCTION AgeR RETURN NUMBER
  , MEMBER FUNCTION AgeV RETURN VARCHAR
  );
/

-- Functions for the Date Object (ADT)
CREATE OR REPLACE TYPE BODY Date_Info AS
  -- Calculate the age in just years
  MEMBER FUNCTION Age RETURN NUMBER AS
    BEGIN
      RETURN trunc(months_between(sysdate,Date_val)/12);
    END Age;
  -- Calculate the age with the DB precise RAW Data
  MEMBER FUNCTION AgeR RETURN NUMBER AS
    BEGIN
      RETURN months_between(sysdate,Date_val)/12;
    END AgeR;
  -- Calculate the age with years and months
  MEMBER FUNCTION AgeV RETURN VARCHAR AS
    BEGIN
      RETURN '(' ||
             trunc(months_between(sysdate,Date_val)/12)
             || ',' ||
             trunc(mod(months_between(sysdate,Date_val),12))
             || ',' ||
             trunc(sysdate-add_months(Date_val,trunc(months_between(sysdate,Date_val)/12)*12+trunc(mod(months_between(sysdate,Date_val),12))))
             || ')';
    END AgeV;
  END;
/

--Create the Bridge table
CREATE TABLE Bridge_Tbl
  ( Bridge_ID       NUMBER(8) NOT NULL
  , Name            VARCHAR(60)
  , Year_Built      DATE_INFO
  , Bridge_Location Location_Typ
  , PRIMARY KEY(Bridge_ID)
  );

--Create a sequence to keep track of the Bridge_ID values
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
CREATE OR REPLACE FUNCTION Insert_Bridge
  ( Name    IN Bridge_Tbl.Name%TYPE
  , Year    IN VARCHAR
  , Country IN Bridge_Tbl.Bridge_Location.Country%Type
  , State   IN Bridge_Tbl.Bridge_Location.State%Type
  , City    IN Bridge_Tbl.Bridge_Location.City%Type
  , Lat     IN Bridge_Tbl.Bridge_Location.Lat%Type
  , Lot     IN Bridge_Tbl.Bridge_Location.Lot%Type 
  ) 
  RETURN VARCHAR AS
BEGIN
  --DBMS_OUTPUT.PUT_LINE('INFO' || Name || ',' || TO_DATE(Year,'YYYY-MM-DD') || ',' || Country || ',' || State || ',' || City || ',' || Lat || ',' || Lot);
  INSERT INTO bridge_tbl VALUES (0,Name, DATE_INFO(TO_DATE(Year,'YYYY-MM-DD')), Location_Typ(Country, State, City, Lat, Lot));
  RETURN 'SUCCESS';
  EXCEPTION
    WHEN others THEN
      RETURN 'FAIL';
END Insert_Bridge;
/

--View of the bridge data
CREATE OR REPLACE VIEW Bridge AS
select B.Bridge_ID                AS BID
     , B.name                     AS NAME
     , B.Year_Built.Date_Val      AS EST
     , B.Year_Built.age()         AS AGE_Y
     , B.Bridge_Location.Country  AS COUNTRY
     , B.Bridge_Location.State    AS STATE
     , B.Bridge_Location.City     AS CITY
     , B.Bridge_Location.Lat      AS LAT
     , B.Bridge_Location.Lot      AS LOT
     from Bridge_Tbl B;
