# Azure Secure Web App Platform

A hands-on Azure Cloud Engineering portfolio project focused on building,
deploying and evolving a secure Python web application on Microsoft Azure.

This project demonstrates the end-to-end deployment and management of a Python web application on Microsoft Azure.

The solution includes automated CI/CD with GitHub Actions, passwordless authentication using OIDC and Managed Identity, Infrastructure as Code with Terraform, remote Terraform state in Azure Storage, and a responsive Flask web interface.

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

CI/CD pipeline documentation updated.

---

## Phase 3 - Infrastructure as Code with Terraform

The Azure infrastructure was migrated from manually created resources to Infrastructure as Code using Terraform.

### Terraform-managed resources

Terraform manages:

- Azure Resource Group
- Linux App Service Plan
- Linux Web App

The existing Azure resources were imported into Terraform state instead of being recreated.

### Terraform workflow

    Terraform configuration
            |
            | terraform plan
            v
    Remote Terraform State
            |
            | Azure Storage
            v
    Azure Infrastructure

### Remote State

Terraform state is stored remotely in Azure Storage instead of locally.

This provides persistent state even when Terraform is executed from an ephemeral Azure Cloud Shell session.

The backend uses Microsoft Entra ID authentication instead of storing Storage Account access keys in the repository.

### Importing Existing Infrastructure

The Azure resources were initially created manually through the Azure Portal.

They were imported into Terraform using `terraform import`, allowing Terraform to manage the existing infrastructure without recreating it.

Imported resources:

- Resource Group
- App Service Plan
- Linux Web App

### Infrastructure Validation

The Terraform configuration was aligned with the existing Azure infrastructure until Terraform reported:

    No changes. Your infrastructure matches the configuration.

A controlled Infrastructure as Code change was then performed by updating the `ManagedBy` tag from:

    Manual

to:

    Terraform

Terraform showed:

    Plan: 0 to add, 3 to change, 0 to destroy.

After applying the plan:

    Apply complete! Resources: 0 added, 3 changed, 0 destroyed.

A final `terraform plan` confirmed:

    No changes. Your infrastructure matches the configuration.

This validated that the Terraform configuration, remote state, and Azure infrastructure were synchronized.



---

## Phase 4 - Web Interface Improvement

The original Flask application used inline HTML inside `app.py`.

The application structure was improved by separating application logic, HTML templates, CSS, and static assets.

### Application structure

```text
azure-secure-webapp-platform/
├── app.py
├── templates/
│   └── index.html
├── static/
│   ├── css/
│   │   └── style.css
│   └── images/
│       └── background.png
└── requirements.txt
