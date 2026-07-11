FROM node:20 AS builder

WORKDIR /app

ENV VITE_CLASS_ID=107125

COPY package*.json ./

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN chown -R appuser:appgroup \
    /usr/share/nginx/html \
    /var/cache/nginx \
    /var/run \
    /var/log/nginx

USER appuser

RUN npm install

COPY . . 

RUN npm run build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
