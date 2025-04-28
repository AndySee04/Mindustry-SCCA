#!/bin/bash
mkdir -p reports
START_TIME=$(date +%s)

echo "# Deployment Report" > reports/deployment-report.md
echo "Deployment Timestamp: $(date -u)" >> reports/deployment-report.md
echo "GitHub Workflow Name: ${{ GITHUB_WORKFLOW }}" >> reports/deployment-report.md
echo "" >> reports/deployment-report.md

echo "# Environment Information" >> reports/deployment-report.md
echo "Docker Version: $(docker --version)" >> reports/deployment-report.md
echo "OS: $(uname -a)" >> reports/deployment-report.md
echo "" >> reports/deployment-report.md

echo "# Docker Images" >> reports/deployment-report.md
echo "Client Image: amiwhatiam/mindustry-client" >> reports/deployment-report.md
echo "Server Image: amiwhatiam/mindustry-server" >> reports/deployment-report.md
echo "" >> reports/deployment-report.md

echo "# Build Information" >> reports/deployment-report.md
echo "Build Status: SUCCESS" >> reports/deployment-report.md
echo "Release Tag: $GITHUB_REF" >> reports/deployment-report.md
echo "Git Commit: $GITHUB_SHA" >> reports/deployment-report.md
echo "" >> reports/deployment-report.md

echo "# Docker Push Information" >> reports/deployment-report.md
echo "Client Image Digest: ${{ steps.push-client.outputs.digest }}" >> reports/deployment-report.md
echo "Server Image Digest: ${{ steps.push-server.outputs.digest }}" >> reports/deployment-report.md
echo "" >> reports/deployment-report.md

END_TIME=$(date +%s)
DEPLOY_DURATION=$((END_TIME - START_TIME))
echo "" >> reports/deployment-report.md
echo "# Deployment Duration" >> reports/deployment-report.md
echo "Deployment Duration: ${DEPLOY_DURATION} seconds" >> reports/deployment-report.md
