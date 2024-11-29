#!/bin/sh

socat VSOCK-LISTEN:8080,fork TCP:127.0.0.1:3000 &

/usr/local/bin/node index.js
