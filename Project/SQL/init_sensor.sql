--
-- Teds Init Script
-- V 1.2
--

-- Sensor Table
CREATE TABLE Sensor_Tbl
  ( Sensor_ID               NUMBER(10) NOT NULL
  , Bridge_ID               NUMBER(8)  -- Which bridge sensor resides
  , Teds_ID                 NUMBER(10) -- Sensor TEDS 
  , Bridge_Location         NUMBER(4)  -- Location number based on bridge schematic (1,000 sensors)
  , FOREIGN KEY(Bridge_ID)  REFERENCES Bridge_Tbl(Bridge_ID)
  , FOREIGN KEY(Teds_ID)    REFERENCES Teds_Tbl(Teds_ID)
  , PRIMARY KEY(Sensor_ID)
  );

-- Create a sequence to keep track of the Sensor_ID values
CREATE SEQUENCE Sensor_Seq
  MINVALUE 0
  START WITH 0;

-- Insert Trigger to maintain Sensor ID
CREATE OR REPLACE TRIGGER SensorTrig
  BEFORE INSERT ON Sensor_Tbl 
  FOR EACH ROW
BEGIN
  SELECT Sensor_Seq.NEXTVAL
  INTO   :new.Sensor_ID
  FROM   dual;
END;
/

-- Sensor Data table
CREATE TABLE Sensor_Data
  ( Sensor_ID               NUMBER(20) NOT NULL
  , DataEntry               TIMESTAMP(0)  -- Date When Data Was entered
  , Val                     NUMBER(5)     -- xxxxx raw adjust based on TEDS sensor value
  , FOREIGN KEY(Sensor_ID)  REFERENCES Sensor_Tbl(Sensor_ID)
  );

-- Maintain insert routines to Bridge
-- Applys a timestamp to keep track of data entry
CREATE OR REPLACE PROCEDURE Insert_Data
  ( Sensor_ID IN Sensor_Data.Sensor_ID%TYPE
  , Val       IN Sensor_Data.Val%TYPE
  )
  AS
  time TIMESTAMP := SYSTIMESTAMP;
BEGIN
  --DBMS_OUTPUT.PUT_LINE('Data Added: SID-' || Sensor_ID || ':' || Val || ' (' || time || ')');
  INSERT INTO Sensor_Data VALUES (Sensor_ID, time, Val);
END Insert_Data;
/

-- Experimental Table with the latest sensor data for each sensor
-- Only contain the recent inserted data plus a num entry to keep 
--    track how much data in the sensors db
CREATE TABLE Data_Update
  ( Sensor_ID               NUMBER(20) NOT NULL UNIQUE
  , DataEntry               TIMESTAMP(0)        -- TimeStamp of data entered
  , Val                     NUMBER(5)           -- Sensor_TBL Val
  , NumEntry                NUMBER(5) DEFAULT 1 -- How many recordings on the sensor_data
  , FOREIGN KEY(Sensor_ID)  REFERENCES Sensor_Tbl(Sensor_ID)
  );

-- Update Data Routine
-- Handles the update of the sensor stats table
CREATE OR REPLACE PROCEDURE Update_Data
  ( P_Sensor_ID IN Sensor_Data.Sensor_ID%TYPE
  , P_DateEnrty IN Sensor_Data.DataEntry%TYPE
  , P_Val       IN Sensor_Data.Val%TYPE
  )
  AS
  NumInc NUMBER;
BEGIN
  -- DBMS_OUTPUT.PUT_LINE('INSERT:' || P_Sensor_ID || ',' || P_DateEnrty || ',' || P_Val);
  INSERT INTO Data_Update (Sensor_ID, DataEntry, Val) VALUES (P_Sensor_ID, P_DateEnrty, P_Val);
  -- Check if there was data already on the Data tbl. If duplicate increment num enrty
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      -- Grab the Current NumEntry
      SELECT NumEntry
        INTO NumInc
        FROM DATA_UPDATE
        WHERE SENSOR_ID = 0;
      -- Update the number entry and post date entry
      UPDATE Data_Update
      SET    DataEntry = P_DateEnrty,
             Val = P_Val,
             NumEntry = NumInc +1
      WHERE Sensor_ID = P_Sensor_ID;
END;
/
