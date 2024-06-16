#!/bin/bash

DEFAULT_GIVERS=1000
TIMEOUT=4
API="tonapi"

if [ "$2" = "" ]; then
    GIVERS=1000
else
    GIVERS=$2
fi

GPU_COUNT=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l) > /dev/null 2>&1

if [ "$GPU_COUNT" = "0" ] || [ "$GPU_COUNT" = "" ]; then
    echo "Cant get GPU count. Aborting."
    exit 1
fi

echo "Detected ${GPU_COUNT} GPUs"

if [ "$1" = "gram" ]; then
    echo "Starting GRAM miner"
    CMD="node send_multigpu.js --api ${API} --bin ./pow-miner-cuda --givers ${GIVERS} --gpu-count ${GPU_COUNT} --timeout ${TIMEOUT}"
elif [ "$1" = "mrdn" ]; then
    echo "Starting Meridian miner"
    CMD="node send_multigpu_meridian.js --api ${API} --bin ./pow-miner-cuda --givers ${GIVERS} --gpu-count ${GPU_COUNT} --timeout ${TIMEOUT}"
elif [ "$1" = "chipi" ]; then
    echo "Starting Chipi miner"
    CMD="node send_multigpu_chipi.js --api ${API} --bin ./pow-miner-cuda --givers ${GIVERS} --gpu-count ${GPU_COUNT} --timeout ${TIMEOUT}"
else
    echo -e "Invalid argument. Use ${GREEN}./mine.sh mrdn/gram/chipi${NC} to start miner."
    exit 1
fi

npm install

while true; do
    $CMD
    sleep 1;
done;
