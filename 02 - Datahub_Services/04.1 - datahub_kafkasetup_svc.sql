USE ROLE DATAHUB_ROLE;
USE ADM_SNOWFLAKE;
USE SCHEMA DATAHUB;

CREATE SERVICE datahub_kafkasetup_svc
  IN COMPUTE POOL DATAHUB_POOL
  FROM SPECIFICATION $$
    spec:
      containers:
      - name: kafkasetup
        image: /manage_db/datahub/datahub_repository/datahub-kafka-setup:head
        env:
            DATAHUB_PRECREATE_TOPICS: ${DATAHUB_PRECREATE_TOPICS:-false}
            KAFKA_BOOTSTRAP_SERVER: datahub-broker-svc.mupx.svc.spcs.internal:29092
            KAFKA_ZOOKEEPER_CONNECT: datahub-zookeeper-svc.mupx.svc.spcs.internal:2181
            USE_CONFLUENT_SCHEMA_REGISTRY: TRUE
      $$
      
   MIN_INSTANCES=1
   MAX_INSTANCES=1;

/*
SELECT SYSTEM$GET_SERVICE_STATUS('datahub_kafkasetup_svc');
CALL SYSTEM$GET_SERVICE_LOGS('datahub_kafkasetup_svc', '0','kafkasetup');
SHOW SERVICES;
*/
