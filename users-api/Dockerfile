FROM eclipse-temurin:11-jre

WORKDIR /app

COPY target/*.jar app.jar

ENTRYPOINT ["java", "--add-opens", "java.base/java.lang=ALL-UNNAMED", "-jar", "app.jar"]