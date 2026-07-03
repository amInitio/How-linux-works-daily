#!/usr/bin/env bash
set -e

echo "🚀 Running Day 11 Lab: Intermediate Commands & Pipeline Tracing..."
echo "----------------------------------------------------------------------"

echo "📊 Step 1: Testing Pipeline Combinations (Extracting from /etc/passwd)..."
echo "Sorting passwd file, extracting lines with 'root' or 'systemd', showing top 2 rows:"
sort /etc/passwd | grep -E "root|systemd" | head -n 2
echo "----------------------------------------------------------------------"

echo "🔍 Step 2: Testing 'file' type detection..."
echo "Creating an extensionless dummy file containing text..."
echo "Hello Arch Linux User" > dummy_resource
file dummy_resource
echo "----------------------------------------------------------------------"

echo "📝 Step 3: Testing 'diff -u' outputs..."
echo -e "Line 1\nLine 2\nLine 3" > file1.txt
echo -e "Line 1\nLine 2 Modified\nLine 3" > file2.txt

echo "Displaying unified difference between file1 and file2:"
diff -u file1.txt file2.txt || echo "💡 (diff returns non-zero when differences are found, which is normal)"

echo "----------------------------------------------------------------------"
echo "🧹 Cleaning up lab artifacts..."
rm dummy_resource file1.txt file2.txt
echo "✅ Lab executed successfully!"


