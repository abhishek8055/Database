USE [master]
GO
/****** Object:  Database [SchoolManagement_DB]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnc_GetAllSchoolPersonnel]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnc_GetHighestGradeOfStudent]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  Table [dbo].[Enrollments]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnc_GetGradeRange]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnc_GetEnrollmentByGradeRange]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  Table [dbo].[Classes]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  Table [dbo].[Courses]    Script Date: 11/10/2023 5:42:39 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Courses] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecturers]    Script Date: 11/10/2023 5:42:39 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Lecturers] UNIQUE NONCLUSTERED 
(
	[StaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProgrammeOfStudy]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  Table [dbo].[School- Branches]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  Table [dbo].[Students]    Script Date: 11/10/2023 5:42:39 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Students] UNIQUE NONCLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
/****** Object:  StoredProcedure [dbo].[sp_SelectAllStudents]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SelectStudentById]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spin_InsertStudent]    Script Date: 11/10/2023 5:42:39 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spin_InsertStudent2]    Script Date: 11/10/2023 5:42:39 PM ******/
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
