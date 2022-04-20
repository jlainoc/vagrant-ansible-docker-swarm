#!/bin/bash
#¿this file should be executed as sudo?

export LANG=es_ES.UTF-8
export > /var/tmp/export.txt

export DEBIAN_FRONTEND=noninteractive

# automatic switching to mirrors by geo-location by country
# notice this may not be the closest/fastest mirror by ping/transfer
sed -i -e 's/http:\/\/us.archive.ubuntu.com\/ubuntu/mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/g' /etc/apt/sources.list

sudo apt-get update > /dev/null