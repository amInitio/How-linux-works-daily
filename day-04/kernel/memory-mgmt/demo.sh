#!/usr/bin/env bash
# Linux System Lab: Code or commands go here
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "🚀 Running Day 04 Lab: Virtual Memory Mapping..."

MY_PID=$$

echo "🔍 Fetching Virtual Memory Layout for current Shell (PID: $MY_PID)..."
echo "----------------------------------------------------------------------"
head -n 10 /proc/$MY_PID/maps
echo "----------------------------------------------------------------------"

echo "💡 Quick Guide on the Output Columns:"
echo "Column 1: Virtual Address Range (Mapped by MMU)"
echo "Column 2: Permissions (r=read, w=write, x=execute, p=private)"
echo "Column 5: Path to the physical binary/library mapped in RAM"
echo "✅ Lab executed successfully!"