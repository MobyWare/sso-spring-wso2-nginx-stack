echo "Starting process to get new JKS with different CN and SAN as existing JKS"
echo "Clearing output"
rm  ./output/*
echo "1) Get new keystore in P12 by converting existng JKS"
keytool -importkeystore -srckeystore ../wso2.jks -destkeystore ./output/wso2.p12 -deststoretype PKCS12
echo "2) Get private key from new P12 keystore"
openssl pkcs12 -in ./output/wso2.p12  -nodes -nocerts -out ./output/wso2-key.pem
echo "3) Remove password from private key by copying and regenerating"
cp ./output/wso2-key.pem ./output/wso2-key-temp.pem
openssl rsa -in ./output/wso2-key-temp.pem -out ./output/wso2-key.pem
echo "4) Get public key from new P12 keystore"
openssl pkcs12 -in ./output/wso2.p12 -clcerts -nokeys -out ./output/wso2.pem
echo "5) Generate CSR based previous private & public key but with CN and alternates from CNF file"
openssl req -new -key ./output/wso2-key.pem -out ./output/wso2.csr -subj "/CN=localhost" -config wso2-openssl-idp.cnf
echo "6) Generate new self-signed cert from CSR (with the new CN and SAN but same keys)"
openssl x509 -req -in ./output/wso2.csr -CA ./output/wso2.pem -CAkey ./output/wso2-key.pem -CAcreateserial -out ./output/wso2-new.pem -days 3650 -extensions v3_req -extfile wso2-openssl-idp.cnf
echo "7) Import private key and new public key into new keystore in P12 format"
openssl pkcs12 -export -name wso2carbon -in ./output/wso2.pem -inkey ./output/wso2-key.pem -out ./output/wso2-new.p12
echo "8) Generate the desired new JKS file (from old one) by converting new p12 file to JKS format"
keytool -importkeystore -destkeystore ./output/wso2-new.jks -srckeystore ./output/wso2-new.p12 -srcstoretype pkcs12 -alias wso2carbon
