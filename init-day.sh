#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: ./init_day.sh day-XX_topic-name"
    exit 1
fi

DIR_NAME=$1
mkdir -p "$DIR_NAME/lab"
touch "$DIR_NAME/demo.sh"

cat << 'EOF' > "$DIR_NAME/notes.md"
# Day XX: Topic

### 🧠 Mechanism
- 

### 🔍 OS Hook
- 

### 🛠️ Lab & Tools
- 

### ⚠️ Pitfalls
- 
EOF

chmod +x "$DIR_NAME/demo.sh"
echo "✔ Structure for $DIR_NAME created successfully!"
