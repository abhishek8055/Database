USE [SchoolManagement_DB]

------------------------------------SP 1 without parameter---------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SelectAllStudents
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

--RUN
EXECUTE [dbo].[sp_SelectAllStudents]
EXEC [dbo].[sp_SelectAllStudents]

----------------------------------SP 2 with parameter-------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_SelectStudentById
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

--RUN
EXECUTE [dbo].[sp_SelectStudentById]
EXECUTE [dbo].[sp_SelectStudentById][1478523756]
EXECUTE [dbo].[sp_SelectStudentById] @StudentId = 1478523756


----------------------SP 3 with Insert query and return value------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spin_InsertStudent
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

--RUN
DECLARE @Id int
EXECUTE [dbo].[spin_InsertStudent] 
	'Yash', 
	'Dhuyal', 
	'1996-11-23',
	'XAD6755',
	1,
	@Id OUTPUT

SELECT @Id

--RUN 2
DECLARE @id int
EXECUTE [dbo].[spin_InsertStudent] 'Yashika', 'Dhruva', '1996-01-24', 'XAD2758', 2, @id OUTPUT
Execute [dbo].[sp_SelectStudentById] @id


----------------------SP 3 with Insert query without return value------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spin_InsertStudent2
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

--RUN
EXECUTE [dbo].[spin_InsertStudent2] 
	@FirstName = 'Amit', 
	@Lastname = 'Mishra', 
	@DateOfBirth = NULL, 
	@StudentId = 'XAD6276', 
	@ProgramId = NULL

EXECUTE [dbo].[spin_InsertStudent2] 
	@FirstName = 'Dhruv', 
	@Lastname = 'Gosain', 
	@StudentId = 'XAD7865'