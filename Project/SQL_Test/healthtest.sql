DROP TABLE Health_Report;
DROP TABLE Sensor_Thresholds;

-- Report the health when a sensor inserts data
CREATE TABLE Health_Report
  ( Bridge_ID NUMBER(8) NOT NULL
  , DateEntry TIMESTAMP(0)
  , Status NUMBER(2) -- 0 GREEN/GOOD, 1 YELLOW/WARNING, 2 RED/FAILURE
  , Report VARCHAR(30)
  , FOREIGN KEY (Bridge_ID) REFERENCES Bridge_Tbl(Bridge_ID)
  );

-- House all the thresdholds for sensors
CREATE TABLE Sensor_Thresholds
  ( Teds_ID NUMBER(10)
  , CheckCode NUMBER(2)  -- What to check (0 equal, 1 min:less than, 2 max: greater than)
  , Threshold_Value NUMBER(5)  -- Value Surpass?
  , Report_Code NUMBER(2)
  , Report_Results VARCHAR(32) -- What should the report output
  , FOREIGN KEY (Teds_ID) REFERENCES Teds_Tbl(Teds_ID)
  );

--Insert Some Thresholds
INSERT INTO Sensor_Thresholds VALUES (0,0,115,0,'Equal Activate G');
INSERT INTO Sensor_Thresholds VALUES (0,1,90,1,'Min Activate Y');
INSERT INTO Sensor_Thresholds VALUES (0,2,100,2,'Max Activate R');

CREATE OR REPLACE PROCEDURE Sensor_Grab 
  ( P_SENSOR_ID IN Sensor_Data.Sensor_ID%Type
  , P_Bridge_ID OUT Bridge_Tbl.Bridge_ID%TYPE
  , P_TEDS_ID OUT Teds_Tbl.Teds_ID%TYPE
  )
  IS
BEGIN
  -- Grab Bridge and Ted ID
  SELECT Bridge_ID, Teds_ID
    INTO P_Bridge_ID, P_Teds_ID
    FROM SENSOR_TBL
    WHERE SENSOR_ID = P_Sensor_ID;
    
END Sensor_Grab;
/

-- Check for various attributes from the sensor and report 
create or replace PROCEDURE Health_Check
  ( P_Sensor_ID IN Sensor_Data.Sensor_ID%TYPE
  , P_Val IN Sensor_Data.Val%TYPE
  , P_Bridge_ID IN Bridge_Tbl.Bridge_ID%TYPE
  , P_Teds_ID IN Teds_Tbl.Teds_ID%TYPE
  )
  AS
  CURSOR THRESHOLD_T IS
    SELECT Teds_ID, CheckCode, Threshold_Value, Report_Code, Report_Results
    FROM SENSOR_THRESHOLDS
    WHERE TEDS_ID = P_Teds_ID;
    
  THRES THRESHOLD_T%ROWTYPE;
BEGIN

  --DBMS_OUTPUT.PUT_LINE('Health Check:' || P_Sensor_ID || ',' || P_Bridge_ID  || ',' || P_TEDS_ID || ',' || P_Val);
  
  --Grab the threshold checks table
  OPEN THRESHOLD_T;
  LOOP
    FETCH THRESHOLD_T INTO THRES;
    EXIT WHEN THRESHOLD_T%NOTFOUND;
    --DBMS_OUTPUT.PUT_LINE(THRES.Teds_ID || ',' || THRES.CheckCode || ',' || THRES.Threshold_Value || ',' || THRES.Report_Code || ',' || THRES.Report_Results);
    -- Go Though the checks
    
    -- Equal Threshold
    IF THRES.CheckCode = 0 THEN
    
      IF P_Val = THRES.Threshold_Value THEN
        INSERT INTO HEALTH_REPORT VALUES (P_Bridge_ID, SYSDATE, THRES.Report_Code, THRES.Report_Results);
      END IF;
    
    -- High Threshold
    ELSIF THRES.CheckCode = 1 THEN
    
      IF P_Val > THRES.Threshold_Value  THEN
        INSERT INTO HEALTH_REPORT VALUES (P_Bridge_ID, SYSDATE, THRES.Report_Code, THRES.Report_Results);
      END IF;
    
    
    -- Low Threshold
    ELSIF THRES.CheckCode = 2 THEN
    
      IF P_Val < THRES.Threshold_Value THEN
        INSERT INTO HEALTH_REPORT VALUES (P_Bridge_ID, SYSDATE, THRES.Report_Code, THRES.Report_Results);
      END IF;
    
    -- No Check
    END IF;
  END LOOP;
  CLOSE THRESHOLD_T;

END;
/

--Create a Trigger to maintain insert
CREATE OR REPLACE TRIGGER SensorDataTrig
BEFORE INSERT
  ON Sensor_Data 
  FOR EACH ROW

DECLARE
  P_BRIDGE_ID NUMBER(5);
  P_TEDS_ID NUMBER(10);

BEGIN
  UPDATE_DATA(:new.Sensor_ID,:new.DataEntry,:new.Val);
  Sensor_Grab(:new.Sensor_ID,P_Bridge_ID,P_Teds_ID);
  Health_Check(:new.Sensor_ID,:new.Val,P_Bridge_ID,P_Teds_ID);
END;
/

--Test Data
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
