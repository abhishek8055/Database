------------------------------------------Scalar Valued Functions------------------------------------------
/*
	Scalar Valued Functions: Returns one value
		e.g: 
		1. Aggregate Functions: Avg(), Count(), Sum(), Max(), Min() etc.
		2. Date Time Functions: Dateadd(), Datediff(), Datename(), Day(), Month(), Year(), etc.
		3. Mathematical Functions: Sin(), Cos(), Log(), Pi(), Power(), Rand(), Round(), Ceiling(), Floor(), etc.
		4. String Functions: Trim(), Upper(), Lower(), etc.
		Etc.
*/

--System Scalar Function Example--
SELECT GETDATE() [Today's Date], Day(GETDATE()) [Day], Month(GETDATE()) [Month], Year(GETDATE()) [Year];

--Custom Scalar Function--

-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Abhishek Dwivedi
-- Create date: 11/09/2023
-- Description:	Function takes student id as input parameter and returns the highest grade from enrolment table
-- =============================================
CREATE FUNCTION fnc_GetHighestGradeOfStudent 
(
	-- Add the parameters for the function here
	@StudentId int
	--@StudentId int = 1 //Default value is 1
	--@CourseId int = NULL //Default value is Null
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

-----RUN------------------------------------------------------
SELECT [dbo].[fnc_GetHighestGradeOfStudent](2) [Highest Grade]





------------------------------------------********END*********---------------------------------------------------------


--------------------------------------------TABLE-Valued Functions-----------------------------------------------------

/*
	TABLE-Valued Functions
	2 Types
		1. Inline: returns Table
		2. Multi-statement


*/

------------Inline Table Valued Function------------------------------------------

-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnc_GetGradeRange
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

--RUN------
SELECT * FROM [dbo].[fnc_GetGradeRange](40, 90)

---------------------------------********-----------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [fnc_GetEnrollmentByGradeRange]
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

--RUN------
SELECT * FROM [dbo].[fnc_GetEnrollmentByGradeRange](80, 90)
SELECT Grade FROM [dbo].[fnc_GetEnrollmentByGradeRange](80, 90)


------------Multi-Statement Table Valued Function------------------------------------------

-- ================================================
-- Template generated from Template Explorer using:
-- Create Multi-Statement Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnc_GetAllSchoolPersonnel
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

---RUN--------
SELECT * FROM [dbo].[fnc_GetAllSchoolPersonnel]()