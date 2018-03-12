-- All SP creates.

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
-- Create date: 12/9/2013
-- Description:	Create procedure to get topic text based on topic key
-- =============================================
CREATE PROCEDURE SP_GetTopicPreview 
	-- Add the parameters for the stored procedure here
	@TopicKey varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Literal
	FROM Answers
	where TopicKey = @TopicKey
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
-- Create date: 12/10/2013
-- Description:	Procedure to get list of keys for a topic
-- =============================================
CREATE PROCEDURE SP_GetTopicList 
	-- Add the parameters for the stored procedure here
	@CategoryID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  AnswerID as TopicID, TopicKey, Literal
	FROM    Answers
	WHERE	CategoryID = @CategoryID
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
-- Create date: 12/10/2013
-- Description:	Add a topic to a crime. Make a new answer link.
-- =============================================
CREATE PROCEDURE SP_AddTopicToCrime 
	-- Add the parameters for the stored procedure here
	@CrimeAnswerID int,
	@CategoryID int,
	@AnswerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO AnswerLinks (CrimeAnswerID, CategoryID, AnswerID)
	VALUES     (@CrimeAnswerID, @CategoryID, @AnswerID)
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
-- Create date: 12/10/2013
-- Description:	Get Answer paragraph for a given topic category
-- =============================================
CREATE PROCEDURE SP_GetAnswer 
	-- Add the parameters for the stored procedure here
	@CrimeAnswerID int, 
	@CategoryID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Literal, TopicKey, A.AnswerID
	FROM Answers A Inner Join AnswerLinks AL on A.AnswerID = AL.AnswerID
	WHERE (AL.CrimeAnswerID = (@CrimeAnswerID)) and  (AL.CategoryID = (@CategoryID))
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
-- Create date: 12/10/2013
-- Description:	Get topic literal by topic key
-- =============================================
CREATE PROCEDURE SP_GetTopicByKey 
	-- Add the parameters for the stored procedure here
	@TopicKey nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Literal
	FROM Answers
	WHERE TopicKey = @TopicKey
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
-- Create date: 12/17/2013
-- Description:	Get all categories
-- =============================================
CREATE PROCEDURE SP_GetCategories 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Category; 
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
-- Create date: 12/17/2013
-- Description:	Add new answer paragraph
-- =============================================
CREATE PROCEDURE SP_AddAnswer 
	-- Add the parameters for the stored procedure here
	@TopicKey varchar(50), 
	@CategoryID int,
	@Literal varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Answers(CategoryID, TopicKey, Literal) Values (@CategoryID, @TopicKey, @Literal);
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
-- Create date: 12/18/2013
-- Description:	To add a new law to the system
-- =============================================
CREATE PROCEDURE SP_AddLaw 
	-- Add the parameters for the stored procedure here
	@LawOrdinal int,
	@FullLawDescription varchar(max),
	@Title varchar(3),
	@Section varchar(9),
	@Subsection varchar(12),
	@Class varchar(4),
	@NYSLawCategory varchar(1000),
	@Statue varchar(max),
	@EffectiveDate datetime,
	@RepealDate datetime,
	@JOIndicator int,
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
	statute, 
	selected_laws_indicator, 
	deprecated, 
	effective_date, 
	repeal_date, 
	jo_indicator, 
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
	@Statue,
	0,
	0,
	@EffectiveDate,
	@RepealDate,
	@JOIndicator,
	@AttemptedNYSLawCategory,
	@AttemptedClass,
	@VFIndicator,
	@AttemptedVFIndicator,
	0
	);

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
-- Create date: 12/18/2013
-- Description:	Get details of a law
-- =============================================
CREATE PROCEDURE SP_GetLawDetails 
	-- Add the parameters for the stored procedure here
	@CID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	law_ordinal, 
	full_law_description, 
	title, 
	section, 
	subsection, 
	class, 
	nys_law_category, 
	statute, 
	selected_laws_indicator, 
	deprecated, 
	effective_date, 
	repeal_date, 
	jo_indicator, 
	attempted_nys_law_category, 
	attempted_class, 
	vf_indicator, 
	attempted_vf_indicator, 
	Viewable
	FROM tblCrimes
	WHERE CrimesID = @CID
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
-- Create date: 12/18/2013
-- Description:	Update law information
-- =============================================
CREATE PROCEDURE SP_UpdateLaw 
	-- Add the parameters for the stored procedure here
	@CID int,
	@LawOrdinal int,
	@FullLawDescription varchar(max),
	@Title varchar(3),
	@Section varchar(9),
	@Subsection varchar(12),
	@Class varchar(4),
	@NYSLawCategory varchar(1000),
	@Statue varchar(max),
	@EffectiveDate datetime,
	@RepealDate datetime,
	@JOIndicator int,
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
	statute = @Statue,
	effective_date = @EffectiveDate,
	repeal_date = @RepealDate,
	jo_indicator = @JOIndicator,
	attempted_nys_law_category = @AttemptedNYSLawCategory,
	attempted_class = @AttemptedClass,
	vf_indicator = @VFIndicator,
	attempted_vf_indicator = @AttemptedVFIndicator
	WHERE CrimesID = @CID
