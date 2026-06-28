# DAY-08 - Users (English)

### 🧠 Mechanism
- **The Concept of a User:** In Linux, a user is an entity that can execute processes and own files. The kernel does not understand alphabetical usernames (like `billyjoe`); instead, it tracks and recognizes them strictly via numeric identifiers called **User IDs (UIDs)**.
- **Process Boundaries:** Every user-space process runs under the identity of a specific user owner. A standard user can modify or terminate their own processes but is completely isolated from interfering with other users' running applications.
- **The Root User (Superuser):** Root is the ultimate exception to standard permission laws. The root user can override any file permission and manipulate or terminate any active process belonging to any user on the system.
- **Root Execution Mode:** Crucially, despite its absolute power, the root user still executes entirely within the operating system's **User Mode (Ring 3)**, not Kernel Mode (Ring 0). Root must still use system calls to request privileged tasks from the kernel.
- **Groups:** Groups are designated collections of users. Their foundational purpose is to allow multiple users to efficiently share access to files and directories without manually altering individual permissions.

### 🔍 OS Hook
- **The Identity Mapping Database (`/etc/passwd`):** Since the kernel only operates on numeric UIDs, the system uses the flat text database located at `/etc/passwd` to translate alphabetical usernames into numerical UIDs at runtime. For instance, the superuser `root` is fundamentally hardcoded to UID `0`.

### 🛠️ Lab & Tools
**Hands-on Lab: Inspecting Numeric UIDs and Process Ownership**

In this lab, we describe the exact tracing logic handled inside the companion `demo.sh` script:

1. **User Identity Resolution:** We leverage the `id` utility to view how the system translates our human-readable username into raw numeric values behind the scenes.
2. **Root User Verification:** We parse the `/etc/passwd` system database to confirm that the superuser account maps explicitly to numeric UID `0`.
3. **Active Process Inspection:** We invoke the `ps` command on the current shell execution context to observe how active processes inherit and display the numerical UID of their runtime owner.

### ⚠️ Pitfalls
- **The Blind Trust of Root Access:** Because the system assumes the root user makes no mistakes, a minor typo can wipe out essential system configuration or files instantly without prompting a confirmation warning.
- **Username vs. UID Confusion:** Changing a user's textual name while keeping their numeric UID intact changes nothing from the kernel's perspective. Ownership of files remains bound to the numerical index, meaning a file is owned by a number, not a name.