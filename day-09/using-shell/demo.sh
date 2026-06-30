#!/usr/bin/env bash
set -e

echo "🚀 Running Day 09 Lab: Shell Basics & Streams..."

echo "----------------------------------------------------------------------"
echo "🔗 Checking /bin/sh symlink target:"
ls -l /bin/sh
echo "----------------------------------------------------------------------"

echo "💡 Interactive Lab Instruction:"
echo "We will now run 'cat' without files. It will read from your keyboard (stdin)"
echo "and output right back to your terminal screen (stdout)."
echo ""

echo "👉 Type a few words, press ENTER to see it mirror."
echo "👉 When done, press [Ctrl+D] on a new line to exit gracefully."
echo "----------------------------------------------------------------------"

cat

echo "----------------------------------------------------------------------"
echo "✅ Lab executed successfully!"
echo "Becuase you entered CRTL+D you can see me. (CRTL+D just ends the stream)"
echo "Next time enter CRTL+C to terminate the hole proccess"