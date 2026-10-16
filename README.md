# Student Placement Prediction & Placement Readiness Platform

[![Python 3.10+](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100%2B-009688.svg)](https://fastapi.tiangolo.com)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An enterprise-grade MLOps platform for student campus placement prediction, multi-dimensional readiness indexing, explainable AI diagnostics, and personalized career roadmaps.

---

> [!IMPORTANT]
> **Current Project Status: Architectural Foundation**
>
> **ML training has not yet been implemented.**
>
> The repository has been initialized with a clean, production-oriented modular architecture, configuration system, logging infrastructure, API schemas, and validation suite. Machine learning training, model selection, explainability, and dataset ingestion will be developed in successive phases.

---

## 🎯 Project Objective

The objective of this platform is to provide higher education institutions, career counseling cells, and students with an end-to-end intelligent career readiness platform that:

1. Ingests and validates student academic, technical, and experiential records.
2. Trains, compares, and evaluates multiple candidate classification models.
3. Produces calibrated placement likelihood predictions and confidence bounds.
4. Calculates a weighted **Placement Readiness Score** across 5 core competencies.
5. Generates **AI-driven career insights**, identifying skill gaps and actionable recommendations.
6. Serves predictions via high-throughput **FastAPI** REST microservices and an interactive dashboard.

---

## 🏛️ System Architecture Flow

```
Student Profile
      │
      ▼
   Dataset
      │
      ▼
Data Ingestion (src/data/ingestion.py)
      │
      ▼
Validation (src/data/validation.py)
      │
      ▼
Preprocessing (src/preprocessing/preprocessor.py)
      │
      ▼
Feature Engineering (src/features/feature_engineering.py)
      │
      ▼
Model Training (src/models/train.py) [Pending Phase 4]
      │
      ▼
Evaluation & Metrics (src/models/evaluate.py) [Pending Phase 6]
      │
      ▼
Model Registry (src/models/registry.py)
      │
      ▼
Prediction API (src/api/)
      │
      ▼
Readiness Engine (src/readiness/readiness_score.py)
      │
      ▼
AI Insights (src/insights/career_insights.py)
      │
      ▼
Frontend Dashboard
```

Detailed architectural specifications are documented in [`docs/architecture.md`](docs/architecture.md).

---

## 📁 Directory Structure

```
student-placement-mlops/
│
├── data/
│   ├── raw/                  # Staged raw student datasets
│   ├── interim/              # Partially transformed intermediate data
│   ├── processed/            # Cleaned, train/test/val splits (Parquet)
│   └── external/             # Third-party benchmark datasets
│
├── artifacts/
│   ├── models/               # Serialized model artifacts (.joblib)
│   ├── preprocessors/        # Fitted ColumnTransformer pipelines
│   ├── metrics/              # Model evaluation reports and confusion matrices
│   └── explainability/       # Feature importance charts and SHAP outputs
│
├── configs/
│   ├── config.yaml           # Global system, paths, and API settings
│   └── model_config.yaml     # Feature schemas, target columns, and model params
│
├── notebooks/                # Exploratory Data Analysis & experimentation
│
├── src/
│   ├── __init__.py
│   ├── data/
│   │   ├── __init__.py
│   │   ├── ingestion.py      # Raw data ingestion handlers
│   │   ├── validation.py     # Schema and constraint validator
│   │   └── dataset.py        # Dataset loader and train/val/test splitter
│   ├── preprocessing/
│   │   ├── __init__.py
│   │   └── preprocessor.py   # Scikit-learn ColumnTransformer pipelines
│   ├── features/
│   │   ├── __init__.py
│   │   └── feature_engineering.py # Academic & skill index derivation
│   ├── models/
│   │   ├── __init__.py
│   │   ├── train.py          # Candidate model training orchestrator
│   │   ├── evaluate.py       # Classification metric computation
│   │   ├── predict.py        # Inference engine
│   │   └── registry.py       # Model artifact versioning
│   ├── explainability/
│   │   ├── __init__.py
│   │   └── feature_importance.py # Global & local explainability
│   ├── readiness/
│   │   ├── __init__.py
│   │   └── readiness_score.py # Multi-dimensional readiness scoring
│   ├── insights/
│   │   ├── __init__.py
│   │   └── career_insights.py # Skill gap & career action plans
│   ├── api/
│   │   ├── __init__.py
│   │   ├── main.py           # FastAPI entrypoint
│   │   ├── schemas.py        # Pydantic request & response models
│   │   └── routes.py         # REST endpoint routes
│   ├── pipeline/
│   │   ├── __init__.py
│   │   └── training_pipeline.py # End-to-end training orchestrator
│   └── utils/
│       ├── __init__.py
│       ├── logger.py         # Centralized logging setup
│       ├── config.py         # Config loader & PathConfig
│       └── common.py         # I/O and helper functions
│
├── tests/
│   ├── __init__.py
│   ├── test_config.py
│   ├── test_logger.py
│   ├── test_data_validation.py
│   ├── test_preprocessing.py
│   ├── test_prediction.py
│   └── test_api.py
│
├── mlruns/                   # MLflow experiment tracking logs
│
├── docs/
│   ├── architecture.md       # Complete architectural breakdown
│   ├── dataset_card.md       # Dataset schema and attribute descriptions
│   └── ml_pipeline.md        # MLOps lifecycle details
│
├── scripts/
│   └── setup_project.py      # Environment and directory verifier
│
├── .env.example              # Environment variables template
├── .gitignore                # Git ignore rules for data, models, and cache
├── requirements.txt          # Foundational dependencies
├── pyproject.toml            # Python packaging and tool configuration
├── Dockerfile                # Production container specification
├── docker-compose.yml        # Multi-container orchestration
├── Makefile                  # Developer workflow automation commands
└── README.md
```

---

## ⚙️ Setup and Installation

### 1. Prerequisites
- Python 3.9+ (Python 3.10 recommended)
- Git

### 2. Clone and Setup Environment

```bash
# Clone repository
git clone <repo-url> student-placement-mlops
cd student-placement-mlops

# Create virtual environment
python -m venv .venv

# Activate virtual environment
# Windows:
.venv\Scripts\activate
# Linux/macOS:
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 3. Initialize Configuration & Environment

```bash
# Copy environment variables template
cp .env.example .env

# Verify project structure and configuration
python scripts/setup_project.py
```

### 4. Run Test Suite

```bash
pytest tests/ -v
```

### 5. Launch FastAPI Service (Development)

```bash
uvicorn src.api.main:app --reload --host 0.0.0.0 --port 8000
```

Interactive API documentation will be available at:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

### 6. Docker Quick Start (Production Containerization)

The platform is fully containerized with multi-stage Docker builds and Docker Compose orchestration.

```bash
# Build both backend and frontend images
docker compose build

# Start services in the background
docker compose up -d

# Check running container status and health
docker compose ps

# View container logs
docker compose logs backend
docker compose logs frontend

# Stop containers
docker compose down
```

### 7. Continuous Integration & Quality (CI/CD)

The repository uses GitHub Actions (`.github/workflows/ci.yml`) to enforce code quality, test coverage, static analysis, and container buildability on every `push` and `pull_request` to `main`, `master`, and `develop`.

#### Pipeline Workflow:
1. **Backend Tests & Quality:**
   - Verifies runtime model artifacts exist and load without retraining (`scripts/verify_docker.py`).
   - Runs static linting with `ruff`.
   - Executes 96 backend unit and integration tests with `pytest -q`.
2. **Frontend Tests & Build:**
   - Executes Jest test suite (`npm test -- --runInBand`).
   - Runs TypeScript strict validation (`npx tsc --noEmit`).
   - Compiles production bundle (`npm run build`).
3. **Docker Build Verification:**
   - Multi-stage Docker build validation for both backend and frontend images.
4. **Security & Dependency Audit:**
   - Runs `pip-audit` and `npm audit` for non-blocking dependency vulnerability monitoring.

#### Local Reproduction:
Developers can verify all CI checks locally prior to pushing:

```bash
# Backend verification
pytest -q
python scripts/verify_docker.py

# Frontend verification
cd frontend
npm test -- --runInBand
npx tsc --noEmit
npm run build
cd ..

# Docker build verification
docker compose build
```

---

## 🗓️ Development Phases

| Phase | Milestone | Status |
| :---: | :--- | :---: |
| **Phase 1** | Project Architecture, Configuration, Logging & Foundation | **COMPLETED** |
| **Phase 2** | Dataset Acquisition, Ingestion & Data Validation | **COMPLETED** |
| **Phase 3** | Data Preprocessing Pipeline & Feature Engineering | **COMPLETED** |
| **Phase 4** | Model Training, Baseline & Candidate Algorithms | **COMPLETED** |
| **Phase 5** | Hyperparameter Tuning & Cross-Validation Comparison | **COMPLETED** |
| **Phase 6** | Model Evaluation, Metrics & Performance Thresholds | **COMPLETED** |
| **Phase 7** | Model Explainability (SHAP / Feature Importance) | **COMPLETED** |
| **Phase 8** | Placement Prediction Inference Engine & Confidence Scoring | **COMPLETED** |
| **Phase 9** | Model Registry & MLflow Experiment Tracking | **COMPLETED** |
| **Phase 10**| Placement Readiness Scoring Engine | **COMPLETED** |
| **Phase 11**| AI-Generated Career Insights & Skill Gap Analysis | **COMPLETED** |
| **Phase 12**| Production FastAPI Microservice & Endpoints | **COMPLETED** |
| **Phase 13**| Frontend Dashboard Integration | **COMPLETED** |
| **Phase 14**| Production Docker Containerization | **COMPLETED** |
| **Phase 15**| Production CI/CD with GitHub Actions | **COMPLETED** |
| **Phase 16**| Model Monitoring, Drift Detection & Production Logging | Planned |

---

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

