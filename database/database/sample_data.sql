-- Sample data for Student Management System

-- Insert departments
INSERT INTO departments (name, code, building, phone)
VALUES 
('Computer Science', 'CS', 'Science Building', '555-1000'),
('Mathematics', 'MATH', 'Science Building', '555-1001'),
('English', 'ENG', 'Humanities Building', '555-2000');

-- Insert programs
INSERT INTO programs (department_id, name, degree_level, total_credits)
VALUES
(1, 'Computer Science', 'Bachelor', 120),
(1, 'Data Science', 'Master', 36),
(2, 'Mathematics', 'Bachelor', 120),
(3, 'English Literature', 'Bachelor', 120);

-- Insert faculty
INSERT INTO faculty (first_name, last_name, email, phone, department_id, title, office_location)
VALUES
('John', 'Smith', 'jsmith@university.edu', '555-1101', 1, 'Professor', 'SB-201'),
('Sarah', 'Johnson', 'sjohnson@university.edu', '555-1102', 1, 'Associate Professor', 'SB-202'),
('Robert', 'Williams', 'rwilliams@university.edu', '555-2101', 2, 'Professor', 'SB-301'),
('Emily', 'Brown', 'ebrown@university.edu', '555-2201', 3, 'Assistant Professor', 'HB-101');

-- Insert students
INSERT INTO students (first_name, last_name, email, phone, address, date_of_birth, enrollment_date, program_id, status)
VALUES
('Michael', 'Davis', 'mdavis@student.university.edu', '555-3001', '123 College St', '2000-05-15', '2022-09-01', 1, 'active'),
('Jessica', 'Miller', 'jmiller@student.university.edu', '555-3002', '456 University Ave', '2001-02-20', '2022-09-01', 1, 'active'),
('David', 'Wilson', 'dwilson@student.university.edu', '555-3003', '789 Campus Rd', '1999-11-10', '2021-09-01', 3, 'active'),
('Jennifer', 'Taylor', 'jtaylor@student.university.edu', '555-3004', '321 Scholar Ln', '2000-07-25', '2022-09-01', 4, 'active');

-- Insert courses
INSERT INTO courses (department_id, code, name, description, credits)
VALUES
(1, 'CS101', 'Introduction to Programming', 'Fundamentals of programming using Python', 4),
(1, 'CS201', 'Data Structures', 'Study of fundamental data structures and algorithms', 4),
(1, 'CS301', 'Database Systems', 'Design and implementation of database systems', 3),
(2, 'MATH101', 'Calculus I', 'Differential and integral calculus', 4),
(3, 'ENG101', 'Composition I', 'Introduction to academic writing', 3);

-- Insert prerequisites
INSERT INTO prerequisites (course_id, required_course_id, minimum_grade)
VALUES
(2, 1, 'C'), -- CS201 requires CS101 with at least C
(3, 2, 'C'); -- CS301 requires CS201 with at least C

-- Insert course sections
INSERT INTO course_sections (course_id, faculty_id, semester, section_number, schedule, location, capacity)
VALUES
(1, 1, 'Fall 2023', '01', 'MWF 10:00-10:50', 'SB-101', 30),
(1, 2, 'Fall 2023', '02', 'TTh 13:00-14:15', 'SB-102', 25),
(2, 1, 'Fall 2023', '01', 'MWF 11:00-11:50', 'SB-101', 30),
(3, 2, 'Spring 2024', '01', 'TTh 10:00-11:15', 'SB-103', 20),
(4, 3, 'Fall 2023', '01', 'MWF 09:00-09:50', 'SB-201', 35),
(5, 4, 'Fall 2023', '01', 'TTh 11:00-12:15', 'HB-105', 25);

-- Insert enrollments
INSERT INTO enrollments (student_id, section_id, status, grade)
VALUES
(1, 1, 'completed', 'A'),
(1, 3, 'completed', 'B'),
(1, 5, 'completed', 'A'),
(2, 1, 'completed', 'B'),
(2, 3, 'completed', 'A'),
(3, 5, 'completed', 'C'),
(4, 6, 'completed', 'A'),
(1, 4, 'registered', NULL),
(2, 4, 'registered', NULL);

-- Insert advising relationships
INSERT INTO advising (student_id, faculty_id, start_date, is_primary)
VALUES
(1, 1, '2022-09-01', TRUE),
(2, 1, '2022-09-01', TRUE),
(3, 3, '2021-09-01', TRUE),
(4, 4, '2022-09-01', TRUE);

-- Insert advising notes
INSERT INTO advising_notes (advising_id, notes, created_by_faculty_id)
VALUES
(1, 'Discussed course selection for next semester. Recommended taking CS301.', 1),
(1, 'Student is progressing well. GPA is 3.5.', 1),
(4, 'Interested in creative writing courses for next term.', 4);

-- Insert users
INSERT INTO users (username, password_hash, role, associated_id)
VALUES
('admin', 'hashed_admin_password', 'admin', NULL),
('jsmith', 'hashed_faculty_password', 'faculty', 1),
('sjohnson', 'hashed_faculty_password', 'faculty', 2),
('mdavis', 'hashed_student_password', 'student', 1),
('jmiller', 'hashed_student_password', 'student', 2);
