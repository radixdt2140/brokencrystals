# BrokenCrystals - Deployment Checklist

## A. Pre-deployment

- [x] Docker image built successfully.
- [x] Docker image verified.
- [x] Docker image pushed to Azure Container Registry.
- [x] Docker image excludes local .env files.
- [x] Docker image excludes config/keys private files.
- [ ] Senior architecture approval received.
- [ ] Database hosting strategy finalized.
- [ ] Data persistence and reset behavior approved.
- [ ] Azure cost and resource sizing approved.

## B. Application Configuration

- [ ] Configure production environment variables.
- [ ] Configure DATABASE_HOST and database credentials.
- [ ] Configure Keycloak connection URL and credentials.
- [ ] Configure JWT and JWK key-file delivery.
- [ ] Configure GRPC_WEB_PROXY_URL.
- [ ] Configure MailCatcher SMTP and API endpoints.
- [ ] Configure Ollama endpoint and model.
- [ ] Configure URL for the Azure application hostname.
- [ ] Set ENABLE_HTTPS=false.
- [ ] Set ENABLE_CLUSTER=false.

## C. Azure Deployment

- [ ] Create approved database resources.
- [ ] Create Keycloak Container App.
- [ ] Create BrokenCrystals web Container App.
- [ ] Configure internal service communication.
- [ ] Configure Container Apps secrets.
- [ ] Configure health probes.
- [ ] Configure ingress and scaling.
- [ ] Verify container startup.

## D. Application Testing

- [ ] Verify application homepage.
- [ ] Verify /api/config.
- [ ] Verify authentication with Keycloak.
- [ ] Verify database connectivity.
- [ ] Verify gRPC-Web functionality.
- [ ] Verify email functionality.
- [ ] Verify MailCatcher email inspection.
- [ ] Verify Ollama fallback chat.
- [ ] Verify intentional vulnerable test cases.
- [ ] Verify cold start after scale-to-zero.

## E. Domain and Cutover

- [ ] Senior approves domain selection.
- [ ] Configure approved custom domain.
- [ ] Configure HTTPS.
- [ ] Complete end-to-end testing.
- [ ] Obtain cutover approval.
- [ ] Update DNS.
- [ ] Verify production domain.
- [ ] Keep VPS available until migration is confirmed.

## Safety Rules

- Never modify the existing VPS deployment without approval.
- Never modify other vulnerable applications.
- Never reuse exposed credentials or private keys without a security review.
- Never delete backups before migration validation.
- Never change DNS before cutover approval.
