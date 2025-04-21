FROM maven:3.8.7-openjdk-17-slim
WORKDIR /java-test-app
COPY pom.xml .
COPY /src ./src
RUN mvn clean package -DskipTests

FROM maven:3.8.7-openjdk-17-slim
WORKDIR /app
COPY --from-builder /java-test-app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
