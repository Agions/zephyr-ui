# CI/CD Setup Guide

## 🚀 Setting Up ZephyrUI Enterprise CI/CD

This guide will help you set up the complete enterprise CI/CD pipeline for your ZephyrUI project.

## 📋 Prerequisites

### Required Accounts
- **GitHub Account**: For repository management
- **Pub.dev Account**: For package publishing
- **Slack Workspace**: For notifications (optional)
- **Codecov Account**: For coverage reporting (optional)

### Required Tokens
- **GitHub Personal Access Token**: For repository operations
- **Pub.dev API Token**: For package publishing
- **Slack Webhook URL**: For notifications
- **Codecov Token**: For coverage reporting

## 🔧 Repository Setup

### 1. Fork or Clone the Repository
```bash
# Clone the repository
git clone https://github.com/your-username/zephyr_ui.git
cd zephyr_ui
```

### 2. Configure GitHub Repository Settings

#### Enable GitHub Actions
1. Go to your repository on GitHub
2. Click on **Settings** → **Actions** → **General**
3. Enable **Allow all actions and reusable workflows**
4. Enable **Allow GitHub Actions to create and approve pull requests**

#### Configure Branch Protection
1. Go to **Settings** → **Branches** → **Branch protection rules**
2. Click **Add rule**
3. Enter **main** as the branch name pattern
4. Enable:
   - **Require a pull request before merging**
   - **Require status checks to pass before merging**
   - **Require branches to be up to date before merging**
   - **Require conversation resolution**
5. Add required status checks:
   - `code-quality`
   - `security`
   - `testing`
   - `build`

### 3. Configure GitHub Secrets

Go to **Settings** → **Secrets and variables** → **Actions** and add the following secrets:

#### Essential Secrets
```bash
# GitHub Token for repository operations
GITHUB_TOKEN=your_github_personal_access_token

# Pub.dev Publishing Token
PUB_DEV_PUBLISH_TOKEN=your_pub_dev_api_token

# Slack Webhook for notifications
SLACK_WEBHOOK_URL=your_slack_webhook_url

# Codecov Token for coverage reporting
CODECOV_TOKEN=your_codecov_token
```

#### Optional Secrets
```bash
# Docker registry credentials
DOCKER_USERNAME=your_docker_username
DOCKER_PASSWORD=your_docker_password

# AWS credentials for deployment
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
```

## 🏗️ Pipeline Configuration

### 1. Verify Workflow Files

Ensure all workflow files are present in `.github/workflows/`:
- `ci.yml` - Main CI/CD pipeline
- `quality.yml` - Quality assurance
- `security.yml` - Security scanning
- `performance.yml` - Performance monitoring
- `docs.yml` - Documentation deployment
- `publish.yml` - Automated publishing

### 2. Configure Analysis Options

Verify `analysis_options.yaml` is properly configured with:
- Enhanced linting rules
- Custom linter configuration
- Performance thresholds
- Security settings

### 3. Set Up Dependency Management

Verify `.github/dependabot.yml` is configured for:
- Daily dependency updates
- Security patching
- Multi-ecosystem support

## 🔍 Testing the Setup

### 1. Run Local Quality Checks
```bash
# Run quality checks
./scripts/quality-check.sh

# Run security scan
./scripts/security-scan.sh

# Test publishing process (dry run)
./scripts/publish.sh
```

### 2. Create Test Pull Request
1. Create a new branch:
   ```bash
   git checkout -b test-ci-setup
   ```
2. Make a small change
3. Commit and push the change
4. Create a pull request
5. Verify all CI/CD checks pass

### 3. Verify Workflow Execution
Check the **Actions** tab in your GitHub repository to ensure:
- All workflows run successfully
- Security scans complete
- Tests pass with adequate coverage
- Builds complete successfully
- Documentation generates correctly

## 🚀 Deployment Configuration

### 1. Configure Publishing

