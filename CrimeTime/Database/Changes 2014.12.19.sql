SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2014.10.03
-- Description:	Procedure to get list of Pragraphs for a specified Category
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetParagraphList] 
	@CategoryID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  AnswerID as ParagraphID, CategoryID, TopicKey AS ParagraphKey, Literal
	FROM    Answers
	WHERE	CategoryID = @CategoryID
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
CREATE PROCEDURE [dbo].[SP_GetParagraphCategories] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		[ParagraphsID]
		,[Literal]
  FROM [tblParagraphs]
END
GO

SET IDENTITY_INSERT [dbo].[tblParagraphs] ON
INSERT INTO [dbo].[tblParagraphs]
           ([ParagraphsID], [Literal])
     VALUES
           (16, 'Comprehensive Alcohol and Substance Abuse Treatment')
INSERT INTO [dbo].[tblParagraphs]
           ([ParagraphsID], [Literal])
     VALUES
           (17, 'Parole Supervision')
INSERT INTO [dbo].[tblParagraphs]
           ([ParagraphsID], [Literal])
     VALUES
           (18, 'Judicial Diversion')
INSERT INTO [dbo].[tblParagraphs]
           ([ParagraphsID], [Literal])
     VALUES
           (19, 'Shock')
INSERT INTO [dbo].[tblParagraphs]
           ([ParagraphsID], [Literal])
     VALUES
           (20, 'Interim Probation Supervision')
SET IDENTITY_INSERT [dbo].[tblParagraphs] OFF
GO

ALTER TABLE dbo.tblParagraphs
ADD SortOrder INT NULL
GO
UPDATE tblParagraphs SET SortOrder = 1 WHERE ParagraphsID = 1
UPDATE tblParagraphs SET SortOrder = 2 WHERE ParagraphsID = 2
UPDATE tblParagraphs SET SortOrder = 3 WHERE ParagraphsID = 3
UPDATE tblParagraphs SET SortOrder = 4 WHERE ParagraphsID = 16
UPDATE tblParagraphs SET SortOrder = 5 WHERE ParagraphsID = 17
UPDATE tblParagraphs SET SortOrder = 6 WHERE ParagraphsID = 19
UPDATE tblParagraphs SET SortOrder = 7 WHERE ParagraphsID = 18
UPDATE tblParagraphs SET SortOrder = 8 WHERE ParagraphsID = 4
UPDATE tblParagraphs SET SortOrder = 9 WHERE ParagraphsID = 14
UPDATE tblParagraphs SET SortOrder = 10 WHERE ParagraphsID = 5
UPDATE tblParagraphs SET SortOrder = 11 WHERE ParagraphsID = 8
UPDATE tblParagraphs SET SortOrder = 12 WHERE ParagraphsID = 6
UPDATE tblParagraphs SET SortOrder = 13 WHERE ParagraphsID = 20
UPDATE tblParagraphs SET SortOrder = 14 WHERE ParagraphsID = 7
UPDATE tblParagraphs SET SortOrder = 15 WHERE ParagraphsID = 10
UPDATE tblParagraphs SET SortOrder = 16 WHERE ParagraphsID = 9
UPDATE tblParagraphs SET SortOrder = 17 WHERE ParagraphsID = 12
UPDATE tblParagraphs SET SortOrder = 18 WHERE ParagraphsID = 13
UPDATE tblParagraphs SET SortOrder = 19 WHERE ParagraphsID = 11
UPDATE tblParagraphs SET SortOrder = 20 WHERE ParagraphsID = 15
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
CREATE PROCEDURE [dbo].[SP_GetParagraphAndCategory] 
	@CrimeAnswerID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  a.AnswerID as ParagraphID
		, a.CategoryID
		, TopicKey AS ParagraphKey
		, p.Literal AS [Category]
		, a.Literal AS [ParagraphText]
		, CASE WHEN al.CrimeAnswerID IS NULL THEN 0 ELSE 1 END AS [Selected]
	FROM    Answers a
		INNER JOIN tblParagraphs p ON a.CategoryID = p.ParagraphsID
		LEFT JOIN AnswerLinks al on a.AnswerID = al.AnswerID AND al.CrimeAnswerID = @CrimeAnswerID
	ORDER BY p.SortOrder, a.TopicKey
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aishwarya Sharma
-- Create date: 12/10/2013
-- Description:	Get Answer paragraph for a given topic category
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetAnswer] 
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
	WHERE (AL.CrimeAnswerID = (@CrimeAnswerID)) and  (a.CategoryID = (@CategoryID))
