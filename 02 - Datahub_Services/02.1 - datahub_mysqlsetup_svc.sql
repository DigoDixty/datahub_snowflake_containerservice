USE ROLE DATAHUB_ROLE;
USE ADM_SNOWFLAKE;
USE SCHEMA DATAHUB;

CREATE SERVICE datahub_mysqlsetup_svc
  IN COMPUTE POOL DATAHUB_POOL
  FROM SPECIFICATION $$
    spec:
      containers:
      - name: mysqlsetup
        image: /manage_db/datahub/datahub_repository/datahub-mysql-setup:head
        env: 
            MYSQL_USERNAME: datahub
            MYSQL_PASSWORD: datahub
            DATAHUB_DB_NAME: datahub
            MYSQL_PORT: 3306
            MYSQL_HOST: datahub-mysql-svc.mupx.svc.spcs.internal
      $$
      
   MIN_INSTANCES=1
   MAX_INSTANCES=1;

/*
DROP SERVICE datahub_mysqlsetup_svc;
SELECT SYSTEM$GET_SERVICE_STATUS('datahub_mysqlsetup_svc');
CALL SYSTEM$GET_SERVICE_LOGS('datahub_mysqlsetup_svc', '0','mysqlsetup');
DROP SERVICE datahub_mysqlsetup_svc;
SHOW SERVICES;
*/