# Student Skill & Internship Tracker

This is a small SQL/DBMS mini project I made to practice database concepts using a practical student internship tracking system.

The project stores student details, their skills, company information, and internship applications in different tables.

## What This Project Contains

* Student details and CGPA
* Skills of students
* Company details
* Internship applications
* Application status such as Applied, Selected, Rejected, and Under Review

## Database Tables

There are 5 tables in this project:

1. `STUDENT` – Stores student information.
2. `SKILL` – Stores the skills available in the database.
3. `STUDENT_SKILL` – Connects students with their skills.
4. `COMPANY` – Stores company details and locations.
5. `INTERNSHIP_APPLICATION` – Stores internship applications and their current status.

## SQL Concepts I Practiced

* Creating tables
* Inserting data
* SELECT queries
* UPDATE
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* Aggregate functions
* JOIN
* LEFT JOIN
* Subqueries
* EXISTS
* NOT EXISTS
* Primary Key
* Foreign Key
* UNIQUE
* NOT NULL
* DEFAULT
* Views

## Some Queries in the Project

I used SQL queries to:

* Display students and their skills
* Find students with a particular skill
* Find students with a CGPA above a specific value
* Find students who have not applied for an internship
* Check internship application status
* Find applications for a particular company
* Count applications for each company
* Calculate department-wise average CGPA
* Find students above the average CGPA
* Find the highest and second-highest CGPA
* Generate reports using SQL Views

## Tools Used

* SQL
* SQLite
* Programiz Online SQL Compiler

## Project Structure

```text
student-skill-internship-tracker/
├── database.sql
└── README.md
```

## About the Project

I created this project to improve my understanding of SQL and DBMS by working with multiple related tables and writing queries for different situations.

It is a small practice project, but it helped me understand how tables can be connected and how SQL can be used to get useful information from a database.