END
GO




-- All SP Alters

-- Procedure change to SP_GetPrefaceList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetPrefaceList]
AS
SELECT  AnswerID as PrefaceID, TopicKey as PrefaceKey
FROM    Answers
WHERE	CategoryID = 1;
GO


-- Procedure change to SP_GetTransitionList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetTransitionList]
AS
SELECT		AnswerID as TransitionID, topicKey as TransitionKey
FROM        Answers
WHERE		CategoryID = 2;
GO


-- Procedure change to SP_GetStatePrisonList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetStatePrisonList]
AS
SELECT		AnswerID as StatePrisonID, topicKey as StatePrisonKey
FROM        Answers
WHERE		CategoryID = 3;
GO


-- Procedure change to SP_GetDefiniteSentenceList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetDefiniteSentenceList]
AS
SELECT		AnswerID as DefiniteSentenceID, topicKey as DefiniteSentenceKey
FROM        Answers
WHERE		CategoryID = 4;
GO


-- Procedure change to SP_GetIntermittentImprisonmentList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetIntermittentImprisonmentList]
AS
SELECT		AnswerID as IntermittentImprisonmentID, topicKey as IntermittentImprisonmentKey
FROM        Answers
WHERE		CategoryID = 5;
GO

-- Procedure change to SP_GetProbationList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetProbationList]
AS
SELECT		AnswerID as ProbationID, topicKey as ProbationKey
FROM        Answers
WHERE		CategoryID = 6;
GO


-- Procedure change to SP_GetConditionalDischargeList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetConditionalDischargeList]
AS
SELECT		AnswerID as ConditionalDischargeID, topicKey as ConditionalDischargeKey
FROM        Answers
WHERE		CategoryID = 7;
GO


-- Procedure change to SP_GetSplitSentenceList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetSplitSentenceList]
AS
SELECT		AnswerID as SplitSentenceID, topicKey as SplitSentenceKey
FROM        Answers
WHERE		CategoryID = 8;
GO



-- Procedure change to SP_GetFineList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetFineList]
AS
SELECT		AnswerID as FineID, topicKey as FineKey
FROM        Answers
WHERE		CategoryID = 9;
GO



-- Procedure change to SP_GetUnconditionalDischargeList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetUnconditionalDischargeList]
AS
SELECT		AnswerID as UnconditionalDischargeID, topicKey as UnconditionalDischargeKey
FROM        Answers
WHERE		CategoryID = 10;
GO



-- Procedure change to SP_GetRestitutionReparationList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetRestitutionReparationList]
AS
SELECT		AnswerID as RestitutionReparationID, topicKey as RestitutionReparationKey
FROM        Answers
WHERE		CategoryID = 11;
GO


