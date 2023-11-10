USE [master]
GO
/****** Object:  Database [SchoolManagement_DB]    Script Date: 11/10/2023 5:44:56 PM ******/
CREATE DATABASE [SchoolManagement_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchoolManagement_Db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SchoolManagement_Db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SchoolManagement_Db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SchoolManagement_Db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SchoolManagement_DB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SchoolManagement_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SchoolManagement_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SchoolManagement_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SchoolManagement_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SchoolManagement_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SchoolManagement_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SchoolManagement_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SchoolManagement_DB] SET  MULTI_USER 
GO
ALTER DATABASE [SchoolManagement_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SchoolManagement_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SchoolManagement_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SchoolManagement_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SchoolManagement_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SchoolManagement_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SchoolManagement_DB] SET QUERY_STORE = ON
GO
ALTER DATABASE [SchoolManagement_DB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SchoolManagement_DB]
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_GetAllSchoolPersonnel]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnc_GetAllSchoolPersonnel]
(
	
)
RETURNS 
@SchoolPersonnel TABLE 
(
	-- Add the column definitions for the TABLE variable here
	PersonnelId nvarchar(10),
	Name nvarchar(100),
	DateOfBirth Date,
	PersonnelType nvarchar(15)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	INSERT INTO @SchoolPersonnel
	SELECT
		StudentId,
		FirstName + ' ' + LastName,
		DateOfBirth,
		'Student'
	FROM Students

	INSERT INTO @SchoolPersonnel
	SELECT
		StaffId,
		FirstName + ' ' + LastName,
		DateOfBirth,
		'Lecturer'
	FROM Lecturers

	RETURN 
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_GetHighestGradeOfStudent]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Abhishek Dwivedi
-- Create date: 11/09/2023
-- Description:	Function takes student id as input parameter and returns the highest grade from enrolment table
-- =============================================
CREATE FUNCTION [dbo].[fnc_GetHighestGradeOfStudent] 
(
	-- Add the parameters for the function here
	@StudentId nvarchar
)
RETURNS decimal(3,1)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @HighestGrade decimal(3,1)

	-- Add the T-SQL statements to compute the return value here
	SELECT @HighestGrade = Max(Grade) from Enrollments WHERE StudentId = @StudentId

	-- Return the result of the function
	RETURN @HighestGrade

END
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[ClassId] [int] NULL,
	[Grade] [nvarchar](2) NULL,
 CONSTRAINT [PK_Enrollments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_GetGradeRange]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnc_GetGradeRange]
