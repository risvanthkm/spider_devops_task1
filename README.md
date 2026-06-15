# SPIDER DevOPS Task1

---

## Overview

---

This project containerizes the CR45 Reduced full-stack application consisting of:

- React frontend
- Go backend
- PostgreSQL database
- Nginx reverse proxy

>The objective of this deployment is to provide a reproducible production-oriented setup using Docker and Docker Compose while preserving authentication, database migrations, and reverse proxying, and persistent storage behavior.

## Features 

---

- Multi container orchestration using **Docker Compose**
- **Dockerfiles** for building Images
- **Nginx** serves the frontend 
- **Reverse proxy** for the API backend
- **SPA** (Single Page Application) routing support
- HTTPS support using **SSL/TLS** certificates
- HTTP to HTTPS redirection
- **Gzip** compression for reduced network bandwidth usage
- Browser **caching** for static assets
- PostgreSQL **health checks** for service readiness monitoring
- Access and error **logging** for improved observability

## Services

---

| Service  | Purpose                                   | Port                          |
|-----------|-------------------------------------------|-------------------------------|
| frontend | React application served through Nginx    | 80, 443                       |
| backend  | Go API server                             | 8080                          |
| db       | PostgreSQL database                       | 5432 (container), 5433 (host) |

## Summary of the containerized setup

---


### Docker Compose

- Manages and coordinates the frontend, backend, and PostgreSQL containers as a single application stack.
- Builds custom images for the frontend and backend services.
- Creates an isolated Docker network.
- Enables service discovery using container names (e.g., `backend`, `db`).
- Maps required ports between the host and containers.
- Configures environment variables for service-specific settings.
- Implements health checks to monitor service availability.
- Defines service dependencies to ensure proper startup order.
- Mounts persistent volumes for PostgreSQL data storage.
- Simplifies deployment and management through a single configuration file.

### Dockerfile 
- Creates custom docker images 
- Pulls a light-weight base images 
- Copies application files into the container filesystem.
- Defines container startup commands
- Builds, downloads dependencies, exposes ports and runs the application

### .dockerignore
- Excludes unnecessary files and directories from the Docker build context.
- Reduces Docker image size and build time.
- Helps maintain cleaner, more secure, and optimized container images.

### Nginx Server

- Serves the React frontend as static content.
- Implements SPA fallback routing using `try_files` for React Router support.
- Reverse proxies API requests to the Go backend service.
- Enables Gzip compression for CSS, JavaScript, and JSON responses.
- Configures browser caching for static assets to improve load times.
- Supports HTTPS with SSL/TLS (TLS 1.2 and TLS 1.3).
- Automatically redirects HTTP traffic to HTTPS.
- Provides access and error logging for observability.
- Uses keepalive connections to improve request handling efficiency.
- Optimizes concurrency with automatic worker process scaling and worker connection tuning.
- Configured with SSL session caching and timeout settings for improved HTTPS performance.


## Setup Instructions

---

Run this command to create self-signed TLS certificate and a private key 

```
openssl req \
-x509 \
-newkey rsa:4096 \
-keyout certs/nginx_ssl.key \
-out certs/nginx_ssl.crt \
-days 365 \
-nodes
```

To build the images and start all containers from your docker-compose.yml, run:

`docker compose -f docker-compose.yml up`

This builds the images and starts the containers, connect them in same Docker Network

To stop and remove and the containers 

`docker compose -f docker-compose.yml down`

For your setup with HTTPS enabled, after startup you should be able to access:
`https://localhost`

## Project Structure 
```
cr45-reduced/
│
├── **docker-compose.yml**
│
├── **DOCS.md**
├── **README.md**
│
├── certs/
│   └── .gitkeep
│
├── backend/
│   ├── **Dockerfile**
│   ├── **.dockerignore**
│   │
│   ├── cmd/
│   ├── internal/
│   ├── migrations/
│   ├── go.mod
│   └── go.sum
│
└── frontend/
    ├── **Dockerfile**
    ├── **.dockerignore**
    ├── **nginx.conf**
    │
    ├── src/
    ├── public/
    ├── package.json
    └── package-lock.json
```

# Thank You :)




