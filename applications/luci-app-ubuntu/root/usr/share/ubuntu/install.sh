#!/bin/sh

image_name=`uci get ubuntu.@ubuntu[0].image 2>/dev/null`

[ -z "$image_name" ] && image_name="linkease/desktop-ubuntu-arm64:develop"

install(){
    local password=`uci get ubuntu.@ubuntu[0].password 2>/dev/null`
    local port=`uci get ubuntu.@ubuntu[0].port 2>/dev/null`
    [ -z "$password" ] && password="password"
    [ -z "$port" ] && port=6901

    DOCKERPATH=`uci get dockerman.local.daemon_data_root`
    if findmnt -T ${DOCKERPATH} | grep -q /dev/sd ; 
    then
        docker network ls -f "name=docker-pcnet" | grep -q docker-pcnet || \
        docker network create -d bridge --subnet=10.10.100.0/24 --ip-range=10.10.100.0/24 --gateway=10.10.100.1 docker-pcnet
        
        docker run -d --name ubuntu \
        --dns=223.5.5.5 -u=0:0 \
        -v=/mnt:/mnt:rslave \
        --net="docker-pcnet" \
        --ip=10.10.100.9 \
        --shm-size=512m \
        -p $port:6901 \
        -e VNC_PW=$password \
        -e VNC_USE_HTTP=0 \
        --restart unless-stopped \
        $image_name
    else
        echo "docker not in disk"
    fi                         
}


while getopts ":il" optname
do
    case "$optname" in
        "l")
        echo -n $image_name
        ;;
        "i")
        install
        ;;
        ":")
        echo "No argument value for option $OPTARG"
        ;;
        "?")
        echo "未知选项 $OPTARG"
        ;;
        *)
       echo "Unknown error while processing options"
        ;;
    esac
done