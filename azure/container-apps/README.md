# BrokenCrystals - Azure Container Apps Migration

## 1. Project Details

- Source: Linux VPS
- GitHub: https://github.com/BrightSec/brokencrystals
- Azure Resource Group: zt-vulnerable-applications-rg
- Azure Region: Central US
- Container Registry: ztvulnerableappsacr.azurecr.io
- Container Apps Environment: vulnapps-env
- Migration Branch: migration/azure-container-apps

## 2. Current Container Image

- Image: ztvulnerableappsacr.azurecr.io/brokencrystals:v1.0.0
- Application Port: 3000
- Runtime: Node.js 18
- Image Status: Built and pushed to ACR

## 3. Proposed Architecture

### Web Application
- Node.js application
- Public ingress on port 3000
- gRPC-Web proxy
- MailCatcher
- Ollama
- Application PostgreSQL database (architecture pending approval)

### Identity Application
- Keycloak 26.1.2
- Keycloak PostgreSQL database (architecture pending approval)
- Internal or public ingress (pending approval)

## 4. Proposed Scaling

- Minimum replicas: 0
- Maximum replicas: 1
- ACA Consumption workload profile
- Scale-to-zero behavior must be validated.

## 5. Configuration and Secrets

- Use Azure Container Apps secrets for runtime credentials.
- Deliver required application key files through a secure runtime mount.
- Do not copy .env files or private keys into the Docker image.
- Existing exposed credentials and tracked private keys require a coordinated security review before reuse.

## 6. Pending Senior Approval

- Database hosting architecture.
- Whether database data can reset when replicas restart or scale to zero.
- Keycloak ingress requirements.
- MailCatcher and Ollama deployment requirements.
- Azure resource sizing and estimated cost.
- Domain selection:
  - brokencrystals.zerothreat.ai
  - brokencrystal.qtrob.com
- Credential and private-key rotation plan.

## 7. Migration Safety

- Keep the existing VPS application running.
- Do not modify existing vulnerable applications.
- Do not change DNS before successful Azure testing and approval.
- Do not create or modify Azure resources until architecture approval.
- Preserve intentional vulnerabilities and existing application behavior.

## 8. Validation Before Cutover

- Application startup and health checks.
- Database initialization and application connectivity.
- Keycloak authentication.
- gRPC-Web communication.
- Email sending and MailCatcher inspection.
- Ollama fallback chat behavior.
- Scale-to-zero and cold-start behavior.
- Domain and HTTPS validation.

## 9. Current Status

- [x] Docker image built.
- [x] Docker image verified.
- [x] Docker image pushed to ACR.
- [x] Azure deployment folder created.
- [ ] Architecture approval.
- [ ] Deployment configuration.
- [ ] Azure deployment.
- [ ] Application testing.
- [ ] DNS and cutover approval.
