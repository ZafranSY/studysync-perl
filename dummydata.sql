-- Inserting into sessionSemester
INSERT INTO sessionSemester (semester_id) 
VALUES 
        ('2024/2025-1'),
        ('2024/2025-2');

-- Inserting into roles
INSERT INTO roles (role_name) 
VALUES 
        ('Academic Officer'),
        ('Pensyarah'), 
        ('Pelajar FSKSM'); 


-- Inserting into user
INSERT INTO user (full_name, login_name, email, role_id, session_id, successful_logins, last_login) 
VALUES 
        ('John Academic', 'johnAcad', 'johnAcad@utm.com', 1, '313', 5, NOW()), 
        ('John AcadeOwo', 'johnAcadowo', 'johnAcadowo@utm.com', 1, '314', 5, NOW()), 
        ('John Officer', 'johnOFF', 'johnOFF@utm.com', 1, '315', 5, NOW()), 
        ('John Pensyarah', 'johnPen', 'johnPen@utm.com', 2, 'qw', 10, NOW()),
        ('John Lecturer', 'johnLect', 'johnLect@utm.com', 2, 'qq', 10, NOW()),
        ('John Dr.', 'johnDr', 'johnDr@utm.com', 2, 'qo', 10, NOW()),
        ('John Pengajar', 'johnPeng', 'johnPeng@utm.com', 2, 'qo', 10, NOW()),
        ('John Cikgu.', 'johnCeg', 'johnCeg@utm.com', 2, 'qo', 10, NOW()),
        ('John Student', 'johnStu', 'johnStu@utm.com', 3, 'ab', 10, NOW());

-- Inserting into Categories
INSERT INTO Categories (category, semester_id) 
VALUES 
        ('PSM 1', '2024/2025-1'),
        ('Research', '2024/2025-1'),
        ('Training', '2024/2025-1'),
        ('Timetable', '2024/2025-1'),
        ('Course Coordination', '2024/2025-1'),
        ('Course Files', '2024/2025-1'),
        
        ('PSM 2', '2024/2025-2'),
        ('Course Coordination', '2024/2025-2'),
        ('Timetable', '2024/2025-2'),
        ('Course Files', '2024/2025-2'),
        ('Workshop', '2024/2025-2'),
        ('Internship', '2024/2025-2'),
        ('Personal','2024/2025-2');


