--
-- TEDS DATA IEEE 1451d
--
-- Sensor Setup/design based on the type of sensor and configurations
--

DROP TABLE Teds_Tbl;



CREATE TABLE Teds_Tbl
  ( 
  -- Basic TEDS Content
    Teds_ID NUMBER(10)
  -- Section 1
  , Manufactureer_ID NUMBER(5) -- 17 - 16381    : 14 Bits
  , Model_Number NUMBER(5)     -- 0  - 32767    : 15 Bits
  , Version_Letter CHAR(1)     -- A  - Z        :  5 Bits
  , Version_Number NUMBER(2)   -- 0  - 63       :  6 Bits
  , Serial_Number NUMBER(8)    -- 0  - 16777215 : 24 Bits
  
  -- Section 2 Standard Template TEDS
  , Template_ID Number(2)      -- 25 - 39       :  8 Bits
  , Standard_Template RAW(2000)
  -- Section 3 Calibration TEDS Template
  , Template_ID_C NUMBER(2)    -- 40 - 42       :  8 Bits
  , Calibration_Template RAW(2000)
  
  -- Section 4 User Data
  , User_Text VARCHAR(32)
  , PRIMARY KEY (TEDS_ID)
);

--Create a sequence to keep track of the Teds_ID values
DROP SEQUENCE   Teds_Seq;
CREATE SEQUENCE Teds_Seq
  MINVALUE 0
  START WITH 0;

--Create a Trigger to maintain insert
CREATE OR REPLACE TRIGGER TedsTrig
BEFORE INSERT ON Teds_Tbl 
FOR EACH ROW
BEGIN
  SELECT Teds_Seq.NEXTVAL
  INTO   :new.Teds_ID
  FROM   dual;
END;
/

--Test TEDS INSERT
--arbitrary data
INSERT INTO Teds_Tbl VALUES (0,17,1,'a',1,12341234,25,'FFFFF',0, '0','Acceleretor Test');
INSERT INTO Teds_Tbl VALUES (0,42,3,'b',3,86753090,33,'A0A0A',0, '0','Bridge S Test');
INSERT INTO Teds_Tbl VALUES (0,88,2,'a',5,13371337,35,'E8F8A',0, '0','Strain Test');
INSERT INTO Teds_Tbl VALUES (0,99,6,'c',2,80808080,37,'FACE0',0, '0','Res Temp Test');
INSERT INTO Teds_Tbl VALUES (0,99,6,'c',2,80808080,38,'FACE0',0, '0','Thermistor Test');

SELECT * FROM TEDS_TBL;

DROP TABLE Transducer_Type;
--IEEE Standard Templates - Trandsucer Types
CREATE TABLE Transducer_Type (
  Transducer_ID  NUMBER(2) NOT NULL,
  Name VARCHAR(100),
  PRIMARY KEY(Transducer_ID)
);
--Transducer Type Data
INSERT INTO Transducer_Type VALUES (25,'Accelerometer and Force');
INSERT INTO Transducer_Type VALUES (26,'Charge Amplifier (w/ attached accelerometer)');
INSERT INTO Transducer_Type VALUES (27,'Microphone with built-in preamplifier');
INSERT INTO Transducer_Type VALUES (28,'Microphone Preamplfiers (w/ attached microphone)');
INSERT INTO Transducer_Type VALUES (29,'Microphones (capacitive)');
INSERT INTO Transducer_Type VALUES (30,'High-Level Voltage Output Sensors');
INSERT INTO Transducer_Type VALUES (31,'Current Loop Output Sensors');
INSERT INTO Transducer_Type VALUES (32,'Resistance Sensors');
INSERT INTO Transducer_Type VALUES (33,'Bridge Sensors');
INSERT INTO Transducer_Type VALUES (34,'AC Linear/Rotary Variable Differential Transformer (LVDT/RVDT) Sensors');
INSERT INTO Transducer_Type VALUES (35,'Strain Gage');
INSERT INTO Transducer_Type VALUES (36,'Thermocouple');
INSERT INTO Transducer_Type VALUES (37,'Resistance Temperature Detectors (RTDs)');
INSERT INTO Transducer_Type VALUES (38,'Thermistor');
INSERT INTO Transducer_Type VALUES (39,'Potentiometric Voltage Divider');
INSERT INTO Transducer_Type VALUES (40,'Calibration Table');
INSERT INTO Transducer_Type VALUES (41,'Calibration Curve (Polynomial)');
INSERT INTO Transducer_Type VALUES (42,'Frequency Response Table');

