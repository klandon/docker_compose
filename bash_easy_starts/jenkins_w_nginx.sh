#!/usr/bin/env bash

echo "#################### Starting Jenkins with Nginx Reverse Proxy #################### "

jenkinsDir="/opt/docker_data/jenkins"
nginxDir="/opt/docker_data/nginx_conf"
nginxConf="/opt/docker_data/nginx_conf/nginx.conf"
nginxJenkinsLoc="/opt/docker_data/nginx_conf/locations"


echo "#################### Jenkins Data Dir Setup ####################"
if [ -d "$jenkinsDir" ]; then
  echo "Jenkins Dir $jenkinsDir already exist"
else
  echo "Creating Jenkins Dir $jenkinsDir"
  mkdir -p $jenkinsDir
  echo "Changing Perms using 777 as default"
  chmod 777 $jenkinsDir
fi


echo "#################### Nginx Config Dir Setup ####################"
if [ -d "$nginxDir" ]; then
  echo "Nginx Dir $nginxDir already exist"
else
  echo "Creating Nginx Dir $nginxDir"
  mkdir -p $nginxDir
  echo "Creating Nginx Locations Dir $nginxJenkinsLoc"
  mkdir -p $nginxJenkinsLoc
  echo "Changing Perms using 777 as default"
  chmod -R 777 $nginxDir
fi

echo "#################### Moving Nginx Config Files ####################"
if [ -d "$nginxDir" ]; then

  echo "Moving Main Config File $nginxConf"
  if [ -f "$nginxConf" ]; then
      echo "A nginx Config already exists please delete it before using this script , assuming ignore"
  else
      cp ../jenkins_nginx/nginx.conf $nginxConf
  fi

  echo "Moving Jenkins Location File $nginxJenkinsLoc/jenkins.location"
  if [ -f "$nginxJenkinsLoc/jenkins.location" ]; then
      echo "A Jenkins Location Config already exists please delete it before using this script , assuming ignore"
  else
      cp ../jenkins_nginx/jenkins.location $nginxJenkinsLoc/jenkins.location
  fi

else
  echo "Nginx Dir $nginxDir doesnt exist"
fi



echo "#################### Running Docker Compose ####################"
docker-compose -f ../jenkins_nginx/jenkins_nginx.yaml up -d
