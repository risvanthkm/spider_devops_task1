# Documentation

## Deployment Setup Approach

The frontend is built using a multi-stage Docker build. Static assets are served through Nginx. Nginx also acts as a reverse proxy for backend API requests.

The backend is containerized using a Go runtime image and communicates with PostgreSQL using environment variables supplied through Docker Compose.

PostgreSQL is deployed as a separate container with persistent storage provided through Docker volumes.

All these containers are linked by a same Docker Network

---

## Challenges Faced

During deployment, the machine already had a local PostgreSQL instance running on port 5432. As a result, Docker was unable to bind the PostgreSQL container to the same host port and produced a port allocation conflict.

To avoid this issue, the PostgreSQL container continued to listen on its default internal port:

`5432`

while being mapped to host port:

`5433`

---

Initially the backend could not connect to PostgreSQL because the connection string used:

`localhost:5432`

Inside containers, localhost refers to the container itself rather than another service.

The issue was resolved by using the Docker Compose service name:

`postgres://postgres:postgres@db:5432/cr45_reduced?sslmode=disable`

where db is the PostgreSQL service hostname

---

## Building and Running the Application
> Recommended OS - Any standard Linux distribution 
Please install docker if it doesn't exist in the system

### Directory 
`cd spider_devops_task1/DevOPS_Task1/`

### Generate SSL Certificates

`mkdir -p certs`

```
openssl req \
-x509 \
-newkey rsa:4096 \
-keyout certs/nginx_ssl.key \
-out certs/nginx_ssl.crt \
-days 365 \
-nodes
```

### Build and Start Containers
`docker compose up`

### Run in Detached Mode
`docker compose up -d`

### Stop Containers

`docker compose down`

### Remove Containers and Volumes
`docker compose down -v`

---

## Services and Ports

| Service  | Purpose                                   | Port                          |
|-----------|-------------------------------------------|-------------------------------|
| frontend | React application served through Nginx    | 80, 443(https)                       |
| backend  | Go API server                             | 8080                          |
| db       | PostgreSQL database                       | 5432 (container), 5433 (host) |

---

## How frontend reaches the backend

The frontend does not communicate directly with the backend container.
Here NGINX is the only entrypoint.

Instead, all API requests are sent to Nginx:

https://localhost/api/*

Nginx forwards those requests to:

http://backend:8080

using:
```
location /api/ {
    proxy_pass http://backend:8080;
}
```
Here nginx acts the reverse proxy.

---

## How PostgreSQL is configured
PostgreSQL runs in its own container.

Configuration is provided using environment variables in the docker compose file:

```
POSTGRES_DB=cr45_reduced

POSTGRES_USER=postgres

POSTGRES_PASSWORD=postgres
```

The backend connects using:

`postgres://postgres:postgres@db:5432/cr45_reduced?sslmode=disable`

Database persistence is achieved through a named Docker volume:

`postgres_data:/var/lib/postgresql/data`

This ensures data survives container recreation and restarts.

---

## Migration Handling

The backend automatically executes migrations during startup.

Migration files are stored in:

`backend/migrations/`

When the backend starts:

- Connects to PostgreSQL
- Executes pending migrations
- Creates required schema
- Seeds initial application data

---

## Common failure cases 

### SSL Certificates missing.

Certificate files are missing or not mounted.

Verify:

`ls certs`

and confirm these exists:

- nginx_ssl.crt
- nginx_ssl.key


If not there:

`mkdir -p certs`

```
openssl req \
-x509 \
-newkey rsa:4096 \
-keyout certs/nginx_ssl.key \
-out certs/nginx_ssl.crt \
-days 365 \
-nodes
```

---

## Improvements Implemented

### 1. Health checks

Health checks for the postgres db has been added to the docker compose file.

To verify it please run:

`docker ps` 

after starting the containers

---

### 2. Access and error logs

Added location for access and error logs by the nginx server 

To verify it run :

```
docker ps # get the hash id of frontend container
docker exec -it <hash_id_of_frontend_container> /bin/sh
cd /var/log/nginx/
ls
```

---

### 3 . Compression, Caching , keepalive tuning, worker/process tuning

Gzip Compression
```
gzip on;

gzip_vary on;
gzip_proxied any;
gzip_comp_level 6;

gzip_types
    text/css
    application/json
    application/javascript;
    
```

Static Asset Caching

```
location ~* \.(js|css)$ {
    expires 30d;
    add_header Cache-Control "public, immutable";
}
```
Keepalive Connections

```
keepalive_timeout 65;
keepalive_requests 100;
```

Worker Process Tuning

```
worker_processes auto;
worker_connections 1024;
```
Compression, caching headers for static assets, keepalive tuning,  worker/process tuning appropriate for the setup has been added to the nginx.conf file

Verify compression:

`curl -I -H "Accept-Encoding: gzip" https://localhost`

Expected header:Content-Encoding: gzip

Verify caching:
```
Open browser Developer Tools:

Network → Select JS/CSS file
```

Expected headers:

Cache-Control: public, immutable
Expires: <future date>

---

### 4. HTTPS support

The SSL / TLS certificates paths are provided to the nginx.conf to establish HTTPS connection between the client and the nginx server. 
```
Nginx HTTPS configuration:

listen 443 ssl;

Certificate configuration:

ssl_certificate /etc/nginx/certs/nginx_ssl.crt;
ssl_certificate_key /etc/nginx/certs/nginx_ssl.key;

TLS configuration:

ssl_protocols TLSv1.2 TLSv1.3;

HTTP traffic is automatically redirected:

server {
    listen 80;
    return 301 https://$host$request_uri;
}
```

Also redirection from HTTP to HTTPS is also implemeted using the HTTP status code 301

To verify this visit `http://localhost`

---



