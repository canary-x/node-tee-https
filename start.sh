#!/bin/sh

echo Sleeping 3 seconds
sleep 3

echo Starting socat
socat VSOCK-LISTEN:8080,fork TCP:127.0.0.1:3000 &

echo Starting node
/usr/local/bin/node index.js
