#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
    echo "🔑 Root privileges required for system-wide D-Bus monitoring."
    echo "🔄 Escalating privileges via sudo..."
    exec sudo "$0" "$@"
fi

echo "🚀 Running Day 07 Lab: User Space Inspection..."
echo "----------------------------------------------------------------------"
echo "📊 Real User-Space Process Tree (Top 10):"
ps -ef | grep -v '\[.*\]' | head -n 10

echo "----------------------------------------------------------------------"
echo "🚌 Monitoring active User Space Bus signals (Capturing for 3 seconds)..."
timeout 3s dbus-monitor --system "type='signal'" || echo "⚠️ D-Bus monitor interrupted or skipped."
echo "----------------------------------------------------------------------"
echo "✅ Lab executed successfully!"