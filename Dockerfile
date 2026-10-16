# =============================================================================
# Production Backend Dockerfile - Student Placement MLOps
# =============================================================================
FROM python:3.10-slim

WORKDIR /app

# Set production environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app \
    APP_ENV=production \
    LOG_LEVEL=INFO \
    API_HOST=0.0.0.0 \
    API_PORT=8000

# Install lightweight system dependencies (curl for healthcheck)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root system user and group
RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /sbin/nologin appuser

# Copy dependency specifications first for Docker layer caching
COPY requirements.txt pyproject.toml ./

# Install python dependencies without development cache
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy required application code, configs, data, and trained model artifacts
COPY configs/ ./configs/
COPY src/ ./src/
COPY data/ ./data/
COPY artifacts/ ./artifacts/
COPY docs/ ./docs/
COPY scripts/ ./scripts/

# Create runtime directories with proper permissions
RUN mkdir -p logs mlruns && \
    chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose FastAPI server port
EXPOSE 8000

# Define container healthcheck using existing /health endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Production startup command (bound to 0.0.0.0, no reload)
CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
