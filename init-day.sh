#!/usr/bin/env bash
set -e

ENV_FILE=".day_env"

get_env() {
    if [ -f "$ENV_FILE" ]; then
        grep "^$1=" "$ENV_FILE" | cut -d'=' -f2
    else
        echo ""
    fi
}

set_env() {
    touch "$ENV_FILE"
    if grep -q "^$1=" "$ENV_FILE"; then
        sed -i "s/^$1=.*/$1=$2/" "$ENV_FILE"
    else
        echo "$1=$2" >> "$ENV_FILE"
    fi
    
    if [ ! -f .gitignore ] || ! grep -q "$ENV_FILE" .gitignore; then
        echo "$ENV_FILE" >> .gitignore
        echo "🛡️ Added $ENV_FILE to .gitignore"
    fi
}


CURRENT_NUM=$(get_env "CURRENT_DAY")
if [ -n "$CURRENT_NUM" ]; then
    ACTIVE_DAY_DIR="day-$(printf "%02d" "$CURRENT_NUM")"
else
    ACTIVE_DAY_DIR=""
fi


case "$1" in
    set-day)
        if [ -z "$2" ]; then
            echo "❌ Error: Please specify a day number. Example: $0 set-day 1"
            exit 1
        fi
        
        NUM=$2
        DAY_DIR="day-$(printf "%02d" "$NUM")"
        
        mkdir -p "$DAY_DIR"
        set_env "CURRENT_DAY" "$NUM"

        LAST_NUM=$(get_env "LAST_DAY")
        if [ -z "$LAST_NUM" ] || [ "$NUM" -gt "$LAST_NUM" ]; then
            set_env "LAST_DAY" "$NUM"
        fi

        echo "📅 Active day set to: day-$(printf "%02d" "$NUM")/"
        echo "🔝 Latest day tracked: day-$(printf "%02d" "$(get_env "LAST_DAY")")/"
        ;;

    change-day)
        if [ -z "$2" ]; then
            echo "❌ Error: Specify day number, 'last', or 'max'. Example: $0 change-day 5"
            exit 1
        fi

        TARGET=$2
        if [ "$TARGET" = "last" ] || [ "$TARGET" = "max" ]; then
            TARGET=$(get_env "LAST_DAY")
            if [ -z "$TARGET" ]; then
                echo "❌ Error: No days have been tracked yet. Run set-day first."
                exit 1
            fi
        fi

        TARGET_DIR="day-$(printf "%02d" "$TARGET")"
        if [ ! -d "$TARGET_DIR" ]; then
            echo "❌ Error: Directory $TARGET_DIR does not exist."
            exit 1
        fi

        set_env "CURRENT_DAY" "$TARGET"
        echo "🔄 Switched focus to active day: $TARGET_DIR/"
        ;;

    add)
        if [ -z "$ACTIVE_DAY_DIR" ] || [ ! -d "$ACTIVE_DAY_DIR" ]; then
            echo "❌ Error: No active day set or directory missing. Run set-day or change-day."
            exit 1
        fi
        if [ -z "$2" ]; then
            echo "❌ Error: Please specify a topic title. Example: $0 add main-memory"
            exit 1
        fi

        TOPIC_TITLE="$2"
        TARGET_DIR="${ACTIVE_DAY_DIR}/${TOPIC_TITLE}"

        echo "📁 Creating standard topic structure in: $TARGET_DIR..."
        mkdir -p "$TARGET_DIR/lab"

        cat << 'EOF' > "$TARGET_DIR/demo.sh"
#!/usr/bin/env bash
# Linux System Lab: Code or commands go here
set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$DIR/lab"
echo "🚀 Running lab environment in $LAB_DIR..."
EOF
        chmod +x "$TARGET_DIR/demo.sh"

        cat << EOF > "$TARGET_DIR/notes-fa.md"
# ${ACTIVE_DAY_DIR^^} - ${TOPIC_TITLE^} (فارسی)

### 🧠 Mechanism (مکانیزم داخلی لینوکس)
- 

