# ==========================
# Base image
# ==========================
FROM python:3.12.11-slim-bookworm AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# ==========================
# Builder
# ==========================
FROM base AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

COPY pyproject.toml uv.lock ./

RUN uv sync --no-dev --frozen

# ==========================
# Runtime
# ==========================
FROM base

RUN groupadd -r django && useradd -r -g django django

COPY --from=builder /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:$PATH"

COPY . .

RUN chown -R django:django /app

USER django

ENTRYPOINT ["sh", "docker/entrypoint.sh"]

CMD [
    "python",
    "manage.py",
    "runserver",
    "0.0.0.0:8000"
]