-- Inserting into gdlinks
INSERT INTO gdlinks (category, sessem, ref_name, description, owner, link) 
VALUES 
        ('PSM 1', '2024/2025-1', 'Marks Rubric', 'PSM 1 marking sheets', 'johnAcad@utm.com', 'http://google.com'),
        ('PSM 1', '2024/2025-1', 'List of Approved Titles', 'PSM Titles approved by the board', 'johnAcad@utm.com', 'http://google.com'),
        ('PSM 1', '2024/2025-1', 'List of Candidates', 'Candidates List', 'johnAcad@utm.com', 'http://google.com'),
        ('Research', '2024/2025-1', 'Marks Rubric', 'Research marking sheets', 'johnAcad@utm.com', 'http://google.com'),
        ('Research', '2024/2025-1', 'List of Approved Titles', 'Research Titles approved by the board', 'johnAcad@utm.com', 'http://google.com'),
        ('Research', '2024/2025-1', 'List of Candidates', 'Candidates List', 'johnAcad@utm.com', 'http://google.com'),
        ('Training', '2024/2025-1', 'List of Deliverables', 'Details on the deliverables during training', 'johnAcad@utm.com', 'http://google.com'),
        ('Training', '2024/2025-1', 'List of Approved Companies', 'Companies approved by the faculty', 'johnAcad@utm.com', 'http://google.com'),
        ('Training', '2024/2025-1', 'List of Candidates', 'Candidates List enlisted for training', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-1', 'SECJH-1st', 'Timetable for secjh 1st year', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-1', 'SECJH-2nd', 'Timetable for secjh 2nd year', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-1', 'SECJH-3rd', 'Timetable for secjh 3rd year', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-1', 'SECJH-4th', 'Timetable for secjh 4th year', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-1', 'FSEK-1st', 'Timetable for FSEK 1st year', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-1', 'FSEK-2nd', 'Timetable for FSEK 2nd year', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-1', 'FSEK-3rd', 'Timetable for FSEK 3rd year', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-1', 'FSEK-4th', 'Timetable for FSEK 4th year', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Course Coordination', '2024/2025-1', 'FC CC', 'Course Coordination for Computing Students', 'johnAcad@utm.com', 'http://google.com'),
        ('Course Coordination', '2024/2025-1', 'FKE CC', 'Course Coordination for Electrical Students', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Course Coordination', '2024/2025-1', 'FS CC', 'Course Coordination for Science Students', 'johnOFF@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECJ3104-01', 'Topic 01 for App Dev ', 'johnPen@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECJ3104-02', 'Topic 02 for App Dev ', 'johnPen@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECJ3104-03', 'Topic 03 for App Dev ', 'johnPen@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECJ3104-04', 'Topic 04 for App Dev ', 'johnPen@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECJ3303-01', 'Topic 01 for Internet Programming ', 'johnLect@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECJ3303-02', 'Topic 02 for Internet Programming ', 'johnLect@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECJ3303-03', 'Topic 03 for Internet Programming ', 'johnLect@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECJ3303-04', 'Topic 04 for Internet Programming ', 'johnLect@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECR3432-01', 'Topic 01 for Cryptography ', 'johnDr@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECR3432-02', 'Topic 02 for Cryptography ', 'johnDr@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECR3432-03', 'Topic 03 for Cryptography ', 'johnDr@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'SECR3432-04', 'Topic 04 for Cryptography ', 'johnDr@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'FESM2301-01', 'Topic 01 for Material Science ', 'johnCeg@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'FESM2301-02', 'Topic 02 for Material Science ', 'johnCeg@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'FESM2301-03', 'Topic 03 for Material Science ', 'johnCeg@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'FESM2301-04', 'Topic 04 for Material Science ', 'johnCeg@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'FEVK2431-01', 'Topic 01 for Electronics ', 'johnPeng@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'FEVK2431-02', 'Topic 02 for Electronics ', 'johnPeng@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'FEVK2431-03', 'Topic 03 for Electronics ', 'johnPeng@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-1', 'FEVK2431-04', 'Topic 04 for Electronics ', 'johnPeng@utm.com', 'http://google.com'),
        

        ('PSM 2', '2024/2025-2', 'Marks Rubric', 'PSM 2 marking sheets', 'johnAcad@utm.com', 'http://google.com'),
        ('PSM 2', '2024/2025-2', 'List of Approved Titles', 'PSM Titles approved by the board', 'johnAcad@utm.com', 'http://google.com'),
        ('PSM 2', '2024/2025-2', 'List of Candidates', 'Candidates List', 'johnAcad@utm.com', 'http://google.com'),
        ('Course Coordination', '2024/2025-2', 'FC CC', 'Course Coordination for Computing Students', 'johnAcad@utm.com', 'http://google.com'),
        ('Course Coordination', '2024/2025-2', 'FKE CC', 'Course Coordination for Electrical Students', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Course Coordination', '2024/2025-2', 'FS CC', 'Course Coordination for Science Students', 'johnOFF@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-2', 'SECJH-1st', 'Timetable for secjh 1st year', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-2', 'SECJH-2nd', 'Timetable for secjh 2nd year', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-2', 'SECJH-3rd', 'Timetable for secjh 3rd year', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-2', 'SECJH-4th', 'Timetable for secjh 4th year', 'johnAcad@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-2', 'FSEK-1st', 'Timetable for FSEK 1st year', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-2', 'FSEK-2nd', 'Timetable for FSEK 2nd year', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-2', 'FSEK-3rd', 'Timetable for FSEK 3rd year', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Timetable', '2024/2025-2', 'FSEK-4th', 'Timetable for FSEK 4th year', 'johnAcadowo@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECJ2104-01', 'Topic 01 for Data Structure ', 'johnPen@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECJ2104-02', 'Topic 02 for Data Structure ', 'johnPen@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECJ2104-03', 'Topic 03 for Data Structure ', 'johnPen@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECJ2104-04', 'Topic 04 for Data Structure ', 'johnPen@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECJ1023-01', 'Topic 01 for Technique Programming ', 'johnLect@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECJ1023-02', 'Topic 02 for Technique Programming ', 'johnLect@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECJ1023-03', 'Topic 03 for Technique Programming ', 'johnLect@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECJ1023-04', 'Topic 04 for Technique Programming ', 'johnLect@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECR4123-01', 'Topic 01 for RSA  ', 'johnDr@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECR4123-02', 'Topic 02 for RSA  ', 'johnDr@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECR4123-03', 'Topic 03 for RSA  ', 'johnDr@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'SECR4123-04', 'Topic 04 for RSA  ', 'johnDr@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'FQEW2121-01', 'Topic 01 for Quantum Physics ', 'johnCeg@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'FQEW2121-02', 'Topic 02 for Quantum Physics ', 'johnCeg@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'FQEW2121-03', 'Topic 03 for Quantum Physics ', 'johnCeg@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'FQEW2121-04', 'Topic 04 for Quantum Physics ', 'johnCeg@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'FERR2325-01', 'Topic 01 for Motors and Robots ', 'johnPeng@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'FERR2325-02', 'Topic 02 for Motors and Robots ', 'johnPeng@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'FERR2325-03', 'Topic 03 for Motors and Robots ', 'johnPeng@utm.com', 'http://google.com'),
        ('Course Files', '2024/2025-2', 'FERR2325-04', 'Topic 04 for Motors and Robots ', 'johnPeng@utm.com', 'http://google.com'),
        ('Workshop', '2024/2025-2', 'WORKSHOP-AD-01', 'Workshop on Application Development', 'johnAcad@utm.com', 'http://google.com'),
        ('Workshop', '2024/2025-2', 'WORKSHOP-IP-01', 'Workshop on Internet Programming', 'johnLect@utm.com', 'http://google.com'),
        ('Workshop', '2024/2025-2', 'WORKSHOP-CR', 'Workshop on Cryptography', 'johnDr@utm.com', 'http://google.com'),
        ('Internship', '2024/2025-2', 'Opportunities', 'Internship Opportunities for Students', 'johnAcad@utm.com', 'http://google.com'),
        ('Internship', '2024/2025-2', 'Placement', 'Internship Placements for Engineering Students', 'johnAcad@utm.com', 'http://google.com'),
        
        ('Personal', '2024/2025-2', 'Daily Schedule', 'Personal daily schedule', 'johnStu@utm.com', 'http://google.com'),
        ('Personal', '2024/2025-2', 'To-Do List', 'Tasks and reminders for the semester', 'johnStu@utm.com', 'http://google.com'),
        ('Personal', '2024/2025-2', 'Notes Archive', 'Collection of personal notes', 'johnStu@utm.com', 'http://google.com'),
        ('Personal', '2024/2025-2', 'Resource Links', 'Bookmarks for useful resources', 'johnStu@utm.com', 'http://google.com');

