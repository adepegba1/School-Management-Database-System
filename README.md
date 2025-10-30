# 🏫 School Management Database System
## 📘 Introduction
The School Management Database Project is a structured SQL-based system designed to model the academic and administrative relationships within a school environment. The project simulates a real-world school system, including departments, courses, instructors, and students, and supports both onsite and online learning delivery.
The main objectives of the project are:
- To design and implement a normalized relational database that supports efficient data management.
- To explore key SQL concepts such as joins, constraints, subqueries, and aggregate functions.
- To analyze the relationships between departments, instructors, students, and courses.
- To extract actionable insights using queries and reports that mimic real institutional data operations.

## ⚙️ Methodology
### Database Design
  The database was created using MySQL and consists of seven primary tables:
  	
  <table>
    <thead>
      <tr>
        <th>Table</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Department</td>
        <td>Stores department details (name, budget, administrator, and start date).</td>
      </tr>
      <tr>
        <td>Person</td>
        <td>Contains both instructors and students (distinguished using a Discriminator column).</td>
      </tr>
      <tr>
        <td>Course</td>
        <td>Lists all available courses, including credits and department affiliation.</td>
      </tr>
      <tr>
        <td>Onsite_Course</td>
        <td>Defines location, days, and time for in-person courses.</td>
      </tr>
      <tr>
        <td>Online_Course</td>
        <td>Contains URLs for online learning materials.</td>
      </tr>
      <tr>
        <td>Student_Grade</td>
        <td>Tracks student performance and course enrollment.</td>
      </tr>
      <tr>
        <td>Course_Instructor</td>
        <td>Maps instructors to the courses they teach.</td>
      </tr>      
    </tbody>
  </table>

### Data Insertion
Each table was populated with realistic sample data covering:
- 5 Departments
- 11 Courses
- 10 People (5 instructors, 5 students)
- Multiple delivery types (Online/Onsite/Both)

### Relationships
Key relationships were defined using foreign keys with constraints:
- Department ↔ Course: One-to-many
- Person ↔ Student_Grade: One-to-many
- Person ↔ Course_Instructor: One-to-many
- Course ↔ Online_Course / Onsite_Course: One-to-one

<p>This ensured referential integrity and cascade behavior (e.g., deleting a department removes its courses).</p>

### Analytical Queries
A series of advanced SQL queries were executed to explore and analyze the database:
- Aggregations (AVG, SUM, COUNT)
- Conditional logic (CASE WHEN)
- Joins (Inner, Left, and Multi-table joins)
- Filtering using WHERE, HAVING, and date comparisons

## 📊 Findings
### 1. Student Course Enrollments
```sql
SELECT student_grade.person_id, first_name, COUNT(course_id)
FROM person
JOIN student_grade ON student_grade.Person_Id = person.Person_Id
WHERE Discriminator = "student"
GROUP BY First_Name, person.Person_Id;
```
Finding:
- Each student is enrolled in 1–3 courses. Brendan and Victoria appear most active, indicating higher academic engagement.

### 2. Instructors Without Assigned Courses
```sql
SELECT person.person_id, First_Name
FROM person
LEFT JOIN course_instructor ON course_instructor.Person_Id = person.Person_Id
WHERE Discriminator = "instructor" AND course_instructor.Person_Id IS NULL;
```
Finding:
- Some instructors (e.g., Nancy Sanchez) have not yet been assigned to teach any course — a potential issue in workload distribution.

### 3. Departments Without Active Instructors
```sql
SELECT person.person_id, First_Name
FROM department
LEFT JOIN course ON course.Department_Id = department.department_id
LEFT JOIN course_instructor ON course_instructor.Course_Id = course.Course_Id
LEFT JOIN person ON person.Person_Id = course_instructor.Person_Id
WHERE Discriminator = "Instructor" AND course.Department_Id IS NULL;
```
Finding:
- All departments currently have at least one assigned instructor, ensuring proper staffing across programs.

