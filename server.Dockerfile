# Build stage
FROM openjdk:21 AS build

WORKDIR /app
COPY . .

# Make the gradle wrapper executable 
RUN chmod +x ./gradlew

RUN ./gradlew server:dist

# Runtime stage
FROM openjdk:21-slim

WORKDIR /app
# Copy from build stage
COPY --from=build /app/server/build/libs/server-release.jar .

EXPOSE 6567/tcp
EXPOSE 6567/udp

ENTRYPOINT ["java", "-jar", "server-release.jar"]