FROM nginx:1.11.1
#RUN apt-get update && apt-get install -y curl
COPY ./*.html /usr/share/nginx/html/ 
COPY nginx.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT nginx -g 'daemon off;'

EXPOSE 8080