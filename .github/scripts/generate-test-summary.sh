#!/bin/bash

echo "# Test Summary" > test-summary.md
echo "Test Run Timestamp: $(date -u)" >> test-summary.md

# Gradle puts XML files into build/test-results/test/TEST-*.xml
# We can count total tests by looking into those files.

if [ -d "build/test-results/test" ]; then
    TOTAL=$(grep -o 'tests="[^"]*"' build/test-results/test/*.xml | sed 's/tests="//;s/"//' | paste -sd+ - | bc)
    FAILED=$(grep -o 'failures="[^"]*"' build/test-results/test/*.xml | sed 's/failures="//;s/"//' | paste -sd+ - | bc)
    SKIPPED=$(grep -o 'skipped="[^"]*"' build/test-results/test/*.xml | sed 's/skipped="//;s/"//' | paste -sd+ - | bc)
    PASSED=$((TOTAL - FAILED - SKIPPED))

    echo "Tests Run: $TOTAL" >> test-summary.md
    echo "Tests Passed: $PASSED" >> test-summary.md
    echo "Tests Failed: $FAILED" >> test-summary.md
    echo "Tests Skipped: $SKIPPED" >> test-summary.md
else
    echo "Tests Run: 0" >> test-summary.md
    echo "Tests Passed: 0" >> test-summary.md
    echo "Tests Failed: 0" >> test-summary.md
    echo "Tests Skipped: 0" >> test-summary.md
fi

echo "" >> test-summary.md
echo "Full HTML report available at build/reports/tests/test/index.html" >> test-summary.md
