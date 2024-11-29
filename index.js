const express = require('express');
const http = require('http');
const vsock = require('node-vsock');

// const port = process.env.SERVER_PORT || 3000;

const app = express();
app.get('/', (req, res) => {
  res.json({ message: 'Hello from VSOCK!' });
});

// Create HTTP server from Express app
const httpServer = http.createServer(app);

// Create VSOCK server
const vsockServer = new vsock.VsockServer();

// Pipe VSOCK connections to HTTP server
vsockServer.on('connection', (socket) => {
  httpServer.emit('connection', socket);
});

vsockServer.listen(3000);
