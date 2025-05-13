# Stage 1: Build and test using Maven
FROM maven:3.8.8-eclipse-temurin-17 as builder

# Set working directory
WORKDIR /usr/src/app

# Copy the source code
COPY . .

# Install dependencies and run tests
# Tests assume Chrome is available (installed below)
RUN apt-get update && \
    apt-get install -y wget unzip curl gnupg && \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    mvn clean verify

# Stage 2: Optional runtime container (for compiled app or test reports)
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy test reports or compiled artifacts if needed
COPY --from=builder /usr/src/app/target /app/target

# Default command (e.g., to view test reports or run app if applicable)
CMD ["ls", "-l", "/app/target"]