### 🔍 OS Hook (ردپای سیستم‌عامل)
- 

### 🛠️ Lab & Tools (آزمایشگاه و ابزارها)
- 

### ⚠️ Pitfalls (اشتباهات رایج)
- 
EOF

        cat << EOF > "$TARGET_DIR/notes-en.md"
# ${ACTIVE_DAY_DIR^^} - ${TOPIC_TITLE^} (English)

### 🧠 Mechanism
- 

### 🔍 OS Hook
- 

### 🛠️ Lab & Tools
- 

### ⚠️ Pitfalls
- 
EOF
        echo "✅ Successfully initialized: $TARGET_DIR/"
        ;;

    add-root)
        if [ -z "$ACTIVE_DAY_DIR" ] || [ ! -d "$ACTIVE_DAY_DIR" ]; then
            echo "❌ Error: No active day set. Run set-day or change-day first."
            exit 1
        fi
        if [ -z "$2" ]; then
            echo "❌ Error: Specify a root directory name. Example: $0 add-root kernel"
            exit 1
        fi
        
        ROOT_DIR="${ACTIVE_DAY_DIR}/$2"
        mkdir -p "$ROOT_DIR"
        echo "📁 Created empty root directory: $ROOT_DIR/"
        ;;

    add-sub)
        if [ -z "$ACTIVE_DAY_DIR" ] || [ ! -d "$ACTIVE_DAY_DIR" ]; then
            echo "❌ Error: No active day set."
            exit 1
        fi
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "❌ Error: Usage: $0 add-sub <root_dir> <sub_topic>"
            echo "   Example: $0 add-sub kernel processes"
            exit 1
        fi

        ROOT_DIR="${ACTIVE_DAY_DIR}/$2"
        SUB_TOPIC="$3"
        TARGET_DIR="${ROOT_DIR}/${SUB_TOPIC}"

        if [ ! -d "$ROOT_DIR" ]; then
            echo "❌ Error: Parent directory '$ROOT_DIR' does not exist. Run add-root first."
            exit 1
        fi

        echo "📁 Creating structured sub-topic in: $TARGET_DIR..."
        mkdir -p "$TARGET_DIR/lab"

        cat << 'EOF' > "$TARGET_DIR/demo.sh"
#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$DIR/lab"
echo "🚀 Running sub-topic lab environment..."
EOF
        chmod +x "$TARGET_DIR/demo.sh"

        cat << EOF > "$TARGET_DIR/notes-fa.md"
# ${ACTIVE_DAY_DIR^^} -> ${2^^} -> ${SUB_TOPIC^} (فارسی)

### 🧠 Mechanism (مکانیزم داخلی لینوکس)
- 

### 🔍 OS Hook (ردپای سیستم‌عامل)
- 

### 🛠️ Lab & Tools (آزمایشگاه و ابزارها)
- 

### ⚠️ Pitfalls (اشتباهات رایج)
- 
EOF

        cat << EOF > "$TARGET_DIR/notes-en.md"
# ${ACTIVE_DAY_DIR^^} -> ${2^^} -> ${SUB_TOPIC^} (English)

### 🧠 Mechanism
- 

### 🔍 OS Hook
- 

### 🛠️ Lab & Tools
- 

### ⚠️ Pitfalls
- 
EOF
        echo "✅ Successfully initialized sub-topic: $TARGET_DIR/"
        ;;

    *)
        echo "💡 Usage:"
        echo "  $0 set-day <num>                 -> Create and/or focus on a specific day"
        echo "  $0 change-day <num|last|max>     -> Switch focus to a previous day or max/last day"
        echo "  $0 add <title>                   -> Standard generation directly in active day"
        echo "  $0 add-root <dir_name>           -> Create an empty root folder inside active day"
        echo "  $0 add-sub <root_dir> <title>    -> Create structured topic inside the root folder"
        
        if [ -n "$CURRENT_NUM" ]; then
            echo -e "\n📍 Current Focus: day-$(printf "%02d" "$CURRENT_NUM")/"
        fi
        exit 1
        ;;
esac