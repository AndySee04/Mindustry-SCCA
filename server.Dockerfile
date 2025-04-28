# Build stage
FROM ubuntu:22.04

WORKDIR /app
COPY . .

# Install dependencies and clean up apt lists
RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    dos2unix \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Convert gradlew line endings from CRLF to LF and make executable
RUN dos2unix ./gradlew && \
    chmod +x ./gradlew

# Build the server
RUN ./gradlew server:dist

# --- Runtime stage ---
# Use a smaller base image for the final container
FROM openjdk:21-slim

WORKDIR /app

# Copy only the built artifact and necessary files from the build stage
COPY --from=0 /app/server/build/libs/server-release.jar .

EXPOSE 6567/tcp
EXPOSE 6567/udp

ENTRYPOINT ["java", "-jar", "server-release.jar"]