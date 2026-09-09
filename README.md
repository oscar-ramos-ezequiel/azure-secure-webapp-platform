# Azure Secure Web App Platform

A hands-on Azure Cloud Engineering portfolio project focused on building,
deploying and evolving a secure Python web application on Microsoft Azure.

The project starts with a manual Azure deployment and will progressively
evolve toward Infrastructure as Code, CI/CD, security, monitoring and
cloud automation.

## 🎯 Project Objectives

- Deploy a Python web application on Microsoft Azure
- Apply cloud resource naming conventions
- Organize infrastructure using Azure Resource Groups
- Implement tagging and basic cloud governance
- Monitor cloud spending with Azure Cost Management
- Deploy workloads using Azure App Service
- Implement CI/CD with GitHub Actions
- Manage infrastructure using Terraform
- Apply Azure security best practices
- Implement monitoring and observability

---

## 🏗️ Current Architecture

```text
Microsoft Azure Subscription
│
├── Azure Cost Management
│   └── Monthly Budget / Cost Alerts
│
└── Resource Group
    └── rg-portfolio-webapp-dev-001
        │
        ├── App Service Plan
        │   ├── Linux
        │   ├── F1 Free SKU
        │   └── France Central
        │
        └── Azure App Service
            ├── app-portfolio-webapp-dev-001
            ├── Linux
            ├── Python runtime
            └── Public HTTPS access
---

## Phase 2 - CI/CD with GitHub Actions

The application is automatically deployed to Azure App Service using a GitHub Actions CI/CD pipeline.

### Deployment Flow

    Developer Workstation
            |
            | git push
            v
    GitHub Repository
            |
            | GitHub Actions
            v
    Build Python Application
            |
            | OIDC Authentication
            v
    Azure Managed Identity
            |
            | Website Contributor
            v
    Azure App Service

### CI/CD Implementation

The deployment pipeline is defined in:

`.github/workflows/main_app-portfolio-webapp-dev-001.yml`

The workflow is automatically triggered when changes are pushed to the `main` branch.

The pipeline performs the following steps:

1. Checks out the source code.
2. Configures the Python runtime.
3. Installs application dependencies.
4. Builds the deployment artifact.
5. Authenticates to Microsoft Azure using OpenID Connect (OIDC).
6. Deploys the application to Azure App Service.

### Passwordless Authentication with OIDC

GitHub Actions authenticates to Azure using OpenID Connect and a user-assigned managed identity.

This avoids storing long-lived Azure passwords, service principal secrets, or publish profiles in GitHub.

The managed identity has the `Website Contributor` role scoped to the Azure App Service.

    GitHub Actions
          |
          | Temporary OIDC Token
          v
    Microsoft Entra ID
          |
          v
    User Assigned Managed Identity
          |
          v
    Azure App Service

### OIDC Troubleshooting

During the initial Deployment Center configuration, Azure could not automatically verify the GitHub OIDC subject claim.

The repository uses GitHub immutable OIDC subject claims.

The issue was resolved by:

1. Keeping the user-assigned managed identity created by Azure.
2. Creating the federated credential manually.
3. Associating the GitHub repository and `main` branch with the federated identity.
4. Assigning the `Website Contributor` role to the managed identity.
5. Reconfiguring Azure Deployment Center to use the existing identity.

After this configuration, GitHub Actions authenticated successfully using OIDC.

### CI/CD Validation

The pipeline was tested by modifying the Flask homepage locally.

The change was committed and pushed using Git:

    git add app.py
    git commit -m "feat: update homepage with CI/CD status"
    git push

The push automatically triggered GitHub Actions.

Both pipeline jobs completed successfully:

- Build
- Deploy

The updated application was deployed to Azure App Service without performing a manual deployment from the Azure Portal.