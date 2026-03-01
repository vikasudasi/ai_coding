# =============================================================================
# Dockerfile — Universal Language-Agnostic Base
# =============================================================================
# This is a placeholder Dockerfile. Replace the base image and build steps
# with those appropriate for your project's runtime.
#
# Agent instructions: Do NOT change WORKDIR or the COPY ordering convention.
# Always copy dependency manifests first (for layer caching), then source.
# =============================================================================

# --- Stage 1: Base runtime ---
# Replace with your language's official image, e.g.:
#   python:3.12-slim | node:20-alpine | golang:1.22-alpine | rust:1.78-slim
FROM ubuntu:24.04 AS base

# Metadata
LABEL maintainer="your-team@example.com"
LABEL description="[Replace: short description of this service]"

# Prevent interactive prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Install common utilities (trim this list for production)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    bash \
    git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# --- Stage 2: Dependencies ---
# AGENT: Copy ONLY the dependency manifest first (layer cache optimization).
# Example patterns:
#   COPY package*.json ./          # Node.js
#   COPY requirements*.txt ./      # Python
#   COPY go.mod go.sum ./          # Go
#   COPY Cargo.toml Cargo.lock ./  # Rust

# COPY [dependency-manifest] ./
# RUN [install-command]   e.g. npm ci | pip install -r requirements.txt | go mod download

# --- Stage 3: Application source ---
COPY . .

# --- Stage 4: Build (if compiled language) ---
# RUN [build-command]   e.g. npm run build | go build -o /app/server ./cmd/server

# --- Runtime configuration ---
# Expose the application port (change to match your app)
EXPOSE 8080

# Health check — replace with your app's actual health endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Non-root user for security (principle of least privilege)
RUN useradd -r -u 1001 -g root appuser
USER appuser

# Application entrypoint — replace with your start command
CMD ["bash", "-c", "echo 'Replace this CMD with your application start command'"]
