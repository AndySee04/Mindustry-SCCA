FROM openjdk:21

WORKDIR /app

COPY server/build/libs/server-release.jar .

EXPOSE 6567
EXPOSE 6567/udp