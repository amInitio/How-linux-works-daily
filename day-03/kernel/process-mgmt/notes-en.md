# DAY-03 -> KERNEL -> Process-mgmt (English)

### 🧠 Mechanism
Process management describes the starting, pausing, resuming, and terminating of processes. While starting and terminating are straightforward, how a process uses the CPU during normal operation is more complex.

On any modern operating system, many processes appear to run "simultaneously" (Multitasking). However, on a single-core CPU, only one process can actually use the CPU at any given microsecond. The system achieves multitasking by letting each process use the CPU for a tiny fraction of a second—called a **Time Slice**—and then pausing it to let another process take a turn. The act of one process giving up control of the CPU to another is called a **Context Switch**.

The kernel is entirely responsible for context switching. When a process's time slice expires in user mode, the following 7-step sequence occurs:
1. The CPU hardware interrupts the current process based on an internal timer, switches from **User Mode** to **Kernel Mode**, and hands control back to the kernel.
2. The kernel records the current **State** (registers, memory pointers) of the interrupted process so it can be resumed later.
3. The kernel performs tasks that arrived during the preceding time slice (like handling I/O operations).
4. The kernel analyzes the process list and chooses the next process that is ready to run.
5. The kernel prepares the memory and the CPU environment for this new process.
6. The kernel configures the CPU hardware timer with the duration of the new process's time slice.
7. The kernel switches the CPU back into **User Mode** and hands over execution control to the new process.

‌Bellow chart explains these steps with firefox and vim processes example : 


    ===================================================================================
      TIME LINE                   CONTEXT SWITCHING PROCESS (7-STEP)
    ===================================================================================

    [ USER SPACE ]             [ KERNEL SPACE ]                [ HARDWARE CPU ]
    
      Firefox (A) 
      Active (User Mode)
          │
          │ (Executing...)
          ▼
          ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒►  [ HARDWARE TIMER ]
                                                                  Time Slice Expires!
                                                                        │
          ┌────────────────────────────────────────────────────────────┘
          ▼
    ┌──────────────┐
    │ STEP 1: IRQ  │ ◄─── Forced Interrupt (Switches CPU Hardware to Kernel Mode)
    └──────┬───────┘
            │
            ▼
    ┌──────────────┐
    │ STEP 2: SAVE │ ◄─── Kernel saves State/Image of Firefox (A) to struct task_struct
    └──────┬───────┘      (Saves Registers, Program Counter, Memory Maps)
            │
            ▼
    ┌──────────────┐
    │ STEP 3: I/O  │ ◄─── Kernel flushes background I/O operations & system buffers
    └──────┬───────┘
            │
            ▼
    ┌──────────────┐
    │ STEP 4: PICK │ ◄─── Linux Scheduler inspects Run-Queue & selects Vim (B)
    └──────┬───────┘
            │
            ▼
    ┌──────────────┐
    │ STEP 5: LOAD │ ◄─── Kernel maps Memory Pages & loads CPU Registers for Vim (B)
    └──────┬───────┘
            │
            ▼
    ┌──────────────┐
    │ STEP 6: TIMER│ ◄─── Kernel programs Hardware Timer for the next 10ms - 20ms
    └──────┬───────┘
            │
            ▼
    ┌──────────────┐
    │ STEP 7: EXEC │ ◄─── Kernel switches CPU back to User Mode & relinquishes control
    └──────┬───────┘
            │
    ┌──────┘
    ▼
      Vim (B) 
      Active (User Mode)
          │
          │ (Executing...)
          ▼
    
    ===================================================================================

> **Key Takeaway:** The kernel runs *between* process time slices during a context switch. On multi-CPU systems, the kernel can run on one core while user processes run on others, but it still performs context switches to maximize core utilization.

### 🔍 OS Hook
* **State Storage in Source Code:** The Linux kernel maintains a data structure for every single process called `struct task_struct` (defined in `linux/sched.h`). Inside it, `thread_struct` holds the CPU register values (like RIP, RSP) and memory state during a context switch.
* **Live OS Counters:** The kernel exposes context switch metrics inside `/proc/[PID]/status` and `/proc/[PID]/sched`. These are split into two categories:
  1. **Voluntary:** The process yields the CPU willingly (e.g., waiting for I/O).
  2. **Involuntary:** The kernel forces the process out because its **Time Slice** expired.

### 🛠️ Lab & Tools
**Hands-on Lab: Tracking Time Slices and Context Switches in Real-Time**

In this lab, we will generate a massive CPU load to trigger aggressive task scheduling, then monitor the kernel's scheduler interventions using `pidstat`.

* **Step 1 (Install Sysstat):** Install the system statistics package on Arch Linux:
```bash
sudo pacman -S sysstat
```

* **Step 2 (Generate heavy CPU contention):** Spawn a heavy background task that consumes CPU cycles:
```bash
sha256sum /dev/zero &
PID_TEST=$!
```

* **Step 3 (Intercept Scheduler Metrics):** Monitor the context switch rate of the target PID every 1 second, for 5 iterations:
```bash
pidstat -w -p $PID_TEST 1 5
```
Look closely at the output headers: `cswch/s` (voluntary switches) and `nvcswch/s` (involuntary switches). High numbers in `nvcswch/s` mathematically prove that the kernel is constantly slicing down your process's execution time via hardware interrupts.

* `cswch/s`: The number of times per second the process itself voluntarily requests to yield the CPU.
* `nvcswch/s`: The number of times per second the kernel forcefully preempts (pauses) the process so the CPU can attend to other background tasks.

* **Step 4 (Cleanup):** Kill the benchmark process:
```bash
kill $PID_TEST
```

### ⚠️ Pitfalls
* **Misconception: Thinking that Context Switching is completely free with zero performance overhead.**
  * **Reality:** Context switching is expensive. When the kernel forces a switch, the CPU cache (L1/L2/L3) gets invalidated and rewritten with the new process's memory maps (Cache Thrashing). Excessive involuntary context switching severely degrades CPU efficiency.
* **Misconception: Assuming that Multi-core/Multi-CPU systems eliminate the need for context switches.**
  * **Reality:** The number of running processes on an active Linux system always vastly outnumbers the physical CPU cores. The kernel must still multiplex execution time on every single core using the exact 7-step interrupt sequence.