#### Pub.dev Setup
1. Go to [pub.dev](https://pub.dev)
2. Sign in to your account
3. Go to **Account settings** → **API tokens**
4. Create a new API token
5. Add the token to GitHub secrets as `PUB_DEV_PUBLISH_TOKEN`

#### Documentation Deployment
1. Enable GitHub Pages in repository settings
2. Configure GitHub Pages to deploy from `/docs` folder
3. Verify documentation builds correctly

### 2. Configure Notifications

#### Slack Integration
1. Create a Slack app for your workspace
2. Add incoming webhook functionality
3. Create a webhook URL
4. Add the URL to GitHub secrets as `SLACK_WEBHOOK_URL`

#### Email Notifications
1. Configure email notifications in repository settings
2. Set up notification preferences for different events

## 📊 Monitoring and Analytics

### 1. Code Coverage
1. Sign up for [Codecov](https://codecov.io)
2. Connect your GitHub repository
3. Add the Codecov token to GitHub secrets
4. Verify coverage reports appear after test runs

### 2. Security Monitoring
1. Monitor GitHub Dependabot alerts
2. Review CodeQL scanning results
3. Set up security alert notifications

### 3. Performance Monitoring
1. Review performance benchmark results
2. Monitor build times and resource usage
3. Set up performance regression alerts

## 🛠️ Customization

### 1. Custom Lint Rules
Add custom lint rules to `analysis_options.yaml`:
```yaml
custom_linter:
  rules:
    - your_custom_rule
    - another_custom_rule
```

### 2. Environment-Specific Workflows
Create environment-specific workflow files:
```yaml
# .github/workflows/staging.yml
name: Staging Deployment
on:
  push:
    branches: [staging]
```

### 3. Custom Scripts
Add custom scripts to the `scripts/` directory:
```bash
# scripts/custom-check.sh
#!/bin/bash
# Your custom validation logic
```

## 🔧 Troubleshooting

### Common Issues

#### 1. Workflows Not Running
- Check GitHub Actions is enabled
- Verify workflow files are in correct location
- Ensure proper YAML syntax

#### 2. Permission Errors
- Verify GitHub token has necessary permissions
- Check repository access settings
- Ensure proper branch protection rules

#### 3. Test Failures
- Check test dependencies
- Verify test environment setup
- Review test configuration

#### 4. Build Failures
- Check Flutter version compatibility
- Verify all dependencies are available
- Review build configuration

### Debugging Steps

1. **Check Workflow Logs**: Review individual workflow step logs
2. **Verify Secrets**: Ensure all secrets are properly configured
3. **Test Locally**: Run validation scripts locally
4. **Check Dependencies**: Verify all dependencies are compatible
5. **Review Configuration**: Double-check all configuration files

## 📚 Best Practices

### 1. Security
- Rotate secrets regularly
- Use minimal required permissions
- Monitor access logs
- Keep dependencies updated

### 2. Performance
- Monitor build times
- Optimize workflow steps
- Use caching where appropriate
- Parallelize independent tasks

### 3. Maintenance
- Regular dependency updates
- Monitor workflow performance
- Keep documentation current
- Review security reports

### 4. Monitoring
- Set up alert notifications
- Monitor key metrics
- Regular security audits
- Performance benchmarking

## 🚀 Next Steps

1. **Monitor First Run**: Watch the first complete pipeline execution
2. **Configure Notifications**: Set up alert notifications
3. **Establish Monitoring**: Set up dashboards and monitoring
4. **Document Processes**: Document your specific processes
5. **Team Training**: Train team members on the new pipeline

## 📞 Support

If you encounter any issues during setup:

1. **Check Documentation**: Review this guide and other documentation
2. **GitHub Issues**: Check existing issues or create a new one
3. **Community**: Join our community discussions
4. **Email Support**: Contact our support team

---

## 🎉 Congratulations!

You've successfully set up the enterprise CI/CD pipeline for ZephyrUI. Your project now has:

- ✅ Automated quality checks
- ✅ Security scanning
- ✅ Performance monitoring
- ✅ Documentation deployment
- ✅ Automated publishing
- ✅ Comprehensive reporting

The pipeline will now automatically run on every commit and pull request, ensuring only high-quality code makes it to production.