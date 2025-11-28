# Use a supported Java 8 JRE image
FROM eclipse-temurin:8-jre

# Set working directory
WORKDIR /app

# Copy the built JAR
COPY target/*.jar app.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8083

# Run the application
CMD ["java", "-jar", "app.jar"]
