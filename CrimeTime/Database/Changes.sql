SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2015.01.07
-- Description:	Get the parameters for a specified permutation
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetPermutationParameters] 
	@CrimeAnswerID INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ca.CrimeAnswerID
		, ca.Attempted
		, ca.QuestionsResponse
		, ac.Literal AS Age
		, pc.Literal AS PastConvictions
		, fc.Literal AS FelonyCategory
	FROM tblCrimeAnswer ca 
		LEFT JOIN tblAgeCategory ac ON ca.AgeCategory = ac.AgeCategoryID
		LEFT JOIN tblFelonyConvictions fc ON ca.FelonyConvictions = fc.FelonyConvictionsID
		LEFT JOIN tblPastConvictions pc ON ca.PastConvictions = pc.PastConvictionsID
	WHERE ca.CrimeAnswerID = @CrimeAnswerID
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 12/10/2013
-- Description:	Add a topic to a crime. Make a new answer link.
-- =============================================
ALTER PROCEDURE [dbo].[SP_AddTopicToCrime] 
	@CrimeAnswerID int,
	@AnswerID int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO AnswerLinks (CrimeAnswerID, AnswerID)
	VALUES     (@CrimeAnswerID, @AnswerID)
END
GO

DROP PROCEDURE [dbo].[SP_AddTopicToCrime]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParagraphCategory](
	[ParagraphCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Literal] [nchar](100) NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_ParagraphCategory] PRIMARY KEY CLUSTERED 
(
	[ParagraphCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET IDENTITY_INSERT [dbo].[ParagraphCategory] ON
GO
INSERT INTO [dbo].[ParagraphCategory]([ParagraphCategoryID],[Literal],[SortOrder])
	(SELECT ParagraphsID, Literal, SortOrder FROM tblParagraphs)
GO
SET IDENTITY_INSERT [dbo].[ParagraphCategory] OFF
GO

DELETE FROM Category
GO
DROP TABLE Category
GO
ALTER TABLE [dbo].[tblSpecialQuestionsParagraphs] DROP CONSTRAINT [FK_tblSpecialQuestionsParagraphs_tblParagraphs]
GO
ALTER TABLE [dbo].[tblSpecialQuestionsParagraphs]  WITH CHECK ADD  CONSTRAINT [FK_tblSpecialQuestionsParagraphs_ParagraphCategory] FOREIGN KEY([ParagraphsID])
REFERENCES [dbo].[ParagraphCategory] ([ParagraphCategoryID])
GO
ALTER TABLE [dbo].[tblSpecialQuestionsParagraphs] CHECK CONSTRAINT [FK_tblSpecialQuestionsParagraphs_ParagraphCategory]
GO

DELETE FROM tblParagraphs
GO
DROP TABLE tblParagraphs
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2014.12.09
-- Description:	Get Paragraph text for list of paragraph IDs
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetParagraphByIDs] 
	@ParagraphIDs IDSet READONLY
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  a.Literal AS [ParagraphText]
	FROM Answers a 
		INNER JOIN (SELECT * FROM @ParagraphIDs) IDs ON a.AnswerID = IDs.ID
		INNER JOIN ParagraphCategory pc ON a.CategoryID = pc.ParagraphCategoryID
	ORDER BY pc.SortOrder, a.TopicKey
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2014.10.02
-- Description:	Get list of Paragraph Categories
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetParagraphCategories] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		[ParagraphCategoryID]
		,[Literal]
  FROM [ParagraphCategory]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2014.10.28
-- Description:	Procedure to get list of Paragraphs with Category
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetParagraphAndCategory] 
	@CrimeAnswerID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  a.AnswerID as ParagraphID
		, a.CategoryID
		, TopicKey AS ParagraphKey
		, pc.Literal AS [Category]
		, a.Literal AS [ParagraphText]
		, CASE WHEN al.CrimeAnswerID IS NULL THEN 0 ELSE 1 END AS [Selected]
	FROM    Answers a
		INNER JOIN ParagraphCategory pc ON a.CategoryID = pc.ParagraphCategoryID
		LEFT JOIN AnswerLinks al on a.AnswerID = al.AnswerID AND al.CrimeAnswerID = @CrimeAnswerID
	ORDER BY pc.SortOrder, a.TopicKey
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_GetCrimeQuestion]
(
@CrimeID int
)
AS
SELECT tblQuestions.QuestionsID
	, tblQuestions.Literal
	, tblCrimeAnswer.CrimesID
	, tblCrimeAnswer.Attempted
FROM tblQuestions INNER JOIN
	tblCrimeAnswer ON tblQuestions.QuestionsID = tblCrimeAnswer.QuestionID
WHERE tblCrimeAnswer.CrimesID = @CrimeID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_MakeViewable]
(
@CrimesID int
)
AS
UPDATE tblCrimes
SET Viewable = (SELECT Viewable ^ 1 FROM tblCrimes WHERE CrimesID = @CrimesID)
WHERE (CrimesID = @CrimesID)
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2015.01.20
-- Description:	Remove Paragraph from a Permutation
-- =============================================
CREATE PROCEDURE [dbo].[SP_RemoveParagraphFromPermutation] 
	@PermutationID int,
	@ParagraphID int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM AnswerLinks
	WHERE CrimeAnswerID = @PermutationID
		AND AnswerID = @ParagraphID
END
GO


