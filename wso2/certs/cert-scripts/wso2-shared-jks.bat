keytool -importkeystore -srckeystore ..\wso2.jks -destkeystore wso2.p12 -deststoretype PKCS12
REM openssl pkcs12 -in wso2.p12  -nodes -nocerts -out wso2_key.pem
