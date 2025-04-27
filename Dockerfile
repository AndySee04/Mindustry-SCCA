FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies (keep the same install step as before)
RUN apt-get update && apt-get install -y \
    git \
    openjdk-21-jdk \
    libx11-6 libxext6 libxrender1 libxtst6 libxi6 libasound2 \
    libsdl2-2.0-0 libsdl2-image-2.0-0 libsdl2-mixer-2.0-0 libsdl2-net-2.0-0 libsdl2-ttf-2.0-0 \
    libwayland-client0 libwayland-cursor0 libwayland-egl1 \
    libxcomposite1 libxdamage1 libxfixes3 libxkbcommon0 \
    mesa-va-drivers mesa-vdpau-drivers mesa-utils \
    dos2unix \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends x11-apps && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

# Convert gradlew line endings from CRLF (Windows) to LF (Unix)
RUN dos2unix ./gradlew

# Make the Gradle wrapper executable
RUN chmod +x ./gradlew

RUN ./gradlew desktop:dist

# --- Added Entrypoint Script ---
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/entrypoint.sh"]

# The CMD now provides default arguments to the entrypoint script (the java command)
# CMD is not strictly necessary if the script hardcodes the command, but good practice
# if you might want to override it. However, since the script exec's the java command,
# the script itself is the ENTRYPOINT. We can actually remove the old CMD.