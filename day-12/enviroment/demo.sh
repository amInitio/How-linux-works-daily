#!/usr/bin/env bash
set -e

echo "🚀 Running Day 12 Lab: Password, Dotfiles & Environment variables..."
echo "----------------------------------------------------------------------"

# 1. Test Dotfiles visibility
echo "📝 Step 1: Testing hidden dotfiles behavior..."
touch .hidden_dummy.txt
echo "Listing directory WITHOUT -a (should NOT show the hidden file):"
ls | grep hidden_dummy || echo "🔍 (File is hidden successfully)"
echo ""
echo "Listing directory WITH -a:"
ls -a | grep .hidden_dummy
echo "----------------------------------------------------------------------"

# 2. Test Shell vs Environment Variable Isolation
echo "📊 Step 2: Testing variable inheritance..."
LOCAL_VAR="I am local to this shell"
export ENV_VAR="I am exported globally"

echo "Creating a quick child process to test variable access:"
bash -c '
echo "  [Child Process Context]"
echo "  Accessing LOCAL_VAR: [$LOCAL_VAR] (Should be empty)"
echo "  Accessing ENV_VAR: [$ENV_VAR] (Should print the value)"
'
echo "----------------------------------------------------------------------"

# 3. Test PATH modification safety check
echo "🕵️ Step 3: Demonstrating PATH variable inspection..."
echo "Your current command search paths (PATH):"
echo "$PATH" | tr ':' '\n' | head -n 3
echo "... (showing top 3 search directories)"

echo "----------------------------------------------------------------------"
# Clean up
echo "🧹 Cleaning up lab dotfiles..."
rm .hidden_dummy.txt
echo "✅ Lab executed successfully!"