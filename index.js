const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello World!');
});

console.log('Sleeping 3s...');

setTimeout(() => {
  app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
  });
}, 3000);

