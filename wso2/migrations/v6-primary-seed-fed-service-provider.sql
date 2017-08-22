LOCK TABLES `SP_APP` WRITE;
/*!40000 ALTER TABLE `SP_APP` DISABLE KEYS */;
INSERT INTO `SP_APP` /*using specified columns to reduce impact of schema changes. 5.3 adds column ENABLE_AUTHORIZATION.We can accept default).*/
(TENANT_ID, APP_NAME, USER_STORE, USERNAME, DESCRIPTION, ROLE_CLAIM, AUTH_TYPE, PROVISIONING_USERSTORE_DOMAIN, IS_LOCAL_CLAIM_DIALECT, IS_SEND_LOCAL_SUBJECT_ID, IS_SEND_AUTH_LIST_OF_IDPS, IS_USE_TENANT_DOMAIN_SUBJECT, IS_USE_USER_DOMAIN_SUBJECT, SUBJECT_CLAIM_URI, IS_SAAS_APP, IS_DUMB_MODE) VALUES (-1234,'wso2-test-api-federated','PRIMARY','admin','Client that is federated','','flow','','1','0','0','1','0',NULL,'0','0');
/*!40000 ALTER TABLE `SP_APP` ENABLE KEYS */;
UNLOCK TABLES;

SET @app_id = LAST_INSERT_ID();

LOCK TABLES `SP_INBOUND_AUTH` WRITE;
/*!40000 ALTER TABLE `SP_INBOUND_AUTH` DISABLE KEYS */;
INSERT INTO `SP_INBOUND_AUTH` 
(TENANT_ID, INBOUND_AUTH_KEY, INBOUND_AUTH_TYPE, INBOUND_CONFIG_TYPE, PROP_NAME, PROP_VALUE, APP_ID) VALUES (-1234,'7r3TkShn_GkoAXdtdW0CeVgB69Ya','oauth2','standardAPP',NULL,NULL,@app_id),(-1234,'wso2-test-api-federated','passivests','standardAPP',NULL,NULL,@app_id),(-1234,'wso2-test-api-federated','openid','standardAPP',NULL,NULL,@app_id);
/*!40000 ALTER TABLE `SP_INBOUND_AUTH` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `SP_CLAIM_MAPPING` WRITE;
/*!40000 ALTER TABLE `SP_CLAIM_MAPPING` DISABLE KEYS */;
INSERT INTO `SP_CLAIM_MAPPING` (TENANT_ID, IDP_CLAIM, SP_CLAIM, APP_ID, IS_REQUESTED, IS_MANDATORY, DEFAULT_VALUE) VALUES (-1234,'http://wso2.org/claims/username','http://wso2.org/claims/username',@app_id,'1','0',NULL),(-1234,'http://wso2.org/claims/role','http://wso2.org/claims/role',@app_id,'1','0',NULL);
/*!40000 ALTER TABLE `SP_CLAIM_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `IDN_OAUTH_CONSUMER_APPS` WRITE;
/*!40000 ALTER TABLE `IDN_OAUTH_CONSUMER_APPS` DISABLE KEYS */;
INSERT INTO `IDN_OAUTH_CONSUMER_APPS` (CONSUMER_KEY, CONSUMER_SECRET, USERNAME, TENANT_ID, USER_DOMAIN, APP_NAME, OAUTH_VERSION, CALLBACK_URL, GRANT_TYPES, PKCE_MANDATORY, PKCE_SUPPORT_PLAIN, APP_STATE) VALUES ('7r3TkShn_GkoAXdtdW0CeVgB69Ya','iL7agEgwSy1fZK1Mi8azcHW7LGoa','admin',-1234,'PRIMARY','wso2-test-api-federated','OAuth-2.0','http://localhost:4006/auth/oauth2/callback','refresh_token implicit password client_credentials authorization_code ','0','1','ACTIVE');
/*!40000 ALTER TABLE `IDN_OAUTH_CONSUMER_APPS` ENABLE KEYS */;
UNLOCK TABLES;

/* Added step to allow local and federated. See v7 for more inserts*/
LOCK TABLES `SP_AUTH_STEP` WRITE;
/*!40000 ALTER TABLE `SP_AUTH_STEP` DISABLE KEYS */;
INSERT INTO `SP_AUTH_STEP` (ID, TENANT_ID, STEP_ORDER, APP_ID, IS_SUBJECT_STEP, IS_ATTRIBUTE_STEP) VALUES (5,-1234,1,@app_id,'1','1');
/*!40000 ALTER TABLE `SP_AUTH_STEP` ENABLE KEYS */;
UNLOCK TABLES;