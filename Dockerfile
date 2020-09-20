FROM node:alpine as builder

WORKDIR /var/www/sites/docker-react

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx

COPY --from=builder /var/www/sites/docker-react/build /usr/share/nginx/html