### 4. Departmental Credit Load and Budgets
```sql
SELECT dep_name, ROUND(AVG(credits), 2) average_course_credit, 
ROUND(SUM(budget), 2) total_budget
FROM department
INNER JOIN course ON department.department_id = course.department_id
GROUP BY dep_name
ORDER BY total_budget DESC;
```
Finding:
- Biological Sciences has the highest budget allocation, while Law operates with the lowest, suggesting prioritization of STEM disciplines.

### 5. Instructor-Course Assignments
```sql
SELECT CONCAT(first_name," ", Last_name) Full_name, title
FROM person
JOIN course_instructor ON course_instructor.person_id = person.person_id
JOIN course ON course.course_id = course_instructor.course_id
WHERE discriminator = 'Instructor'
ORDER BY last_name;
```
Finding:
- Instructors like Brendan Raje and Randall Diaz are actively engaged in multiple courses, while others handle fewer, indicating varying workloads.

### 6. Course Delivery Type
```sql
SELECT title,
CASE
WHEN SC.course_id IS NOT NULL AND LC.Course_Id IS NOT NULL THEN "Both"
WHEN SC.Course_Id IS NOT NULL THEN "Onsite"
WHEN LC.Course_Id IS NOT NULL THEN "Online"
ELSE "Undefined"
END AS Delivery_type
FROM course C
LEFT JOIN onsite_course SC ON C.course_id = SC.course_id
LEFT JOIN online_course LC ON C.Course_Id = LC.Course_Id;
```
Finding:
- A hybrid learning system exists, with both onsite and online delivery modes supporting flexible education.

### 7. Top Performing Students
```sql
SELECT CONCAT(first_name, " ", last_name) full_name, title course_title, grade
FROM person
JOIN student_grade ON student_grade.Person_Id = person.Person_Id
JOIN course ON course.Course_Id = student_grade.Course_Id
WHERE Discriminator = 'Student' AND grade = 'A';
```
Finding:
- Students Benjamin Jackson and Nathaniel Howard earned top grades across multiple courses, showing academic excellence.

### 8. Senior Instructors (Pre-2021 hires)
```sql
SELECT CONCAT(first_name," ", Last_name) Full_name, Instructor_Hire_Date, COUNT(course_id) Number_of_Courses
FROM person
JOIN course_instructor ON person.Person_Id = course_instructor.Person_Id
WHERE discriminator = "instructor" AND Instructor_Hire_Date < "2021-01-01"
GROUP BY full_name, Instructor_Hire_Date
HAVING number_of_courses >= 2;
```
Finding:
- Senior instructors hired before 2021, such as Brendan Raje, teach multiple courses, contributing significantly to course delivery.

### 9. Courses Without Assigned Instructors
```sql
SELECT course.course_id, title, credits
FROM course
LEFT JOIN course_instructor ON course.Course_Id = course_instructor.Course_Id
WHERE course_instructor.Course_Id IS NULL;
```
Finding:
- Some courses (e.g., Contract Law and Microbiology) have no assigned instructors — highlighting areas needing staffing attention.

## 💡 Recommendations

- **Instructor Workload Balancing:**
Redistribute teaching assignments to ensure equal workloads among instructors.

- **Department Budget Review:**
Reassess underfunded departments (e.g., Law) to ensure equitable resource allocation.

- **Course Coverage Assurance:**
Assign instructors to uncovered courses to maintain teaching quality and availability.

- **Encourage Online Integration:**
Expand hybrid course delivery (Online + Onsite) to increase flexibility and enrollment reach.

- **Performance Tracking:**
Introduce automatic alerts for failing students to initiate early intervention and academic support.

## 🧾 Conclusion

This project demonstrates the power of SQL relational modeling and analysis in managing academic operations.
Through effective table design, data normalization, and analytical queries, the system provides valuable insights into:

- Academic structure and resource allocation
- Instructor workload and teaching distribution
- Student performance tracking
- Hybrid education delivery optimization
