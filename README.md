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
