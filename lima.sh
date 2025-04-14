#!/usr/bin/env bash

echo -e "[ ${BLUE}$(date)${RESET_COLOR} ] ( ${GREEN}Lima${RESET_COLOR} ) ${B_PURPLE}-${RESET_COLOR} copy lima configurations"
cp -rf $SOURCE/lima/_config $HOME/.lima/

echo -e "[ ${BLUE}$(date)${RESET_COLOR} ] ( ${GREEN}Lima${RESET_COLOR} ) ${B_PURPLE}-${RESET_COLOR} configure lima sudoers"
export LIMA_HOME="$HOME/.lima"
limactl sudoers > /tmp/etc_sudoers.d_lima
sudo install -o root /tmp/etc_sudoers.d_lima "/private/etc/sudoers.d/lima"

echo -e "[ ${BLUE}$(date)${RESET_COLOR} ] ( ${GREEN}Lima${RESET_COLOR} ) ${B_PURPLE}-${RESET_COLOR} copy lima templates"
cp -rf $SOURCE/lima/_templates $HOME/.lima/

echo -e "[ ${BLUE}$(date)${RESET_COLOR} ] ( ${GREEN}Lima${RESET_COLOR} ) ${B_PURPLE}-${RESET_COLOR} create lima docker vm"
if [[ ! $(limactl list docker --json 2> /dev/null | jq -r .name) == "docker" ]]; then
    limactl create --name=docker --tty=false $HOME/.lima/_template/docker.yaml
    limactl start docker
    docker context create docker-lima --docker "host=unix:///Users/tdesaules/.lima/docker/sock/docker.sock"
    docker context use docker-lima
fi
