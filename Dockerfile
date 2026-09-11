# Multi-stage build for minimal production image

# =============================================================================
# Stage 1: Frontend build (Node.js)
# =============================================================================
FROM node:22-alpine AS client-build
WORKDIR /app/client
COPY client/package.json client/pnpm-lock.yaml client/pnpm-workspace.yaml ./
RUN corepack enable && corepack prepare pnpm@9.15.4 --activate && pnpm install --frozen-lockfile --prod=false
COPY client .
RUN pnpm build

# =============================================================================
# Stage 2: Backend dependencies (Python wheels)
# =============================================================================
FROM python:3.12-slim AS backend-deps
WORKDIR /app/backend
COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

# =============================================================================
# Stage 3: Backend application code
# =============================================================================
FROM python:3.12-slim AS backend-app
WORKDIR /app/backend
COPY backend .

# =============================================================================
# Stage 4: Runtime - minimal image with nginx + python
# =============================================================================
FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080 \
    DJANGO_SETTINGS_MODULE=core.settings \
    VITE_API_BASE_URL=/api

# Install only runtime system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    libpq5 \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/log/nginx /var/lib/nginx /tmp/nginx/client_temp

# Copy Python dependencies from backend-deps stage
COPY --from=backend-deps /install /usr/local

# Copy backend application code
COPY --from=backend-app /app/backend /app/backend

# Copy built frontend assets
COPY --from=client-build /app/client/dist /usr/share/nginx/html

# Copy configuration files
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
COPY docker/start-services.sh /start-services.sh

RUN chmod +x /docker-entrypoint.sh /start-services.sh

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
