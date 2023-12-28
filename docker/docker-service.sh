#!/bin/sh

# You might name this script "docker-service" and place it in "$HOME/bin".
#
# This script should be called with a single argument: the name of the WSL
# distribution with dockerd. To find a list of WSL distros, launch Powershell then
#
# wsl -l -q
#
# A usage example:
#
# $HOME/bin/docker-service Ubuntu
#
# If no distribution is specified, the default one will be used.
# This script can also be sourced from your shell initialization script, such
# as .bashrc or .profile, with something like (assuming distro is "Ubuntu":
#
# . $HOME/bin/docker-service Ubuntu
#
# Or called from Windows with
#
# wsl -d Ubuntu ~/bin/docker-service Ubuntu

[ -z "$1" ] && DOCKER_DISTRO="$WSL_DISTRO_NAME" || DOCKER_DISTRO="$1"
# If embedding this in .bashrc, .profile, .zshenv, or the like, remove the above line
# and set $DOCKER_DISTRO to an empty string or something like this:
# DOCKER_DISTRO="-d Ubuntu"
DOCKER_DIR=/mnt/wsl/shared-docker
DOCKER_SOCK="$DOCKER_DIR/docker.sock"
export DOCKER_HOST="unix://$DOCKER_SOCK"
if [ ! -S "$DOCKER_SOCK" ]; then
    mkdir -pm o=,ug=rwx "$DOCKER_DIR"
    chgrp docker "$DOCKER_DIR"
    /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
fi