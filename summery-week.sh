#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
    echo "❌ Error: Please specify the week number."
    echo "Usage: $0 <week_number> (e.g., $0 2)"
    exit 1
fi

WEEK_NUM=$1
DIR_NAME="week-${WEEK_NUM}"

echo "🚀 Creating structure for ${DIR_NAME}..."

mkdir -p "${DIR_NAME}"

touch "${DIR_NAME}/notes-fa.md"
touch "${DIR_NAME}/notes-en.md"


echo "✅ Done! Created:"
echo "  📁 ${DIR_NAME}/notes-fa.md"
echo "  📁 ${DIR_NAME}/notes-en.md"
