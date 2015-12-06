--Date_Info: ADT Class
DROP TYPE Date_Info;

CREATE TYPE Date_Info AS OBJECT
  ( Date_Val Date
  , MEMBER FUNCTION age RETURN NUMBER
  , MEMBER FUNCTION ageV RETURN VARCHAR
  , MEMBER FUNCTION ageR RETURN NUMBER
  );
/

CREATE OR REPLACE
TYPE BODY DATE_INFO AS

  -- Calculate the age in just years
  MEMBER FUNCTION age RETURN NUMBER AS
  BEGIN
    RETURN trunc(months_between(sysdate,Date_val)/12);
  END age;
  -- Calculate the age with years and months
  MEMBER FUNCTION ageV RETURN VARCHAR AS
  BEGIN
    RETURN '(' ||
           trunc(months_between(sysdate,Date_val)/12)
           || ',' ||
           trunc(mod(months_between(sysdate,Date_val),12))
           || ',' ||
           trunc(sysdate-add_months(Date_val,trunc(months_between(sysdate,Date_val)/12)*12+trunc(mod(months_between(sysdate,Date_val),12))))
           || ')';
  END ageV;
  -- Calculate the age with the DB precise RAW Data
  MEMBER FUNCTION ageR RETURN NUMBER AS
  BEGIN
    RETURN months_between(sysdate,Date_val)/12;
  END ageR;
END;
/

DECLARE
  D0 Date_Info;
  Results VARCHAR2(100);
BEGIN
  D0 := Date_Info(TO_DATE('1935-06-22','YYYY-MM-DD'));
  Results := D0.age();
  DBMS_OUTPUT.PUT_LINE('Age = ' || Results || ' years');
  Results := D0.ageV();
  DBMS_OUTPUT.PUT_LINE('AgeV = ' || Results || ' (YY,MM,DD)');
  Results := D0.ageR();
  DBMS_OUTPUT.PUT_LINE('AgeR = ' || Results);
END;