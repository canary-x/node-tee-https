#!/bin/sh

echo Sleeping 3 seconds
sleep 3

echo Starting socat
socat VSOCK-LISTEN:8000,fork TCP:0.0.0.0:3000 &

echo Starting node
/usr/local/bin/node index.js
