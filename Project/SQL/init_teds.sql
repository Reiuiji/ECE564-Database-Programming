--
-- Teds Init Script
--


-- TEDS (Transducer Electronic Data Sheets) Table
CREATE TABLE Teds_Tbl
  ( Teds_ID               NUMBER(10) -- What type of Data Sheet
  -- Section 1
  , Manufacture_ID        NUMBER(5)  -- 17 - 16381    : 14 Bits
  , Model_Number          NUMBER(5)  -- 0  - 32767    : 15 Bits
  , Version_Letter        CHAR(1)    -- A  - Z        :  5 Bits
  , Version_Number        NUMBER(2)  -- 0  - 63       :  6 Bits
  , Serial_Number         NUMBER(8)  -- 0  - 16777215 : 24 Bits
  -- Section 2 Standard Template TEDS
  , Template_ID           Number(2)  -- 25 - 39       :  8 Bits
  , Standard_Template     RAW(2000)  -- RAW data from the teds dev
  -- Section 3 Calibration TEDS Template
  , Template_ID_C         NUMBER(2)  -- 40 - 42       :  8 Bits
  , Calibration_Template  RAW(2000)  -- RAW Calibration Data
  -- Section 4 User Data
  , User_Text             VARCHAR(32)-- Custom User Text
  , PRIMARY KEY (TEDS_ID)
);

-- Create a sequence to keep track of the Teds_ID values
CREATE SEQUENCE Teds_Seq
  MINVALUE 0
  START WITH 0;

-- Create a Trigger to maintain insert
CREATE OR REPLACE TRIGGER TedsTrig
  BEFORE INSERT ON Teds_Tbl 
  FOR EACH ROW
BEGIN
  SELECT Teds_Seq.NEXTVAL
  INTO   :new.Teds_ID
  FROM   dual;
END;
/

-- IEEE Standard Templates - Transducer Types
CREATE TABLE Transducer_Type 
  ( Transducer_ID  NUMBER(2) NOT NULL
  , Name           VARCHAR(100)
  , PRIMARY KEY(Transducer_ID)
  );

-- IEEE Standard Templates - Physical Measurement
CREATE TABLE physical_type
  ( physical_id  NUMBER(3) NOT NULL
  , unit         varchar(12)
  , PRIMARY KEY(physical_id)
  );
