DECLARE
  NAME VARCHAR2(60);
  YEAR VARCHAR2(200);
  COUNTRY VARCHAR2(60);
  STATE VARCHAR2(2);
  CITY VARCHAR2(60);
  LAT VARCHAR2(60);
  LOT VARCHAR2(60);
  v_Return VARCHAR2(15000);
BEGIN
  NAME := 'Sagamore Bridge';
  YEAR := '1935-06-22';
  COUNTRY := 'USA';
  STATE := 'MA';
  CITY := 'Bourne';
  LAT := '41.77628';
  LOT := '-70.54326';

  v_Return := insert_bridge('Sagamore Bridge','1935-06-22','USA','MA','Bourne','41.77628','-70.54326');
  DBMS_OUTPUT.PUT_LINE('v_Return = ' || v_Return);
 -- :v_Return := v_Return;
--rollback; 
END;
