#!/usr/bin/env bash
# Linux System Lab: Code or commands go here

set -e


DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$DIR/lab"

echo "Starting Day 02 Lab: Memory Image Extraction..."


mkdir -p "$LAB_DIR"
rm -f "$LAB_DIR/sleep_memory.img"

echo "Step 1: Spawning background sleep process..."
sleep 1000 &
PID=$!
echo "   Active Process PID: $PID"


sleep 1

echo "Step 2: Sending SIGSEGV (Signal 11) to force a crash..."

set +e
kill -11 $PID
set -e


sleep 2

echo "Step 3: Extracting physical memory image via coredumpctl..."
coredumpctl dump $PID -o "$LAB_DIR/sleep_memory.img" --quiet

echo "Step 4: Extracting live strings from the binary image..."
echo "--------------------------------------------------------"
strings "$LAB_DIR/sleep_memory.img" | grep -E "PATH=|XDG_" | head -n 5
echo "--------------------------------------------------------"

echo "Step 5 : Extracting Hex codes from binary image..."
echo "--------------------------------------------------------"
hexdump -C $LAB_DIR/sleep_memory.img | head -n 20
echo "--------------------------------------------------------"

echo "Lab finished successfully! Raw image saved in: day-02/main-memory/lab/sleep_memory.img"
