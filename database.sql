-- ============================================================
-- STUDENT SKILL & INTERNSHIP TRACKER
-- DBMS Mini Project
-- Database: SQLite
-- ============================================================


-- ============================================================
-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE STUDENT (
    Student_ID INTEGER PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(30),
    Semester INTEGER,
    CGPA DECIMAL(4,2)
);

CREATE TABLE SKILL (
    Skill_ID INTEGER PRIMARY KEY,
    Skill_Name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE STUDENT_SKILL (
    Student_ID INTEGER,
    Skill_ID INTEGER,
    PRIMARY KEY (Student_ID, Skill_ID),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Skill_ID) REFERENCES SKILL(Skill_ID)
);

CREATE TABLE COMPANY (
    Company_ID INTEGER PRIMARY KEY,
    Company_Name VARCHAR(100) UNIQUE NOT NULL,
    Location VARCHAR(50)
);

CREATE TABLE INTERNSHIP_APPLICATION (
    Application_ID INTEGER PRIMARY KEY,
    Student_ID INTEGER,
    Company_ID INTEGER,
    Status VARCHAR(30) DEFAULT 'Applied',
    Application_Date DATE,
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Company_ID) REFERENCES COMPANY(Company_ID)
);


-- ============================================================
-- 2. INSERT STUDENT DATA
-- ============================================================

INSERT INTO STUDENT
(Student_ID, Name, Department, Semester, CGPA)
VALUES
(101, 'Arjun', 'AIML', 3, 8.50),
(102, 'Rahul', 'CSE', 3, 7.80),
(103, 'Priya', 'AIML', 2, 9.10),
(104, 'Anjali', 'ECE', 3, 8.20),
(105, 'Ravi', 'CSE', 4, 6.90),
(106, 'Sneha', 'AIML', 3, 8.80),
(107, 'Kiran', 'IT', 2, 7.40),
(108, 'Aman', 'CSE', 3, 6.50),
(109, 'Varun', 'AIML', 4, 9.00),
(110, 'Neha', 'ECE', 2, 7.70);


-- ============================================================
-- 3. INSERT SKILL DATA
-- ============================================================

INSERT INTO SKILL
(Skill_ID, Skill_Name)
VALUES
(1, 'C++'),
(2, 'Python'),
(3, 'SQL'),
(4, 'Java'),
(5, 'HTML'),
(6, 'CSS'),
(7, 'JavaScript'),
(8, 'Git');


-- ============================================================
-- 4. CONNECT STUDENTS WITH SKILLS
-- ============================================================

INSERT INTO STUDENT_SKILL
(Student_ID, Skill_ID)
VALUES
(101, 1),
(101, 2),
(101, 3),

(102, 1),
(102, 3),
(102, 8),

(103, 2),
(103, 3),
(103, 4),

(104, 5),
(104, 6),

(105, 1),
(105, 3),
(105, 8),

(106, 2),
(106, 3),
(106, 7),

(107, 1),
(107, 8),

(108, 1),
(108, 3),

(109, 2),
(109, 3),
(109, 4),

(110, 5),
(110, 6),
(110, 7);


-- ============================================================
-- 5. INSERT COMPANY DATA
-- ============================================================

INSERT INTO COMPANY
(Company_ID, Company_Name, Location)
VALUES
(201, 'Google', 'Bangalore'),
(202, 'Microsoft', 'Hyderabad'),
(203, 'Infosys', 'Pune'),
(204, 'TCS', 'Mumbai'),
(205, 'Wipro', 'Bangalore'),
(206, 'Tech Mahindra', 'Pune');


-- ============================================================
-- 6. INSERT INTERNSHIP APPLICATIONS
-- ============================================================

