FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /java-test-app
COPY pom.xml .
COPY /src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=builder /java-test-app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
