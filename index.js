const express = require('express');
const http = require('http');

const AF_VSOCK = 40;
const PORT = parseInt(process.env.SERVER_PORT) || 8000;
const CID = parseInt(process.env.SERVER_VSOCK_CID) || 3;

const app = express();
const server = http.createServer(app);

// Basic health check
app.get('/health', (req, res) => {
  res.status(200).send('healthy');
});

// Error handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

// Graceful shutdown
process.on('SIGTERM', () => {
  server.close(() => {
    console.log('Server shutting down');
    process.exit(0);
  });
});

// Override listen method for VSock
const originalListen = server.listen.bind(server);
server.listen = () => {
  return originalListen({
    host: '0.0.0.0',
    port: PORT,
    addressType: AF_VSOCK,
    cid: CID
  });
};

server.listen();
console.log(`Server running on VSock CID ${CID}, port ${PORT}`);
