#!/usr/bin/env bash
set -e

DAY_FILE=".current_day"

case "$1" in
    set-day)
        if [ -z "$2" ]; then
            echo "❌ Error: Please specify a day number. Example: $0 set-day 1"
            exit 1
        fi
        
        DAY_DIR="day-$(printf "%02d" "$2")"
        
        mkdir -p "$DAY_DIR"
        echo "$DAY_DIR" > "$DAY_FILE"
        echo "📅 Active day directory set to: $DAY_DIR/"
        ;;

    add)
        if [ ! -f "$DAY_FILE" ] || [ ! -d "$(cat $DAY_FILE)" ]; then
            echo "❌ Error: Active day directory does not exist. Run '$0 set-day <number>' first."
            exit 1
        fi
        if [ -z "$2" ]; then
            echo "❌ Error: Please specify a topic title. Example: $0 add levels-of-abstraction"
            exit 1
        fi

        PARENT_DAY_DIR=$(cat "$DAY_FILE")
        TOPIC_TITLE="$2"
        TARGET_DIR="${PARENT_DAY_DIR}/${TOPIC_TITLE}"

        echo "📁 Creating sub-topic structure in: $TARGET_DIR..."
        mkdir -p "$TARGET_DIR/lab"

        cat << 'EOF' > "$TARGET_DIR/demo.sh"
#!/usr/bin/env bash
# Linux System Lab: Code or commands go here

echo "🚀 Running lab environment..."
EOF
        chmod +x "$TARGET_DIR/demo.sh"

        cat << EOF > "$TARGET_DIR/notes.md"
# ${PARENT_DAY_DIR^^} - ${TOPIC_TITLE^}

<div dir="rtl">

### 🧠 Mechanism (مکانیزم داخلی لینوکس)
- 

### 🔍 OS Hook (ردپای سیستم‌عامل)
- 

### 🛠️ Lab & Tools (آزمایشگاه و ابزارها)
- 

### ⚠️ Pitfalls (اشتباهات رایج)
- 

</div>

---

### 🧠 Mechanism
- 

### 🔍 OS Hook
- 

### 🛠️ Lab & Tools
- 

### ⚠️ Pitfalls
- 
EOF

        echo -e "✅ Successfully initialized: $TARGET_DIR/"
        ;;

    *)
        echo "💡 Usage:"
        echo "  $0 set-day <number>   -> Create & set the active day folder (e.g., day-01/)"
        echo "  $0 add <title>        -> Add a sub-topic inside the active day folder"
        echo -e "\nExample workflow:"
        echo "  $0 set-day 1"
        echo "  $0 add abstraction"
        echo "  $0 add memory-hardware"
        exit 1
        ;;
esac