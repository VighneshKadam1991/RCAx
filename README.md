# RCAx
RCA extended with AI

RCA Bot – Project Structure

rca-bot-ai/
├── backend-springboot/                 # Java Spring Boot app
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/rcabot/
│   │   │   │   ├── controller/         # API endpoints
│   │   │   │   ├── service/            # GPT, ML, RCA logic
│   │   │   │   ├── model/              # DTOs / Data Models
│   │   │   │   ├── config/             # AWS client configs
│   │   │   │   └── utils/              # Log parsing, preprocessors
│   │   │   └── resources/
│   │   │       └── application.yml     # Spring config
│   ├── Dockerfile                      # Optional for ECS
│   └── pom.xml                         # Maven dependencies
│
├── lambda-rca-handler/                 # Lambda to call SageMaker + Bedrock
│   ├── handler.py                      # Python Lambda (or Java if preferred)
│   ├── requirements.txt
│   └── lambda.zip                      # Zipped for Terraform
│
├── ml-model/                           # ML model for RCA
│   ├── train_model.py                  # Training code (e.g., XGBoost, MLP)
│   ├── inference.py                    # Endpoint logic for SageMaker
│   ├── rca-model.tar.gz                # Exported model artifact
│   └── sample_logs.csv                 # Training logs
│
├── terraform/                          # Infra setup
│   ├── main.tf                         # Providers + root module
│   ├── variables.tf                    # Variables for reuse
│   ├── outputs.tf                      # Exposed outputs
│   ├── iam.tf                          # IAM roles/policies
│   ├── lambda.tf                       # Lambda + IAM + CloudWatch
│   ├── sagemaker.tf                    # SageMaker model/deployment
│   ├── bedrock.tf                      # Bedrock GPT integration
│   ├── apigateway.tf                   # Gateway to expose API
│   ├── s3.tf                           # S3 for logs + model storage
│   ├── rds.tf                          # PostgreSQL or MySQL for RCA data
│   ├── vpc.tf                          # Optional private networking
│   └── ecs.tf                          # ECS cluster for Spring Boot (optional)
│
├── data/                               # Sample logs / training inputs
│   ├── raw-logs/
│   ├── labeled_logs.csv
│   └── preprocess.ipynb
│
├── scripts/                            # Shell scripts
│   ├── deploy.sh
│   ├── train-upload.sh
│   └── invoke-lambda.sh
│
├── README.md
└── LICENSE



Data Flow Overview

[User Query]
↓
[Spring Boot API] ─────> [Lambda]
↓
┌────────────────────────────┐
│   SageMaker (ML RCA model)│  → RCA category
│   Bedrock (GPT)           │  → Suggested fix
└────────────────────────────┘
↓
[Spring Boot API]
↓
[Final Response]



Responsibilities of Each Component

| Component       | Responsibilities                                    |
| --------------- | --------------------------------------------------- |
| **Spring Boot** | API layer, input validation, orchestrates AWS calls |
| **Lambda**      | Lightweight connector for GPT + ML models           |
| **SageMaker**   | Trained ML model that predicts RCA                  |
| **Bedrock**     | GPT/Claude model gives human-readable fix           |
| **RDS**         | Stores RCA logs and results                         |
| **S3**          | Stores trained model, raw logs                      |
| **Terraform**   | Builds and manages the entire AWS infra             |