END
GO

ALTER TABLE AnswerLinks
ALTER COLUMN CategoryID INT NULL
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2014.10.28
-- Description:	Get paragraph text based on paragraphID
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetAnswerPreview] 
	@ParagraphID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Literal
	FROM Answers
	WHERE AnswerID = @ParagraphID
END
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
CREATE PROCEDURE [dbo].[SP_LawsUsingParagraph] 
	@ParagraphID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT 
		c.CrimesID 
		, c.title + ' ' + c.section + ' ' + c.subsection + ' - ' + c.full_law_description AS law
	FROM AnswerLinks al 
		INNER JOIN tblCrimeAnswer ca ON al.CrimeAnswerID = ca.CrimeAnswerID
		INNER JOIN tblCrimes c ON ca.CrimesID = c.CrimesID
	WHERE al.AnswerID = @ParagraphID
	ORDER BY law
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2014.11.25
-- Description:	Get Permutations Using a Specific Paragraph for a given law
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetPermutationList] 
	@ParagraphID INT
	, @CrimesID INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ca.CrimeAnswerID
		, ca.Attempted
		, ca.QuestionsResponse
		, ac.Literal AS Age
		, pc.Literal AS PastConvictions
		, fc.Literal AS FelonyCategory
	FROM AnswerLinks al 
		INNER JOIN tblCrimeAnswer ca ON al.CrimeAnswerID = ca.CrimeAnswerID
		LEFT JOIN tblAgeCategory ac ON ca.AgeCategory = ac.AgeCategoryID
		LEFT JOIN tblFelonyConvictions fc ON ca.FelonyConvictions = fc.FelonyConvictionsID
		LEFT JOIN tblPastConvictions pc ON ca.PastConvictions = pc.PastConvictionsID
	WHERE al.AnswerID = @ParagraphID AND ca.CrimesID = @CrimesID
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Author:		Scott Mitchell
-- Create date: 2014.12.02
-- Description:	Get Paragraph Text
-- Change Log:
-- ==========================================================================================
CREATE PROCEDURE [dbo].[SP_GetParagraph] 
	@ParagraphID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Literal AS ParagraphText FROM Answers
	WHERE AnswerID = @ParagraphID
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Mitchell
-- Create date: 2014.12.03
-- Description:	Add Paragraph to a Permutation
-- =============================================
CREATE PROCEDURE [dbo].[SP_AddParagraphToPermutation] 
	@PermutationID int,
	@ParagraphID int
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT * FROM AnswerLinks WHERE CrimeAnswerID = @PermutationID AND AnswerID = @ParagraphID)
		INSERT INTO AnswerLinks (CrimeAnswerID, AnswerID)
			VALUES (@PermutationID, @ParagraphID)
END
GO



CREATE TYPE [dbo].[IDSet] AS TABLE(
	[ID] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
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
CREATE PROCEDURE [dbo].[SP_GetParagraphByIDs] 
	@ParagraphIDs IDSet READONLY
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  a.Literal AS [ParagraphText]
	FROM Answers a 
		INNER JOIN (SELECT * FROM @ParagraphIDs) IDs ON a.AnswerID = IDs.ID
		INNER JOIN tblParagraphs p ON a.CategoryID = p.ParagraphsID
	ORDER BY p.SortOrder, a.TopicKey
END
GO


UPDATE tblFelonyConvictions
SET Literal = 'Persistent felony offender'
WHERE FelonyConvictionsID = 10
GO


