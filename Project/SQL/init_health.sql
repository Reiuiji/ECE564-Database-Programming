--
-- Teds Init Script
-- V 0.4
--

-- Health Report Table
-- Reports the health of the bridge
CREATE TABLE Health_Report
  ( Bridge_ID               NUMBER(8) NOT NULL
  , DateEntry               TIMESTAMP(0)
  , Status                  NUMBER(2) -- 0 GREEN/GOOD, 1 YELLOW/WARNING, 2 RED/FAILURE
  , Report                  VARCHAR(30)
  , FOREIGN KEY (Bridge_ID) REFERENCES Bridge_Tbl(Bridge_ID)
  );

-- Sensor Threshold Table
-- Maintains all the thresholds the health monitor looks and reports
CREATE TABLE Sensor_Thresholds
  ( Teds_ID               NUMBER(10)
  , CheckCode             NUMBER(2)   -- What to check (0 equal, 1 min:less than, 2 max: greater than)
  , Threshold_Value       NUMBER(5)   -- Threshold Value which triggers event
  , Report_Code           NUMBER(2)   -- Report code (Health_Report.Status)
  , Report_Results        VARCHAR(32) -- What should the report output
  , FOREIGN KEY (Teds_ID) REFERENCES Teds_Tbl(Teds_ID)
  );

-- Routine which will find the Bridge ID as well as the TEDS ID
--  for a specific sensor id
CREATE OR REPLACE PROCEDURE Sensor_Grab
  ( P_Sensor_DI IN  Sensor_Data.Sensor_ID%Type
  , P_Bridge_ID OUT Bridge_Tbl.Bridge_ID%TYPE
  , P_Teds_ID   OUT Teds_Tbl.Teds_ID%TYPE
  )
  IS
BEGIN
  -- Finds the Bridge and Ted ID from Sensor ID
  SELECT Bridge_ID, Teds_ID
    INTO P_Bridge_ID, P_Teds_ID
    FROM Sensor_Tbl
    WHERE Sensor_ID = P_Sensor_ID;
END Sensor_Grab;
/

-- Check for various attributes from the sensor and report 
CREATE OR REPLACE PROCEDURE Health_Check
  ( P_Sensor_ID IN Sensor_Data.Sensor_ID%TYPE
  , P_Val       IN Sensor_Data.Val%TYPE
  , P_Bridge_ID IN Bridge_Tbl.Bridge_ID%TYPE
  , P_Teds_ID   IN Teds_Tbl.Teds_ID%TYPE
  )
  AS
  -- Cursor which has a view into the necessary data from the TEDS ID
  CURSOR Threshold_T IS
    SELECT Teds_ID, CheckCode, Threshold_Value, Report_Code, Report_Results
    FROM Sensor_Thresholds
    WHERE TEDS_ID = P_Teds_ID;
  -- Data holder for the threshold
  Thres Threshold_T%ROWTYPE;
BEGIN
  --DBMS_OUTPUT.PUT_LINE('Health Check:' || P_Sensor_ID || ',' || P_Bridge_ID  || ',' || P_Teds_ID || ',' || P_Val);
  -- Open the threshold cursor
  OPEN Threshold_T;
  LOOP
    FETCH Threshold_T INTO Thres;
    EXIT WHEN Threshold_T%NOTFOUND;
    --DBMS_OUTPUT.PUT_LINE(Thres.Teds_ID || ',' || Thres.CheckCode || ',' || Thres.Threshold_Value || ',' || Thres.Report_Code || ',' || Thres.Report_Results);

    -- Go Though the check routines
    -- Equal Threshold
    IF Thres.CheckCode = 0 THEN
      IF P_Val = Thres.Threshold_Value THEN
        INSERT INTO Health_Report VALUES (P_Bridge_ID, SYSDATE, Thres.Report_Code, Thres.Report_Results);
      END IF;
    
    -- High Threshold
    ELSIF Thres.CheckCode = 1 THEN
      IF P_Val > Thres.Threshold_Value  THEN
        INSERT INTO Health_Report VALUES (P_Bridge_ID, SYSDATE, Thres.Report_Code, Thres.Report_Results);
      END IF;
    
    -- Low Threshold
    ELSIF Thres.CheckCode = 1 THEN
      IF P_Val < Thres.Threshold_Value THEN
        INSERT INTO Health_Report VALUES (P_Bridge_ID, SYSDATE, Thres.Report_Code, Thres.Report_Results);
      END IF;
    
    -- No Check
    --ELSE
    END IF;
  END LOOP;
  CLOSE Threshold_T;
END;
/

--Create a Trigger to maintain Insert of Sensor Data
CREATE OR REPLACE TRIGGER SensorDataTrig
  BEFORE INSERT
  ON Sensor_Data 
  FOR EACH ROW
BEGIN
  DECLARE
    P_BRIDGE_ID NUMBER(5);
    P_TEDS_ID   NUMBER(10);
  BEGIN
    Update_Data(:new.Sensor_ID,:new.DataEntry,:new.Val);
    Sensor_Grab(:new.Sensor_ID,P_Bridge_ID,P_Teds_ID);
    Health_Check(:new.Sensor_ID,:new.Val,P_Bridge_ID,P_Teds_ID);
  END;
END;
/
