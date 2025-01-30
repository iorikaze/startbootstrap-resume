FROM node:18-alpine

WORKDIR /home/node

COPY --chown=node --chmod=500 ./scripts ./app/scripts
COPY --chown=node --chmod=500 ./src ./app/src
COPY --chown=node --chmod=500 ./node_modules ./app/node_modules
COPY --chown=node --chmod=700 ./dist ./app/dist
COPY --chown=node --chmod=400 package*.json ./app

USER node

EXPOSE 3000 3000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl --fail http://localhost:3000 || exit 1

WORKDIR app

ENTRYPOINT ["node", "scripts/start.js"]