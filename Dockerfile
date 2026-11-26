
###################
# BUILD STAGE
###################

FROM node:18-alpine AS build

WORKDIR /usr/src/app

# Build NestJS backend
COPY --chown=node:node package*.json ./
COPY --chown=node:node tsconfig.build.json ./
COPY --chown=node:node tsconfig.json ./
COPY --chown=node:node nest-cli.fast.json ./

COPY --chown=node:node config ./config
COPY --chown=node:node keycloak ./keycloak
COPY --chown=node:node src ./src

ENV NPM_CONFIG_LOGLEVEL=error

RUN npm ci --no-audit
RUN npm run build:fast
RUN npm prune --production

# Build React frontend
COPY --chown=node:node client/package*.json ./client/
COPY --chown=node:node client/src ./client/src
COPY --chown=node:node client/public ./client/public
COPY --chown=node:node client/typings ./client/typings
COPY --chown=node:node client/vcs ./client/vcs
COPY --chown=node:node client/tsconfig.json ./client/tsconfig.json
COPY --chown=node:node client/vite.config.ts ./client/vite.config.ts
COPY --chown=node:node client/index.html ./client/index.html

ENV CYPRESS_INSTALL_BINARY=0

RUN npm ci --prefix=client --no-audit
RUN npm run build --prefix=client

###################
# PRODUCTION STAGE
###################

FROM node:18-alpine AS production

WORKDIR /usr/src/app

ENV NODE_ENV=production

# Application configuration is supplied at runtime.
# Never copy .env files into the image.

COPY --chown=node:node config ./config
COPY --chown=node:node keycloak ./keycloak

COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/package*.json ./
COPY --chown=node:node --from=build /usr/src/app/dist ./dist

COPY --chown=node:node --from=build /usr/src/app/client/dist ./client/dist
COPY --chown=node:node --from=build /usr/src/app/client/vcs ./client/vcs

# Run application as non-root user
USER node

EXPOSE 3000

CMD ["npm", "run", "start:prod"]