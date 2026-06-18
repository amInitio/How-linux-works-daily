# DAY-02 - Main-memory (English)

### 🧠 Mechanism
Of all the hardware on a computer system, **Main Memory (RAM)** is perhaps the most important. In its rawest form, main memory is just a massive storage area for a collection of 0s and 1s, where each individual digit is called a **Bit**.

The running kernel and all active processes reside inside this memory—they are essentially huge collections of bits. All input and output operations from peripheral devices flow through main memory as bits. The CPU acts merely as an operator on memory; it fetches instructions and reads data from the RAM, processes them, and writes the results back out to the memory.

To describe memory conditions, two fundamental terms are used:
* **State:** Strictly speaking, a state is a particular arrangement of bits at a given moment. Since a single process consists of millions of bits, we use abstract terms to describe a state instead of listing raw bits (e.g., "the process is waiting for input").
* **Image:** When referring specifically to the physical, literal arrangement of bits in memory rather than the abstract state, the term `Image` is used.

### 🔍 OS Hook
In Linux, when a process crashes unexpectedly (e.g., due to a memory violation), the kernel can write a snapshot of the process's memory space onto the disk. This file is called a **Core Dump**. A core dump is a literal **Image** representing the exact physical **State** (arrangement of bits) of that process at the exact microsecond it failed, allowing developers to inspect it using tools like `gdb`.

### 🛠️ Lab & Tools
**Minimal Lab: Checking the Abstract State of Main Memory**
To view the high-level, abstracted state of your system's memory without dealing with raw bits, run the following command in your Arch terminal:
```bash
free -h                      # Displays human-readable memory usage and availability
```
To look at the live memory status data structures that the kernel exposes to user space, read the virtual memory file:
```bash
cat /proc/meminfo            # Inspects detailed kernel-level memory allocation
```

**Hands-on Lab: Extracting a Literal Memory Image (Core Dump) on Arch Linux**

In this lab, we will intentionally force a running process to crash, compelling the kernel to write a physical, bit-by-bit snapshot (**Image**) of its RAM allocation onto the disk. We will then extract raw strings from it.

* **Step 1 (Spawn a background process):** Run a `sleep` command for 1000 seconds in the background:
```bash
sleep 1000 &
```
The shell will return a Process ID (PID).

* **Step 2 (Crash the process to trigger a Core Dump):** Send signal 11 (`SIGSEGV` - Segmentation Violation) to force-kill the process:
```bash
kill -11 $!
```
*(Note: `$!` points to the last background PID in Bash).* You will see a terminal notification saying `Segmentation fault (core dumped)`.

* **Step 3 (Extract the raw memory image):** Strip away the abstract state and save the actual memory snapshot into a physical file using systemd's utility:
```bash
coredumpctl dump sleep -o sleep_memory.img
```

* **Step 4 (Inspecting the physical bits/bytes):** To prove this is a literal layout of the RAM, parse the binary file for readable text strings that were residing in memory right before the crash:
```bash
strings sleep_memory.img | grep -i path
```

**To extract hex codes of binary image :**

```bash
hexdump -C sleep_memory.img | head -n 20
```

You will witness environment variables (like `PATH`) and library definitions that were physically mapped inside the process's memory space. This is a direct look at a physical **Image**!


### ⚠️ Pitfalls
* **Misconception:** Assuming that the term "Image" in operating systems only refers to disk images (like `.iso` files or Docker images).
  * **Reality:** At a low level, an `Image` refers to the exact physical layout and arrangement of bits of a process or kernel as it sits inside the RAM.
* **Misconception:** Thinking of the CPU as an isolated brain that operates independently of RAM.
  * **Reality:** The CPU is strictly a memory operator; it cannot execute anything without constantly reading instructions (bits) from and writing data back to main memory.