# DAY-12 - Enviroment (English)

### 🧠 Mechanism
- **The Nature of Dotfiles:** Files and folders beginning with a dot (`.`) possess no special physical attributes within the filesystem layout. They are masked by convention by user-space utilities to prevent cluttering the home workspace.
- **Shell vs. Environment Variables:**
  - **Shell Variable:** Localized strictly to the active shell context; sub-processes or executed binaries cannot access them.
  - **Environment Variable (`export`):** Passed explicitly by the operating system into the environment block allocation of every sub-process spawned from this shell.
- **The `PATH` Search Mechanism:** A colon-separated (`:`) list of system directories. When a command is invoked, the shell scans these paths from left to right, executing the first matching executable binary descriptor it encounters.





### 🔍 OS Hook
- **The Process Environment Table:** Upon process instantiation, the Linux kernel copies the exported environment variables of the parent shell into the upper memory limits of the newly spawned process. Modifications made inside the child process do not reflect back into the parent workspace.

### 💻 Commands Reference

| Command | Options / Patterns | Summary |
| :--- | :--- | :--- |
| **`passwd`** | No core flags | Changes the active user's system authentication password. |
| **`chsh`** | No core flags | Modifies the default login shell configuration for the user account. |
| **`ls -a`** | `-a` (list all entries) | Lists all directory contents, forcing the inclusion of hidden dotfiles. |
| **`.*`** | Glob pattern | Matches dotfiles (Warning: naturally encompasses `.` and `..`). |
| **`.[^.]*`** | Advanced glob pattern | Matches dotfiles safely while excluding the current (`.`) and parent (`..`) directories. |
| **`export`** | `export VAR=value` | Promotes a standard local shell variable into a global environment variable. |


# 💡 The Core Difference:
'VAR=value' creates a local shell variable, invisible to sub-processes.
'export VAR' elevates it to an environment variable, forcing the OS 
to pass a copy of it into the memory space of every child process spawned here.


### 🛠️ Lab & Tools
**Hands-on Lab: Tracking Hidden Descriptors and Environment Variable Isolation**

In this lab, we describe the validation logic handled inside the companion `demo.sh` script to capture variable scoping and path prioritization:

1. **Hidden Node Auditing:** We generate a dummy dotfile and contrast the visibility returns of a standard `ls` query against `ls -a`.
2. **Variable Inheritance Verification:** We instantiate a local shell variable alongside an exported variable, then spawn a child shell script to evaluate which tokens cross the execution boundary.
3. **PATH Prepend Tracing:** We structurally alter the active `PATH` token list to observe how the shell prioritizes custom execution paths.

### ⚠️ Pitfalls
- **The `.*` Deletion Trap:** Executing destructive commands like `rm -rf .*` introduces extreme risks because the pattern matches the parent directory (`..`), potentially wiping out the entire directory tree above your current path.
- **Silent Binary Lockouts via PATH Corruption:** Accidentally dropping the `$` symbol during path manipulation (e.g., typing `PATH=/my/dir`) drops all standard default system binary lookups, breaking basic tools like `ls` or `mkdir` until the shell context is re-instantiated.