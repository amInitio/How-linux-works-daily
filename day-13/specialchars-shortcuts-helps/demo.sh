#!/usr/bin/env bash
set -e

echo "🚀 Running Day 13 Lab: Manual Pages & Shell Interfaces..."
echo "----------------------------------------------------------------------"

# 1. Keyword lookup
echo "🔍 Step 1: Running keyword lookup for 'sort' utilities (man -k)..."
# Using head to prevent flooding the terminal screen
man -k sort | head -n 5
echo "----------------------------------------------------------------------"

# 2. Demonstrate section difference without locking the terminal
echo "📄 Step 2: Extracting descriptive summaries from different sections..."
echo "A) Section 1 Summary (User Command):"
man 1 passwd | head -n 5 | grep -E "passwd" || echo "   -> Retrieved command reference section."

echo ""
echo "B) Section 5 Summary (System Config File Format):"
man 5 passwd | head -n 5 | grep -E "passwd" || echo "   -> Retrieved file format configuration section."

echo "----------------------------------------------------------------------"
echo "💡 Readline Tip Remembered:"
echo "Avoid using hardware arrow keys on the terminal command line."
echo "Use [Ctrl+A] to jump to the front and [Ctrl+E] to jump to the end!"
echo "----------------------------------------------------------------------"
echo "✅ Lab executed successfully!"