(	
	-- Add the parameters for the function here
	@minGrade decimal(3,1),
	@maxGrade decimal(3,1)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT Grade FROM Enrollments WHERE Grade BETWEEN @minGrade AND @maxGrade
)
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_GetEnrollmentByGradeRange]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnc_GetEnrollmentByGradeRange]
(	
	-- Add the parameters for the function here
	@minGrade decimal(3,1),
	@maxGrade decimal(3,1)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT * FROM Enrollments WHERE Grade BETWEEN @minGrade AND @maxGrade
)
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LecturerId] [int] NULL,
	[CourseId] [int] NULL,
	[Time] [time](7) NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](10) NOT NULL,
	[Credits] [int] NOT NULL,
	[ProgrammeOfStudyId] [int] NULL,
	[CourseType] [nvarchar](10) NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecturers]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecturers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NULL,
	[StaffId] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Lecturers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProgrammeOfStudy]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgrammeOfStudy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[DurationInYears] [decimal](10, 0) NOT NULL,
 CONSTRAINT [PK_ProgrammeOfStudy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[School- Branches]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[School- Branches](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NULL,
 CONSTRAINT [PK_School- Branches] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NULL,
	[StudentId] [nvarchar](10) NOT NULL,
	[ProgrammeOfStudyId] [int] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (2, 19, 1, CAST(N'12:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (3, 19, 2, CAST(N'13:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (4, 20, 3, CAST(N'10:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (5, 20, 5, CAST(N'08:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (6, 21, 6, CAST(N'15:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (7, 21, 6, CAST(N'12:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (8, 22, 7, CAST(N'13:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (9, 22, 3, CAST(N'10:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (10, 23, 3, CAST(N'08:00:00' AS Time))
GO
INSERT [dbo].[Classes] ([Id], [LecturerId], [CourseId], [Time]) VALUES (11, 23, 5, CAST(N'15:00:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 
GO
INSERT [dbo].[Courses] ([Id], [Name], [Code], [Credits], [ProgrammeOfStudyId], [CourseType]) VALUES (1, N'Database Development', N'DB101', 3, 1, NULL)
GO
INSERT [dbo].[Courses] ([Id], [Name], [Code], [Credits], [ProgrammeOfStudyId], [CourseType]) VALUES (2, N'C# Development', N'CS103', 5, 1, NULL)
GO
INSERT [dbo].[Courses] ([Id], [Name], [Code], [Credits], [ProgrammeOfStudyId], [CourseType]) VALUES (3, N'JavaScript Development', N'JS590', 4, 3, NULL)
GO
INSERT [dbo].[Courses] ([Id], [Name], [Code], [Credits], [ProgrammeOfStudyId], [CourseType]) VALUES (5, N'MERN Crash', N'MERN15', 5, 2, NULL)
GO
INSERT [dbo].[Courses] ([Id], [Name], [Code], [Credits], [ProgrammeOfStudyId], [CourseType]) VALUES (6, N'Java Fundamentals', N'JAVA101', 4, 4, NULL)
GO
INSERT [dbo].[Courses] ([Id], [Name], [Code], [Credits], [ProgrammeOfStudyId], [CourseType]) VALUES (7, N'Ruby on Rails', N'RB341', 3, 2, N'Part-Time')
GO
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Enrollments] ON 
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (6, 1, 2, N'78')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (7, 2, 3, N'82')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (8, 3, 4, N'65')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (9, 4, 5, N'89')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (10, 1, 6, N'76')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (11, 1, 3, N'98')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (12, 2, 7, N'45')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (13, 2, 5, N'87')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (14, 2, 7, N'86')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (15, 2, 2, N'56')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (16, 3, 7, N'68')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (17, 3, 2, N'78')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (18, 3, 5, N'45')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (19, 4, 2, N'32')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (20, 4, 3, N'87')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (21, 4, 6, N'45')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (22, 4, 4, N'98')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (23, 4, 7, N'89')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentId], [ClassId], [Grade]) VALUES (28, 3, 3, N'76')
GO
SET IDENTITY_INSERT [dbo].[Enrollments] OFF
GO
SET IDENTITY_INSERT [dbo].[Lecturers] ON 
GO
INSERT [dbo].[Lecturers] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (19, N'Shirish', N'Bhardwaj', CAST(N'1985-12-12' AS Date), N'XHD987')
GO
INSERT [dbo].[Lecturers] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (20, N'Mohit', N'Bodhankar', CAST(N'1983-01-07' AS Date), N'XHD0986')
GO
INSERT [dbo].[Lecturers] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (21, N'Praveen K', N'Sharma', CAST(N'1988-11-02' AS Date), N'XHD351')
GO
INSERT [dbo].[Lecturers] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (22, N'Heather', N'Driver', NULL, N'147857')
GO
INSERT [dbo].[Lecturers] ([Id], [FirstName], [LastName], [DateOfBirth], [StaffId]) VALUES (23, N'Christy', N'Oborg', NULL, N'147497')
GO
SET IDENTITY_INSERT [dbo].[Lecturers] OFF
GO
SET IDENTITY_INSERT [dbo].[ProgrammeOfStudy] ON 
GO
INSERT [dbo].[ProgrammeOfStudy] ([Id], [Name], [DurationInYears]) VALUES (1, N'B.Tech in Computer Science', CAST(4 AS Decimal(10, 0)))
GO
INSERT [dbo].[ProgrammeOfStudy] ([Id], [Name], [DurationInYears]) VALUES (2, N'M.Tech in Computer Science', CAST(2 AS Decimal(10, 0)))
GO
INSERT [dbo].[ProgrammeOfStudy] ([Id], [Name], [DurationInYears]) VALUES (3, N'Bsc. in Computer Science', CAST(3 AS Decimal(10, 0)))
GO
INSERT [dbo].[ProgrammeOfStudy] ([Id], [Name], [DurationInYears]) VALUES (4, N'Diploma in IT', CAST(2 AS Decimal(10, 0)))
GO
INSERT [dbo].[ProgrammeOfStudy] ([Id], [Name], [DurationInYears]) VALUES (5, N'N/A', CAST(0 AS Decimal(10, 0)))
GO
SET IDENTITY_INSERT [dbo].[ProgrammeOfStudy] OFF
GO
SET IDENTITY_INSERT [dbo].[School- Branches] ON 
GO
INSERT [dbo].[School- Branches] ([Id], [Name], [Address]) VALUES (1, N'Civil Lines', N'Prayagraj')
GO
INSERT [dbo].[School- Branches] ([Id], [Name], [Address]) VALUES (2, N'Baily', N'Prayagraj')
GO
SET IDENTITY_INSERT [dbo].[School- Branches] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (1, N'Peter', N'Johnson', CAST(N'1991-08-09' AS Date), N'1478523685', 1)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (2, N'Peter', N'Pan', CAST(N'1991-08-09' AS Date), N'1478523756', 2)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (3, N'John', N'Paul', CAST(N'1991-08-09' AS Date), N'1478523678', 3)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (4, N'Matthew', N'Swanson', CAST(N'1991-08-09' AS Date), N'1278523696', 3)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (5, N'Abhishek', N'Dwivedi', NULL, N'XAD6876', NULL)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (7, N'Medha', N'Mishra', NULL, N'XAD6879', NULL)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (8, N'Pranjali', N'Xyua', CAST(N'1996-12-23' AS Date), N'XAD6897', NULL)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (9, N'Yash', N'Dhuyal', CAST(N'1996-11-23' AS Date), N'XAD6755', 1)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (10, N'Amit', N'Mishra', NULL, N'XAD6276', NULL)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (11, N'Kishan', N'Kumar', NULL, N'XAD1879', NULL)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (12, N'Yashika', N'Dhruva', CAST(N'1996-01-24' AS Date), N'XAD2755', 2)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (14, N'Yashika', N'Dhruva', CAST(N'1996-01-24' AS Date), N'XAD2758', 2)
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [DateOfBirth], [StudentId], [ProgrammeOfStudyId]) VALUES (15, N'Dhruv', N'Gosain', NULL, N'XAD7865', 5)
GO
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Courses]    Script Date: 11/10/2023 5:44:56 PM ******/
ALTER TABLE [dbo].[Courses] ADD  CONSTRAINT [IX_Courses] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Lecturers]    Script Date: 11/10/2023 5:44:56 PM ******/
ALTER TABLE [dbo].[Lecturers] ADD  CONSTRAINT [IX_Lecturers] UNIQUE NONCLUSTERED 
(
	[StaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Students]    Script Date: 11/10/2023 5:44:56 PM ******/
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [IX_Students] UNIQUE NONCLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT ('Regular') FOR [CourseType]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_Courses] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_Courses]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_Lecturers] FOREIGN KEY([LecturerId])
REFERENCES [dbo].[Lecturers] ([Id])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_Lecturers]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_ProgrammeOfStudy] FOREIGN KEY([ProgrammeOfStudyId])
REFERENCES [dbo].[ProgrammeOfStudy] ([Id])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_ProgrammeOfStudy]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Classes] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Classes]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Students]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_ProgrammeOfStudy] FOREIGN KEY([ProgrammeOfStudyId])
REFERENCES [dbo].[ProgrammeOfStudy] ([Id])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_ProgrammeOfStudy]
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectAllStudents]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectAllStudents]
	-- Add the parameters for the stored procedure here
	--@StudentId int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Students
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectStudentById]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectStudentById]
	-- Add the parameters for the stored procedure here
	@StudentId nvarchar(10) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Students WHERE StudentId = @StudentId
END
GO
/****** Object:  StoredProcedure [dbo].[spin_InsertStudent]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spin_InsertStudent]
	-- Add the parameters for the stored procedure here
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@DateOfBirth Date = NULL,
	@StudentId nvarchar(10),
	@ProgramId int = NULL,
	@Id int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Students (FirstName, LastName, DateOfBirth, StudentId, ProgrammeOfStudyId) 
		VALUES
			(@FirstName, @LastName, @DateOfBirth, @StudentId, @ProgramId)
	SELECT @Id = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[spin_InsertStudent2]    Script Date: 11/10/2023 5:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spin_InsertStudent2]
	-- Add the parameters for the stored procedure here
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@DateOfBirth Date = NULL,
	@StudentId nvarchar(10),
	@ProgramId int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Students (FirstName, LastName, DateOfBirth, StudentId, ProgrammeOfStudyId) 
		VALUES
			(@FirstName, @LastName, @DateOfBirth, @StudentId, @ProgramId)
END
GO
USE [master]
GO
ALTER DATABASE [SchoolManagement_DB] SET  READ_WRITE 
GO
