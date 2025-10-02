#!/bin/bash
# Test script for currency_exchange_rate.py
# This script runs multiple tests with different currency pairs and dates

echo "======================================"
echo "Currency Exchange Rate API - Test Script"
echo "======================================"
echo ""

# Array of test cases: from_currency to_currency date
tests=(
    "USD EUR 2025-01-15"
    "MDL USD 2025-03-05"
    "EUR RON 2025-04-25"
    "USD MDL 2025-06-15"
    "RON UAH 2025-08-05"
)

echo "Running ${#tests[@]} test cases..."
echo ""

# Counter for successful tests
success_count=0

# Run each test
for i in "${!tests[@]}"; do
    test_num=$((i + 1))
    echo "Test $test_num/${#tests[@]}: ${tests[$i]}"
    echo "--------------------------------------"
    
    # Run the script
    if python3 currency_exchange_rate.py ${tests[$i]}; then
        ((success_count++))
        echo "✓ Test $test_num passed"
    else
        echo "✗ Test $test_num failed"
    fi
    
    echo ""
done

# Summary
echo "======================================"
echo "Test Summary"
echo "======================================"
echo "Total tests: ${#tests[@]}"
echo "Passed: $success_count"
echo "Failed: $((${#tests[@]} - success_count))"
echo ""

# Test error handling
echo "Testing error handling (invalid date)..."
echo "--------------------------------------"
python3 currency_exchange_rate.py USD EUR 2025-12-25
echo ""

# List created files
echo "======================================"
echo "Created Files"
echo "======================================"
ls -lh data/
echo ""

echo "All tests completed!"
