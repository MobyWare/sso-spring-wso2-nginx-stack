# Overview
In this repo, I experiment with creating a stack on a single machine that illustrates a pattern of securing a web-api and static-website using WSO2. The static website will be protected by an nginx proxy. The api will use spring security.

# OAuth Security with WSO2 Identity Server

[https://docs.wso2.com/display/IS510/WSO2+Identity+Server+Documentation](https://docs.wso2.com/display/IS510/WSO2+Identity+Server+Documentation)

Internal Docs: [https://confluence.upmc.com/display/WSO2/WSO2-IS](https://confluence.upmc.com/display/WSO2/WSO2-IS)

## Images

https://hub.docker.com/r/upmcenterprises/wso2-is/

## Getting Started

```bash
$ docker-compose up
```

The Carbon admin UI is served at [https://localhost:9443/carbon](https://localhost:9443/carbon).

## Certs

Certs are required to handle encryption in the container (e.g. TLS connections).  

### Generate Certs

In general you do:

> $ keytool -genkey -alias `descriptive-alias` -keyalg RSA -keysize 2048 -keystore `key-store-output-filename` -dname "CN=`hostname`,OU=`<department-name`,O=`organization-name`,L=`city`,S=`state`,C=`country`" -storepass `password` -keypass `password`

We need to update the SSL cert (and optionally the trust store):
* __*SSL*__ - used for SSL and to encrypt passwords

> keytool -genkey -alias `wso2-vincent` -keyalg RSA -keysize 2048 -keystore wso2.jks -dname "CN=localhost,OU=3PL,O=UPMC Enterprises,L=Pittsburgh,S=PA,C=US" -storepass changeit -keypass changeit

_NB: The image looks for a key-store named `wso2.jks`with the alias `wso2-vincent`._

#### Kubernetes - Move certificates to cluster
We run the command below to move the new file `wso2.jks` to the cluster in a secret, we name `wso2-certs`. We refere it in the deployment file. 

> kubectl create secret generic wso2-certs --from-file=./certs/wso2.jks --from-file=./certs/wso2carbon.jks

_NB: We add wso2carbon.jks. In 5.3.1 of the image it seems to be needed. This may bet fixed in future versions of image._

#### Update trusted certs (trust store)
See the [README.md](https://git.tdc.upmc.edu/upmc-enterprises/wso2-is#certificates) for [upmc-enterprises/wso2-is](https://git.tdc.upmc.edu/upmc-enterprises/wso2-is) repo.
## Database
We use MySQL RDS in AWS and MySQL 5.7 image locally to persist WSO2's data.

### Migrations
TBD: Will write instructions for any seed users or other configuration differences

Ref: [https://confluence.upmc.com/display/WSO2/Certs](https://confluence.upmc.com/display/WSO2/Certs)

## Dynamic Configuration

Configuration is not meant to be hard coded into the container, rather, data should be volumed in via `Volumes`. Currently the `migrations` folder as well as the `certs` should be volumed in.  

Certs Path in Container: /opt/wso2/repository/resources/security
Migrations Path in Container: /opt/flyway/sql/

#### Kubernetes Migrations
Use the command below to move the migrations from git to K8S in AWS. We then reference the config map name, `wso2-migrations`, in the deployment file.

> kubectl create configmap wso2-migrations --from-file=./migrations
