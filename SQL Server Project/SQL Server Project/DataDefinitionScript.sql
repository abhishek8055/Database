--Make sure you are running query on right database
USE SchoolManagement_DB;

--Create Database
CREATE DATABASE SchoolManagement_Db

--Rename Database name
ALTER DATABASE SchoolManagementDB MODIFY NAME = SchoolManagement_DB

--Delete a database
DROP DATABASE SchoolManagement_DB

--Delete Table
DROP Table Student

--Rename Table
EXEC sp_rename 'Student', 'Students'

--Create Table
Create Table Students (
	Id int Primary Key Identity not null,
	FirstName nvarchar(15) not null,
	LastName nvarchar(15),
	DateOfBirthB Date,
	StudentId nvarchar(10) unique
)

--Alter Table
Alter Table Students Alter Column DateOfBirth date null