-- Procedure change to SP_GetSurchargeVictimAssessmentFeeList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetSurchargeVictimAssessmentFeeList]
AS
SELECT		AnswerID as SurchargeVictimAssessmentFeeID, topicKey as SurchargeVictimAssessmentFeeKey
FROM        Answers
WHERE		CategoryID = 12;
GO


-- Procedure change to SP_GetLiscensePenaltiesList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetLiscensePenaltiesList]
AS
SELECT		AnswerID as LiscensePenaltiesID, topicKey as LiscensePenaltiesKey
FROM        Answers
WHERE		CategoryID = 13;
GO


-- Procedure change to SP_GetConsecutiveConcurrentList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetConsecutiveConcurrentList]
AS
SELECT		AnswerID as ConsecutiveConcurrentID, topicKey as ConsecutiveConcurrentKey
FROM        Answers
WHERE		CategoryID = 14;
GO


-- Procedure change to SP_GetEndList
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetEndList]
AS
SELECT		AnswerID as EndID, topicKey as EndKey
FROM        Answers
WHERE		CategoryID = 15;
GO



-- Procedure change to SP_RemoveParagraphsfromCrime
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_RemoveParagraphsfromCrime]
(
@CrimeAnswerID int
)
AS
DELETE FROM AnswerLinks
WHERE     (CrimeAnswerID = @CrimeAnswerID)
GO


-- Procedure change to SP_GetPrefaceByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetPrefacebyID]
(
@PrefaceID int
)
As
SELECT     Literal, AnswerID
FROM         Answers
WHERE     (AnswerID = @PrefaceID)



-- Procedure change to SP_GetTransitionByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetTransitionbyID]
(
@TransitionID int
)
As
SELECT     Literal, AnswerID
FROM         Answers
WHERE     (AnswerID = @TransitionID)



-- Procedure change to SP_GetStatePrisonByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetStatePrisonbyID]
(
@StatePrisonID int
)
As
SELECT     Literal
FROM         Answers
WHERE     (AnswerID = @StatePrisonID)




-- Procedure change to SP_GetDefiniteSentenceByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetDefiniteSentencebyID]
(
@DefiniteSentenceID int
)
As
SELECT     Literal
FROM         Answers
WHERE     (AnswerID = @DefiniteSentenceID)





-- Procedure change to SP_GetIntermittentImrisonmentByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetIntermittentImprisonmentbyID]
(
@IntermittentImprisonmentID int
)
As
SELECT     Literal
FROM         Answers
WHERE     (AnswerID = @IntermittentImprisonmentID)






-- Procedure change to SP_GetProbationByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetProbationbyID]
(
@ProbationID int
)
As
SELECT     Literal
FROM         Answers
WHERE     (AnswerID = @ProbationID)






-- Procedure change to SP_GetConditionalDischargeByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetCONDITIONALDISCHARGEbyID]
(
@CONDITIONALDISCHARGEID int
)
As
SELECT     Literal
FROM        Answers
WHERE     (AnswerID = @CONDITIONALDISCHARGEID)




-- Procedure change to SP_GetSplitSentenceByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetSplitsentencebyID]
(
@SplitsentenceID int
)
As
SELECT     Literal
FROM         Answers
WHERE     (AnswerID = @SplitsentenceID)





-- Procedure change to SP_GetFineByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetFinebyID]
(
@FineID int
)
As
SELECT     Literal
FROM        Answers
WHERE     (AnswerID = @FineID)






-- Procedure change to SP_GetUncondirtionalDischargeByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetUnconditionalDischargebyID]
(
@UnconditionalDischargeID int
)
As
SELECT     Literal
FROM        Answers
WHERE     (AnswerID = @UnconditionalDischargeID)






-- Procedure change to SP_GetUncondirtionalDischargeByID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetRestitutionReparationbyID]
(
@RestitutionReparationID int
)
As
SELECT     Literal
FROM        Answers
WHERE     (AnswerID = @RestitutionReparationID)




