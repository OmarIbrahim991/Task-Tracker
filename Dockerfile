FROM node:20-alpine AS client-build
WORKDIR /app/client
COPY client/package.json client/pnpm-lock.yaml client/pnpm-workspace.yaml ./
RUN corepack enable && pnpm install --frozen-lockfile
COPY client .
RUN pnpm build

FROM python:3.12-slim AS backend-build
WORKDIR /app/backend
COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
	pip install --no-cache-dir -r requirements.txt
COPY backend .

FROM python:3.12-slim AS runtime
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1 \
	PORT=8080 \
	DJANGO_SETTINGS_MODULE=core.settings \
	VITE_API_BASE_URL=/api

RUN apt-get update && apt-get install -y --no-install-recommends nginx && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /var/log/nginx /var/lib/nginx /tmp/nginx/client_temp

COPY --from=client-build /app/client/dist /usr/share/nginx/html
COPY --from=backend-build /app/backend /app/backend

COPY backend/requirements.txt ./backend/requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
	pip install --no-cache-dir -r backend/requirements.txt

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
COPY docker/start-services.sh /start-services.sh

RUN chmod +x /docker-entrypoint.sh /start-services.sh

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
