# Use a Python image with uv pre-installed
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS builder

# Configure uv:
# - Compile bytecode for faster startup
# - Copy mode instead of hardlinks (better for Docker layers)
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

WORKDIR /app

# Install dependencies
# We copy only the lock files first to cache this layer
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-install-project --no-dev

# Copy the rest of the application
COPY . .

# Install the project itself
RUN uv sync --frozen --no-dev

# --- Final Stage ---
# We use a distroless or slim python image for the final runner to keep it small
FROM python:3.13-slim-bookworm

# Copy the environment from the builder
# uv creates the venv in .venv by default
COPY --from=builder /app/.venv /app/.venv
COPY --from=builder /app/src /app/src

# Add virtual environment to PATH
ENV PATH="/app/.venv/bin:$PATH"
WORKDIR /app

# Run the application
# CMD ["python", "-m", "my_project.main"]
