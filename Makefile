.PHONY: help setup test lint run-api clean docker-build docker-run

help:
	@echo "Available commands:"
	@echo "  make setup         - Install dependencies and verify project structure"
	@echo "  make test          - Run test suite"
	@echo "  make lint          - Run code linters/formatters"
	@echo "  make run-api       - Run FastAPI development server"
	@echo "  make docker-build  - Build Docker container image"
	@echo "  make docker-run    - Run container via docker-compose"
	@echo "  make clean         - Clean cache and temporary files"

setup:
	pip install -r requirements.txt
	python scripts/setup_project.py

test:
	pytest tests/ -v

lint:
	black --check src tests
	isort --check-only src tests

run-api:
	uvicorn src.api.main:app --reload --host 0.0.0.0 --port 8000

docker-build:
	docker build -t student-placement-mlops:latest .

docker-run:
	docker-compose up -d

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	rm -rf build dist *.egg-info
