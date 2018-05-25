��������ӵ�����


/*

CREATE TABLE CONCATENATE
(
C1 VARCHAR2(50),
C2 VARCHAR2(50),
C3 VARCHAR2(50),
C4 VARCHAR2(50)
)


*/

SELECT * from CONCATENATE;


---------------��д-----------------
DECLARE

  ----�����ĸ��������������޸������ַ�
  V_1 VARCHAR2(200);
  V_2 VARCHAR2(200);
  V_3 VARCHAR2(200);
  V_4 VARCHAR2(200);

  V_TEMP VARCHAR2(200);
  CURSOR EMP_CUR IS
    SELECT C1, C2, C3,C4 FROM CONCATENATE FOR UPDATE OF C_SAVE NOWAIT;
BEGIN
  FOR EMP IN EMP_CUR LOOP
    ----�жϵ�һ���Ƿ�Ϊ��
    IF (EMP.C1 IS NULL) THEN
      V_1 := NULL;
    ELSE
      V_1 := EMP.C1;
    END IF;
  
    ---------�жϵڶ���
    IF EMP.C2 IS NULL THEN
      V_2 := NULL;
    ELSE
      IF V_1 IS NULL THEN
        V_2 := EMP.C2;
      ELSE
        V_2 := ' AND ' || EMP.C2;
      END IF;
    END IF;
  
    -----�жϵ�����
    IF EMP.C3 IS NULL THEN
      V_3 := NULL;
    ELSE
      IF (V_1 IS NULL) AND (V_2 IS NULL) THEN
        V_3 := EMP.C3;
      ELSE
        V_3 := ' AND ' || EMP.C3;
      END IF;
    END IF;
  
    -----�жϵ�����  
    IF EMP.C4 IS NULL THEN
      V_4 := NULL;
    ELSE
      IF (V_1 IS NULL) AND (V_2 IS NULL) AND (V_3 IS NULL) THEN
        V_4 := EMP.C4;
      ELSE
        V_4 := ' AND ' || EMP.C4;
      END IF;
    END IF;
  
    ------------��ʼƴ��--------
    V_TEMP := V_1 || V_2 || V_3||V_4;
    IF V_TEMP IS NOT NULL THEN
      V_TEMP:='FILTER('||V_TEMP||')';
    END IF;
    UPDATE CONCATENATE SET C_SAVE = V_TEMP WHERE CURRENT OF EMP_CUR;
  
  END LOOP;
END;
