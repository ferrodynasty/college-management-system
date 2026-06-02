# 🎓 College Management System (CMS 2.0)

A web-based College Management System built with **ASP.NET Web Forms**, **C#**, and **Oracle XE** database. It supports three roles — Admin, Professor, and Student — each with their own portal and features.

---

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Database Setup](#database-setup)
- [Project Setup](#project-setup)
- [Configuration](#configuration)
- [Running the Project](#running-the-project)
- [How to Use](#how-to-use)
- [Project Structure](#project-structure)
- [Default Login](#default-login)

---

## ✨ Features

| Role      | Features |
|-----------|----------|
| **Admin**     | Add / delete students, Add / delete professors |
| **Professor** | Post homework, mark attendance, enter marks, answer student doubts |
| **Student**   | View marks, view attendance, view homework, ask doubts |

---

## 🛠 Tech Stack

- **Frontend** — ASP.NET Web Forms (`.aspx`), HTML, CSS
- **Backend** — C# (.NET Framework 4.7.2)
- **Database** — Oracle Database XE (Express Edition)
- **ORM/Driver** — Oracle.ManagedDataAccess (ODP.NET)
- **IDE** — Visual Studio 2022

---

## ✅ Prerequisites

Make sure you have the following installed before starting:

1. [Visual Studio 2022](https://visualstudio.microsoft.com/) — with **ASP.NET and web development** workload
2. [Oracle Database XE 21c](https://www.oracle.com/database/technologies/xe-downloads.html) — free version
3. [.NET Framework 4.7.2](https://dotnet.microsoft.com/en-us/download/dotnet-framework/net472)

---

## 🗄 Database Setup

### Step 1 — Install Oracle XE
Download and install Oracle XE. During installation, set a password for the `system` user — remember it.

### Step 2 — Connect to Oracle
Open **SQL Plus** or **Oracle SQL Developer** and connect as:
```
Username: system
Password: (the password you set during installation)
Host:     localhost:1521/xepdb1
```

### Step 3 — Create the Tables
Run the following SQL to create all required tables:

```sql
-- Users table (shared login for all roles)
CREATE TABLE cms_users (
    user_id   VARCHAR2(20) PRIMARY KEY,
    username  VARCHAR2(50) UNIQUE NOT NULL,
    password  VARCHAR2(50) NOT NULL,
    role      VARCHAR2(20) NOT NULL  -- 'admin', 'professor', 'student'
);

-- Admin table
CREATE TABLE admin (
    admin_id  VARCHAR2(20) PRIMARY KEY,
    full_name VARCHAR2(100),
    email     VARCHAR2(100),
    phone     VARCHAR2(20),
    address   VARCHAR2(200)
);

-- Student table
CREATE TABLE student (
    student_id VARCHAR2(20) PRIMARY KEY,
    full_name  VARCHAR2(100),
    email      VARCHAR2(100),
    phone      VARCHAR2(20),
    address    VARCHAR2(200),
    class      VARCHAR2(50)
);

-- Professor table
CREATE TABLE professor (
    prof_id   VARCHAR2(20) PRIMARY KEY,
    full_name VARCHAR2(100),
    email     VARCHAR2(100),
    phone     VARCHAR2(20),
    address   VARCHAR2(200),
    dept      VARCHAR2(100)
);

-- Attendance table
CREATE TABLE attendance (
    id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id VARCHAR2(20) REFERENCES student(student_id),
    subject    VARCHAR2(100),
    date_col   DATE,
    status     VARCHAR2(10)  -- 'Present' or 'Absent'
);

-- Marks table
CREATE TABLE marks (
    id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id VARCHAR2(20) REFERENCES student(student_id),
    subject    VARCHAR2(100),
    exam_type  VARCHAR2(50),
    marks      NUMBER,
    max_marks  NUMBER
);

-- Homework table
CREATE TABLE homework (
    id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    prof_id     VARCHAR2(20) REFERENCES professor(prof_id),
    title       VARCHAR2(200),
    description CLOB,
    subject     VARCHAR2(100),
    due_date    DATE,
    class       VARCHAR2(50)
);

-- Doubt table
CREATE TABLE doubt (
    id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id  VARCHAR2(20) REFERENCES student(student_id),
    subject     VARCHAR2(100),
    question    CLOB,
    answer      CLOB,
    status      VARCHAR2(20) DEFAULT 'Pending'
);
```

### Step 4 — Insert a Default Admin
```sql
INSERT INTO cms_users (user_id, username, password, role)
VALUES ('A001', 'admin', 'admin123', 'admin');

INSERT INTO admin (admin_id, full_name, email, phone, address)
VALUES ('A001', 'Administrator', 'admin@college.edu', '9999999999', 'College Campus');

COMMIT;
```

---

## 💻 Project Setup

### Step 1 — Clone the Repository
```bash
git clone https://github.com/ferrodynasty/college-management-system.git
cd college-management-system
```

### Step 2 — Restore NuGet Packages
Open the solution in **Visual Studio 2022**, then:
```
Tools → NuGet Package Manager → Restore NuGet Packages
```
Or right-click the solution in Solution Explorer → **Restore NuGet Packages**

This will automatically download the `packages/` folder (which is not included in the repo).

---

## ⚙️ Configuration

Open `cms2.0/Web.config` and update the connection string with your Oracle credentials:

```xml
<connectionStrings>
    <add name="OracleXE"
         connectionString="User Id=system;Password=YOUR_PASSWORD;Data Source=localhost:1521/xepdb1;"
         providerName="Oracle.ManagedDataAccess.Client" />
</connectionStrings>
```

Replace `YOUR_PASSWORD` with the password you set for Oracle XE during installation.

> **Note:** If your Oracle listener uses a different port or service name, update `localhost:1521/xepdb1` accordingly.

---

## ▶️ Running the Project

1. Open `cms2.0.slnx` in **Visual Studio 2022**
2. Make sure Oracle XE is running (check Windows Services → `OracleServiceXEPDB1` should be **Running**)
3. Press **F5** or click the green **▶ Run** button
4. The browser will open at `loginform.aspx`

---

## 📖 How to Use

### 🔐 Login
- Open the app in your browser
- Select your **Role** (Admin / Professor / Student)
- Enter your **Username** and **Password**
- Click **Sign In**

---

### 👨‍💼 Admin Portal
After logging in as Admin you can:

**Manage Students**
1. Click **Manage Students**
2. Click **+ Add Student** → fill in ID, Name, Username, Password, Email, Phone, Class
3. Click **Add Student** to save
4. To remove a student, click **Delete** on their card

**Manage Professors**
1. Click **Manage Professors**
2. Click **+ Add Professor** → fill in ID, Name, Username, Password, Email, Phone, Department
3. Click **Add Professor** to save
4. To remove a professor, click **Delete** on their card

---

### 👨‍🏫 Professor Portal
After logging in as Professor you can:

**Post Homework**
1. Click **Homework** → fill in Title, Subject, Class, Due Date, Description
2. Click **Save** — students of that class will see it

**Mark Attendance**
1. Click **Attendance** → select Subject and Date
2. Mark each student as Present or Absent
3. Click **Save Attendance**

**Enter Marks**
1. Click **Manage Marks** → select Student, Subject, Exam Type
2. Enter marks and max marks → click **Save**

**Answer Doubts**
1. Click **Student Doubts** → see all pending questions
2. Type your answer → click **Answer**

---

### 🎓 Student Portal
After logging in as Student you can:

**View Marks** — Click **My Marks** to see all subjects and scores

**View Attendance** — Click **Attendance** to see your present/absent record with percentage

**View Homework** — Click **Assignments** to see all posted homework for your class

**Ask a Doubt** — Click **Ask a Doubt** → type your subject and question → submit. Check back later for the professor's answer.

---

## 📁 Project Structure

```
cms2.0/
├── cms2.0/                  ← Main web application
│   ├── loginform.aspx       ← Login page (entry point)
│   ├── adminDesk.aspx       ← Admin dashboard
│   ├── studentDesk.aspx     ← Student dashboard
│   ├── professordesk.aspx   ← Professor dashboard
│   ├── manageStudent.aspx   ← Admin: manage students
│   ├── manageprofessor.aspx ← Admin: manage professors
│   ├── attendance.aspx      ← Student: view attendance
│   ├── manageAttendance.aspx← Professor: mark attendance
│   ├── marks.aspx           ← Student: view marks
│   ├── managemarks.aspx     ← Professor: enter marks
│   ├── homework.aspx        ← Student: view homework
│   ├── managehomework.aspx  ← Professor: post homework
│   ├── doubt.aspx           ← Student: ask doubts
│   ├── managedoubt.aspx     ← Professor: answer doubts
│   ├── StyleSheet.css       ← All UI styles
│   ├── DbHelper.cs          ← Database helper class
│   └── Web.config           ← App configuration (DB connection)
├── cms2.0.slnx              ← Visual Studio solution file
└── .gitignore
```

---

## 🔑 Default Login

| Role      | Username | Password |
|-----------|----------|----------|
| Admin     | `admin`  | `admin123` |

> Professors and Students are added by the Admin. Their credentials are set during creation.

---

## 📝 Notes

- The `packages/` folder is not included in the repo. Visual Studio will restore it automatically via NuGet.
- Always start Oracle XE service before running the project.
- Session timeout is set to **30 minutes** of inactivity.
- Make sure to change the default admin password after first login.
