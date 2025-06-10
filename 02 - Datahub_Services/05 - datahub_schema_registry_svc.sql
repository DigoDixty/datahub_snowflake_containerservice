USE ROLE DATAHUB_ROLE;
USE ADM_SNOWFLAKE;
USE SCHEMA DATAHUB;

CREATE SERVICE datahub_schema_registry_svc
  IN COMPUTE POOL DATAHUB_POOL
  FROM SPECIFICATION $$
    spec:
      containers:
      - name: schema-registry
        image: /manage_db/datahub/datahub_repository/cp-schema-registry:7.9.1
        env:
            SCHEMA_REGISTRY_HOST_NAME: schemaregistry
            SCHEMA_REGISTRY_KAFKASTORE_SECURITY_PROTOCOL: PLAINTEXT
            SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS: datahub-broker-svc.mupx.svc.spcs.internal:29092

      endpoints:    
      - name: schema-registry
        port: 8081
        public: true
        
      $$
   MIN_INSTANCES=1
   MAX_INSTANCES=1;

/*
SHOW ENDPOINTS IN SERVICE datahub_schema_registry_svc;
SELECT SYSTEM$GET_SERVICE_STATUS('datahub_schema_registry_svc');
CALL SYSTEM$GET_SERVICE_LOGS('datahub_schema_registry_svc', '0','schema-registry');
SHOW SERVICES;
*/