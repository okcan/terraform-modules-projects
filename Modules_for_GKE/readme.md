# 🌐 GKE Terraform Module

This repository provides a **modular Terraform setup** to provision a **private GKE (Google Kubernetes Engine) cluster** on Google Cloud Platform (GCP), including:

- 🛡️ Custom VPC and Subnet
- 🔄 Secondary IP ranges for Pods and Services
- 🌍 Cloud NAT + Router for secure internet access
- ☸️ GKE Cluster with private nodes and authorized API access

---

## 📁 Directory Structure

```
terraform-gke/
├── main.tf                   # Root configuration to wire modules
├── variables.tf              # Root input variable declarations
├── terraform.tfvars          # User-provided values
├── outputs.tf
└── modules/
    ├── network/              # VPC + subnet + secondary IP ranges
    ├── gke/                  # GKE cluster + node pool
    └── nat/                  # Cloud NAT and Router
```

---

## 🚀 Getting Started

### 🔧 Prerequisites

- [Terraform](https://www.terraform.io/downloads)
- [Google Cloud SDK](https://cloud.google.com/sdk)
- A GCP project with billing enabled

### 🔐 Authenticate with GCP

```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project <your-project-id>
```

---

### ⚙️ Configuration

Update `terraform.tfvars`:

```hcl
project_id          = "your-gcp-project-id"
region              = "europe-west2"
authorized_ip       = "YOUR_PUBLIC_IP/32"
pods_range_name     = "pods-range"
services_range_name = "services-range"
```

📌 You can find your IP with:

```bash
curl ifconfig.me
```

---

### ⏱ Deployment

```bash
terraform init
terraform apply
```

---

## 🧩 Module Overview

### `network/`

Creates:
- Custom VPC (`auto_create_subnetworks = false`)
- Subnet (e.g. `10.10.0.0/16`)
- Secondary IP ranges for:
  - Pods: `10.20.0.0/16`
  - Services: `10.30.0.0/20`

### `nat/`

Creates:
- Cloud Router
- Cloud NAT (to allow private nodes outbound internet access)

### `gke/`

Creates:
- Private GKE cluster (`enable_private_nodes = true`)
- Master authorized networks (only your IP can access `kubectl`)
- Node pool using `e2-medium` instances

---

## 🧹 Cleanup

```bash
terraform destroy
```

---

## 📄 License

MIT License © 2025 Polygon Labs
