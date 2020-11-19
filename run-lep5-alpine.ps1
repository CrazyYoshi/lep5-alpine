docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker build $PSScriptRoot -t crazyyoshi/lep5-alpine:latest
docker run -d -p 80:80 crazyyoshi/lep5-alpine:latest