-- Link TEDS with what type the data is
Select TD.TEDS_ID, TT.Name 
FROM TEDS_TBL TD
JOIN TRANSDUCER_TYPE TT ON TD.Template_ID = TT.Transducer_ID;

--IEEE Standard Templates - Physical Measureand

DROP Table physical_type;
CREATE TABLE physical_type (
  physical_id  NUMBER(3) NOT NULL,
  unit    varchar(12),
  PRIMARY KEY(physical_id)
);

-- Physical Type Data
INSERT INTO Physical_Type VALUES (0,'K');
INSERT INTO Physical_Type VALUES (1,'°C');
INSERT INTO Physical_Type VALUES (2,'strain');
INSERT INTO Physical_Type VALUES (3,'microstrain');
INSERT INTO Physical_Type VALUES (4,'N');
INSERT INTO Physical_Type VALUES (5,'LB');
INSERT INTO Physical_Type VALUES (6,'kgf');
INSERT INTO Physical_Type VALUES (7,'m/s^2');
INSERT INTO Physical_Type VALUES (8,'ga');
INSERT INTO Physical_Type VALUES (9,'Nm/radian 25');
INSERT INTO Physical_Type VALUES (10,'Nm');
INSERT INTO Physical_Type VALUES (11,'oz-in');
INSERT INTO Physical_Type VALUES (12,'Pa');
INSERT INTO Physical_Type VALUES (13,'psi');
INSERT INTO Physical_Type VALUES (14,'Kg');
INSERT INTO Physical_Type VALUES (15,'G');
INSERT INTO Physical_Type VALUES (16,'m');
INSERT INTO Physical_Type VALUES (17,'mm');
INSERT INTO Physical_Type VALUES (18,'in');
INSERT INTO Physical_Type VALUES (19,'m/s');
INSERT INTO Physical_Type VALUES (20,'mph');
INSERT INTO Physical_Type VALUES (21,'fps');
INSERT INTO Physical_Type VALUES (22,'radians');
INSERT INTO Physical_Type VALUES (23,'degrees');
INSERT INTO Physical_Type VALUES (24,'radian/s');
INSERT INTO Physical_Type VALUES (25,'rpm');
INSERT INTO Physical_Type VALUES (26,'Hz');
INSERT INTO Physical_Type VALUES (27,'g/l');
INSERT INTO Physical_Type VALUES (28,'kg/m^3');
INSERT INTO Physical_Type VALUES (29,'mole/m^3');
INSERT INTO Physical_Type VALUES (30,'mole/l');
INSERT INTO Physical_Type VALUES (31,'m^3/m^3');
INSERT INTO Physical_Type VALUES (32,'l/l');
INSERT INTO Physical_Type VALUES (33,'kg/s');
INSERT INTO Physical_Type VALUES (34,'m^3/s');
INSERT INTO Physical_Type VALUES (35,'m^3/hr');
INSERT INTO Physical_Type VALUES (36,'gpm');
INSERT INTO Physical_Type VALUES (37,'cfm');
INSERT INTO Physical_Type VALUES (38,'1/min');
INSERT INTO Physical_Type VALUES (39,'RH');
INSERT INTO Physical_Type VALUES (40,'%');
INSERT INTO Physical_Type VALUES (41,'V');
INSERT INTO Physical_Type VALUES (42,'V rms');
INSERT INTO Physical_Type VALUES (43,'Amperes');
INSERT INTO Physical_Type VALUES (44,'Amperes rms');
INSERT INTO Physical_Type VALUES (45,'Watts');