# Define the image name for docker operations
IMAGE_NAME := my-project
APP_MODULE := my_project.main

# .PHONY tells Make that these targets are not files
.PHONY: help install run format lint type-check check test clean docker-build docker-run

# Default target: print this help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install      Install dependencies using uv"
	@echo "  run          Run the application locally"
	@echo "  format       Format code with Ruff"
	@echo "  lint         Lint code with Ruff (and fix auto-fixable issues)"
	@echo "  type-check   Run static type checking with Ty"
	@echo "  check        Run format, lint, and type-check"
	@echo "  test         Run tests with pytest"
	@echo "  clean        Remove all cache and temporary files"
	@echo "  docker-build Build the Docker image"
	@echo "  docker-run   Run the Docker container"

# --- dependency management ---
install:
	@echo "🚀 Installing dependencies..."
	uv sync

# --- development ---
run:
	@echo "🚀 Running application..."
	uv run python -m $(APP_MODULE)

format:
	@echo "✨ Formatting code..."
	uv run ruff format .

lint:
	@echo "🚨 Linting code..."
	uv run ruff check . --fix

type-check:
	@echo "🔍 Type checking..."
	uv run ty check

# Shortcut to run all code quality tools
check: format lint type-check

test:
	@echo "🧪 Running tests..."
	uv run pytest --cov=src tests

# --- docker ---
docker-build:
	@echo "🐳 Building Docker image..."
	docker build -t $(IMAGE_NAME) .

docker-run:
	@echo "🐳 Running Docker container..."
	docker run --rm -it $(IMAGE_NAME)

# --- cleanup ---
clean:
	@echo "🧹 Cleaning up..."
	rm -rf .venv
	rm -rf .ruff_cache
	rm -rf .ty
	rm -rf .pytest_cache
	rm -rf __pycache__
	find . -type d -name "__pycache__" -exec rm -rf {} +
