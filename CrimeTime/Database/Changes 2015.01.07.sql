CREATE TYPE [dbo].[CriteriaSet] AS TABLE(
	[Class] [nvarchar](4) NULL,
	[Category] [nvarchar](4) NULL
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2015.01.05
-- Description:	Get laws for the specified class and category's list
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetLawsByClassAndCategory] 
	@ClassAndCategory CriteriaSet READONLY
AS
BEGIN
	SET NOCOUNT ON;

	SELECT	tblCrimes.CrimesID, 
			tblCrimes.full_law_description AS Name, 
			dbo.FN_GetFullCite(title, section, subsection) AS Cite, 
			dbo.FN_GetFullLevel(tblCrimes.class,nys_law_category, vf_indicator) AS Level, 
			tblCrimes.repeal_date, 
			tblSpecialPopUps.Literal, 
			title, 
			section 
	FROM tblCrimes 
		INNER JOIN (SELECT * FROM @ClassAndCategory) ClassAndCategory ON tblCrimes.class = ClassAndCategory.Class AND tblCrimes.nys_law_category = ClassAndCategory.Category
		LEFT OUTER JOIN tblCrimesSpecialPopups ON tblCrimes.CrimesID = tblCrimesSpecialPopups.CrimesID 
		LEFT OUTER JOIN tblSpecialPopUps ON tblCrimesSpecialPopups.SpecialPopUpsID = tblSpecialPopUps.SpecialPopUpsID 
		LEFT OUTER JOIN tblLawClass ON tblCrimes.class = tblLawClass.Short 
		LEFT OUTER JOIN tblLawCategory ON tblCrimes.nys_law_category = tblLawCategory.Short
	WHERE (tblCrimes.Viewable = 1)
	ORDER BY Cite
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		UNKNOWN
-- Create date: UNKNOWN
-- Description:	Get the Permutations for a law
-- Change Log:
--	2015.01.05 - SM - Added crime level (category and class)
-- =============================================
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

	SELECT ca.CrimeAnswerID
		, tblAgeCategory.Literal AS AgeCat
		, tblFelonyConvictions.Literal AS FelonyCat
		, tblPastConvictions.Literal AS PastConCat
		, tblQuestions.Literal AS Question
		, ca.QuestionsResponse
		, ca.Attempted
		, CASE WHEN ca.Attempted = 1 THEN dbo.FN_GetFullLevel(c.attempted_class, c.attempted_nys_law_category, c.attempted_vf_indicator) ELSE dbo.FN_GetFullLevel(c.class, c.nys_law_category, c.vf_indicator) END AS [Level]
	FROM tblCrimeAnswer ca
		LEFT OUTER JOIN tblQuestions ON ca.QuestionID = tblQuestions.QuestionsID 
		LEFT OUTER JOIN tblAgeCategory ON ca.AgeCategory = tblAgeCategory.AgeCategoryID 
		LEFT OUTER JOIN tblFelonyConvictions ON ca.FelonyConvictions = tblFelonyConvictions.FelonyConvictionsID 
		LEFT OUTER JOIN tblPastConvictions ON ca.PastConvictions = tblPastConvictions.PastConvictionsID
		INNER JOIN tblCrimes c ON ca.CrimesID = c.CrimesID
	WHERE (ca.CrimesID = @CID)

GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2014.11.25
-- Description:	Get Law Using a Specified Paragraph
-- =============================================
ALTER PROCEDURE [dbo].[SP_LawsUsingParagraph] 
	@ParagraphID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT 
		c.CrimesID 
		, c.full_law_description AS Name
		, dbo.FN_GetFullCite(title, section, subsection) AS Cite 
		, dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) AS [Level]
	FROM AnswerLinks al 
		INNER JOIN tblCrimeAnswer ca ON al.CrimeAnswerID = ca.CrimeAnswerID
		INNER JOIN tblCrimes c ON ca.CrimesID = c.CrimesID
	WHERE al.AnswerID = @ParagraphID
	ORDER BY Cite
END
GO
