-- Inserting Values for Bridge

DECLARE
  Results VARCHAR2(100);
BEGIN
  -- insert_bridge(Name, Year_Build, Country, State, City, Lat, Lot);
  Results := insert_bridge('Sagamore Bridge','1935-06-22','USA','MA','Bourne','41.77628','-70.54326');
  Results := insert_bridge('Bourne Bridge', '1935-06-22', 'USA','MA','Bourne','41.74781','-70.58963');
  Results := insert_bridge('Cape Cod Canal Railroad Bridge', '1935-06-22', 'USA','MA','Bourne','41.74202','-70.61363');
END;
/

-- Inserting Arbitrary TEDS Data
-- INSERT INTO Teds_Tbl VALUES (0,TEDS_ID, M_ID, Model_NUM, VerNum, Serial, T_ID, StdTmp, TC_ID, CTmp, User_Text);
INSERT INTO Teds_Tbl VALUES (0,17,1,'a',1,12341234,25,'FFFFF',0, '0','Accelerator Test');
INSERT INTO Teds_Tbl VALUES (0,42,3,'b',3,86753090,33,'A0A0A',0, '0','Bridge S Test');
INSERT INTO Teds_Tbl VALUES (0,88,2,'a',5,13371337,35,'E8F8A',0, '0','Strain Test');
INSERT INTO Teds_Tbl VALUES (0,99,6,'c',2,80808080,37,'FACE0',0, '0','Res Temp Test');
INSERT INTO Teds_Tbl VALUES (0,99,6,'c',2,80808080,38,'FACE0',0, '0','Thermistor Test');

-- Inserting Default Transducer Type Data
-- INSERT INTO Transducer_Type VALUES (T_ID,Name);
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

-- Inserting Default Physical Type Data
-- INSERT INTO Physical_Type VALUES (P_ID,Unit);
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

-- Inserting Default Sensor Table Values
-- INSERT INTO Sensor_Tbl VALUES (S_ID,B_ID,T_ID,Location_Number);
INSERT INTO Sensor_Tbl VALUES (0,0,0,0);
INSERT INTO Sensor_Tbl VALUES (0,0,1,1);
INSERT INTO Sensor_Tbl VALUES (0,0,1,2);
INSERT INTO Sensor_Tbl VALUES (0,0,1,3);
INSERT INTO Sensor_Tbl VALUES (0,0,2,4);
INSERT INTO Sensor_Tbl VALUES (0,1,1,2);
INSERT INTO Sensor_Tbl VALUES (0,1,1,3);
INSERT INTO Sensor_Tbl VALUES (0,2,2,4);

-- Insert Health Monitory Thresholds
-- INSERT INTO Sensor_Thresholds VALUES (T_ID, CheckCode, Threshold_Value, Report_Code, Report_Results);
INSERT INTO Sensor_Thresholds VALUES (0,0,115,0,'Equal Activate G');
INSERT INTO Sensor_Thresholds VALUES (0,1,90,1,'Max Activate Y');
INSERT INTO Sensor_Thresholds VALUES (0,2,100,2,'Min Activate R');

-- Insert arbitrary Sensor Data
DECLARE
BEGIN
  -- Insert_Data(S_ID, Val);
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
  Insert_Data(2,80);
  Insert_Data(2,85);
  Insert_Data(2,90);
  Insert_Data(2,95);
  Insert_Data(2,115);
  Insert_Data(2,120);
  Insert_Data(2,130);
END;
/

-- Insert Default Security Values
-- Setup Default User Name and Pass
-- user: root
-- pass: toor
-- * Update when you login

INSERT INTO User_Tbl VALUES ( 'root','root@localhost', '$2y$12$Y9jGaHcdxFkpZgHzYoSiBe1qW3vL4GXydwH65h0RaAWVTQCbgt27u');

-- Create a template Token
DECLARE
BEGIN
  INSERT_TOKEN(0,'6bb047e07c43503d0769f21152fd0090');
  INSERT_TOKEN(0,'a572fd2cc684f05da7a982322cbce2c6');
  INSERT_TOKEN(1,'2bb87705ce1013ab26654c9fe48b67c0');
END;
/
