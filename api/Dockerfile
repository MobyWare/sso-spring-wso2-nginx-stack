FROM java:8-jdk-alpine
MAINTAINER UPMC Enterprises

EXPOSE 8080

RUN mkdir -p /app
VOLUME ["/app"]
COPY ./build/libs/com.upmcenterprises.threepl.api-0.0.1.jar /app/com.upmcenterprises.threepl.api-0.0.1.jar
WORKDIR /app
CMD ["java", "-jar", "/app/com.upmcenterprises.threepl.api-0.0.1.jar"]
