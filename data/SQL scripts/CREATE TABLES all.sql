
--------------------------------------------------------
--  CREATE SEQUENCE
--------------------------------------------------------

   CREATE SEQUENCE  "ADM_ASSIGNEMENT_SEQ"     MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "ADM_DEPARTMENT_NPP_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "ADM_ORGANIZATION_SEQ"    MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "ADM_STATUS_SEQ"          MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "EXT_PERSON_SEQ"          MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "OT_YEAR_SEQ"             MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

   -- Dmitri
   
   CREATE SEQUENCE  "SEQUENCE_ID_DEPARTMENTS"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_DOZNARYAD"    MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_EQUIPMENT"    MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_JTITLE"       MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_ROOMS"        MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_SPECIALS"     MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_STATES"       MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_TASKS"        MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_TOW"          MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_UNITS"        MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_WORKERS"      MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_ZONES"        MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_BRIGADE_CON"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_DOZ_SPEC_CON" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   CREATE SEQUENCE  "SEQUENCE_ID_TASK_R_CON"   MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 2 START WITH 1 NOCACHE NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
   
   

--------------------------------------------------------
--  CREATE Tables
--------------------------------------------------------

  CREATE TABLE "EXT_PERSON" 
   ("ID_PERSON" NUMBER, 
	"W_NAME" VARCHAR2(20 BYTE), 
	"W_SURNAME" VARCHAR2(20 BYTE), 
	"W_PATRONYMIC" VARCHAR2(20 BYTE), 
	"STATUS_CODE" NUMBER, 
	"SEX" VARCHAR2(1 BYTE), 
	"BIRTH_DATE" DATE, 
	"WEIGHT" VARCHAR2(20 BYTE), 
	"HEIGHT" VARCHAR2(20 BYTE), 
	"STAFF_TYPE" VARCHAR2(50 BYTE), 
	"ID_DEPARTMENT_NPP" NUMBER, 
	"ID_ORGANIZATION" NUMBER, 
	"ID_ASSIGNEMENT" NUMBER, 
	"ID_TLD" NUMBER, 
	"DOSE_BEFORE_NPP" NUMBER, 
	"DOSE_CHNPP" NUMBER, 
	"IKU_YEAR" NUMBER, 
	"IKU_MONTH" NUMBER, 
	"AU" NUMBER, 
	"IU" NUMBER, 
	"EMERGENCY_DOSE" VARCHAR2(1 BYTE), 
	"DISABLE_RADIATION" VARCHAR2(1 BYTE), 
	"PASSPORT_NUMBER" VARCHAR2(20 BYTE), 
	"PASSPORT_GIVE" VARCHAR2(200 BYTE), 
	"PASSPORT_DATE" DATE, 
	"POLICY_NUMBER" VARCHAR2(20 BYTE), 
	"SNILS" VARCHAR2(20 BYTE), 
	"WORK_TEL" VARCHAR2(20 BYTE), 
	"WORK_ADDRESS" VARCHAR2(200 BYTE), 
	"MOBILE_TEL" VARCHAR2(20 BYTE), 
	"HOME_TEL" VARCHAR2(20 BYTE), 
	"HOME_ADDRESS" VARCHAR2(200 BYTE), 
	"E_MAIL" VARCHAR2(20 BYTE), 
	"DATE_ON" DATE, 
	"DATE_OFF" DATE, 
	"COMMENTS" VARCHAR2(300 BYTE), 
	"PERSON_NUMBER" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  

    
  CREATE TABLE "ADM_ASSIGNEMENT" 
   (	"ID" NUMBER, 
	"ASSIGNEMENT" VARCHAR2(100 BYTE), 
	"ASSIGNEMENT_CODE" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  
  CREATE TABLE "ADM_DEPARTMENT_NPP" 
   (	"ID" NUMBER, 
	"DEPARTMENT_NPP" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ; 
 
  
  
  CREATE TABLE "ADM_ORGANIZATION" 
   (	"ID" NUMBER, 
	"ORGANIZATION_" VARCHAR2(20 BYTE), 
	"DEPARTMENT" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  
  CREATE TABLE "ADM_STATUS" 
   (	"ID" NUMBER, 
	"STATUS_CODE" NUMBER, 
	"STATUS" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  
  CREATE TABLE "OT_YEAR" 
   (	"ID" NUMBER, 
	"BETA" NUMBER, 
	"GAMMA" NUMBER, 
	"NEUTRON" NUMBER, 
	"EFFECTIVE_DOSE" NUMBER, 
	"HP007" NUMBER, 
	"HP3" NUMBER, 
	"SICH" NUMBER, 
	"ID_PERSON" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  
  -- Dmitri  
  
  CREATE TABLE "TABLE_BRIGADE_CON" 
   ("ID" NUMBER,
    "ID_DOZNARYAD" NUMBER, 
	"ID_WORKER" NUMBER 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
    

  CREATE TABLE "TABLE_DEPARTMENTS" 
   ("ID" NUMBER, 
	"DEPARTMENT" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  
  CREATE TABLE "TABLE_DOZNARYAD" 
   ("ID" NUMBER, 
	"DOZ_NUMBER" VARCHAR2(20 BYTE), 
	"DOZ_DIRECTIVE" NUMBER(1,0), 
	"ID_DEPARTMENT" NUMBER, 
	"ID_RESPONSIBLE" NUMBER, 
	"ID_LEADER" NUMBER, 
	"ID_PRODUCER" NUMBER, 
	"OPEN_DATE" DATE, 
	"CLOSE_DATE" DATE, 
	"DOZ_STATUS" NUMBER, 
	"DOZ_GET_DATE" DATE, 
	"ID_OPEN_WORKER" NUMBER, 
	"ID_CLOSE_WORKER" NUMBER, 
	"ID_AGREED" NUMBER, 
	"START_OF_WORK" DATE, 
	"END_OF_WORK" DATE, 
	"PERMITTED_DOSE" FLOAT(126), 
	"PERMITTED_TIME" NUMBER, 
	"SUM_DOSE" FLOAT(126), 
	"OVER_DOSE" FLOAT(126), 
	"COLLECTIVE_DOSE" FLOAT(126), 
	"SPECIAL_COMMENT" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

 
  CREATE TABLE "TABLE_DOZNARYAD_SPECIALS_CON" 
   ("ID" NUMBER,
    "ID_DOZNARYAD" NUMBER, 
	"ID_SPECIALS" NUMBER 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  CREATE TABLE "TABLE_EQUIPMENT" 
   ("ID" NUMBER, 
	"EQUIPMENT_NAME" VARCHAR2(100 BYTE), 
	"ID_ROOM" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_JOB_TITLE" 
   ("ID" NUMBER, 
	"JOB_NAME" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_ROOMS" 
   ("ID" NUMBER, 
	"ROOM_NAME" VARCHAR2(100 BYTE), 
	"ID_ZONE" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_SPECIALS" 
   ("ID" NUMBER, 
	"OPTION_NAME" VARCHAR2(200 BYTE), 
	"ID_TYPE" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_STATES" 
   ("ID" NUMBER, 
	"STATE_NAME" VARCHAR2(30 BYTE), 
	"STATE_COLOR" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_TASKS" 
   ("ID" NUMBER, 
	"ID_DOZNARYAD" NUMBER, 
	"ID_EQUIPMENT" NUMBER, 
	"ID_UNIT" NUMBER, 
	"ID_TYPE_OF_WORK" NUMBER, 
	"ID_JOB_TITLE" NUMBER, 
	"DOSE_VALUE" FLOAT(126), 
	"PEOPLE_CNT" NUMBER, 
	"CURRENT_DAY" NUMBER, 
	"GAMMA_VALUE" FLOAT(126), 
	"BETA_VALUE" FLOAT(126), 
	"NEUTRON_VALUE" FLOAT(126), 
	"ALFA_VALUE" FLOAT(126), 
	"MEASURE" NUMBER(1,0), 
	"CHB_RAD_STATE" NUMBER(1,0), 
	"ID_BLOK" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_TASKS_ROOMS_CON" 
   ("ID" NUMBER,
    "ID_ROOM" NUMBER, 
	"ID_TASK" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_TYPE_OF_WORK" 
   ("ID" NUMBER, 
	"TYPE_NAME" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_UNITS" 
   ("ID" NUMBER, 
	"UNIT_NAME" VARCHAR2(100 BYTE), 
	"ID_EQUIPMENT" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


CREATE TABLE "TABLE_WORKERS" 
   ("ID" NUMBER, 
	"W_NAME" VARCHAR2(100 BYTE), 
	"W_SURNAME" VARCHAR2(100 BYTE), 
	"W_PATRONYMIC" VARCHAR2(100 BYTE), 
	"PERSON_NUMBER" VARCHAR2(100 BYTE), 
	"FLG_GET" NUMBER(1,0), 
	"FLG_LEADER" NUMBER(1,0), 
	"FLG_PRODUCER" NUMBER(1,0), 
	"FLG_OPEN" NUMBER(1,0), 
	"FLG_CLOSE" NUMBER(1,0), 
	"ID_DEPARTMENT" NUMBER, 
	"TLD_NUMBER" NUMBER, 
	"GENDER" NUMBER(1,0) DEFAULT 1, 
	"BIRTHDAY" DATE, 
	"WEIGHT" NUMBER, 
	"GROWTH" NUMBER, 
	"ID_CONTROL_TYPE" NUMBER, 
	"ID_STATUS" NUMBER, 
	"IKU_MONTH" FLOAT(126), 
	"IKU_YEAR" FLOAT(126), 
	"ID_POSITION" NUMBER, 
	"PASSPORT_SERIAL" VARCHAR2(10 BYTE), 
	"PASSPORT_NUMBER" VARCHAR2(10 BYTE), 
	"PASSPORT_WHO" VARCHAR2(200 BYTE), 
	"PASSPORT_DATE" DATE, 
	"MEDICAL_NUMBER" VARCHAR2(30 BYTE), 
	"HOME_PHONE" VARCHAR2(20 BYTE), 
	"HOME_ADDRESS" VARCHAR2(200 BYTE), 
	"MOBILE_PHONE" VARCHAR2(20 BYTE), 
	"PANSION_NUMBER" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


  CREATE TABLE "TABLE_ZONES" 
   ("ID" NUMBER, 
	"ZONE_NAME" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;   

 
  
--------------------------------------------------------
--  CREATE UNIQUE INDEX
--------------------------------------------------------

  CREATE UNIQUE INDEX "EXT_PERSON_PK" ON "EXT_PERSON" ("ID_PERSON") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  CREATE UNIQUE INDEX "ADM_ASSIGNEMENT_PK" ON "ADM_ASSIGNEMENT" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  CREATE UNIQUE INDEX "ADM_DEPARTMENT_NPP_PK" ON "ADM_DEPARTMENT_NPP" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  CREATE UNIQUE INDEX "ADM_ORGANIZATION_PK" ON "ADM_ORGANIZATION" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  
  CREATE UNIQUE INDEX "ADM_STATUS_PK" ON "ADM_STATUS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;  
  
  
  CREATE UNIQUE INDEX "OT_YEAR_PK" ON "OT_YEAR" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
    
	
	
  -- Dmitri
	
  CREATE UNIQUE INDEX "TABLE_DEPARTMENTS_PK" ON "TABLE_DEPARTMENTS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_DOZNARYAD_PK" ON "TABLE_DOZNARYAD" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_EQUIPMENT_PK" ON "TABLE_EQUIPMENT" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_JOB_TITLE_PK" ON "TABLE_JOB_TITLE" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_ROOMS_PK" ON "TABLE_ROOMS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_SPECIALS_PK" ON "TABLE_SPECIALS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_STATES_PK" ON "TABLE_STATES" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_TASKS_PK" ON "TABLE_TASKS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_TYPE_OF_WORK_PK" ON "TABLE_TYPE_OF_WORK" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_UNITS_PK" ON "TABLE_UNITS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_WORKERS_PK" ON "TABLE_WORKERS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE UNIQUE INDEX "TABLE_ZONES_PK" ON "TABLE_ZONES" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  CREATE UNIQUE INDEX "TABLE_BRIGADE_CON_PK" ON "TABLE_BRIGADE_CON" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;  
  
  CREATE UNIQUE INDEX "TABLE_DOZNARYAD_SPECIALS_C_PK" ON "TABLE_DOZNARYAD_SPECIALS_CON" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  CREATE UNIQUE INDEX "TABLE_TASKS_ROOMS_CON_PK" ON "TABLE_TASKS_ROOMS_CON" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
	
  
--------------------------------------------------------
--  CREATE TRIGGER
--------------------------------------------------------
  CREATE OR REPLACE EDITIONABLE TRIGGER "EXT_PERSON_TRG" 
   before insert on "EXT_PERSON" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID_PERSON" is null then 
         select EXT_PERSON_SEQ.nextval into :NEW."ID_PERSON" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "EXT_PERSON_TRG" ENABLE;



  CREATE OR REPLACE EDITIONABLE TRIGGER "ADM_ASSIGNEMENT_TRG" 
   before insert on "ADM_ASSIGNEMENT" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select ADM_ASSIGNEMENT_SEQ.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "ADM_ASSIGNEMENT_TRG" ENABLE;



  CREATE OR REPLACE EDITIONABLE TRIGGER "ADM_DEPARTMENT_NPP_TRG" 
   before insert on "ADM_DEPARTMENT_NPP" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select ADM_DEPARTMENT_NPP_SEQ.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "ADM_DEPARTMENT_NPP_TRG" ENABLE;



  CREATE OR REPLACE EDITIONABLE TRIGGER "ADM_ORGANIZATION_TRG" 
   before insert on "ADM_ORGANIZATION" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select ADM_ORGANIZATION_SEQ.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "ADM_ORGANIZATION_TRG" ENABLE;



  CREATE OR REPLACE EDITIONABLE TRIGGER "ADM_STATUS_TRG" 
   before insert on "ADM_STATUS" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select ADM_STATUS_SEQ.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "ADM_STATUS_TRG" ENABLE;



  CREATE OR REPLACE EDITIONABLE TRIGGER "OT_YEAR_TRG" 
   before insert on "OT_YEAR" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select OT_YEAR_SEQ.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "OT_YEAR_TRG" ENABLE;



  -- Dmitri  

  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_DEPARTMENTS_PK" 
   before insert on "TABLE_DEPARTMENTS" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_DEPARTMENTS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_DEPARTMENTS_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_DOZNARYAD_PK" 
   before insert on "TABLE_DOZNARYAD" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_DOZNARYAD.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_DOZNARYAD_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_EQUIPMENT_PK" 
   before insert on "TABLE_EQUIPMENT" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_EQUIPMENT.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_EQUIPMENT_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_JTITLE_PK" 
   before insert on "TABLE_JOB_TITLE" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_JTITLE.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_JTITLE_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_ROOMS_PK" 
   before insert on "TABLE_ROOMS" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_ROOMS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_ROOMS_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_SPECIALS_PK" 
   before insert on "TABLE_SPECIALS" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_SPECIALS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_SPECIALS_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_STATES" 
   before insert on "TABLE_STATES" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_STATES.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_STATES" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_TASKS" 
   before insert on "TABLE_TASKS" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_TASKS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_TASKS" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_TOW_PK" 
   before insert on "TABLE_TYPE_OF_WORK" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_TOW.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_TOW_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_UNITS_PK" 
   before insert on "TABLE_UNITS" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_UNITS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_UNITS_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_WORKERS_PK" 
   before insert on "TABLE_WORKERS" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_WORKERS.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_WORKERS_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_ZONES_PK" 
   before insert on "TABLE_ZONES" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_ZONES.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_ZONES_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_BRIGADE_CON_PK" 
   before insert on "TABLE_BRIGADE_CON" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_BRIGADE_CON.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_BRIGADE_CON_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_DOZ_SPEC_CON_PK" 
   before insert on "TABLE_DOZNARYAD_SPECIALS_CON" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_DOZ_SPEC_CON.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_DOZ_SPEC_CON_PK" ENABLE;


  CREATE OR REPLACE EDITIONABLE TRIGGER "TR_TASK_R_CON_PK" 
   before insert on "TABLE_TASKS_ROOMS_CON" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SEQUENCE_ID_TASK_R_CON.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "TR_TASK_R_CON_PK" ENABLE;  



--------------------------------------------------------
--  Constraints for Tables
--------------------------------------------------------  

  ALTER TABLE "EXT_PERSON" MODIFY ("ID_PERSON" NOT NULL ENABLE);
  ALTER TABLE "EXT_PERSON" ADD CONSTRAINT "EXT_PERSON_PK" PRIMARY KEY ("ID_PERSON")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  
  
  
  ALTER TABLE "ADM_ASSIGNEMENT" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "ADM_ASSIGNEMENT" ADD CONSTRAINT "ADM_ASSIGNEMENT_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  

  ALTER TABLE "ADM_DEPARTMENT_NPP" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "ADM_DEPARTMENT_NPP" ADD CONSTRAINT "ADM_DEPARTMENT_NPP_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  
  
  ALTER TABLE "ADM_ORGANIZATION" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "ADM_ORGANIZATION" ADD CONSTRAINT "ADM_ORGANIZATION_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;  
  
  
  ALTER TABLE "ADM_STATUS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "ADM_STATUS" ADD CONSTRAINT "ADM_STATUS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  
  
  
  ALTER TABLE "OT_YEAR" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "OT_YEAR" ADD CONSTRAINT "OT_YEAR_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  
  
  
  -- Dmitri  

  ALTER TABLE "TABLE_DEPARTMENTS" ADD CONSTRAINT "TABLE_DEPARTMENTS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_DOZNARYAD" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_DOZNARYAD" ADD CONSTRAINT "TABLE_DOZNARYAD_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_EQUIPMENT" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_EQUIPMENT" ADD CONSTRAINT "TABLE_EQUIPMENT_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_JOB_TITLE" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_JOB_TITLE" ADD CONSTRAINT "TABLE_JOB_TITLE_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_ROOMS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_ROOMS" ADD CONSTRAINT "TABLE_ROOMS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_SPECIALS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_SPECIALS" ADD CONSTRAINT "TABLE_SPECIALS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_STATES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_STATES" ADD CONSTRAINT "TABLE_STATES_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_TASKS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_TASKS" ADD CONSTRAINT "TABLE_TASKS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_TYPE_OF_WORK" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_TYPE_OF_WORK" ADD CONSTRAINT "TABLE_TYPE_OF_WORK_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_UNITS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_UNITS" ADD CONSTRAINT "TABLE_UNITS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_WORKERS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_WORKERS" ADD CONSTRAINT "TABLE_WORKERS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;

  ALTER TABLE "TABLE_ZONES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_ZONES" ADD CONSTRAINT "TABLE_ZONES_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  
  ALTER TABLE "TABLE_BRIGADE_CON" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_BRIGADE_CON" ADD CONSTRAINT "TABLE_BRIGADE_CON_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  
  ALTER TABLE "TABLE_DOZNARYAD_SPECIALS_CON" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_DOZNARYAD_SPECIALS_CON" ADD CONSTRAINT "TABLE_DOZNARYAD_SPECIALS_C_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  
  ALTER TABLE "TABLE_TASKS_ROOMS_CON" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "TABLE_TASKS_ROOMS_CON" ADD CONSTRAINT "TABLE_TASKS_ROOMS_CON_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;  

