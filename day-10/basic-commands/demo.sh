#!/usr/bin/env bash
set -e

echo "🚀 Running Day 10 Lab: Basic Commands & Filesystem Tracing..."
echo "----------------------------------------------------------------------"

echo "📝 Step 1: Testing touch metadata behavior..."
touch test_file.txt
echo "Initial file status:"
ls -l test_file.txt

echo "⏳ Waiting 2 seconds..."
sleep 2

touch test_file.txt
echo "Status after second touch (Notice the time change but size stays 0):"
ls -l test_file.txt
echo "----------------------------------------------------------------------"

echo "📊 Step 2: Tracking Inodes for cp vs mv..."
echo "Original Inode:"
ls -i test_file.txt

cp test_file.txt copied_file.txt
echo "Copied File Inode (Different Inode = New File on disk):"
ls -i copied_file.txt

mv test_file.txt moved_file.txt
echo "Moved File Inode (Same as Original Inode = Data didn't move!):"
ls -i moved_file.txt
echo "----------------------------------------------------------------------"

echo "🧹 Cleaning up lab files using rm..."
rm copied_file.txt moved_file.txt
echo "✅ Lab executed successfully!"