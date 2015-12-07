--
-- Security Init Script
--

-- Create User Account Login Info
CREATE TABLE User_Tbl 
  ( Username  VARCHAR(32)
  , email     VARCHAR(32)
  , Password  VARCHAR(255)
  , PRIMARY KEY(Username)
  );

-- Log all failed attemts
CREATE TABLE Failed_Login
  ( Username  VARCHAR(32)
  , Event     TIMESTAMP(0)
  , FOREIGN KEY(Username)  REFERENCES User_Tbl(Username)
  );

-- Sensor Access Token Tables
CREATE TABLE ACCESS_TOKEN
  ( Sensor_ID                 NUMBER(10) NOT NULL UNIQUE
  , Key                       VARCHAR(60)
  , FOREIGN KEY(Sensor_ID)    REFERENCES Sensor_Tbl(Sensor_ID)
  );
  
  
-- Insert Auth Token
-- Handles the update of the Sensors Token
CREATE OR REPLACE PROCEDURE INSERT_TOKEN
  ( P_Sensor_ID IN ACCESS_TOKEN.Sensor_ID%TYPE
  , P_Key         IN ACCESS_TOKEN.Key%TYPE
  )
  AS
BEGIN
  INSERT INTO ACCESS_TOKEN (Sensor_ID, Key) VALUES (P_Sensor_ID, P_Key);
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      -- Update to the new token
      UPDATE ACCESS_TOKEN
      SET    Key = P_Key
      WHERE Sensor_ID = P_Sensor_ID;
END;
/