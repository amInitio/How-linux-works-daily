#!/usr/bin/env bash
# Linux System Lab: Code or commands go here

echo "🚀 Running lab environment..."

dmesg  # Permission error => We cant access directly to kernel we should use system calls like dmesg 

sudo dmesg | head -n 20 # agian we use this command with higher permission level

# using head -n 20  here helps us to get just first 20 lines of result .