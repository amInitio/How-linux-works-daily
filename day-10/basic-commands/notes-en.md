# DAY-10 - Basic-commands (English)

### 🧠 Mechanism
- **User Space Command Nature:** Commands like `ls`, `cp`, `mv`, and `rm` are individual, compiled binaries executing in User Space. They manipulate filesystem structures by interacting with the kernel's virtual filesystem abstraction layer.
- **Metadata Extraction via `ls -l`:** This flag parses filesystem records to display structured ownership, active permission bits, exact file sizes, and time stamps instead of just raw names.
- **The Core Difference Between `cp` and `mv`:**
  - `cp` performs a physical block-by-block duplication of raw data onto a new storage location, generating a completely distinct file entity with a unique inode number.
  - `mv` (when within the same partition) leaves the underlying disk data blocks untouched. It merely alters the directory reference point or renames the pointer, consuming near-zero I/O cycles.
- **Timestamp Modification via `touch`:** If a file does not exist, `touch` instantiates an empty 0-byte file descriptor. If it exists, the file contents remain uncompromised while the kernel forces an update to its modification time metadata.
- **The Unlinking Reality of `rm`:** The `rm` command does not wipe sectors or zero out data blocks. It simply severs the directory listing attachment to that specific data block, decrementing its link count. The blocks become available for reallocation, though the original raw data remains until overwritten.

### 🔍 OS Hook
- **Underlying System Calls:** Each of these basic commands maps to a specific low-level system call interface:
  - `touch` and `ls` invoke variations of the `stat` system call family to evaluate or manipulate temporal and physical metadata attributes.
  - `rm` strictly triggers the `unlink` system call to strip the filename mapping from the directory structure tree.

### 🛠️ Lab & Tools
**Hands-on Lab: Tracing Physical File Behaviors and Metadata Shifts**

In this lab, we describe the validation logic handled inside the companion `demo.sh` script to witness physical filesystem changes:

1. **Temporal Modification Inspection:** We create a tracking target using `touch`, record its metadata using `ls -l`, insert a micro-delay, and re-touch to observe metadata updates without data expansion.
2. **Inode Divergence Tracing:** We leverage the `stat` or `ls -i` commands to prove how `cp` spawns an isolated block index while `mv` preserves the existing hardcoded block descriptor.
3. **Stdout Evaluation:** We verify basic string outputs rendered directly into the stdout channel via `echo`.

### ⚠️ Pitfalls
- **The Irreversible `rm` Execution:** The Linux command line lacks a default recycling buffer or trash system. Once `rm` fires, the `unlink` system call immediately discards the name pointer, making data recovery highly volatile.
- **Silent Overwrites via `cp` and `mv`:** By default, both `cp` and `mv` destination operations will silently overwrite a pre-existing destination file matching the target name without prompting a confirmation block, unless mitigated with the `-i` interactive flag.