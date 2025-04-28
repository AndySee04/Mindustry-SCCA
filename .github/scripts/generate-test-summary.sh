#!/bin/bash

echo "# Test Summary" > reports/test-summary.md
echo "Test Run Timestamp: $(date -u)" >> reports/test-summary.md

# Gradle puts XML files into build/test-results/test/TEST-*.xml
# We can count total tests by looking into those files.

if [ -d "build/test-results/test" ]; then
    TOTAL=$(grep -o 'tests="[^"]*"' build/test-results/test/*.xml | sed 's/tests="//;s/"//' | paste -sd+ - | bc)
    FAILED=$(grep -o 'failures="[^"]*"' build/test-results/test/*.xml | sed 's/failures="//;s/"//' | paste -sd+ - | bc)
    SKIPPED=$(grep -o 'skipped="[^"]*"' build/test-results/test/*.xml | sed 's/skipped="//;s/"//' | paste -sd+ - | bc)
    PASSED=$((TOTAL - FAILED - SKIPPED))

    echo "Tests Run: $TOTAL" >> reports/test-summary.md
    echo "Tests Passed: $PASSED" >> reports/test-summary.md
    echo "Tests Failed: $FAILED" >> reports/test-summary.md
    echo "Tests Skipped: $SKIPPED" >> reports/test-summary.md
else
    echo "Tests Run: 0" >> reports/test-summary.md
    echo "Tests Passed: 0" >> reports/test-summary.md
    echo "Tests Failed: 0" >> reports/test-summary.md
    echo "Tests Skipped: 0" >> reports/test-summary.md
fi

echo "" >> reports/test-summary.md
echo "Full HTML report available at build/reports/tests/test/index.html" >> reports/test-summary.md
