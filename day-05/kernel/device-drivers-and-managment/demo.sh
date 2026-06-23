#!/usr/bin/env bash
set -e

echo "🚀 Running Day 04 Lab: Device Driver Layout..."


echo "📦 Inspecting storage block device interface:"
ls -l /dev/nvme0n1 || ls -l /dev/sda

echo "----------------------------------------------------------------------"
echo "⚡ Listing active disk/storage-related kernel device drivers:"
lsmod | grep -E "nvme|sd|block" | head -n 5
echo "----------------------------------------------------------------------"
echo "✅ Lab executed successfully!"