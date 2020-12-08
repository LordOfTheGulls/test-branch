# Stage 1 - build
FROM node:14.13.0-slim AS build

WORKDIR /site-source

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2 - host
FROM nginx

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /site-source/dist /usr/share/nginx/html/ui
