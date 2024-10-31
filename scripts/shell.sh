#!/bin/bash

cd `dirname $0`

# すでにコンテナが立っている場合、execする

if [ -n "$(docker ps -q -f name=kyopro-env)" ]; then
  docker exec -it kyopro-env /bin/bash
  exit
fi

# もし、dockerイメージが存在しない場合は、ビルドする

if [ -z "$(docker images -q kyopro-env)" ]; then
  ./build.sh
fi

# コンテナを立て、bashを起動する

docker run -id --name kyopro-env kyopro-env /bin/bash
docker exec -it kyopro-env /bin/bash

