--Scalar subquery in SELECT
SELECT 
    s.StudentID,
    s.Name,
    (SELECT COUNT(*) 
     FROM Enrollments e 
     WHERE e.StudentID = s.StudentID) AS TotalCourses
FROM Students s;

-- Correlated subquery in WHERE
SELECT 
    s.Name
FROM Students s
WHERE EXISTS (
    SELECT 1 
    FROM Enrollments e JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
    WHERE e.StudentID = s.StudentID AND g.Grade > 50
);

--subquery in FROM
SELECT 
    Title,
    AvgGrade
FROM (
    SELECT 
        c.Title,
        AVG(g.Grade) AS AvgGrade
    FROM Courses c
    JOIN Enrollments e ON c.CourseID = e.CourseID
    JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
    GROUP BY c.Title
) AS CourseStats
WHERE AvgGrade > 60;

--Subquery with IN
SELECT 
    Name
FROM Students
WHERE StudentID IN (
    SELECT StudentID 
    FROM Enrollments 
    WHERE CourseID = '8'
);

--subquery with = operator
SELECT 
    s.StudentID,
    s.Name,
    g.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Grades g ON g.EnrollmentID = e.EnrollmentID
WHERE g.Grade = (
    SELECT MAX(Grade)
    FROM Grades
);
--Subquery with EXISTS
SELECT 
    Title
FROM Courses c
WHERE EXISTS (
    SELECT 1 
    FROM Enrollments e 
    WHERE e.CourseID = c.CourseID
);

