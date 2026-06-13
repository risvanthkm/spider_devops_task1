FROM node:20 AS builder

WORKDIR /app

ENV VITE_CLASS_ID=107125

COPY package*.json ./

RUN npm install

COPY . . 

RUN npm run build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
