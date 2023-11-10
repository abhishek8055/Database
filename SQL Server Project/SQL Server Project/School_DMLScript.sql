USE SchoolManagement_DB;

--Insert Query multiple columns (pass values in order of columns specified)
Insert into Lecturers (FirstName, LastName, DateOfBirth, StaffId) Values 
	('Shirish', 'Bhardwaj', '12/12/1985', 'XHD987'),
	('Mohit', 'Bodhankar', '01/07/1983', 'XHD0986'),
	('Praveen K', 'Sharma', '11/02/1988', 'XHD351')

--Insert with column names (pass all attributes in order of table design specified)
INSERT INTO Lecturers VALUES 
	('Heather', 'Driver', null, '147857'),
	('Christy', 'Oborg', null, '147497')

--Update Query
Update Lecturers set StaffId = 'XHD901' where Id = 11

--[] use case : 
/*
	[] is helpful to ingnore extra whitespaces from the schema names
	there is a table named "School- Branches"
	this table can't be accessed using: select * from school- branches
*/
--For spaced schema use []
Select * from [SchoolManagement_DB].[dbo].[School- Branches]


--CASE Query
Select 
	Id,
	FirstName as [First Name], -- Alias for column using AS, [] because of space
	LastName [Last Name], -- Alias for column example without using AS,  [] because of space
	StaffId EmployeeId, -- Alias for column example, [] not needed
	Case 
		When DateOfBirth is null then '01/01/1900'
		Else DateOfBirth
	End DoB,
	Case
		When StaffId like 'XHD%' then 'Onboarded'
		Else 'Not Onboarded'
		End [Onboard Status] --Have to use [] for spaced values
From Lecturers;


insert into Students values 
('Peter', 'Johnson', '1991-08-09', '1478523685', 1),
('Peter', 'Pan', '1991-08-09', '1478523756', 2),
('John', 'Paul', '1991-08-09', '1478523678', 3),
('Matthew', 'Swanson', '1991-08-09', '1278523696', 3)

insert into classes values
(null, 1, '12:00'), 
(null, 3, '13:00'), 
(null, 1, '10:00'), 
(null, 1, '08:00'), 
(null, 5, '15:00')

insert into Enrollments values
(1, 2, NULL), 
(2, 3, NULL), 
(3, 4, NULL), 
(4, 5, NULL), 
(1, 6, NULL)

select 
	c.Id [Class Id],
	l.FirstName + ' ' + l.LastName [Lecturer],
	c.Time [Class Time]
from Classes c
full join Lecturers l on c.LecturerId = l.Id
		
-- We want classes and who is teaching them
SELECT * FROM Classes c
INNER JOIN Lecturers l ON c.LecturerId = l.Id

-- We want classes and who is teaching them even if no one is assigned
SELECT * FROM Classes c 
LEFT JOIN Lecturers l ON c.LecturerId = l.Id
-- RIGHT JOIN Lecturers l ON c.LecturerId = l.Id

-- FUll Join
SELECT * FROM Classes c 
FULL JOIN Lecturers l ON c.LecturerId = l.Id

-- Cross Join
SELECT * FROM Classes c CROSS JOIN Lecturers

insert into Courses values
('Ruby on Rails', 'RB341', 3, 2, 'Part-Time')

select distinct c.LecturerId, co.Name
from Classes c
inner join Courses co on c.CourseId = co.Id 

select CourseId, LecturerId from Classes group by CourseId, LecturerId

select *  from Classes where LecturerId is null

select LecturerId, count(LecturerId) [Count] from Classes group by LecturerId

select count(LecturerId) [Count] from Classes where LecturerId is null group by LecturerId

select 
	s.FirstName + ' ' + s.LastName [Student Name],
	co.Name [Course Name],
	e.Grade
from Enrollments e
inner join Students s on e.StudentId = s.Id
inner join Classes c on e.ClassId = c.Id
inner join Courses co on c.CourseId = co.Id 
where e.Grade in (select top(3) Grade from Enrollments order by Grade)

select * from Enrollments order by Grade desc

select * from Enrollments 
where StudentId in 
(SELECT top (3) StudentId from Enrollments group by StudentId, Grade having Count(StudentId) = 1
order by Grade desc) 
order by Grade desc

SELECT 
	Id,
	ClassId,
    StudentId,
    Grade,
    LAG(StudentId) OVER (ORDER BY StudentId) AS PreviousValue
FROM Enrollments;

--RATHI'S QUERY
with t1 as (SELECT 
	Id,
	ClassId,
    StudentId,
    Grade,
    LAG(StudentId) OVER (ORDER BY Grade desc) AS PreviousValue
FROM Enrollments)

select top(3) * from t1
where StudentId != PreviousValue or PreviousValue is Null
--ENDS--

SELECT top (3) StudentId from Enrollments group by StudentId, Grade having Count(StudentId) = 1
order by Grade desc

SELECT top (3) StudentId, Grade from Enrollments group by StudentId, Grade
order by Grade desc

--Min & Max
SELECT 
	S.StudentId,
	S.FirstName + ' ' + S.LastName [Student],
	Min(Grade) [Lowest Grade],
	Max(Grade) [Highest Grade],
	Count(ClassId) [Number of Classes]
FROM Enrollments E
INNER JOIN Students S ON  E.StudentId = S.Id
GROUP BY S.StudentId, S.FirstName, S.LastName












