#!/bin/bash
#
# Script to pull the given ollama model into the local ollama container

CONTAINER_ID=$(docker ps -q --filter ancestor=ollama/ollama)

USAGE="$0 <modelName>"

if [ $# -ne 1 ]; then
    echo "ERROR: must provide exactly one argument"
    echo ${USAGE}
    exit 1
fi

MODEL_NAME=$1

docker exec -it ${CONTAINER_ID} ollama pull ${MODEL_NAME}
