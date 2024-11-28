# Builder stage
FROM node:18-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Runner stage
FROM node:18-alpine
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

ENV SERVER_PORT=8080 \
    SERVER_VSOCK_CID=3

EXPOSE 8080

CMD ["node", "index.js"]