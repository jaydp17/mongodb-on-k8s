FROM node:8.9.0-alpine
WORKDIR /app
COPY package.json yarn.lock /app/
RUN yarn --prod && \
  yarn cache clean
COPY src /app/src
CMD node src/index.js
