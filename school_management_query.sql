-- Retrieve details of all student that are taking a course and count how many courses each student are taking
SELECT student_grade.person_id, first_name, COUNT(course_id)
FROM person
JOIN student_grade
ON student_grade.Person_Id = person.Person_Id
WHERE Discriminator = "student"
GROUP BY First_Name, person.Person_Id;

-- What is the name of instructor that have not teach any course
SELECT person.person_id, First_Name
FROM person
LEFT JOIN course_instructor
ON course_instructor.Person_Id = person.Person_Id
WHERE Discriminator = "instructor" AND course_instructor.Person_Id IS NULL;

-- Is there any department that has No instructor
SELECT person.person_id, First_Name
FROM department
LEFT JOIN course
ON course.Department_Id = department.department_id
LEFT JOIN course_instructor
ON course_instructor.Course_Id = course.Course_Id
LEFT JOIN person
ON person.Person_Id = course_instructor.Person_Id
WHERE Discriminator = "Instructor" AND course.Department_Id IS NULL;

-- Which instructor does not have a department
SELECT First_Name, Dep_Name
FROM person
LEFT JOIN course_instructor
ON person.Person_Id = course_instructor.Person_Id
LEFT JOIN course
ON course.Course_Id = course_instructor.Course_Id
LEFT JOIN department
ON department.Department_Id = course.Department_Id
WHERE Discriminator = "instructor" AND dep_name IS NULL;


-- Calculate the average course credit load and the total budget for each department. 
-- List the results and order them by total budget (highest to lowest). Include the department name (Dep_Name).
SELECT dep_name, ROUND(AVG(credits), 2) average_course_credit, ROUND(SUM(budget), 2) total_budget
FROM department
INNER JOIN course
ON department.department_id = course.department_id
GROUP BY dep_name
ORDER BY total_budget DESC;

-- Retrieve the full name (First Name + Last Name) of all people who are explicitly designated as an 'Instructor' 
-- (Discriminator in the Person table). For each instructor, also list the title of all courses they are currently 
-- assigned to teach. Order the results by the instructor's last name.
SELECT CONCAT(first_name," ", Last_name) Full_name, title
FROM person
JOIN course_instructor
ON course_instructor.person_id = person.person_id
JOIN course
ON course.course_id = course_instructor.course_id
WHERE discriminator = 'Instructor'
ORDER BY last_name;

-- Create a report showing the title of every course and its Delivery Type ('Online', 'Onsite', or 'Both')
SELECT title,
CASE
WHEN SC.course_id IS NOT NULL AND LC.Course_Id IS NOT NULL THEN "Both"
WHEN SC.Course_Id IS NOT NULL THEN "Onsite"
WHEN LC.Course_Id IS NOT NULL THEN "Online"
ELSE "Undefined"
END AS Delivery_type
FROM course C
LEFT JOIN onsite_course SC
ON C.course_id = SC.course_id
LEFT JOIN online_course LC
ON C.Course_Id = LC.Course_Id;



-- Find the full name of all people who are enrolled as 'Student' (Discriminator is 'Student') and have received a grade of 'A'.
-- Show the student's name, the course title, and the grade they received.
SELECT CONCAT(first_name, " ", last_name) full_name, title course_title, grade
FROM person
JOIN student_grade
ON student_grade.Person_Id = person.Person_Id
JOIN course
ON course.Course_Id = student_grade.Course_Id
WHERE Discriminator = 'Student' AND grade = 'A';


-- List the full name of all instructors who were hired before '2021-01-01' and are currently teaching more than two (2) courses.
-- Show their hire date and the total number of courses they teach.
SELECT CONCAT(first_name," ", Last_name) Full_name, Instructor_Hire_Date, COUNT(course_id) Number_of_Courses
FROM person
JOIN course_instructor
ON person.Person_Id = course_instructor.Person_Id
WHERE discriminator = "instructor" AND Instructor_Hire_Date < "2021-01-01"
GROUP BY full_name, Instructor_Hire_Date
HAVING number_of_courses >= 2;


-- Find the Course Title of all courses listed in the Course table that do not have an entry in the Course_Instructor table.
SELECT course.course_id, title, credits
FROM course
LEFT JOIN course_instructor
ON course.Course_Id = course_instructor.Course_Id
WHERE course_instructor.Course_Id IS NULL