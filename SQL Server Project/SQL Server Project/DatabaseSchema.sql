Create Database SchoolManagement_DB
GO
USE SchoolManagement_DB

CREATE TABLE Students(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	StudentId NVARCHAR(10) UNIQUE,
	ProgrammeOfStudy NVARCHAR(150) NOT NULL,
)

CREATE TABLE Lecturers (
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	StaffId NVARCHAR(10) UNIQUE
)

CREATE TABLE Courses (
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Code NVARCHAR(5) UNIQUE,
	Credits int
)

-- Commands to add new column to tables with relationships
ALTER TABLE Students 
ADD ProgrammeOfStudyId int FOREIGN KEY REFERENCES ProgrammesOfStudy(Id)

ALTER TABLE Courses 
ADD ProgrammeOfStudyId int FOREIGN KEY REFERENCES ProgrammesOfStudy(Id)

-- Creating new tables with relationships and foreign keys
CREATE TABLE Classes (
	Id int PRIMARY KEY IDENTITY,
	LecturerId int FOREIGN KEY REFERENCES Lecturers(Id),
	CourseId int FOREIGN KEY REFERENCES Courses(Id),
	[Time] time 
)

CREATE TABLE Enrollments (
	Id int PRIMARY KEY IDENTITY,
	StudentId int FOREIGN KEY REFERENCES Students(Id),
	ClassId int FOREIGN KEY REFERENCES Classes(Id),
	Grade nvarchar(2) 
)

Alter Table Courses Add CourseType nvarchar(10) default 'Regular'



Create Database HCBGDataHub