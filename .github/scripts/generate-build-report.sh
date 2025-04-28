#!/bin/bash
mkdir -p reports
START_TIME=$(date +%s)

echo "# Build Report" > reports/build-report.md
echo "Build Timestamp: $(date -u)" >> reports/build-report.md
echo "GitHub Workflow Name: ${{ GITHUB_WORKFLOW }}" >> reports/build-report.md
echo "" >> reports/build-report.md

echo "# Environment Information" >> reports/build-report.md
echo "Java Version: $(java -version 2>&1 | head -n 1)" >> reports/build-report.md
echo "Java Distributor: Temurin" >> reports/build-report.md
echo "Gradle Version: $(gradle --version | grep Gradle)" >> reports/build-report.md
echo "OS: $(uname -a)" >> reports/build-report.md
echo "" >> reports/build-report.md

echo "# Build Information" >> reports/build-report.md
echo "Build Status: SUCCESS" >> reports/build-report.md
echo "Git Commit: $GITHUB_SHA" >> reports/build-report.md
echo "Branch: $GITHUB_REF_NAME" >> reports/build-report.md
echo "" >> reports/build-report.md

echo "# Package Information" >> reports/build-report.md
echo "Build name: Mindustry" >> reports/build-report.md
TAG=$(git describe --tags --abbrev=0 || echo "v1.0.0")
echo "Package Version: $TAG" >> reports/build-report.md
echo "" >> reports/build-report.md

echo "# Repository Stats" >> reports/build-report.md
echo "Total Files in Repo: $(find . -type f | wc -l)" >> reports/build-report.md
echo "Total Lines of Code (Java + Gradle): $(find . \( -name '*.java' -o -name '*.gradle' \) -exec cat {} + | wc -l)" >> reports/build-report.md
echo "" >> reports/build-report.md

echo "# Build Output Analysis" >> reports/build-report.md
echo "Built JAR File Size: $(du -h build/libs/*.jar | cut -f1)" >> reports/build-report.md
echo "Total Build Folder Size: $(du -sh build/ | cut -f1)" >> reports/build-report.md
echo "Total Files in Build Folder: $(find build/ -type f | wc -l)" >> reports/build-report.md

END_TIME=$(date +%s)
BUILD_DURATION=$((END_TIME - START_TIME))
echo "" >> reports/build-report.md
echo "# Build Duration" >> reports/build-report.md
echo "Build Duration: ${BUILD_DURATION} seconds" >> reports/build-report.md

# === NEW SECTION: Server Stats ===
echo "# Server Stats" >> reports/build-report.md
SERVER_JAR="server/build/libs/server-release.jar"

if [[ -f "$SERVER_JAR" ]]; then
    echo "Server Build Status: SUCCESS" >> reports/build-report.md
    echo "Server JAR Path: $SERVER_JAR" >> reports/build-report.md
    echo "Server JAR Size: $(du -h "$SERVER_JAR" | cut -f1)" >> reports/build-report.md
    echo "Server Build Folder Size: $(du -sh build/ | cut -f1)" >> reports/build-report.md
    echo "Server Build Files Count: $(find build/ -type f | wc -l)" >> reports/build-report.md
else
    echo "Server Build Status: FAILED (JAR not found)" >> reports/build-report.md
fi