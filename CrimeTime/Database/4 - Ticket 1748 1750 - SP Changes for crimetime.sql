/****** Object:  StoredProcedure [dbo].[SP_AddLaw]    Script Date: 1/29/2014 12:23:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 12/18/2013
-- Description:	To add a new law to the system
-- =============================================
ALTER PROCEDURE [dbo].[SP_AddLaw] 
	-- Add the parameters for the stored procedure here
	@LawOrdinal int,
	@FullLawDescription varchar(max),
	@Title varchar(3),
	@Section varchar(9),
	@Subsection varchar(12),
	@Class varchar(4),
	@NYSLawCategory varchar(1000),
	--@Statue varchar(max),
	@EffectiveDate datetime,
	@RepealDate datetime,
	--@JOIndicator int,
	@AttemptedNYSLawCategory varchar(1),
	@AttemptedClass varchar(4),
	@VFIndicator varchar(4),
	@AttemptedVFIndicator varchar(4)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblCrimes
	(
	law_ordinal, 
	full_law_description, 
	title, 
	section, 
	subsection, 
	class, 
	nys_law_category, 
	--statute, 
	selected_laws_indicator, 
	deprecated, 
	effective_date, 
	repeal_date, 
	--jo_indicator, 
	attempted_nys_law_category, 
	attempted_class, 
	vf_indicator, 
	attempted_vf_indicator, 
	Viewable
	)

	VALUES

	(
	@LawOrdinal, 
	@FullLawDescription,
	@Title,
	@Section,
	@Subsection,
	@Class,
	@NYSLawCategory,
	--@Statue,
	0,
	0,
	@EffectiveDate,
	@RepealDate,
	--@JOIndicator,
	@AttemptedNYSLawCategory,
	@AttemptedClass,
	@VFIndicator,
	@AttemptedVFIndicator,
	0
	);

END


/****** Object:  StoredProcedure [dbo].[SP_UpdateLaw]    Script Date: 2/3/2014 8:48:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 12/18/2013
-- Description:	Update law information
-- =============================================
ALTER PROCEDURE [dbo].[SP_UpdateLaw] 
	-- Add the parameters for the stored procedure here
	@CID int,
	@LawOrdinal int,
	@FullLawDescription varchar(max),
	@Title varchar(3),
	@Section varchar(9),
	@Subsection varchar(12),
	@Class varchar(4),
	@NYSLawCategory varchar(1000),
	--@Statue varchar(max),
	@EffectiveDate datetime,
	@RepealDate datetime,
	--@JOIndicator int,
	@AttemptedNYSLawCategory varchar(1),
	@AttemptedClass varchar(4),
	@VFIndicator varchar(4),
	@AttemptedVFIndicator varchar(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblCrimes
	SET 
	law_ordinal = @LawOrdinal, 
	full_law_description = @FullLawDescription,
	title = @Title,
	section = @Section,
	subsection = @Subsection,
	class = @Class,
	nys_law_category = @NYSLawCategory,
	--statute = @Statue,
	effective_date = @EffectiveDate,
	repeal_date = @RepealDate,
	--jo_indicator = @JOIndicator,
	attempted_nys_law_category = @AttemptedNYSLawCategory,
	attempted_class = @AttemptedClass,
	vf_indicator = @VFIndicator,
	attempted_vf_indicator = @AttemptedVFIndicator
	WHERE CrimesID = @CID
END

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/3/2014
-- Description:	
-- =============================================
CREATE PROCEDURE SP_UpdateQuestioninList 
	-- Add the parameters for the stored procedure here
	@QuestionID int,
	@Question varchar(300)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblQuestions 
	SET Literal = @Question
	WHERE QuestionsID = @QuestionID
END
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/4/2014
-- Description:	Delete sentence info
-- =============================================
CREATE PROCEDURE SP_DeleteSentence 
	-- Add the parameters for the stored procedure here
	@CrimeAnswerID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from AnswerLinks
	where CrimeAnswerID = @CrimeAnswerID

	delete from tblCrimeAnswer
	where CrimeAnswerID = @CrimeAnswerID
END
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCrimeName]    Script Date: 2/11/2014 9:23:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetCrimeName]
(
@CRIMEID int,
@CrimeAnswerID int
)
AS
Declare @CID int

If @CrimeID=0
SELECT  @CID= CrimesID
FROM         tblCrimeAnswer
WHERE     (CrimeAnswerID =@CrimeAnswerID)
Else
Set @CID=@CrimeID

SELECT     full_law_description, CrimesID, Viewable, section, title, subsection
FROM         tblCrimes
WHERE     (CrimesID = @CID)

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/11/2014
-- Description:	Check if a question is in use
-- =============================================
CREATE PROCEDURE SP_CheckQuestionInUse 
	-- Add the parameters for the stored procedure here
	@QuestionID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
  SELECT distinct QuestionID
  FROM tblCrimeAnswer
  where QuestionID = @QuestionID
END
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/11/2014
-- Description:	Delete a question from question list
-- =============================================
CREATE PROCEDURE SP_DeleteQuestion 
	-- Add the parameters for the stored procedure here
	@QuestionID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblQuestions
	where QuestionsID = @QuestionID
END
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/11/2014
-- Description:	Check if a paragraph is in use
-- =============================================
CREATE PROCEDURE SP_CheckTopicInUse 
	-- Add the parameters for the stored procedure here
	@TopicID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT distinct AnswerID as TopicID
  FROM AnswerLinks
  where AnswerID = @TopicID
END
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/11/2014
-- Description:	Delete a paragraph
-- =============================================
CREATE PROCEDURE SP_DeleteParagraph 
	-- Add the parameters for the stored procedure here
	@TopicID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Answers
	where AnswerID = @TopicID
END
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCrimeAnswerListByCrimeID]    Script Date: 2/13/2014 8:57:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetCrimeAnswerListByCrimeID]
(
@CRIMEID int,
@CRIMEANSWERID int
)
AS
Declare @CID int
If @CrimeAnswerID=0
Begin
SET @CID=@CRIMEID
END
ELSE
Begin
SELECT  @CID=  CrimesID
FROM         tblCrimeAnswer
WHERE     (CrimeAnswerID =@CrimeAnswerID )
END

SELECT     tblCrimeAnswer.CrimeAnswerID, tblAgeCategory.Literal AS AgeCat, tblFelonyConvictions.Literal AS FelonyCat, tblPastConvictions.Literal AS PastConCat,
                       tblQuestions.Literal AS Question, tblCrimeAnswer.QuestionsResponse, tblCrimeAnswer.Attempted, tblMitigatingFactorQuestions.Short AS Mitigating
FROM         tblCrimeAnswer Left Outer JOIN
                      tblQuestions ON tblCrimeAnswer.QuestionID = tblQuestions.QuestionsID Left Outer JOIN
                      tblAgeCategory ON tblCrimeAnswer.AgeCategory = tblAgeCategory.AgeCategoryID Left Outer JOIN
                      tblFelonyConvictions ON tblCrimeAnswer.FelonyConvictions = tblFelonyConvictions.FelonyConvictionsID Left Outer JOIN
                      tblPastConvictions ON tblCrimeAnswer.PastConvictions = tblPastConvictions.PastConvictionsID LEFT OUTER JOIN
					  tblCrimesMitigatingFactorQuestions ON tblCrimesMitigatingFactorQuestions.CrimesID = tblCrimeAnswer.CrimesID LEFT OUTER JOIN
					  tblMitigatingFactorQuestions ON tblMitigatingFactorQuestions.MitigatingFactorQuestionsID = tblCrimesMitigatingFactorQuestions.MitigatingFactorQuestionsID
WHERE     (tblCrimeAnswer.CrimesID = @CID)

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/18/2014
-- Description:	Update QuestionID in tblCrimeAnswer
-- =============================================
CREATE PROCEDURE SP_UpdateCrimeQuestion 
	-- Add the parameters for the stored procedure here
	@CrimeID int, 
	@QuestionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update tblCrimeAnswer
	set QuestionID = @QuestionID
	where CrimeAnswerID = (	select max(CrimeAnswerID) as CrimeAnsID
							from tblCrimeAnswer
							where CrimesID = @CrimeID)
END
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/18/2014
-- Description:	Retrieve all CrimeAnswerID for a crime from tblCrimeAnswer
-- =============================================
CREATE PROCEDURE SP_GetCrimeAnswers
	-- Add the parameters for the stored procedure here
	@CrimeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select CrimeAnswerID
	from tblCrimeAnswer
	where CrimesID = @CrimeID
END
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/18/2014
-- Description:	Get Pagaragraph link ID's
-- =============================================
CREATE PROCEDURE SP_GetParaLinks 
	-- Add the parameters for the stored procedure here
	@CrimeAnswerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	from AnswerLinks
	where CrimeAnswerID = @CrimeAnswerID
END
GO

/****** Object:  StoredProcedure [dbo].[SP_DeleteSentence]    Script Date: 2/19/2014 2:23:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/4/2014
-- Description:	Delete sentence info
-- =============================================
ALTER PROCEDURE [dbo].[SP_DeleteSentence] 
	-- Add the parameters for the stored procedure here
	@CrimeAnswerID int,
	@CID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from AnswerLinks
	where CrimeAnswerID = @CrimeAnswerID

	delete from tblCrimeAnswer
	where CrimeAnswerID = @CrimeAnswerID

	delete from tblCrimesMitigatingFactorQuestions
	where CrimesID = @CID
END


/****** Object:  StoredProcedure [dbo].[SP_GetCrimeAnswerListByCrimeID]    Script Date: 3/3/2014 8:52:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetCrimeAnswerListByCrimeID]
(
@CRIMEID int,
@CRIMEANSWERID int
)
AS
Declare @CID int

If @CrimeAnswerID=0
Begin
SET @CID=@CRIMEID
END

ELSE
Begin
SELECT  @CID=  CrimesID
FROM         tblCrimeAnswer
WHERE     (CrimeAnswerID =@CrimeAnswerID )
END

SELECT     tblCrimeAnswer.CrimeAnswerID, tblAgeCategory.Literal AS AgeCat, tblFelonyConvictions.Literal AS FelonyCat, tblPastConvictions.Literal AS PastConCat,
                       tblQuestions.Literal AS Question, tblCrimeAnswer.QuestionsResponse, tblCrimeAnswer.Attempted
FROM         tblCrimeAnswer Left Outer JOIN
                      tblQuestions ON tblCrimeAnswer.QuestionID = tblQuestions.QuestionsID Left Outer JOIN
                      tblAgeCategory ON tblCrimeAnswer.AgeCategory = tblAgeCategory.AgeCategoryID Left Outer JOIN
                      tblFelonyConvictions ON tblCrimeAnswer.FelonyConvictions = tblFelonyConvictions.FelonyConvictionsID Left Outer JOIN
                      tblPastConvictions ON tblCrimeAnswer.PastConvictions = tblPastConvictions.PastConvictionsID
WHERE     (tblCrimeAnswer.CrimesID = @CID)


/****** Object:  StoredProcedure [dbo].[SP_UpdateCrimeQuestion]    Script Date: 3/3/2014 12:17:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 2/18/2014
-- Description:	Update QuestionID in tblCrimeAnswer
-- =============================================
ALTER PROCEDURE [dbo].[SP_UpdateCrimeQuestion] 
	-- Add the parameters for the stored procedure here
	@CrimeID int, 
	@QuestionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update tblCrimeAnswer
	set QuestionID = @QuestionID
	where CrimesID = @CrimeID
END

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 3/3/2014
-- Description:	Update mitigating factor in a crime
-- =============================================
CREATE PROCEDURE SP_UpdateMitigating 
	-- Add the parameters for the stored procedure here
	@CrimeID int,
	@FactorID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update tblCrimesMitigatingFactorQuestions
	set MitigatingFactorQuestionsID = @FactorID
	where CrimesID = @CrimeID
END
GO

/****** Object:  StoredProcedure [dbo].[SP_GetMitigatingFactor]    Script Date: 3/5/2014 9:01:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 3/3/2014
-- Description:	Retrieve the mitigating factor for a crime
-- =============================================
CREATE PROCEDURE SP_GetMitigatingFactor
	-- Add the parameters for the stored procedure here
	@crimeID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT short from
	tblMitigatingFactorQuestions A inner join
	tblCrimesMitigatingFactorQuestions B on A.MitigatingFactorQuestionsID = B.MitigatingFactorQuestionsID
	where B.CrimesID = @crimeID

END


/****** Object:  StoredProcedure [dbo].[SP_GetMitigatingFactor]    Script Date: 3/5/2014 9:04:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 3/3/2014
-- Description:	Retrieve the mitigating factor for a crime
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetMitigatingFactor] 
	-- Add the parameters for the stored procedure here
	@crimeID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT short, Literal from
	tblMitigatingFactorQuestions A inner join
	tblCrimesMitigatingFactorQuestions B on A.MitigatingFactorQuestionsID = B.MitigatingFactorQuestionsID
	where B.CrimesID = @crimeID

END

/****** Object:  StoredProcedure [dbo].[SP_GetMitigatingQuestionList]    Script Date: 3/6/2014 1:54:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetMitigatingQuestionList]
AS
SELECT     Short, MitigatingFactorQuestionsID, Literal
FROM         tblMitigatingFactorQuestions


/****** Object:  StoredProcedure [dbo].[SP_UpdateMitigating]    Script Date: 3/7/2014 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 3/3/2014
-- Description:	Update mitigating factor in a crime
-- =============================================
ALTER PROCEDURE [dbo].[SP_UpdateMitigating] 
	-- Add the parameters for the stored procedure here
	@CrimeID int,
	@FactorID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	--Checking if any mitigating factors exist.
	declare @count int;
	
	select @count = count(*) from tblCrimesMitigatingFactorQuestions where CrimesID = @CrimeID;

	if @count = 0
	begin
		insert into tblCrimesMitigatingFactorQuestions(CrimesID) VALUES (@CrimeID)
	end

	update tblCrimesMitigatingFactorQuestions
	set MitigatingFactorQuestionsID = @FactorID
	where CrimesID = @CrimeID
END

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 03/26/2014
-- Description:	Retrieve info from tblLawClass
-- =============================================
CREATE PROCEDURE GetClass 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT short, literal from tblLawClass
END
GO


-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 03/26/2014
-- Description:	Retrieve info from tblLawCategory
-- =============================================
CREATE PROCEDURE GetCategory 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT short, literal from tblLawCategory
END
GO
