DROP TABLE Data_Update;
DROP TABLE Sensor_Data;
DROP TABLE Sensor_Tbl;

--Information for each sensor
CREATE TABLE Sensor_Tbl (
  Sensor_ID NUMBER(10) NOT NULL,
  Bridge_ID NUMBER(8), -- Which bridge sensor resides
  Teds_ID   NUMBER(10), -- Sensor TEDS 
  Bridge_Location NUMBER(4), -- Location number based on bridge schematic (1,000 sensors)
  FOREIGN KEY(Bridge_ID) REFERENCES Bridge_Tbl(Bridge_ID),
  FOREIGN KEY(Teds_ID) REFERENCES Teds_Tbl(Teds_ID),
  PRIMARY KEY(Sensor_ID)
);

--Create a sequence to keep track of the Sensor_ID values
DROP SEQUENCE   Sensor_Seq;
CREATE SEQUENCE Sensor_Seq
  MINVALUE 0
  START WITH 0;

--Create a Trigger to maintain insert
CREATE OR REPLACE TRIGGER SensorTrig
BEFORE INSERT ON Sensor_Tbl 
FOR EACH ROW
BEGIN
  SELECT Sensor_Seq.NEXTVAL
  INTO   :new.Sensor_ID
  FROM   dual;
END;
/

INSERT INTO Sensor_Tbl VALUES (0,0,0,0);
INSERT INTO Sensor_Tbl VALUES (0,0,1,1);
INSERT INTO Sensor_Tbl VALUES (0,0,1,2);
INSERT INTO Sensor_Tbl VALUES (0,0,1,3);
INSERT INTO Sensor_Tbl VALUES (0,0,2,4);

--Contains only the sensor data and thats it to prevent redudency
CREATE TABLE Sensor_Data (
  Sensor_ID NUMBER(20) NOT NULL,
  DataEntry TIMESTAMP(0),
  Val NUMBER(5), -- xxxxx raw value which will be changed based on the TEDS sensor value
  FOREIGN KEY(Sensor_ID) REFERENCES Sensor_Tbl(Sensor_ID)
);

----Maintain insert routines to Bridge
CREATE OR REPLACE PROCEDURE Insert_Data(
  Sensor_ID IN Sensor_Data.Sensor_ID%TYPE,
  Val IN Sensor_Data.Val%TYPE
  ) 
  AS
  time TIMESTAMP := SYSTIMESTAMP;
BEGIN
  --DBMS_OUTPUT.PUT_LINE('Data Added: SID-' || Sensor_ID || ':' || Val || ' (' || time || ')');
  INSERT INTO Sensor_Data VALUES (Sensor_ID, time, Val);

END Insert_Data;
/

--Insert arbitraty sensor data to test
DECLARE
BEGIN
  Insert_Data(0,100);
  Insert_Data(0,80);
  Insert_Data(0,90);
  Insert_Data(0,95);
  Insert_Data(0,115);
  Insert_Data(0,120);
  Insert_Data(1,100);
  Insert_Data(1,80);
  Insert_Data(1,90);
  Insert_Data(1,95);
  Insert_Data(1,115);
  Insert_Data(1,120);
  Insert_Data(2,100);
  Insert_Data(2,80);
  Insert_Data(2,90);
  Insert_Data(2,95);
  Insert_Data(2,115);
  Insert_Data(2,120);
END;
/

--Experimental Table with the latest sensor data for each sensor
--ONly contain the recent inserted data plus a num entry to keep track how much data in the sensors db
CREATE TABLE Data_Update (
  Sensor_ID NUMBER(20) NOT NULL UNIQUE,
  DataEntry TIMESTAMP(0),
  Val NUMBER(5), -- xxxxx raw value which will be changed based on the TEDS sensor value
  NumEntry NUMBER(5) DEFAULT 1,
  FOREIGN KEY(Sensor_ID) REFERENCES Sensor_Tbl(Sensor_ID)
);


CREATE OR REPLACE PROCEDURE Update_Data(
  P_Sensor_ID IN Sensor_Data.Sensor_ID%TYPE,
  P_DateEnrty IN Sensor_Data.DataEntry%TYPE,
  P_Val IN Sensor_Data.Val%TYPE
  )
  AS
  NumInc NUMBER;
BEGIN
  --DBMS_OUTPUT.PUT_LINE('INSERT:' || P_Sensor_ID || ',' || P_DateEnrty || ',' || P_Val);
  INSERT INTO Data_Update (Sensor_ID, DataEntry, Val) VALUES (P_Sensor_ID, P_DateEnrty, P_Val);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    Select NumEntry
      INTO NumInc
      From DATA_UPDATE
      WHERE SENSOR_ID = 0;
    UPDATE Data_Update
    SET    DataEntry = P_DateEnrty,
           Val = P_Val,
           NumEntry = NumInc +1
    WHERE Sensor_ID = P_Sensor_ID;
END;
/

--Update Data Test
DECLARE
BEGIN
  UPDATE_DATA(0,SYSDATE,5);
  dbms_lock.sleep( 10 ); -- Wait 10 Seconds
  UPDATE_DATA(1,SYSDATE,6);
  dbms_lock.sleep( 10 ); -- Wait 10 Seconds
  UPDATE_DATA(0,SYSDATE,7);
  dbms_lock.sleep( 10 ); -- Wait 10 Seconds
  UPDATE_DATA(0,SYSDATE,8);
  dbms_lock.sleep( 10 ); -- Wait 10 Seconds
  UPDATE_DATA(0,SYSDATE,4);
  dbms_lock.sleep( 10 ); -- Wait 10 Seconds
END;