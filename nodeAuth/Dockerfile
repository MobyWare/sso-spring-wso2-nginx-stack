FROM node:4.6

RUN mkdir -p /usr/nodeAuth
WORKDIR /usr/nodeAuth

COPY ./app /usr/nodeAuth/app
COPY ./typings /usr/nodeAuth/typings
COPY ./package.json /usr/nodeAuth/package.json
COPY ./jsconfig.json /usr/nodeAuth/jsconfig.json

RUN npm install

ENV WSO2_NODE_CLIENT_PORT=4006
EXPOSE 4006
CMD [ "node", "/usr/nodeAuth/app/app.js" ]