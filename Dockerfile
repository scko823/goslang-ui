FROM node:6.10-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app

COPY .babelrc .postcssrc.js index.html /usr/src/app/

RUN mkdir -p /usr/src/app/src
COPY src/ /usr/src/app/src/

RUN mkdir -p /usr/src/app/config
COPY config/ /usr/src/app/config/

RUN mkdir -p /usr/src/app/build
COPY build/ /usr/src/app/build/

RUN npm install

RUN npm run build

RUN npm prune --production
