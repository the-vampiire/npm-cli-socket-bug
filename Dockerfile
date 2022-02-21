FROM node:17-alpine as prod-dependencies

COPY package*.json ./

RUN npm install --only=production

# all (prod and dev dependencies)
# copies prod deps and installs dev deps
FROM node:17-alpine as all-dependencies

COPY --from=prod-dependencies ./ ./

RUN npm install

# build stage
FROM node:17-alpine as compile

WORKDIR /compile

COPY --from=all-dependencies ./ ./