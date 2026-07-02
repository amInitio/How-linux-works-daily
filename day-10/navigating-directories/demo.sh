#!/usr/bin/env bash
set -e

echo "🚀 Running Day 10 Lab: Directory Navigation & Globbing..."
echo "----------------------------------------------------------------------"

echo "📂 Step 1: Testing directory creation and parent pointers..."
mkdir -p test_dir/nested_sub
echo "Current directory tree created."
cd test_dir
echo "Moved inside: $(pwd)"
cd ..
echo "Moved back using '..' pointer: $(pwd)"
echo "----------------------------------------------------------------------"

echo "⚠️ Step 2: Testing rmdir restriction..."
echo "Attempting to remove a non-empty directory using rmdir:"
rmdir test_dir || echo "❌ System blocked rmdir because the directory is not empty! (Expected Behavior)"
echo "----------------------------------------------------------------------"

echo "🕵️ Step 3: Proving Wildcard Behavior (* vs ?)..."
cd test_dir
touch boat.txt brat.txt boot1.txt

echo "1) Testing Asterisk [echo b*]:"
echo b*
echo "👆 Matches everything starting with 'b' regardless of length."
echo ""

echo "2) Testing Question Mark [echo b?at.txt]:"
echo b?at.txt
echo "👆 Matches exactly 1 character placeholder (boat and brat, but skips boot1)."
echo ""

echo "3) Running quoted literal [echo '*']:"
echo '*'
echo "👆 Inside quotes, Bash globbing is disabled. We get the raw star symbol!"
cd ..

echo "----------------------------------------------------------------------"
echo "🧹 Cleaning up everything recursively using rm -rf..."
rm -rf test_dir
echo "✅ Lab executed successfully!"