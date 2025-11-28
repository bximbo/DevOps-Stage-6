FROM openjdk:8-jre-alpine

WORKDIR /app

COPY target/users-api-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8083

CMD ["java", "-jar", "app.jar"]