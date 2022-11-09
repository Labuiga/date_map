#!/bin/bash

# python venv
pydir="/p3/"
if [ ! -d "$pydir" ]; then
  echo "Installing p3 venv"
  virtualenv -p python3 p3
fi
. p3/bin/activate && pip install -r requirements.txt

# file db
mkdir -p "db/files"

# docker
dv=$(docker --version)
if grep -q "Docker version" <<< "$dv"; then
  echo "$dv" allready installed
else
  echo "Installing docker now..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  ./get-docker.sh
fi

# dockerized mongo
mkdir -p "db/mongo_files"
dps=$(docker ps)
if grep -q "date_map_mongo" <<< "$dps"; then
  echo "$dps"
else
  echo "Installing mongo now..."
  docker pull mongo
  docker run -it -v db/mongo_files/data/db --name date_map_mongo -d mongo
fi
