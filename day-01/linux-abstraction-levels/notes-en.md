# DAY-01 - Linux-abstraction-levels (English)

### 🧠 Mechanism

A modern operating system like Linux is full of **processes** and complex components that are simultaneously running and communicating with each other. Understanding all these details at first glance is very difficult. To solve this problem and better understand the system, we use **Abstraction Layers**; meaning we ignore the unnecessary details of the lower layers so we can focus on the performance of the entire macro-system.

In this book, we call each of these segregated software subdivisions a **Component**. Each level of abstraction helps us understand where a specific group of components stands and how much distance it has relative to the **user** and the **hardware**.

Linux generally consists of **three main layers of abstraction**:

1. **Hardware:**
The base and foundation of the system, which includes the **Central Processing Unit (CPU)**, **Main Memory (RAM)**, and devices like disks and network cards.
2. **The Kernel:**
The central core of the operating system, which is software residing in memory, tells the CPU what to do, and acts as the **primary interface** between the hardware and running programs.
3. **User Space / Processes:**
The highest layer of the system, which includes all running programs managed by the kernel (such as web servers, shells, compilers, and graphical applications).

---

```text
    +-------------------------------------------------------------+
    |                       User Space                           |
    |  [Bash Shell]      [C++ Compiler]      [Your Processes]    |
    +-------------------------------------------------------------+
                                  ||
                                  ||  System Calls
                                  \/
    +-------------------------------------------------------------+
    |                           Kernel                            |
    |     Process Mgmt  |  Memory Mgmt  |  Device Drivers         |
    +-------------------------------------------------------------+
                                  ||
                                  ||  Direct Hardware Access
                                  \/
    +-------------------------------------------------------------+
    |                          Hardware                           |
    |    [CPU]    |    [Memory]    |    [Disks]    |  [Network]   |
    +-------------------------------------------------------------+
```

---

**A critical divide: The way programs run in the kernel layer and the user layer is completely different:**

* **Kernel Mode:**
Code running in this mode has **unrestricted access** to the processor and the entire main memory. This is a powerful but **dangerous** privilege; because a minor mistake in the kernel layer can **crash** the entire system. The memory space that only the kernel can access is called **Kernel Space**.
* **User Mode:**
Programs in this environment (processes) have restricted access to memory and safe CPU operations. The memory space that user processes can access is called **User Space**. If a process in the user space (like a web browser) encounters an error and crashes, the damage is limited and the kernel immediately **cleans up** its effects, without causing any harm to the rest of the system or background processes.


### 🔍 OS Hook

* **The Boundary:** The only way to transition from **User Space** to **Kernel Space** is through a **System Call (syscall)**. User processes are hardware-isolated.
* **Kernel Exposure via `/proc`:** Linux uses the virtual `/proc` filesystem to expose internal kernel data structures to user space. It doesn't exist on disk; it is generated on-the-fly in memory. Every process has a directory here named after its Process ID (**PID**). 

### 🛠️ Lab & Tools

**Minimal Lab: Feeling the User-Kernel Privilege Boundary**

To understand how user space tools are restricted and must rely on the kernel for sensitive tasks, run these two simple tests in your Arch terminal:

* **Test 1 (Access Denied in User Space):** Run the `dmesg` command as a regular user (without sudo). The kernel will block your process and return `Operation not permitted`. This proves that in User Mode, you cannot directly inspect kernel memory.
* **Test 2 (Crossing the Boundary via Elevation):** Run `sudo dmesg`. Once authenticated, your process successfully makes the system call, triggers a transition into Kernel Space, and the kernel safely fetches and displays the raw hardware boot logs from its protected memory.

### ⚠️ Pitfalls


* **Misconception:** Thinking that files inside `/proc` occupy storage space on your NVMe/HDD.
  * **Reality:** These files are completely virtual, RAM-based, and have a size of 0 bytes. They vanish when the system powers off.
* **Misconception:** Assuming core terminal utilities like `ls`, `cat`, or `id` are part of the Linux kernel.
  * **Reality:** These are user space applications provided by GNU Coreutils. The kernel provides no interactive commands; it only manages their execution environment.
