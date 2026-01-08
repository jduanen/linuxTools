#!/bin/bash
#
# This script issues a query to the desired local LLM model running on the DGX spark
#
# Usage: ./localLLM.sh <query> {"stream"}

#### TODO think about output to a file as an option
#### TODO parse the response JSON from CURL and assemble the full response message

SERVER="spark-8d0d.lan"
MODEL="llama3.1:8b"
STREAM=false

if [ $# -eq 0 ] || [ $# -gt 2 ]; then
  echo "Usage: ./localLLM.sh <query> {"stream"}"
  exit 1
fi

CONTENT=$1

STREAM="false"
if [ $# -eq 2 ]; then
  if [ $2 == "stream" ]; then
    STREAM="true"
  else
    echo "Usage: ./localLLM.sh <query> {"stream"}"
    exit 1
  fi
fi

curl "http://${SERVER}:11434/api/chat" -d "{\"model\": \"${MODEL}\", \"messages\": [{\"role\": \"user\", \"content\": \"$CONTENT\"}],
  \"stream\": ${STREAM}}"

