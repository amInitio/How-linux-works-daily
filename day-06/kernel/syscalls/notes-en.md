# DAY-06 -> KERNEL -> Syscalls (English)

### 🧠 Mechanism
- **System Calls (Syscalls):** The formal interface provided by the kernel to allow user processes to request privileged operations that they cannot perform independently (e.g., file I/O via `open()`, `read()`, `write()`).
- **Process Creation Dynamics:** Except for the initial `init` process, every single user process in Linux spawns via two foundational syscalls:
  - `fork()`: The kernel creates a nearly identical clone of the calling process (parent), duplicating its memory space and state into a new child process.
  - `exec(program)`: The kernel obliterates the current process's memory space and context, replacing it entirely with the newly specified executable code.
- **The Shell Execution Loop:** When a user executes a command like `ls` in a terminal, the shell does not disappear. Instead, the shell invokes `fork()` to create a background clone of itself, and that clone immediately calls `exec(ls)` to transform into the `ls` program.


```text
+---------+                                 +---------+
|  shell  | ──────────────────────────────> |  shell  | (Parent)
+---------+                                 +---------+
     │
     │ fork() 
     ▼
+---------------+                           +--------------+                                   +--------+
| copy of shell | ────────────────────────> |   exec(ls)   | (Child) ────────────────────────> |   ls   |
+---------------+                           +--------------+                                   +--------+
```



- **Pseudodevices Support:** The kernel also exposes software-only features called pseudodevices (e.g., `/dev/random` or `/dev/urandom`). They act like physical devices to ensure standard file-operation compatibility, but are implemented purely in kernel software for cryptographic security and entropy harvesting.



### 🔍 OS Hook
- **The `strace` Utility:** Linux provides a direct window into system calls using the `strace` tool. By running `strace [command]`, you can intercept and log every single hardware-level syscall (like `execve`, `brk`, `openat`) executed between the binary and the kernel.

### 🛠️ Lab & Tools
**Hands-on Lab: Intercepting `fork()` and `exec()` via Strace**

In this lab, we trace the live execution of a basic command to visually map out the exact sequence of process cloning and execution described in the text.

**Complete Lab Source Code (Inside demo.sh):**
The script invokes strace on a sub-shell execution to capture the hidden syscall trail:
1. `strace -f -e trace=process,file bash -c "ls /dev/null"`
   *(Note: `-f` ensures strace follows the child process created by fork, and `-e trace=process,file` filters out unnecessary clutter, keeping only process creation and file syscalls).*

**Step-by-Step Output Analysis:**
Running the lab produces a sequence similar to this:
```text
[pid  9102] clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|...) = 9103
[pid  9103] execve("/usr/bin/ls", ["ls", "/dev/null"], 0x7ffd...) = 0
/dev/null
```


### 🔍 Deep Dive: Why a Pseudodevice for Randomness Instead of a Dedicated Syscall?

* **The Question:** Why did the kernel architects expose a virtual file like `/dev/random` instead of just writing a straightforward system call to return a random number?
* **Architectural Breakdown:** This honors the core Unix Philosophy and solves several system design hurdles:
  1. **The "Everything is a File" Mantra:** By standardizing randomness into a file interface, user-space developers don't need new syntax. They read stream bytes using standard `open()` and `read()` loops, exactly like parsing a standard text document.
  2. **Shell Interoperability (Piping):** Since it behaves like a file, it pipes flawlessly with shell utilities. Creating a 1MB cryptographic key requires a single line: `dd if=/dev/urandom of=key.bin`, avoiding compiled C overhead.
  3. **Preventing Syscall Bloat:** Adding a new syscall requires updating hardware interrupt tables and glibc wrappers, forcing lifetime backward compatibility. The kernel avoids this unless absolutely necessary.

* **The Historical Twist (Enter `getrandom()`):** In 2014 (Linux kernel 3.17), developers faced a critical vulnerability: what if an early-stage boot daemon needs cryptographic entropy before the `/dev` filesystem is mounted? Or what if a highly secure containerized process is isolated from devfs? To close this loop, Linux implemented the **`getrandom()`** system call. Today, shell scripts favor `/dev/urandom`, while core crypto engines (like OpenSSL) target the syscall directly.