INSERT INTO INTERNSHIP_APPLICATION
(Application_ID, Student_ID, Company_ID, Status, Application_Date)
VALUES
(1, 101, 201, 'Applied', '2026-08-01'),
(2, 101, 203, 'Under Review', '2026-08-05'),
(3, 102, 202, 'Applied', '2026-08-03'),
(4, 103, 201, 'Selected', '2026-07-28'),
(5, 103, 204, 'Applied', '2026-08-02'),
(6, 104, 203, 'Rejected', '2026-07-30'),
(7, 105, 204, 'Under Review', '2026-08-04'),
(8, 106, 201, 'Applied', '2026-08-06'),
(9, 106, 205, 'Selected', '2026-07-25'),
(10, 107, 206, 'Applied', '2026-08-07'),
(11, 108, 204, 'Rejected', '2026-07-29'),
(12, 109, 202, 'Under Review', '2026-08-01'),
(13, 109, 201, 'Applied', '2026-08-08'),
(14, 110, 205, 'Applied', '2026-08-09');


-- ============================================================
-- 7. BASIC STUDENT REPORT
-- ============================================================

SELECT *
FROM STUDENT;


-- ============================================================
-- 8. STUDENT SKILL REPORT
-- ============================================================

SELECT
    STUDENT.Name,
    SKILL.Skill_Name
FROM STUDENT
JOIN STUDENT_SKILL
    ON STUDENT.Student_ID = STUDENT_SKILL.Student_ID
JOIN SKILL
    ON STUDENT_SKILL.Skill_ID = SKILL.Skill_ID
ORDER BY STUDENT.Name;


-- ============================================================
-- 9. FIND STUDENTS WHO KNOW PYTHON
-- ============================================================

SELECT
    STUDENT.Name
FROM STUDENT
JOIN STUDENT_SKILL
    ON STUDENT.Student_ID = STUDENT_SKILL.Student_ID
JOIN SKILL
    ON STUDENT_SKILL.Skill_ID = SKILL.Skill_ID
WHERE SKILL.Skill_Name = 'Python';


-- ============================================================
-- 10. STUDENTS WITH CGPA ABOVE 8
-- ============================================================

SELECT
    Student_ID,
    Name,
    Department,
    CGPA
FROM STUDENT
WHERE CGPA > 8
ORDER BY CGPA DESC;


-- ============================================================
-- 11. STUDENTS WHO HAVE NOT APPLIED
-- ============================================================

SELECT
    STUDENT.Student_ID,
    STUDENT.Name
FROM STUDENT
LEFT JOIN INTERNSHIP_APPLICATION
    ON STUDENT.Student_ID = INTERNSHIP_APPLICATION.Student_ID
WHERE INTERNSHIP_APPLICATION.Student_ID IS NULL;


-- ============================================================
-- 12. INTERNSHIP STATUS REPORT
-- ============================================================

SELECT
    Status,
    COUNT(*) AS Total_Applications
FROM INTERNSHIP_APPLICATION
GROUP BY Status;


-- ============================================================
-- 13. COMPLETE INTERNSHIP REPORT
-- ============================================================

SELECT
    STUDENT.Name,
    COMPANY.Company_Name,
    INTERNSHIP_APPLICATION.Status
FROM STUDENT
JOIN INTERNSHIP_APPLICATION
    ON STUDENT.Student_ID = INTERNSHIP_APPLICATION.Student_ID
JOIN COMPANY
    ON INTERNSHIP_APPLICATION.Company_ID = COMPANY.Company_ID;


-- ============================================================
-- 14. SELECTED STUDENTS
-- ============================================================

SELECT
    STUDENT.Name,
    COMPANY.Company_Name,
    INTERNSHIP_APPLICATION.Status
FROM STUDENT
JOIN INTERNSHIP_APPLICATION
    ON STUDENT.Student_ID = INTERNSHIP_APPLICATION.Student_ID
JOIN COMPANY
    ON INTERNSHIP_APPLICATION.Company_ID = COMPANY.Company_ID
WHERE INTERNSHIP_APPLICATION.Status = 'Selected';


-- ============================================================
-- 15. APPLICATIONS UNDER REVIEW
-- ============================================================

SELECT
    STUDENT.Name,
    COMPANY.Company_Name,
    INTERNSHIP_APPLICATION.Application_Date
FROM STUDENT
JOIN INTERNSHIP_APPLICATION
    ON STUDENT.Student_ID = INTERNSHIP_APPLICATION.Student_ID
JOIN COMPANY
    ON INTERNSHIP_APPLICATION.Company_ID = COMPANY.Company_ID
WHERE INTERNSHIP_APPLICATION.Status = 'Under Review';


