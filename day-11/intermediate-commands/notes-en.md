# DAY-11 - Intermediate-commands (English)

### 🧠 Mechanism
- **Pipeline Filtering:** Linux intermediate commands are designed as modular utilities. The core mechanics lie in passing standard streams (`stdin`/`stdout`) via the pipe operator (`|`) sequentially between programs to transform raw streams into clean output data.

### 🔍 OS Hook
- **Metadata and System Index Engines:** Utilities like `file` query filesystem layers by inspecting magic bytes within headers, while `locate` avoids active disk-sweeping by consulting a pre-built local index database.

### 💻 Commands Reference

| Command | Options | Summary |
| :--- | :--- | :--- |
| **`grep`** | `-i` (case-insensitive) <br> `-v` (invert match) <br> `-E` or `egrep` (extended regex) | Searches and extracts lines matching a pattern from files or input streams. |
| **`less`** | `/word` (search forward) <br> `?word` (search backward) <br> `space`/`b` (page navigation) / `q` (quit) | Interactively pages through and navigates large files or long command outputs. |
| **`pwd`** | `-P` (physical path, resolves and strips symbolic links) | Prints the absolute current working directory of the process. |
| **`diff`** | `-u` (unified format, preferred for automated patches) | Compares two text files line-by-line and outputs the exact discrepancies. |
| **`file`** | No specific core options | Inspects file headers to safely identify the true file format type. |
| **`find`** | `dir -name 'pattern' -print` | Conducts a live, real-time directory tree scan matching filenames under patterns. |
| **`locate`** | No specific core options | Queries a pre-built index database for ultra-fast filename location. |
| **`head`** | `-n` (specifies explicit line counts from the top) | Outputs the beginning lines of a target file or data stream (default 10). |
| **`tail`** | `-n` (specifies explicit line counts from the bottom) <br> `+n` (outputs starting from line n to the end) | Outputs the trailing lines of a target file or data stream (default 10). |
| **`sort`** | `-n` (evaluates based on numeric value) <br> `-r` (reverses sort order) | Sorts text or numerical lines within a file or redirected stream. |

### 🛠️ Lab & Tools
**Hands-on Lab: Pipeline Text Transformation and Filtering Traces**

In this lab, we describe the validation logic handled inside the companion `demo.sh` script to witness cross-utility cooperation:

1. **Combined Filtering:** We extract and parse system logs or configs using `grep`, isolating specific lines using `head` and `tail`.
2. **File Format Diagnostics:** We invoke `file` on an extensionless resource to prove header-based type determination.
3. **Differential Output Audits:** We generate two slightly altered text files and parse their runtime layout differences via `diff -u`.

**Locate and Find Commands Difference Workshop:**

1. Choose one of the older files on the system
2. Use the locate command to find it
```bash
locate FILE
```

3. Now use the find command
```Bash
find DIR -name file -print
```
   
4. At this stage, create a new file
```Bash
touch new_file
```

5. Use both locate and find commands again.

You will see that this time the locate command is not useful. Because your new file is too new to be indexed.

### ⚠️ Pitfalls
- **The Stale Cache Cache of `locate`:** The `locate` tool cannot detect newly created files until the background index task runs. Use `find` for real-time validation of recent files.
- **The Quoting Oversight in `find`:** Neglecting single quotes around wildcard characters in `find` parameters (e.g., omitting quotes in `-name *.txt`) triggers pre-execution shell globbing expansion, corrupting the tool's runtime argument layout.