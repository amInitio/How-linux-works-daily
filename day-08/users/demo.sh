#!/usr/bin/env bash
set -e

echo "🚀 Running Day 08 Lab: Users & UID Inspection..."
echo "----------------------------------------------------------------------"

# 1. Display the numeric UID and group associations of the active user
echo "Current User Identity Details:"
id

echo "----------------------------------------------------------------------"

# 2. Extract and verify root's numerical mapping from the system database
echo "Checking Root's UID mapping in system:"
grep "^root:" /etc/passwd

echo "----------------------------------------------------------------------"

# 3. Observe how the active shell process enforces and reflects your numeric UID
echo "Current Shell Process User IDs:"
ps -o pid,uid,user,cmd -p $$

echo "----------------------------------------------------------------------"
echo " Lab executed successfully!"