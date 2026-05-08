<div align="left">

```
 _____ _             ____             _   _            _
|_   _| |__   ___   / ___|  ___ _ __ | |_(_)_ __   ___| |
  | | | '_ \ / _ \  \___ \ / _ \ '_ \| __| | '_ \ / _ \ |
  | | | | | |  __/   ___) |  __/ | | | |_| | | | |  __/ |
  |_| |_| |_|\___|  |____/ \___|_| |_|\__|_|_| |_|\___|_|
```

# The Sentinel
### A Secure System Administration Toolkit

![Bash](https://img.shields.io/badge/Built%20With-Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Platform](https://img.shields.io/badge/OS-Linux-orange?style=for-the-badge&logo=linux)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)
![Course](https://img.shields.io/badge/Course-IT%20101-blue?style=for-the-badge)

**The Problem:** New Linux system administrators often face many problems due to the differences in the environment between Linux and other operating systems. Typing commands manually, especially for beginners, often leads to spelling errors, and even when done correctly, it takes a lot of time to manage daily tasks.

**The Solution:** To solve that we made one script that combine everything in One Place. The first time you turn it on, it asks you to log in, then it will give you menu that has 6 Module.

----
This Project made for **IT 101 - Shell and Script Programming with UNIX** course at **Zewail City of Science and Technology**.
We went above the standard curriculum requirements by applying real-world system administration, background process management, and defensive security practices and we made it to become an Effective toolkit for beginners

## 👥 Team Members

| Name | Student ID | Role |
| :--- | :--- | :--- |
| **Ahmed Amir Ibrahim** | 202507440 | Team Leader (Module 1, 2 & Integration) |
| **Zeyad Ahmed Fouad** | 202505153 | Team Member (Module 3 & 4) |
| **Yehia Mohamed** | 202508315 | Team Member (Module 5 & 6) |




---

## 📖 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Modules](#-modules)
- [Setup & Installation](#-setup--installation)
- [First Admin Account](#-creating-your-first-admin-account)
- [Usage Guide](#-usage-guide)
- [File Structure](#-file-structure)

---

## 🔍 Overview

**The Sentinel** is a modular, menu-driven Bash script that acts as a secure system administration dashboard. It integrates:

- 🔐 User authentication with hashed passwords
- 📊 Real-time system resource monitoring
- 💾 Automated backup management with logging
- ✅ Admin task tracking with full CRUD support
- 🌐 Remote server uptime monitoring
- 📁 Temporary LAN file sharing

All of this is accessible from a single, clean terminal interface — no need to write multiple commands or scripts.

---

## 🏗 Architecture

The entire toolkit runs through `sentinel.sh`, which authenticates the user first then it launches the main menu. Every feature lives in its own script.

```
the-sentinel/
│
├── sentinel.sh          ← Main script: auth in the beginning + Main menu
├── auth.sh              ← Sign Up / Sign In with SHA-256 hashing
├── monitor.sh           ← Live CPU, Memory and Disk monitor
├── backup.sh            ← tar.gz backups with logging with their date on it
├── tasks.sh             ← CSV-based admin task list (CRUD)
├── uptime.sh            ← Ping-based remote server monitor (.watchlist.conf)
├── fileserver.sh        ← Python HTTP server wrapper to share through "http://localhost:8000/"(start/stop)
└── README.md
```

> **Auto-generated at runtime:**
> `.sentinel_users` · `.admin_tasks.csv` · `.watchlist.conf` · `backup.log` · `uptime.log` · `fileserver_access.log`

---

## 🧩 Modules

| # | Module | Script | Key Feature |
|---|--------|--------|-------------|
| 1 | 🔐 Secure Authentication | `auth.sh` | SHA-256 hashed passwords, with 600 file permissions |
| 2 | 📊 System Resource Monitor | `monitor.sh` | Live CPU/RAM/Disk, auto-refresh, Sends alerts |
| 3 | 💾 Backup Utility | `backup.sh` | we used `.tar.gz` archives with full logging with their date on it |
| 4 | ✅ Admin Task List | `tasks.sh` | Full CRUD, priority levels, due dates, auto-sort |
| 5 | 🌐 Remote Uptime Monitor | `uptime.sh` | Ping watchlist, UP/DOWN status, write the failure |
| 6 | 📁 Temporary File Server | `fileserver.sh` | Python HTTP wrapper, PID-based start/stop |

---

## ⚙️ Setup & Installation

### Prerequisites

- Linux or any Unix-based system
- Bash shell
- Python 3 *(only required for Module 6)*

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/Ahmedamir21/the-sentinel-toolkit.git

cd the-sentinel-toolkit
```

**2. Grant execute permissions**
```bash
chmod +x sentinel.sh auth.sh monitor.sh backup.sh tasks.sh uptime.sh fileserver.sh
```

**3. Launch The Sentinel**
```bash
./sentinel.sh
```

All configuration files and logs are created automatically on first run. No need for manual setups .

---

## 🔑 Creating Your First Admin Account

On first launch, you'll see the authentication screen. Choose **Option 1 — Sign Up**:

```
 -------------------------------------- 
           Authentication Menu            
 -------------------------------------- 
1. Sign Up (New Admin)
2. Sign In (Existing Admin)

Choose an option (1 or 2): 1

Enter new username: admin
Enter new password: ••••••••
Account created successfully!
```

> **Security Highlights:**
> * Your password is **never stored in plain text**. It is hashed using `sha256sum` before being saved.
> * When you sign in, the system hashes your input and compares it against your stored hash.
> * The `.sentinel_users` file is protected with `600` permissions — so only the owner can access it.
> * **Note:** ⚠️ You cannot sign up with a username that already exists.
>
> &nbsp;

---

## 📋 Usage Guide

### 🔐 Module 1 — Secure Authentication
Handles account creation and login. All passwords are hashed with SHA-256 before storage. The `.sentinel_users` file has strict `600` permissions so only the owner who can access to it.

### 📊 Module 2 — System Resource Monitor
Displays a live, auto-refreshing dashboard every 2 seconds.
- Disk usage via `df`
- Memory via `free`
- CPU load via `top`
- 🔴 Red warning printed if CPU exceeds **80%**

> Press `q` to exit the monitor.

### 💾 Module 3 — Backup Utility
Enter any directory path and the script creates a compressed archive with the time and date in the name of it:
#### For Example:
```
backup_2026-05-07_14-30.tar.gz
```
Every operation is logged in `backup.log` with their time and date, source directory, output file, and file size (readable for human).

### ✅ Module 4 — Admin Task List
A CSV-based to-do list with full CRUD support. Tasks are automatically sorted by priority then due date when viewed.

| Priority | Value |
|----------|-------|
| 🔴 High | `HIGH` |
| 🟡 Medium | `MED` |
| 🟢 Low | `LOW` |

### 🌐 Module 5 — Remote Uptime Monitor
Reads server IPs/hostnames from `.watchlist.conf` (one per line) and pings each one.
- 🟢 `[ UP ]` — server is reachable, response time shown
- 🔴 `[ DOWN ]` — failure logged with timestamp to `uptime.log`

Default watchlist: `8.8.8.8`, `google.com`, `192.168.1.99`

#### The Ip `192.168.1.99` is an example to show you an Example of 🔴 `[ DOWN ]`

### 📁 Module 6 — Temporary File Server
Starts a Python HTTP server in the background for quick LAN file sharing.
- **Start:** enter a directory → server runs on port `8000`
- **Stop:** kills the background process using the saved PID
- Access via browser at `http://Your_Ip:8000`
- All requests logged to `fileserver_access.log`

> **Note:** ⚠️ Make sure port 8000 is not blocked by your firewall before using this module.

---

## 📁 File Structure

| File | Type | Description |
|------|------|-------------|
| `sentinel.sh` | Script | Main entry point |
| `auth.sh` | Script | Authentication module |
| `monitor.sh` | Script | System monitor module |
| `backup.sh` | Script | Backup utility module |
| `tasks.sh` | Script | Task list module |
| `uptime.sh` | Script | Uptime monitor module |
| `fileserver.sh` | Script | File server module |
| `.sentinel_users` | Hidden | Users (Username:Hashed password) |
| `.admin_tasks.csv` | Hidden | Task data file |
| `.watchlist.conf` | Hidden | Server watchlist (IP/Domain to connect) |
| `backup.log` | Log | Backup history |
| `uptime.log` | Log | Server failure log |
| `fileserver_access.log` | Log | HTTP access log |

---

<div align="center">

*IT 101 — Shell and Script Programming with UNIX*
*University of Science and Technology · Academic Year 2025–2026*

</div>
