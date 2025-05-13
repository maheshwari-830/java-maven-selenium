# Use Maven image to build the project
FROM maven:3.8.8-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Build the application (you can change `clean install` to another Maven goal)
RUN mvn clean install

# -------------------------------------------------------------------
# Optional: Run tests in Docker (with headless browser support)
# -------------------------------------------------------------------
# You can extend this step to install browsers like Chromium if needed
# For example, for headless Chrome testing

# FROM selenium/standalone-chrome as tester (if using selenium container)

# Or continue with this image for simple Java-based tests

# Final image to run your app or tests (if needed)
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy compiled code from the builder
COPY --from=builder /app/target /app/target

# Copy test reports if needed
# COPY --from=builder /app/target/surefire-reports /app/reports

# Set the default command to run tests or your app
CMD ["java", "-jar", "/app/target/your-app-name.jar"]
