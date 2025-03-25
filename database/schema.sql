-- Database schema for Student Management System

CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

-- Departments table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    building VARCHAR(50),
    phone VARCHAR(20)
);

-- Programs table
CREATE TABLE programs (
    program_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    degree_level VARCHAR(50) NOT NULL, -- Bachelor, Master, PhD
    total_credits INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Students table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    date_of_birth DATE,
    enrollment_date DATE NOT NULL,
    program_id INT,
    graduation_date DATE,
    status ENUM('active', 'inactive', 'graduated', 'suspended') DEFAULT 'active',
    FOREIGN KEY (program_id) REFERENCES programs(program_id)
);

-- Faculty table
CREATE TABLE faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department_id INT NOT NULL,
    title VARCHAR(50), -- Professor, Associate Professor, etc.
    office_location VARCHAR(50),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Courses table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    credits INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE (department_id, code),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Course offerings (sections)
CREATE TABLE course_sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    faculty_id INT,
    semester VARCHAR(20) NOT NULL, -- Fall 2023, Spring 2024, etc.
    section_number VARCHAR(10) NOT NULL,
    schedule VARCHAR(100), -- Days and times
    location VARCHAR(50),
    capacity INT NOT NULL,
    enrolled INT DEFAULT 0,
    UNIQUE (course_id, semester, section_number),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Prerequisites
CREATE TABLE prerequisites (
    prerequisite_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    required_course_id INT NOT NULL,
    minimum_grade VARCHAR(2),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (required_course_id) REFERENCES courses(course_id),
    UNIQUE (course_id, required_course_id)
);

-- Student enrollments
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('registered', 'waitlisted', 'dropped', 'completed') DEFAULT 'registered',
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (section_id) REFERENCES course_sections(section_id),
    UNIQUE (student_id, section_id)
);

-- Advising relationships
CREATE TABLE advising (
    advising_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    faculty_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    is_primary BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id),
    UNIQUE (student_id, faculty_id)
);

-- Advising notes
CREATE TABLE advising_notes (
    note_id INT AUTO_INCREMENT PRIMARY KEY,
    advising_id INT NOT NULL,
    note_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT NOT NULL,
    created_by_faculty_id INT NOT NULL,
    FOREIGN KEY (advising_id) REFERENCES advising(advising_id),
    FOREIGN KEY (created_by_faculty_id) REFERENCES faculty(faculty_id)
);

-- Users table for authentication
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'faculty', 'student') NOT NULL,
    associated_id INT, -- Student_id or faculty_id
    last_login TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Indexes for performance optimization
CREATE INDEX idx_students_program ON students(program_id);
CREATE INDEX idx_students_status ON students(status);
CREATE INDEX idx_enrollments_student ON enrollments(student_id);
CREATE INDEX idx_enrollments_section ON enrollments(section_id);
CREATE INDEX idx_enrollments_status ON enrollments(status);
CREATE INDEX idx_course_sections_course ON course_sections(course_id);
CREATE INDEX idx_course_sections_faculty ON course_sections(faculty_id);
CREATE INDEX idx_advising_student ON advising(student_id);
CREATE INDEX idx_advising_faculty ON advising(faculty_id);
