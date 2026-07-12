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

`mkdir certs`

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
# Spider DevOps Task 2

<p align="center">

![Go](https://img.shields.io/badge/Go-1.25-00ADD8?style=for-the-badge&logo=go&logoColor=white)
![React](https://img.shields.io/badge/React-19-61DAFB?style=for-the-badge&logo=react&logoColor=black)
![Vite](https://img.shields.io/badge/Vite-7-646CFF?style=for-the-badge&logo=vite&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Reverse%20Proxy-009639?style=for-the-badge&logo=nginx&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-17-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![SSL](https://img.shields.io/badge/HTTPS-TLS-green?style=for-the-badge&logo=letsencrypt&logoColor=white)
![Docker Hub](https://img.shields.io/badge/DockerHub-Images-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![wrk](https://img.shields.io/badge/Performance-wrk-orange?style=for-the-badge)
![Trivy](https://img.shields.io/badge/Security-Trivy-1904DA?style=for-the-badge)

</p>

---

## Overview

This project focuses on transforming a containerized web application into a production-ready deployment by implementing modern DevOps practices.

The application consists of a React frontend, a Go backend, and a PostgreSQL database. It is deployed using Docker Compose with Nginx acting as a reverse proxy and load balancer. The project also includes an automated Jenkins CI/CD pipeline, HTTPS configuration, container hardening, vulnerability scanning, horizontal scaling, and performance benchmarking.

The goal is to demonstrate production deployment concepts including security, scalability, observability, automation, and resiliency.

---

# Documentation

Detailed documentation can be found in:

> **[DOCS.md](DOCS.md)**

The documentation includes:

- Project Architecture
- System Workflow
- Deployment Guide
- Jenkins CI/CD Pipeline
- Docker Configuration
- Nginx Configuration
- Security Improvements
- Production Optimizations
- Horizontal Scaling
- Load Balancing
- Performance Testing
- Vulnerability Scanning
- Observability

---

# Features

## Docker & Deployment

- Multi-container application using Docker Compose
- Multi-stage Docker builds
- Production-ready Docker images
- Docker Hub image publishing
- Automated deployment using Docker Compose
- Environment variable management
- Resource limits (CPU & Memory)
- Restart policies
- Read-only container filesystem
- Non-root containers
- Linux capability restrictions

---

## Reverse Proxy & Networking

- Nginx reverse proxy
- HTTPS using self-signed SSL certificates
- Automatic HTTP → HTTPS redirection
- HTTP Strict Transport Security (HSTS)
- Static asset caching
- Gzip compression
- Keep-alive optimization
- Reverse proxy request forwarding
- Client IP forwarding (`X-Real-IP`, `X-Forwarded-For`)
- Security response headers

---

## High Availability

- Horizontal backend scaling (3 replicas)
- Nginx Least Connections load balancing
- Automatic backend failover
- Health check endpoint
- Backend pool management
- High availability deployment

---

## Security

- HTTPS (TLS 1.2 & TLS 1.3)
- HSTS
- Referrer Policy
- X-Content-Type-Options
- X-Frame-Options
- Permissions Policy
- API rate limiting
- Capability dropping
- No privilege escalation
- Read-only filesystem
- Non-root execution
- Docker image vulnerability scanning (Trivy)

---

## CI/CD

- Automated Jenkins Pipeline
- Go testing
- Frontend build validation
- Docker image build
- Docker image push in Docker Hub
- Automated deployment
- Versioned Docker images
- Latest image deployment
- Health Check
---

## Observability

- Container logging
- Nginx access logs
- Nginx error logs
- Health endpoint
- Docker restart policies
- Container monitoring support

---

## Performance

- Load balancing
- Horizontal scaling benchmark
- wrk performance testing
- Single vs Multi backend comparison
- Throughput analysis
- Latency analysis
- Failover testing

---

## Production Optimizations

- Optimized Nginx configuration
- Gzip compression
- Browser caching
- Worker auto scaling
- Keep-alive tuning
- Rate limiting
- Reduced container privileges
- Image size optimization
- Resource isolation

---

# Tech Stack

| Category | Technologies |
|----------|--------------|
| Frontend | React, Vite |
| Backend | Go |
| Database | PostgreSQL |
| Reverse Proxy | Nginx |
| Containerization | Docker, Docker Compose |
| CI/CD | Jenkins |
| Registry | Docker Hub |
| Security | Trivy, OpenSSL |
| Performance Testing | wrk |
| Operating System | Ubuntu Linux |

---

# Project Highlights

- Production-ready Docker deployment
- Automated CI/CD pipeline
- Secure container configuration
- Reverse proxy with HTTPS
- Load balancing & failover
- Horizontal backend scaling
- Performance benchmarking
- Vulnerability scanning
- Production optimizations
- Infrastructure hardening

---

---

# Thank You : )




