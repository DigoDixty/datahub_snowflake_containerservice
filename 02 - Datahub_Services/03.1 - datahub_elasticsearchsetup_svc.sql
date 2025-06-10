USE ROLE DATAHUB_ROLE;
USE ADM_SNOWFLAKE;
USE SCHEMA DATAHUB;

CREATE SERVICE datahub_elasticsearchsetup_svc
IN COMPUTE POOL DATAHUB_POOL
FROM SPECIFICATION $$
    spec:
      containers:
      - name: elasticsearchsetup
        image: /manage_db/datahub/datahub_repository/datahub-elasticsearch-setup:head
        env:
            ELASTICSEARCH_USE_SSL: false
            USE_AWS_ELASTICSEARCH: false
            ELASTICSEARCH_HOST: datahub-elasticsearch-svc.mupx.svc.spcs.internal
            ELASTICSEARCH_PORT: 9200
            ELASTICSEARCH_PROTOCOL: http
      $$
      
MIN_INSTANCES=1
MAX_INSTANCES=1;

/*
SELECT SYSTEM$GET_SERVICE_STATUS('datahub_elasticsearchsetup_svc');
CALL SYSTEM$GET_SERVICE_LOGS('datahub_elasticsearchsetup_svc', '0','elasticsearchsetup');
ALTER SERVICE datahub_elasticsearchsetup_svc RESUME;
ALTER SERVICE datahub_elasticsearchsetup_svc SUSPEND;
SHOW SERVICES;
*/