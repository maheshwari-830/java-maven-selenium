# Stage 1: Build stage
FROM maven:3.9.5-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime stage
FROM eclipse-temurin:17-jdk

WORKDIR /app
COPY --from=build /app/target/java-maven-selenium-*.jar app.jar

CMD ["java", "-jar", "app.jar"]
