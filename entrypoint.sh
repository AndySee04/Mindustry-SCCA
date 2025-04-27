#!/bin/bash

# Set permissions/ownership for the HOME directory inside the container.
# This is crucial because the volume might be created/owned by root on the host.
# We use id -u and id -g to get the numerical user and group IDs of the user
# the container is started with via the -u flag.
# The script runs as root initially, allowing chown to succeed.
chown -R $(id -u):$(id -g) "$HOME"

# Create the necessary directories if they don't exist
mkdir -p "$HOME"/.local/share/Mindustry/crashes

# Execute the original application command, replacing the script process.
# The exec command will run the java command as the user specified by the -u flag.
exec java -jar desktop/build/libs/Mindustry.jar "$@"