ARG NODE_VERSION=19.3.0
FROM node:${NODE_VERSION}-bullseye-slim

WORKDIR /usr/src/app
COPY --chown=node:node . .

RUN apt-get update \
  && apt-get install -y --no-install-recommends dumb-init \
  && npm ci --only=production

ARG PORT=3000

ENV PORT $PORT

EXPOSE $PORT

USER node

CMD ["dumb-init", "node", "index.mjs"]
