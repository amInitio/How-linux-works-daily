#!/usr/bin/env bash
set -e

echo "🚀 Running Day 14 Lab: I/O Redirection & Error Anatomy..."
echo "----------------------------------------------------------------------"

# 1. Test separate redirection of stdout and stderr
echo "📝 Step 1: Separating stdout (Channel 1) and stderr (Channel 2)..."
# Generating a success stream and a failure stream on purpose
ls /etc/passwd /non_existent_path > output.log 2> error.log || true

echo "Contents of output.log (stdout tracking):"
cat output.log
echo "Contents of error.log (stderr tracking):"
cat error.log
echo "----------------------------------------------------------------------"

# 2. Test stream merging (2>&1)
echo "📊 Step 2: Merging both streams into a single log file..."
ls /etc/passwd /another_fake_path > combined.log 2>&1 || true

echo "Contents of combined.log (Both streams united):"
cat combined.log
echo "----------------------------------------------------------------------"

# 3. Simulate structural filesystem errors
echo "🕵️ Step 3: Forcing a 'Not a directory' structural error..."
touch regular_file.txt
echo "Attempting to treat a regular file like a directory path context:"
# Temporarily turning off 'set -e' to gracefully capture the error output
set +e
touch regular_file.txt/nested_file.log 2> structural_error.log
set -e

cat structural_error.log
echo "----------------------------------------------------------------------"

# Clean up
echo "🧹 Cleaning up generated lab log artifacts..."
rm -f output.log error.log combined.log regular_file.txt structural_error.log
echo "✅ Lab executed successfully!"