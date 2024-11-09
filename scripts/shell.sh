#!/bin/bash

cd `dirname $0`

CONTAINER_NAME="kyopro-env"
CURRENT_ID=$(docker ps -a --format "{{.Image}}" -f name=$CONTAINER_NAME)
CURRENT_RUNNING_ID=$(docker ps --format "{{.Image}}" -f name=$CONTAINER_NAME)
if [ $CURRENT_ID = $CONTAINER_NAME ]; then
  RUNNING=true
else
  RUNNING=false
fi

if [ -z $(docker images -q $CONTAINER_NAME) ]; then
  echo "$CONTAINER_NAME image does not exist; build..."
  ./build.sh
fi

if [ -n $CURRENT_ID ]; then
  echo "$CONTAINER_NAME container exists"
  if [ $CURRENT_ID = $CONTAINER_NAME ]; then
    echo "$CONTAINER_NAME container is latest"
    if [ ! $RUNNING ]; then
      echo "$CONTAINER_NAME container is not running; start..."
      docker start $CONTAINER_NAME
    fi
  else
    echo "$CONTAINER_NAME container is outdated; remove and recreate..."
    if [ $RUNNING ]; then
      echo "$CONTAINER_NAME container is running; stop..."
      docker stop $CONTAINER_NAME
    fi
    docker rm $CONTAINER_NAME
    docker run -id --name $CONTAINER_NAME \
      -v $(dirname `pwd`)/secrets/oj-tools:/root/.local/share/online-judge-tools \
      -v $(dirname `pwd`)/secrets/copilot:/root/.config/github-copilot \
      -v $(dirname `pwd`)/secrets/ssh:/root/.ssh \
      $CONTAINER_NAME /bin/bash

    docker exec $CONTAINER_NAME /bin/bash -c "git config --global user.email '$(cat $(dirname `pwd`)/secrets/git/email)'"
    docker exec $CONTAINER_NAME /bin/bash -c "git config --global user.name '$(cat $(dirname `pwd`)/secrets/git/name)'"
  fi
else
  echo "$CONTAINER_NAME container does not exist; create..."
  docker run -id --name $CONTAINER_NAME $CONTAINER_NAME /bin/bash
fi
echo "$CONTAINER_NAME container is ready"
docker exec -it $CONTAINER_NAME /bin/bash -c "cd /kyopro/include/atcoder-library && git remote set-url origin git@github.com:ZOI-dayo/atcoder-library.git"
docker exec -it $CONTAINER_NAME /bin/bash

