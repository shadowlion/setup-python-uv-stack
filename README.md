# 🐍 Modern Python Template

A high-performance Python development template leveraging the **Astral ecosystem** for speed and developer happiness.

## 🚀 The Stack

- **[uv](https://github.com/astral-sh/uv)**: Blazing fast Python package and project manager.
- **[Ruff](https://github.com/astral-sh/ruff)**: An extremely fast Python linter and code formatter.
- **[ty](https://github.com/astral-sh/ty)**: Astral's high-performance static type checker.
- **Docker**: Optimized multi-stage builds using `uv`.
- **GitHub Actions**: Pre-configured CI for linting, type-checking, and building.

---

## 🛠️ Getting Started

### 1. Prerequisites
Ensure you have `uv` installed. If not, run:
`curl -LsSf https://astral.sh/uv/install.sh | sh`

### 2. Setup
Clone the repository and install dependencies:
`make install`

This will automatically create a `.venv` and install all dev dependencies.

### 3. Development Workflow
We use a `Makefile` to simplify common tasks:

| Command | Description |
| :--- | :--- |
| `make run` | Run the application locally |
| `make format` | Auto-format code with Ruff |
| `make lint` | Run Ruff linter (with auto-fix) |
| `make type-check` | Run static analysis with Ty |
| `make check` | **The Big Three:** Format + Lint + Type Check |
| `make test` | Run pytest |
| `make clean` | Remove all caches and virtual environments |

---

## 🧪 Testing
This project uses the modern `src/` layout. Tests are located in the `tests/` directory and run via `pytest`.

`make test`

---

## 🐳 Docker

The `Dockerfile` is optimized for production. To build and run your app in a container:

`make docker-build`
`make docker-run`

The build process uses a **multi-stage strategy**:
1. **Builder stage**: Uses `uv` to install dependencies into a virtual environment.
2. **Runner stage**: Copies only the `.venv` and source code into a slim Python image.

---

## ⚙️ CI/CD

On every push to `main` or Pull Request, GitHub Actions will:
1. Verify code formatting (Ruff).
2. Run the linter (Ruff).
3. Perform type checking (Ty).
4. Execute the test suite (Pytest).
5. Attempt a Docker build to ensure no regression in containerization.

---

## 📁 Project Structure

```text
├── .github/workflows/ # CI/CD pipelines
├── src/               # Application source code
│   └── whatever/    # Main package
├── tests/             # Test suite (pytest)
├── pyproject.toml     # Unified tool configuration
├── uv.lock            # Deterministic dependency lock
├── Dockerfile         # Optimized container definition
└── Makefile           # Developer shortcuts
```
