#!/bin/bash
#
# Script to list the ollama models currently loaded in the local Ollama container

CONTAINER_ID=$(docker ps -q --filter ancestor=ollama/ollama)

docker exec -it ${CONTAINER_ID} ollama list
