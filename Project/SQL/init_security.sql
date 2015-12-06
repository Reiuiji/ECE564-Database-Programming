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
  ( Sensor_ID                 NUMBER(10) NOT NULL
  , Key                       VARCHAR(60)
  , FOREIGN KEY(Sensor_ID)    REFERENCES Sensor_Tbl(Sensor_ID)
  );

-- Setup Default User Name and Pass
-- user: root
-- pass: toor
-- * Update when you login

INSERT INTO User_Tbl VALUES ( 'root','root@localhost', '$2y$12$Y9jGaHcdxFkpZgHzYoSiBe1qW3vL4GXydwH65h0RaAWVTQCbgt27u');