-- ============================================================
-- 16. APPLICATIONS FOR GOOGLE
-- ============================================================

SELECT
    STUDENT.Name,
    INTERNSHIP_APPLICATION.Status
FROM STUDENT
JOIN INTERNSHIP_APPLICATION
    ON STUDENT.Student_ID = INTERNSHIP_APPLICATION.Student_ID
JOIN COMPANY
    ON INTERNSHIP_APPLICATION.Company_ID = COMPANY.Company_ID
WHERE COMPANY.Company_Name = 'Google';


-- ============================================================
-- 17. APPLICATIONS PER COMPANY
-- ============================================================

SELECT
    COMPANY.Company_Name,
    COUNT(INTERNSHIP_APPLICATION.Application_ID) AS Total_Applications
FROM COMPANY
LEFT JOIN INTERNSHIP_APPLICATION
    ON COMPANY.Company_ID = INTERNSHIP_APPLICATION.Company_ID
GROUP BY COMPANY.Company_ID, COMPANY.Company_Name
ORDER BY Total_Applications DESC;


-- ============================================================
-- 18. MOST APPLIED COMPANY
-- ============================================================

SELECT
    COMPANY.Company_Name,
    COUNT(INTERNSHIP_APPLICATION.Application_ID) AS Total_Applications
FROM COMPANY
JOIN INTERNSHIP_APPLICATION
    ON COMPANY.Company_ID = INTERNSHIP_APPLICATION.Company_ID
GROUP BY COMPANY.Company_ID, COMPANY.Company_Name
ORDER BY Total_Applications DESC
LIMIT 1;


-- ============================================================
-- 19. DEPARTMENT-WISE STUDENT COUNT
-- ============================================================

SELECT
    Department,
    COUNT(*) AS Total_Students
FROM STUDENT
GROUP BY Department
ORDER BY Total_Students DESC;


-- ============================================================
-- 20. DEPARTMENT-WISE AVERAGE CGPA
-- ============================================================

SELECT
    Department,
    ROUND(AVG(CGPA), 2) AS Average_CGPA
FROM STUDENT
GROUP BY Department
ORDER BY Average_CGPA DESC;


-- ============================================================
-- 21. STUDENTS ABOVE AVERAGE CGPA
-- ============================================================

SELECT
    Student_ID,
    Name,
    Department,
    CGPA
FROM STUDENT
WHERE CGPA > (
    SELECT AVG(CGPA)
    FROM STUDENT
)
ORDER BY CGPA DESC;


-- ============================================================
-- 22. HIGHEST CGPA STUDENT
-- ============================================================

SELECT
    Student_ID,
    Name,
    Department,
    CGPA
FROM STUDENT
WHERE CGPA = (
    SELECT MAX(CGPA)
    FROM STUDENT
);


-- ============================================================
-- 23. SECOND-HIGHEST CGPA
-- ============================================================

SELECT
    Student_ID,
    Name,
    Department,
    CGPA
FROM STUDENT
WHERE CGPA = (
    SELECT MAX(CGPA)
    FROM STUDENT
    WHERE CGPA < (
        SELECT MAX(CGPA)
        FROM STUDENT
    )
);


-- ============================================================
-- 24. STUDENTS WHO KNOW BOTH C++ AND SQL
-- ============================================================

SELECT
    STUDENT.Name
FROM STUDENT
JOIN STUDENT_SKILL
    ON STUDENT.Student_ID = STUDENT_SKILL.Student_ID
JOIN SKILL
    ON STUDENT_SKILL.Skill_ID = SKILL.Skill_ID
WHERE SKILL.Skill_Name IN ('C++', 'SQL')
GROUP BY STUDENT.Student_ID, STUDENT.Name
HAVING COUNT(DISTINCT SKILL.Skill_Name) = 2;


-- ============================================================
-- 25. STUDENTS WITH 3 OR MORE SKILLS
-- ============================================================

SELECT
    STUDENT.Name,
    COUNT(STUDENT_SKILL.Skill_ID) AS Total_Skills
FROM STUDENT
JOIN STUDENT_SKILL
    ON STUDENT.Student_ID = STUDENT_SKILL.Student_ID
