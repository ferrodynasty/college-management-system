-- ============================================================
-- CMS 2.0 – Oracle XE Database Schema
-- Run as: system / your-admin-user
-- Target PDB: xepdb1  (or adjust Data Source in Web.config)
-- ============================================================

-- ─── USERS (login table – all roles) ────────────────────────
CREATE TABLE cms_users (
    user_id   VARCHAR2(20)   PRIMARY KEY,
    username  VARCHAR2(60)   NOT NULL UNIQUE,
    password  VARCHAR2(255)  NOT NULL,          -- store hashed in production
    role      VARCHAR2(20)   NOT NULL           -- 'admin' | 'professor' | 'student'
);

-- ─── ADMIN ──────────────────────────────────────────────────
CREATE TABLE admin (
    admin_id  VARCHAR2(20)  PRIMARY KEY REFERENCES cms_users(user_id),
    full_name VARCHAR2(100) NOT NULL,
    email     VARCHAR2(100),
    phone     VARCHAR2(20),
    address   VARCHAR2(200)
);

-- ─── PROFESSOR ──────────────────────────────────────────────
CREATE TABLE professor (
    prof_id   VARCHAR2(20)  PRIMARY KEY REFERENCES cms_users(user_id),
    full_name VARCHAR2(100) NOT NULL,
    email     VARCHAR2(100),
    phone     VARCHAR2(20),
    address   VARCHAR2(200),
    dept      VARCHAR2(100)
);

-- ─── STUDENT ────────────────────────────────────────────────
CREATE TABLE student (
    student_id VARCHAR2(20)  PRIMARY KEY REFERENCES cms_users(user_id),
    full_name  VARCHAR2(100) NOT NULL,
    email      VARCHAR2(100),
    phone      VARCHAR2(20),
    address    VARCHAR2(200),
    class      VARCHAR2(50)
);

-- ─── ATTENDANCE ─────────────────────────────────────────────
CREATE TABLE attendance (
    att_id     NUMBER         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id VARCHAR2(20)   NOT NULL REFERENCES student(student_id),
    subject    VARCHAR2(100)  NOT NULL,
    att_date   DATE           NOT NULL,
    status     VARCHAR2(10)   NOT NULL CHECK (status IN ('Present','Absent'))
);

-- ─── MARKS ──────────────────────────────────────────────────
CREATE TABLE marks (
    mark_id    NUMBER        GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id VARCHAR2(20)  NOT NULL REFERENCES student(student_id),
    subject    VARCHAR2(100) NOT NULL,
    marks      NUMBER(5,2)   NOT NULL CHECK (marks BETWEEN 0 AND 100)
);

-- ─── HOMEWORK / ASSIGNMENTS ─────────────────────────────────
CREATE TABLE homework (
    hw_id      NUMBER         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    prof_id    VARCHAR2(20)   NOT NULL REFERENCES professor(prof_id),
    title      VARCHAR2(200)  NOT NULL,
    class      VARCHAR2(50)   NOT NULL,
    subject    VARCHAR2(100)  NOT NULL,
    due_date   DATE           NOT NULL,
    description CLOB
);

-- ─── DOUBTS / QUESTIONS ─────────────────────────────────────
CREATE TABLE doubt (
    doubt_id    NUMBER         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id  VARCHAR2(20)   NOT NULL REFERENCES student(student_id),
    subject     VARCHAR2(100)  NOT NULL,
    question    CLOB           NOT NULL,
    answer      CLOB,
    asked_on    DATE           DEFAULT SYSDATE,
    answered_on DATE,
    status      VARCHAR2(20)   DEFAULT 'Pending' CHECK (status IN ('Pending','Answered'))
);

-- ============================================================
-- SEED DATA
-- ============================================================

-- Users
INSERT INTO cms_users VALUES ('A001', 'admin',   'admin123',    'admin');
INSERT INTO cms_users VALUES ('P001', 'prof1',   'prof123',     'professor');
INSERT INTO cms_users VALUES ('P002', 'prof2',   'prof123',     'professor');
INSERT INTO cms_users VALUES ('S2401','alice',   'alice123',    'student');
INSERT INTO cms_users VALUES ('S2400','bob',     'bob123',      'student');
INSERT INTO cms_users VALUES ('S2399','carol',   'carol123',    'student');

-- Admin
INSERT INTO admin VALUES ('A001','Dr. Admin User','admin@cms.edu','9876543210','Campus HQ');

-- Professors
INSERT INTO professor VALUES ('P001','Prof. Ravi Kumar','ravi@cms.edu','9000000001','Dept of CS','Computer Science');
INSERT INTO professor VALUES ('P002','Prof. Meena Sharma','meena@cms.edu','9000000002','Dept of Maths','Mathematics');

-- Students
INSERT INTO student VALUES ('S2401','Alice Johnson','alice@cms.edu','9111111111','Block A','CS 101');
INSERT INTO student VALUES ('S2400','Bob Smith',    'bob@cms.edu',  '9111111112','Block B','Math 101');
INSERT INTO student VALUES ('S2399','Carol Lee',    'carol@cms.edu','9111111113','Block C','Eng 201');

-- Attendance
INSERT INTO attendance (student_id,subject,att_date,status) VALUES ('S2401','Mathematics',DATE '2026-04-24','Present');
INSERT INTO attendance (student_id,subject,att_date,status) VALUES ('S2401','Physics',    DATE '2026-04-23','Absent');
INSERT INTO attendance (student_id,subject,att_date,status) VALUES ('S2401','Mathematics',DATE '2026-04-22','Present');
INSERT INTO attendance (student_id,subject,att_date,status) VALUES ('S2401','English',    DATE '2026-04-21','Present');
INSERT INTO attendance (student_id,subject,att_date,status) VALUES ('S2400','Mathematics',DATE '2026-04-24','Absent');
INSERT INTO attendance (student_id,subject,att_date,status) VALUES ('S2400','Physics',    DATE '2026-04-23','Present');
INSERT INTO attendance (student_id,subject,att_date,status) VALUES ('S2399','Chemistry',  DATE '2026-04-24','Present');
INSERT INTO attendance (student_id,subject,att_date,status) VALUES ('S2399','Chemistry',  DATE '2026-04-22','Present');

-- Marks
INSERT INTO marks (student_id,subject,marks) VALUES ('S2401','Mathematics',88);
INSERT INTO marks (student_id,subject,marks) VALUES ('S2401','Physics',72);
INSERT INTO marks (student_id,subject,marks) VALUES ('S2400','Mathematics',45);
INSERT INTO marks (student_id,subject,marks) VALUES ('S2400','English',65);
INSERT INTO marks (student_id,subject,marks) VALUES ('S2399','Chemistry',91);

-- Homework
INSERT INTO homework (prof_id,title,class,subject,due_date,description)
  VALUES ('P002','Assignment 1: Linear Algebra','Math 101','Mathematics',DATE '2026-05-10','Complete matrix operations and eigenvalue problems.');
INSERT INTO homework (prof_id,title,class,subject,due_date,description)
  VALUES ('P001','Assignment 2: Programming Basics','CS 101','Computer Science',DATE '2026-05-20','Write a console program that reads and processes data per the spec.');
INSERT INTO homework (prof_id,title,class,subject,due_date,description)
  VALUES ('P001','Assignment 3: Research Write-up','Eng 201','English',DATE '2026-06-01','Submit a 1500-word research essay with references.');

-- Doubts
INSERT INTO doubt (student_id,subject,question,asked_on,status)
  VALUES ('S2401','Mathematics','How do I compute the determinant of a 4×4 matrix?',DATE '2026-04-20','Pending');

COMMIT;
