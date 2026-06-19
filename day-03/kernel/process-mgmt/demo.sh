#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[+] Running Day 02 Lab: Context Switch Tracer..."

if ! command -v pidstat &> /dev/null; then
    echo "pidstat not found. Installing sysstat package via pacman..."
    sudo pacman -S --noconfirm sysstat
fi

echo "Step 1: Simulating aggressive CPU load..."
sha256sum /dev/zero &
LOAD_PID=$!

sleep 1

echo "Step 2: Intercepting Involuntary Context Switches (Time Slice Expirations)..."
echo "--------------------------------------------------------"
pidstat -w -p $LOAD_PID 1 3
echo "--------------------------------------------------------"

echo "Step 3: Cleaning up simulated loads..."
kill $LOAD_PID

echo "[+] Lab execution finished successfully!"