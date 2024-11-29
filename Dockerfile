# Builder stage
FROM node:18-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Runner stage
FROM node:18-alpine

RUN apk add --no-cache socat

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .
COPY start.sh /start.sh

ENV SERVER_PORT=3000

EXPOSE 8080

CMD ["/start.sh"]