GROUP BY STUDENT.Student_ID, STUDENT.Name
HAVING COUNT(STUDENT_SKILL.Skill_ID) >= 3
ORDER BY Total_Skills DESC;


-- ============================================================
-- 26. INTERNSHIP ELIGIBILITY REPORT
-- Rule: CGPA >= 8 and at least one skill
-- ============================================================

SELECT
    STUDENT.Student_ID,
    STUDENT.Name,
    STUDENT.Department,
    STUDENT.CGPA
FROM STUDENT
WHERE STUDENT.CGPA >= 8.0
AND EXISTS (
    SELECT 1
    FROM STUDENT_SKILL
    WHERE STUDENT_SKILL.Student_ID = STUDENT.Student_ID
);


-- ============================================================
-- 27. ELIGIBLE STUDENTS WHO HAVE NOT APPLIED
-- ============================================================

SELECT
    STUDENT.Student_ID,
    STUDENT.Name,
    STUDENT.Department,
    STUDENT.CGPA
FROM STUDENT
WHERE STUDENT.CGPA >= 8.0
AND EXISTS (
    SELECT 1
    FROM STUDENT_SKILL
    WHERE STUDENT_SKILL.Student_ID = STUDENT.Student_ID
)
AND NOT EXISTS (
    SELECT 1
    FROM INTERNSHIP_APPLICATION
    WHERE INTERNSHIP_APPLICATION.Student_ID = STUDENT.Student_ID
);


-- ============================================================
-- 28. CREATE STUDENT REPORT VIEW
-- ============================================================

CREATE VIEW Student_Report AS
SELECT
    Student_ID,
    Name,
    Department,
    Semester,
    CGPA
FROM STUDENT;


-- ============================================================
-- 29. CREATE HIGH CGPA VIEW
-- ============================================================

CREATE VIEW High_CGPA_Students AS
SELECT
    Student_ID,
    Name,
    Department,
    CGPA
FROM STUDENT
WHERE CGPA >= 8.0;


-- ============================================================
-- 30. CREATE INTERNSHIP REPORT VIEW
-- ============================================================

CREATE VIEW Internship_Report AS
SELECT
    STUDENT.Name AS Student_Name,
    STUDENT.Department,
    STUDENT.CGPA,
    COMPANY.Company_Name,
    COMPANY.Location,
    INTERNSHIP_APPLICATION.Status,
    INTERNSHIP_APPLICATION.Application_Date
FROM STUDENT
JOIN INTERNSHIP_APPLICATION
    ON STUDENT.Student_ID = INTERNSHIP_APPLICATION.Student_ID
JOIN COMPANY
    ON INTERNSHIP_APPLICATION.Company_ID = COMPANY.Company_ID;


-- ============================================================
-- 31. VIEW STUDENT REPORT
-- ============================================================

SELECT *
FROM Student_Report;


-- ============================================================
-- 32. VIEW HIGH CGPA STUDENTS
-- ============================================================

SELECT *
FROM High_CGPA_Students;


-- ============================================================
-- 33. VIEW INTERNSHIP REPORT
-- ============================================================

SELECT *
FROM Internship_Report;


-- ============================================================
-- 34. UPDATE APPLICATION STATUS
-- ============================================================

UPDATE INTERNSHIP_APPLICATION
SET Status = 'Under Review'
WHERE Application_ID = 3;


-- ============================================================
-- 35. CHECK UPDATED APPLICATION
-- ============================================================

SELECT *
FROM INTERNSHIP_APPLICATION
WHERE Application_ID = 3;


-- ============================================================
-- 36. FINAL PROJECT REPORT
-- ============================================================

SELECT
    STUDENT.Name,
    STUDENT.Department,
    STUDENT.CGPA,
    COMPANY.Company_Name,
    INTERNSHIP_APPLICATION.Status
FROM STUDENT
JOIN INTERNSHIP_APPLICATION
    ON STUDENT.Student_ID = INTERNSHIP_APPLICATION.Student_ID
JOIN COMPANY
    ON INTERNSHIP_APPLICATION.Company_ID = COMPANY.Company_ID
ORDER BY STUDENT.CGPA DESC;
