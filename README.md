# Cloud Automation Portfolio

A small but production-grade serverless portfolio project deployed on Microsoft Azure using Terraform and GitHub Actions.

This project demonstrates infrastructure automation, identity-based CI/CD, and serverless application design rather than frontend complexity.

---

## Architecture Overview

The system consists of:

- Static website hosted on Azure Storage
- Serverless API implemented with Azure Functions (Python)
- Cosmos DB (Table API) used as a simple persistence layer
- Infrastructure as Code using Terraform modules
- CI/CD pipeline using GitHub Actions with OIDC (no long-lived secrets)

A visitor counter on the site exercises the full request path end-to-end.

---

## Key Design Decisions

- Terraform modules are used to keep infrastructure composable and readable
- OIDC authentication is used for GitHub Actions instead of service principals with secrets
- RBAC-based access is preferred over account keys where supported
- Minimal frontend to keep the focus on cloud automation rather than UI work

This mirrors real-world production tradeoffs rather than tutorial-style scaffolding.

---

## Repository Structure

```text
/
├── infra/              # Terraform root
│   ├── modules/        # Reusable Terraform modules
│   └── environments/   # Environment-specific configuration
├── function_app/       # Azure Functions (Python)
├── site/               # Static website assets
└── .github/workflows/  # CI/CD pipelines

---

## Deployment Flow

- Code is pushed to the repository
- GitHub Actions authenticates to Azure using OIDC
- Terraform plans and applies infrastructure changes
- Application code is deployed to Azure Functions
- Static site is updated

---

## What This Project Is (and Isn’t)

### This is:

- A realistic cloud automation exercise
- A demonstration of IaC, CI/CD, and serverless patterns
- Intentionally small but end-to-end

### This is not:

- A frontend design showcase
- A tutorial copy/paste project
- A production SaaS

---

## Future Improvements
- Migrate static hosting to Azure Static Web Apps
- Add monitoring and alerting
- Expand API surface for additional features