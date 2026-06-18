# DAY-02 - Kernel (English)


### 🧠 Mechanism (The Kernel)
Why are we talking about main memory and states? Nearly everything that the kernel does revolves around main memory. One of the kernel’s tasks is to split memory into many subdivisions, and it must maintain certain state information about those subdivisions at all times. Each process gets its own share of memory, and the kernel must ensure that each process keeps to its share.

The kernel is in charge of managing tasks in four general system areas:

1. **Processes:** The kernel is responsible for determining which processes are allowed to use the CPU.

2. **Memory:** The kernel needs to keep track of all memory—what is currently allocated to a particular process, what might be shared between processes, and what is free.

3. **Device drivers:** The kernel acts as an interface between hardware (such as a disk) and processes. It’s usually the kernel’s job to operate the hardware.

4. **System calls and support:** Processes normally use system calls to communicate with the kernel.
### 🔍 OS Hook
- 

### 🛠️ Lab & Tools
- 

### ⚠️ Pitfalls
- 
