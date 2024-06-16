#!/bin/bash
npm install


while true; do
  node send_multigpu_chipi.js --api lite --bin ./pow-miner-opencl-macos --givers 1000 --gpu-count 1
  sleep 1;
done;
