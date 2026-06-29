# 🐧 How Linux Works - Daily Challenge

<div dir="rtl">

این مخزن شامل خلاصه‌نکات فنی، ساختارهای عملی و آزمایشگاه‌های کدنویسی روزانه از روی کتاب مرجع **"How Linux Works" (Brian Ward)** است. هدف این پروژه، فرار از حفظ کردن دستورات و رسیدن به **تفکر سیستمی و درک عمیق زیرسیستم‌های لینوکس** است.

🛠️ **سیستم‌عامل توسعه:** Arch Linux 🚀

</div>

---

This repository contains technical summaries, hands-on labs, and daily coding experiments based on the reference book **"How Linux Works" by Brian Ward**. The goal of this project is to move beyond memorizing commands and develop a **system-level thinking and deep understanding of Linux subsystems**.

🛠️ **Development OS:** Arch Linux 🚀

---

## 📅 Roadmap & Daily Tracking / نقشه راه و رهگیری روزانه

| Day / روز | Docs / مستندات |
|:---:|:---|
| **01** | [📂](./day-01/) |
| **02** | [📂](./day-02/) |
| **03** | [📂](./day-03/) |
| **04** | [📂](./day-04/) |
| **05** | [📂](./day-05/) |
| **06** | [📂](./day-06/) |
| **07** | [📂](./day-07/) |
| **08** | [📂](./day-08/) |

---

## 🧠 The Loop Rule / قانون حلقه

<div dir="rtl">

برای جلوگیری از پراکندگی مطالب و تثبیت حافظه بلندمدت، هر مفهوم در یک چرخه ۳ مرحله‌ای بازگشت دارد:
1. **مفهوم (Concept):** درک مکانیزم تئوری و ساختار داخلی لینوکس.
2. **ردپای سیستم‌عامل (OS Hook):** ردیابی مفهوم در هسته، سیستم‌کال‌ها یا دایرکتوری `/proc`.
3. **آزمایشگاه (Lab):** پیاده‌سازی عملی با کدنویسی (C / Go / Bash) یا ابزارهای مانیتورینگ .

**این بخش با توجه به مبحث متغیر است**
</div>

To prevent scattered knowledge and activate long-term memory, every concept follows a 3-step loop:
1. **Concept:** Understanding the theoretical mechanism and internal structure of Linux.
2. **OS Hook:** Tracing the concept within the kernel, system calls, or the `/proc` directory.
3. **Lab:** Practical implementation using coding (C / Go / Bash) or system monitoring tools.

**This part may change depending on the concept**

---

## 🛠️ System Toolkit / جعبه‌ابزار سیستمی

* **Tracing:** `strace` (System Call tracer), `ltrace`
* **Monitoring:** `htop`, `top`, `iotop`
* **Network/Files:** `lsof`, `ss`
* **Kernel & Hardware:** `sysctl`, `lsblk`, `dmesg`

---

## 📝 Document Template / قالب استاندارد گزارش‌ها (`notes.md`)

<div dir="rtl">

هر پوشه ریزمبحث در هر روز شامل یک فایل `notes.md` است که به هر دو زبان مستند می‌شود و بخش‌های زیر را پوشش می‌دهد:
1. **Mechanism:** چالش اصلی چیست و لینوکس چطور آن را حل می‌کند؟
2. **OS Hook:** این مفهوم دقیقاً کجای سیستم‌عامل قرار دارد؟
3. **1-Minute Lab:** یک تست کوتاه ترمینالی یا کد سریع برای اثبات ایده.
4. **Pitfalls:** اشتباهات و کج‌فهمی‌های رایج درباره موضوع.

</div>

Each daily folder contains a `notes.md` file documented in both languages, covering:
1. **Mechanism:** What is the core problem and how does Linux solve it?
2. **OS Hook:** Where exactly does this concept live in the OS?
3. **1-Minute Lab:** A short terminal test or quick snippet to prove the idea.
4. **Pitfalls:** Common misconceptions and mistakes about the topic.