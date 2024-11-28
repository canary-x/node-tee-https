FROM node:18-slim

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV SERVER_PORT=8080
ENV SERVER_VSOCK_CID=3

EXPOSE 8000

CMD ["node", "index.js"]
