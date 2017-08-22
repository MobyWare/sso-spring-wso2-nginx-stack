LOCK TABLES `SP_APP` WRITE;
/*!40000 ALTER TABLE `SP_APP` DISABLE KEYS */;
INSERT INTO `SP_APP` /*using specified columns to reduce impact of schema changes. 5.3 adds column ENABLE_AUTHORIZATION.We can accept default).*/
(TENANT_ID, APP_NAME, USER_STORE, USERNAME, DESCRIPTION, ROLE_CLAIM, AUTH_TYPE, PROVISIONING_USERSTORE_DOMAIN, IS_LOCAL_CLAIM_DIALECT, IS_SEND_LOCAL_SUBJECT_ID, IS_SEND_AUTH_LIST_OF_IDPS, IS_USE_TENANT_DOMAIN_SUBJECT, IS_USE_USER_DOMAIN_SUBJECT, SUBJECT_CLAIM_URI, IS_SAAS_APP, IS_DUMB_MODE) VALUES (-1234,'Primary','PRIMARY','admin','Local wso2 acting as SP.','','default','','1','0','0','0','0',NULL,'0','0');
/*!40000 ALTER TABLE `SP_APP` ENABLE KEYS */;
UNLOCK TABLES;

SET @app_id = LAST_INSERT_ID();

LOCK TABLES `SP_INBOUND_AUTH` WRITE;
/*!40000 ALTER TABLE `SP_INBOUND_AUTH` DISABLE KEYS */;
INSERT INTO `SP_INBOUND_AUTH` 
(TENANT_ID, INBOUND_AUTH_KEY, INBOUND_AUTH_TYPE, INBOUND_CONFIG_TYPE, PROP_NAME, PROP_VALUE, APP_ID) VALUES (-1234,'https://localhost:9446/commonauth','samlsso','standardAPP','attrConsumServiceIndex','654496362',@app_id),(-1234,'Primary','passivests','standardAPP',NULL,NULL,@app_id),(-1234,'Primary','openid','standardAPP',NULL,NULL,@app_id);
/*!40000 ALTER TABLE `SP_INBOUND_AUTH` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `SP_CLAIM_MAPPING` WRITE;
/*!40000 ALTER TABLE `SP_CLAIM_MAPPING` DISABLE KEYS */;
INSERT INTO `SP_CLAIM_MAPPING` (TENANT_ID, IDP_CLAIM, SP_CLAIM, APP_ID, IS_REQUESTED, IS_MANDATORY, DEFAULT_VALUE) VALUES (-1234,'http://wso2.org/claims/username','http://wso2.org/claims/username',@app_id,'1','0',NULL),(-1234,'http://wso2.org/claims/role','http://wso2.org/claims/role',@app_id,'1','0',NULL);
/*!40000 ALTER TABLE `SP_CLAIM_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

