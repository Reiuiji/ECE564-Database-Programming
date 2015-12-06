PROMPT ==========================================
PROMPT |           Dropping Database            |
PROMPT |               BridgeMon                |
PROMPT ==========================================

-- Going Through init in reverse

-- Health 
DROP TRIGGER    SensorDataTrig;
DROP PROCEDURE  Health_Check;
DROP PROCEDURE  Sensor_Grab;
DROP TABLE      Sensor_Thresholds;
DROP TABLE      Health_Report;

-- Sensor
DROP PROCEDURE  Update_Data;
DROP TABLE      Data_Update;
DROP PROCEDURE  Insert_Data;
DROP TABLE      Sensor_Data;
DROP TRIGGER    SensorTrig;
DROP SEQUENCE   Sensor_Seq;
DROP TABLE      Sensor_Tbl;

-- TEDS
DROP TABLE      physical_type;
DROP TABLE      Transducer_Type;
DROP TRIGGER    TedsTrig;
DROP SEQUENCE   Teds_Seq;
DROP TABLE      Teds_Tbl;


DROP VIEW       Bridge;
DROP FUNCTION   Insert_Bridge;
DROP TRIGGER    BridgeTrig;
DROP SEQUENCE   Bridge_Seq;
DROP TABLE      Bridge_Tbl;
DROP TYPE BODY  DATE_INFO;
DROP TYPE       Date_Info;
DROP TYPE       Location_Typ;