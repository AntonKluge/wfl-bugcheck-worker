FROM ghcr.io/astral-sh/uv:0.11.16-debian-slim

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV UV_LINK_MODE=copy UV_COMPILE_BYTECODE=1 UV_PYTHON_INSTALL_DIR=/app/.uv/python

COPY pyproject.toml ./
RUN uv sync --no-install-project

COPY . .
RUN uv sync

ENTRYPOINT ["/app/.venv/bin/python", "worker.py"]
