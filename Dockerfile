FROM ghcr.io/astral-sh/uv:0.11.16-debian-slim@sha256:a9d53b71b298c9d4efd82b7134f7f09a53fcdd27e4c2fe1c8ebdb9397dbbcc24

RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    UV_PYTHON_INSTALL_DIR=/app/.uv/python

USER root
RUN groupadd --gid 1001 mistral \
    && useradd --uid 1001 --gid 1001 -m mistral \
    && chown -R 1001:1001 /app

USER 1001

COPY --chown=1001:1001 pyproject.toml uv.lock ./
RUN --mount=type=cache,target=/home/mistral/.cache/uv,uid=1001,gid=1001 \
    uv sync --frozen --no-install-project

COPY --chown=1001:1001 . .
RUN --mount=type=cache,target=/home/mistral/.cache/uv,uid=1001,gid=1001 \
    uv sync --frozen

ENTRYPOINT ["/app/.venv/bin/python", "worker.py"]

