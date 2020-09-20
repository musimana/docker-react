FROM node:alpine as builder

WORKDIR /var/www/sites/frontend

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx

COPY --from=builder /var/www/sites/frontend/build /usr/share/nginx/html
