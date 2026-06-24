#!/usr/bin/env bash
set -e
echo "🔍 Tracing syscalls for process generation..."
echo "----------------------------------------------------------------------"
strace -f -e trace=process,file bash -c "ls /dev/null"
echo "----------------------------------------------------------------------"
echo "✅ Syscall trace finished successfully!"