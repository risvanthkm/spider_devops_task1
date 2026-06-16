# Spider DevOps Task 1

This Repository is divided into  
1. Basic Tasks
2. Domain Specific Task

## Basic Tasks
This section has 3 tasks from domains DevOps, Cybersecurity and AppDev. 
### DevOps :
>This sub-task focuses on developing Bash scripts that automatically scan a repository for common **security threats** and **sanitize environment configuration** files by removing unsafe or invalid entries. Also, every 30 minutes the scripts scan for threats and update the user by sending emails (if threats found) .

[DevOps Basic Task Documentation](/Basic_Task/DevOPS/README.md)

### Cybersecurity 
>Built CryptoVault, a CLI tool for secure file encryption and decryption using the Caesar Cipher, with integrated SHA-256 hash verification to ensure file integrity.

[Cybersecurity Basic Task Documentation](/Basic_Task/Cybersecurity/README.md)

### Application Development
>Developed an interactive browser-based game using HTML, CSS, and JavaScript. Implemented game logic, player interactions, dynamic UI updates, and styling.

## Domain Specific Task 
>This section has the DevOps task 1 which containerizes a full-stack web application built with React frontend, Go backend and PostgreSQL database.

### DevOps
This task containerizes the CR45 Reduced full-stack application using Docker and Docker Compose. The deployment includes a React frontend served by Nginx, a Go backend, and a PostgreSQL database running as separate containers. Nginx provides SPA routing, reverse proxying, HTTPS support, and HTTP-to-HTTPS redirection. Additional improvements include PostgreSQL health checks, access/error logging, Gzip compression, static asset caching, and performance tuning. The setup delivers a reproducible, secure, and production-oriented deployment with persistent storage. 

[DevOps Task1 Documentation](/DevOPS_Task1/README.md)

## Repository Structure

```text
.
├── Basic_Task
│   ├── Application_Development/
│   ├── Cybersecurity/
│   └── DevOPS/
│
└── DevOPS_Task1
```
# Thank you 
