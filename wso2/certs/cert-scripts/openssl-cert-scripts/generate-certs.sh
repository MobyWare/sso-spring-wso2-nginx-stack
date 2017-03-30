#!/usr/bin/env bash

my_hostname=`hostname -f`

#
# First, lets verify if we already have CA files created.
#
if [ ! -d ./output/CA ]; then
    #
    # Lets create an unencrypted CA Private Key and CRT
    #
    /bin/mkdir -p ./output/CA

    #CA Private Key
    /usr/bin/openssl genpkey \
        -algorithm RSA \
            -pkeyopt rsa_keygen_bits:4096 \
        -outform PEM \
            -out ./output/CA/CA-Server-PrivateKey.key

    #You can either use the following way or follow the below two ways for a more broken down version.
#    #CA Signing Certificate. (QUICK WAY!!!) (This Is A Self Signed Certificate.)
#    /usr/bin/openssl req \
#        -new \
#            -sha256 \
#            -subj '/CN=UPMCE-CA' \
#        -key ./output/CA/CA-Server-PrivateKey.key \
#        -x509 \
#            -days 3650 \
#        -out ./output/CA/CA-Server-Certificate.crt

    #Lets make a intermediate CSR.
    /usr/bin/openssl req \
        -new \
            -sha256 \
            -subj "/CN=UPMCE-CA" \
            -reqexts v3_req \
        -config ./openssl.cnf \
        -key ./output/CA/CA-Server-PrivateKey.key \
        -out ./output/CA/CA-Server-CertRequest.csr

    #CA Signing Certificate. (This Is A Self Signed Certificate.)
    /usr/bin/openssl x509 \
        -req \
            -in ./output/CA/CA-Server-CertRequest.csr \
            -days 1095 \
        -extensions v3_req \
            -extfile ./openssl.cnf \
        -signkey ./output/CA/CA-Server-PrivateKey.key \
        -out ./output/CA/CA-Server-Certificate.crt
fi


#Lets always generate a new client certificate.
if [ -d ./output/Client ]; then
    /bin/rm -rf ./output/Client/*
else
    /bin/mkdir -p ./output/Client
fi

#Next Make Client Private Key.
/usr/bin/openssl genpkey \
    -algorithm RSA \
        -pkeyopt rsa_keygen_bits:4096 \
    -outform PEM \
        -out ./output/Client/Client-PrivateKey.key

#Now for the client, we need to create a CSR that can be signed by the CA.
/usr/bin/openssl req \
    -new \
        -sha256 \
        -subj "/C=US/ST=PA/L=Pittsburgh/O=UPMC/OU=UPMC Enterprises/CN=${my_hostname}" \
        -reqexts v3_req \
    -config ./openssl.cnf \
    -key ./output/Client/Client-PrivateKey.key \
    -out ./output/Client/Client-CertRequest.csr

#Using the CA, lets sign the Client's CSR. (This Is Not A Self Signed Certificate.)
/usr/bin/openssl x509 \
    -req \
        -in ./output/Client/Client-CertRequest.csr \
        -days 1095 \
    -extensions v3_req \
        -extfile ./openssl.cnf \
    -CA ./output/CA/CA-Server-Certificate.crt \
        -CAkey ./output/CA/CA-Server-PrivateKey.key \
        -CAcreateserial \
    -out ./output/Client/Client-Signed-Certificate.crt

#Move the Serial file
/bin/mv ./.srl ./output/CA/CA-Server-Certificate.srl

# Concat the clients private key and signed certificate together
/bin/cat ./output/Client/Client-PrivateKey.key \
    ./output/Client/Client-Signed-Certificate.crt \
    > ./output/Client/Client-Combined-KeyFile.pem

######
#Note#
######

# For Some Reason, MySQL does not like the newer style OpenSSL keys that are
# generated with a private key as well as an OID that identifies the key type.
# In the case of MySQL, the fix would be to rewrite the private key to enforce
# older style RSA type.
#
#For more info on this issue search for "openssl begin rsa private key vs begin private key"
#openssl rsa -in ./output/Client/Client-PrivateKey.key -out ./output/client-key.pem

######
#Note#
######
