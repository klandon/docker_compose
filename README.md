# docker_compose
Docker Compose Files for Common Docker Hub Containers

General use

create docker networks
docker network create --driver=bridge dockernet

Create docker data container
mkdir -p /opt/docker_data/nginx_conf

copy nginx config
cp nginx/nginx.conf /opt/docker_data/nginx_conf/