-- Procedure change to SP_GetSurchargeVictimAssessmentFeebyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetSurchargeVictimAssessmentFeebyID]
(
@SurchargeVictimAssessmentFeeID int
)
As
SELECT     Literal
FROM        Answers
WHERE     (AnswerID = @SurchargeVictimAssessmentFeeID)





-- Procedure change to SP_GetLicensePenaltiesbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetLicensePenaltiesbyID]
(
@LicensePenaltiesID int
)
As
SELECT     Literal
FROM        Answers
WHERE     (AnswerID = @LicensePenaltiesID)






-- Procedure change to SP_GetConsecutiveConcurrentbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetConsecutiveConcurrentbyID]
(
@ConsecutiveConcurrentID int
)
As
SELECT     Literal
FROM        Answers
WHERE     (AnswerID = @ConsecutiveConcurrentID)




-- Procedure change to SP_GetEndbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetEndbyID]
(
@EndID int
)
As
SELECT     Literal
FROM        Answers
WHERE     (AnswerID = @EndID)




-- Procedure change to SP_UpdatePrefacebyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdatePrefacebyID]
(
@PrefaceID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @PrefaceID)





-- Procedure change to SP_UpdateTransitionbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateTransitionbyID]
(
@TransitionID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @TransitionID)





-- Procedure change to SP_UpdateStatePrisonbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateStatePrisonbyID]
(
@StatePrisonID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @StatePrisonID)





-- Procedure change to SP_UpdateDefiniteSentencebyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateDefiniteSentencebyID]
(
@DefiniteSentenceID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @DefiniteSentenceID)





-- Procedure change to SP_UpdateIntermittentImprisonmentbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateIntermittentImprisonmentbyID]
(
@IntermittentImprisonmentID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @IntermittentImprisonmentID)





-- Procedure change to SP_UpdateProbationbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateProbationbyID]
(
@ProbationID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @ProbationID)




-- Procedure change to SP_UpdateConditionalDischargebyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateConditionalDischargebyID]
(
@ConditionalDischargeID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @ConditionalDischargeID)




-- Procedure change to SP_UpdateSplitsentencebyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateSplitsentencebyID]
(
@SplitsentenceID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @SplitsentenceID)





-- Procedure change to SP_UpdateFinebyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateFinebyID]
(
@FineID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @FineID)





-- Procedure change to SP_UpdateUnConditionalDischargebyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateUnConditionalDischargebyID]
(
@UnConditionalDischargeID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @UnConditionalDischargeID)





-- Procedure change to SP_UpdateRestitutionReparationbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateRestitutionReparationbyID]
(
@RestitutionReparationID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @RestitutionReparationID)





-- Procedure change to SP_UpdateSurchargeVictimAssessmentFeebyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateSurchargeVictimAssessmentFeebyID]
(
@SurchargeVictimAssessmentFeeID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @SurchargeVictimAssessmentFeeID)





-- Procedure change to SP_UpdateLicensePenaltiesbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateLicensePenaltiesbyID]
(
@LicensePenaltiesID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @LicensePenaltiesID)





-- Procedure change to SP_UpdateLicensePenaltiesbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateConsecutiveConcurrentbyID]
(
@ConsecutiveConcurrentID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @ConsecutiveConcurrentID)





-- Procedure change to SP_UpdateLicensePenaltiesbyID
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_UpdateEndbyID]
(
@EndID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    Answers
SET              Literal =@NewLit 
WHERE     (AnswerID = @EndID)





-- Procedure change to SP_GetAnswerPreface
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetAnswerPreface]
(
@CrimeAnswerID int
)
AS
SELECT     Answers.Literal, Answers.AnswerID, Answers.TopicKey
FROM         Answers INNER JOIN
                      AnswerLinks ON Answers.AnswerID = AnswerLinks.AnswerID
WHERE     (AnswerLinks.CrimeAnswerID = @CrimeAnswerID)