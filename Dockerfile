FROM node:18-alpine

WORKDIR /home/node

COPY ./scripts ./app/scripts
COPY ./src ./app/src
COPY ./node_modules ./app/node_modules
COPY ./dist ./app/dist
COPY package*.json ./app

USER node

EXPOSE 3000 3000
EXPOSE 3001 3001
EXPOSE 3002 3002

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl --fail http://localhost:3000 || exit 1

WORKDIR /app

CMD ["node", "scripts/start.js"]