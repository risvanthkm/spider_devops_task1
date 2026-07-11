FROM node:20 AS builder

WORKDIR /app

ENV VITE_CLASS_ID=107125

COPY package*.json ./

RUN groupadd -r appgroup && \
    useradd -r -g appgroup appuser && \
    chown -R appuser:appgroup /app

USER appuser

RUN npm install

COPY --chown=appuser:appgroup . .

RUN npm run build

FROM nginx:alpine

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

RUN chown -R appuser:appgroup \
    /usr/share/nginx/html \
    /var/cache/nginx \
    /var/run \
    /var/log/nginx

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/dist /usr/share/nginx/html

USER appuser

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
