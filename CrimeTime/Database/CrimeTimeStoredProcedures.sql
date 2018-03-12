USE [CrimeTime]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerCASAT]    Script Date: 02/23/2011 16:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAnswerCASAT]
(
@CrimeAnswerID int
)
AS
SELECT     tblCASAT.Literal, tblCASAT.CasatKey, tblCASAT.CASATID
FROM         tblCrimeAnswerCasat INNER JOIN
                      tblCASAT ON tblCrimeAnswerCasat.CasatID = tblCASAT.CASATID
WHERE     (tblCrimeAnswerCasat.CrimeAnswerID = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[AASP_InsertLawOrdinalforNewCrime130s]    Script Date: 02/23/2011 16:39:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AASP_InsertLawOrdinalforNewCrime130s]
AS
UPDATE    NewCrime130sSpreadsheet
SET              lawordinal =( SELECT    tblCrimes.law_ordinal
FROM         tblCrimes 
where dbo.AAFN_GetLOCITE(tblCrimes.title,tblCrimes.section,tblCrimes.subsection) = NewCrime130sSpreadsheet.cite AND tblCrimes.repeal_date IS NULL
--and NewCrime130sSpreadsheet.cite='VTL 1192(2-A)'
--and NewCrime130sSpreadsheet.CrimeName='aggravated driving while intoxicated (misd)'
)
Where exists (SELECT    tblCrimes.law_ordinal
FROM         tblCrimes 
where dbo.AAFN_GetLOCITE(tblCrimes.title,tblCrimes.section,tblCrimes.subsection) = NewCrime130sSpreadsheet.cite )
GO
/****** Object:  StoredProcedure [dbo].[AASP_GetLawOrdinalforNewCrime]    Script Date: 02/23/2011 16:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AASP_GetLawOrdinalforNewCrime]
AS
SELECT    tblCrimes.law_ordinal, NewCrimeSpreadsheet.CrimeName, NewCrimeSpreadsheet.Age, dbo.AAFN_GetLOCITE(tblCrimes.title,tblCrimes.section,ISNULL(tblCrimes.subsection,'')) as LOCite, NewCrimeSpreadsheet.Cite
FROM         tblCrimes CROSS JOIN
                      NewCrimeSpreadsheet
where dbo.AAFN_GetLOCITE(tblCrimes.title,tblCrimes.section,tblCrimes.subsection) = NewCrimeSpreadsheet.cite
--and NewCrimeSpreadsheet.cite='PL 220.28'
--and NewCrimeSpreadsheet.CrimeName='aggravated driving while intoxicated (misd)'
Order by NewCrimeSpreadsheet.CrimeName
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeFullText]    Script Date: 02/23/2011 16:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeFullText]
(
@CrimeID int
)
AS
SELECT     statute, full_law_description
FROM         tblCrimes
WHERE     (CrimesID = @CrimeID)
GO
/****** Object:  StoredProcedure [dbo].[AASP_InsertLawOrdinalforNewCrime]    Script Date: 02/23/2011 16:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AASP_InsertLawOrdinalforNewCrime]
AS
UPDATE    NewCrimeSpreadsheet
SET              lawordinal =( SELECT    tblCrimes.law_ordinal
FROM         tblCrimes 
where dbo.AAFN_GetLOCITE(tblCrimes.title,tblCrimes.section,tblCrimes.subsection) = NewCrimeSpreadsheet.cite AND tblCrimes.repeal_date IS NULL
--and NewCrimeSpreadsheet.cite='VTL 1192(2-A)'
--and NewCrimeSpreadsheet.CrimeName='aggravated driving while intoxicated (misd)'
)
Where exists (SELECT    tblCrimes.law_ordinal
FROM         tblCrimes 
where dbo.AAFN_GetLOCITE(tblCrimes.title,tblCrimes.section,tblCrimes.subsection) = NewCrimeSpreadsheet.cite)
GO
/****** Object:  StoredProcedure [dbo].[AASP_InsertLawOrdinalforKaylaSPreadsheet]    Script Date: 02/23/2011 16:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AASP_InsertLawOrdinalforKaylaSPreadsheet]
AS
UPDATE    KaylaSpreadsheet
SET              lawordinal =( --SELECT tblCrimes.law_ordinal
SELECT    Top 1 tblCrimes.law_ordinal
FROM         tblCrimes 
--CROSS JOIN KaylaSpreadsheet
where dbo.AAFN_GetLOCITE(tblCrimes.title,tblCrimes.section,tblCrimes.subsection) = KaylaSpreadsheet.cite AND (tblCrimes.repeal_date IS NULL)
--and KaylaSpreadsheet.cite='PL 158.05' 
order by repeal_date DESC
)
Where exists (SELECT    tblCrimes.law_ordinal
FROM         tblCrimes 
where dbo.AAFN_GetLOCITE(tblCrimes.title,tblCrimes.section,tblCrimes.subsection) = KaylaSpreadsheet.cite AND tblCrimes.repeal_date IS NULL)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetIssues]    Script Date: 02/23/2011 16:39:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetIssues]
AS
SELECT     tblCrimeAnswerIssue.AnswerIssueID, tblCrimes.full_law_description as 'Crime Name', tblAgeCategory.Literal as AGE, ISNULL(tblFelonyConvictions.Literal,'no Category') AS 'Fel Sentencing Cat', tblPastConvictions.Literal AS 'Past Convictions', ISNULL(tblCrimeAnswer.QuestionID,'0') as QuestionID, 
                      ISNULL(tblCrimeAnswer.QuestionsResponse,'0') as 'QuestionsResponse', tblCrimeAnswer.Attempted, tblCrimeAnswerIssue.Issue, isnull(tblCrimeAnswerIssue.Fixed,'0') as Fixed, 
                      ISNULL(tblCrimeAnswerIssue.DateFixed,'') as 'Date Fixed'
FROM         tblCrimeAnswerIssue Left outer join
                      tblCrimeAnswer ON tblCrimeAnswerIssue.CrimeAnswerID = tblCrimeAnswer.CrimeAnswerID Left outer join
                      tblCrimes ON tblCrimeAnswer.CrimesID = tblCrimes.CrimesID Left outer join
                      tblAgeCategory ON tblCrimeAnswer.AgeCategory = tblAgeCategory.AgeCategoryID Left outer join
                      tblFelonyConvictions ON tblCrimeAnswer.FelonyConvictions = tblFelonyConvictions.FelonyConvictionsID Left outer join
                      tblPastConvictions ON tblCrimeAnswer.PastConvictions = tblPastConvictions.PastConvictionsID
GO
/****** Object:  StoredProcedure [dbo].[AA_SPDELETEfromCrimetimeAnswers]    Script Date: 02/23/2011 16:39:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[AA_SPDELETEfromCrimetimeAnswers]
AS
Delete FROM tblCrimeAnswerConditionalDischarge
Delete FROM tblCrimeAnswerConsecutiveConcurrent 
Delete FROM tblCrimeAnswerDefiniteSentence 
Delete FROM tblCrimeAnswerEnd 
Delete FROM tblCrimeAnswerFine 
Delete FROM tblCrimeAnswerIntermittentImprisonment 
Delete FROM tblCrimeAnswerLicensePenalties 
Delete FROM tblCrimeAnswerPreface 
Delete FROM tblCrimeAnswerProbation 
Delete FROM tblCrimeAnswerRestitutionReparation 
Delete FROM tblCrimeAnswerSplitSentence 
Delete FROM tblCrimeAnswerStatePrison 
Delete FROM tblCrimeAnswerSurchargeVictimAssessmentFee 
Delete FROM tblCrimeAnswerTransition 
Delete FROM tblCrimeAnswerUnconditionalDischarge
Delete from tblCrimeAnswerIssue
Delete FROM tblCrimeAnswer
UPDATE    tblCrimes
SET              Viewable =0
UPDATE    NewCrimeSpreadsheet
SET              lawordinal = NULL
UPDATE    KaylaSpreadsheet
SET              lawordinal = NULL
GO
/****** Object:  StoredProcedure [dbo].[A_GetListofCrimeswith14paragraphtypes]    Script Date: 02/23/2011 16:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[A_GetListofCrimeswith14paragraphtypes]
as
SELECT     tblCrimeAnswer.CrimeAnswerID, tblCrimeAnswer.CrimesID, tblCrimeAnswer.AgeCategory, tblCrimeAnswer.FelonyConvictions, 
                      tblCrimeAnswer.PastConvictions, tblCrimeAnswer.QuestionID, tblCrimeAnswer.QuestionsResponse, tblCrimeAnswer.Attempted, 
                      tblCrimeAnswerPreface.PrefaceID, tblCrimeAnswerTransition.TransitionID, tblCrimeAnswerConditionalDischarge.ConditionalDischargeID, 
                      tblCrimeAnswerStatePrison.StatePrisonID, tblCrimeAnswerDefiniteSentence.DefiniteSentenceID, 
                      tblCrimeAnswerIntermittentImprisonment.IntermittentImprisonmentID, tblCrimeAnswerProbation.ProbationID, 
                      tblCrimeAnswerSplitSentence.SplitSentenceID, tblCrimeAnswerFine.FineID, tblCrimeAnswerUnconditionalDischarge.UnconditionalDischargeID, 
                      tblCrimeAnswerRestitutionReparation.RestitutionReparationID, tblCrimeAnswerSurchargeVictimAssessmentFee.SurchargeVictimAssessmentFeeID, 
                      tblCrimeAnswerLicensePenalties.LicensePenaltiesID, tblCrimeAnswerConsecutiveConcurrent.ConsecutiveConcurrentID, tblCrimeAnswerEnd.EndID, 
                      tblCrimes.full_law_description, tblCrimes.title, tblCrimes.section, tblCrimes.subsection, tblCrimes.class, tblCrimes.nys_law_category
FROM         tblCrimeAnswer INNER JOIN
                      tblCrimeAnswerPreface ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerPreface.CrimeAnswer INNER JOIN
                      tblCrimeAnswerTransition ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerTransition.CrimeAnswer INNER JOIN
                      tblCrimeAnswerConditionalDischarge ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerConditionalDischarge.CrimeAnswer INNER JOIN
                      tblCrimeAnswerStatePrison ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerStatePrison.CrimeAnswer INNER JOIN
                      tblCrimeAnswerDefiniteSentence ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerDefiniteSentence.CrimeAnswer INNER JOIN
                      tblCrimeAnswerIntermittentImprisonment ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerIntermittentImprisonment.CrimeAnswer INNER JOIN
                      tblCrimeAnswerProbation ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerProbation.CrimeAnswer INNER JOIN
                      tblCrimeAnswerSplitSentence ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerSplitSentence.CrimeAnswer INNER JOIN
                      tblCrimeAnswerFine ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerFine.CrimeAnswer INNER JOIN
                      tblCrimeAnswerUnconditionalDischarge ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerUnconditionalDischarge.CrimeAnswer INNER JOIN
                      tblCrimeAnswerRestitutionReparation ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerRestitutionReparation.CrimeAnswer INNER JOIN
                      tblCrimeAnswerSurchargeVictimAssessmentFee ON 
                      tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerSurchargeVictimAssessmentFee.CrimeAnswer INNER JOIN
                      tblCrimeAnswerLicensePenalties ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerLicensePenalties.CrimeAnswer INNER JOIN
                      tblCrimeAnswerConsecutiveConcurrent ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerConsecutiveConcurrent.CrimeAnswer INNER JOIN
                      tblCrimeAnswerEnd ON tblCrimeAnswer.CrimeAnswerID = tblCrimeAnswerEnd.CrimeAnswer INNER JOIN
                      tblCrimes ON tblCrimeAnswer.CrimesID = tblCrimes.CrimesID
WHERE     (tblCrimeAnswerPreface.PrefaceID IS NOT NULL) AND (tblCrimeAnswerTransition.TransitionID IS NOT NULL) AND 
                      (tblCrimeAnswerConditionalDischarge.ConditionalDischargeID IS NOT NULL) AND (tblCrimeAnswerStatePrison.StatePrisonID IS NOT NULL) AND 
                      (tblCrimeAnswerDefiniteSentence.DefiniteSentenceID IS NOT NULL) AND 
                      (tblCrimeAnswerIntermittentImprisonment.IntermittentImprisonmentID IS NOT NULL) AND (tblCrimeAnswerProbation.ProbationID IS NOT NULL) AND 
                      (tblCrimeAnswerSplitSentence.SplitSentenceID IS NOT NULL) AND (tblCrimeAnswerFine.FineID IS NOT NULL) AND 
                      (tblCrimeAnswerUnconditionalDischarge.UnconditionalDischargeID IS NOT NULL) AND 
                      (tblCrimeAnswerRestitutionReparation.RestitutionReparationID IS NOT NULL) AND 
                      (tblCrimeAnswerSurchargeVictimAssessmentFee.SurchargeVictimAssessmentFeeID IS NOT NULL) AND 
                      (tblCrimeAnswerLicensePenalties.LicensePenaltiesID IS NOT NULL) AND (tblCrimeAnswerEnd.EndID IS NOT NULL)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateStatutoryText]    Script Date: 02/23/2011 16:40:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateStatutoryText]
(
@LawOrdinal int,
@Statutory nvarchar(max)
)
AS
UPDATE    tblCrimes
SET              statute =@Statutory
WHERE     (law_ordinal = @LawOrdinal)
GO
/****** Object:  StoredProcedure [dbo].[AA_SPTruncatefromCrimetimeAnswers]    Script Date: 02/23/2011 16:39:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[AA_SPTruncatefromCrimetimeAnswers]
AS
Truncate Table tblCrimeAnswerConditionalDischarge
Truncate Table tblCrimeAnswerConsecutiveConcurrent 
Truncate Table tblCrimeAnswerDefiniteSentence 
Truncate Table tblCrimeAnswerEnd 
Truncate Table tblCrimeAnswerFine 
Truncate Table tblCrimeAnswerIntermittentImprisonment 
Truncate Table tblCrimeAnswerLicensePenalties 
Truncate Table tblCrimeAnswerPreface 
Truncate Table tblCrimeAnswerProbation 
Truncate Table tblCrimeAnswerRestitutionReparation 
Truncate Table tblCrimeAnswerSplitSentence 
Truncate Table tblCrimeAnswerStatePrison 
Truncate Table tblCrimeAnswerSurchargeVictimAssessmentFee 
Truncate Table tblCrimeAnswerTransition 
Truncate Table tblCrimeAnswerUnconditionalDischarge
Truncate Table tblCrimeAnswerIssue
Truncate Table tblCrimeAnswer
UPDATE    tblCrimes
SET              Viewable =0
UPDATE    NewCrimeSpreadsheet
SET              lawordinal = NULL
UPDATE    KaylaSpreadsheet
SET              lawordinal = NULL
GO
/****** Object:  StoredProcedure [dbo].[SP_GetStatutoryText]    Script Date: 02/23/2011 16:39:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetStatutoryText]
(
@LawOrdinal int
)
AS
Declare @Title nvarchar(4)
Declare @Section nvarchar(10)
Declare @Statute1 nvarchar(max)
Declare @Statute2 nvarchar(max)
Select @Title =title,@Section =section,@Statute1=statute
FROM         tblCrimes
WHERE     (law_ordinal = @LawOrdinal)

SET @Statute2='2'
SELECT  @Statute2=statute
FROM         tblCrimes
WHERE     (title = @Title) AND (section = @Section) --AND ((subsection = ' ') or (subsection = ''))

If len(@statute2)=0 or @statute2='2'
Select @Statute1 as statute
Else
Select @Statute2 as statute
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeName]    Script Date: 02/23/2011 16:39:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeName]
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

SELECT     full_law_description, CrimesID, Viewable
FROM         tblCrimes
WHERE     (CrimesID = @CID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRepealInfo]    Script Date: 02/23/2011 16:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetRepealInfo]
(
@CrimeID int
)
as 
SELECT     full_law_description as Name, (title + ' ' + section + ' ' + subsection) as Cite, ISNULL(repeal_date,'') as RepealDate
FROM         tblCrimes
where CrimesID=@CrimeID
GO
/****** Object:  StoredProcedure [dbo].[SP_MakeViewable]    Script Date: 02/23/2011 16:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_MakeViewable]
(
@CrimesID int,
@Viewable bit
)
AS
UPDATE    tblCrimes
SET              Viewable = @Viewable
WHERE     (CrimesID = @CrimesID)
GO
/****** Object:  StoredProcedure [dbo].[AASP_CopyAnswerstoNewCrime]    Script Date: 02/23/2011 16:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AASP_CopyAnswerstoNewCrime]
(
@oldCID int,
@NewCID int
)
as
begin
Declare @CAID int,
@CID int,
@ACate int,
@FelCon int,
@PCon int,
@QID int,
@QR bit,
@Attempt bit

--Declare the cursor
DECLARE CopyCrimeAnswer CURSOR FOR
SELECT     CrimeAnswerID, CrimesID, AgeCategory, FelonyConvictions, PastConvictions, QuestionID, QuestionsResponse, Attempted
FROM         tblCrimeAnswer
Where CrimesID=@oldCID

OPEN CopyCrimeAnswer

FETCH CopyCrimeAnswer INTO @CAID,
@CID,
@ACate,
@FelCon,
@PCon,
@QID,
@QR,
@Attempt

-- start the main processing loop.
WHILE @@Fetch_Status = 0

  BEGIN

Declare @AnswerID int
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, QuestionID, QuestionsResponse, Attempted)
VALUES     (@NewCID,@ACate,@FelCon,@PCon,@QID,@QR,@Attempt)
Set @AnswerID =@@identity

INSERT INTO tblCrimeAnswerPreface (CrimeAnswer,PrefaceID)
Select @AnswerID,PrefaceID from tblCrimeAnswerPreface where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerConditionalDischarge (CrimeAnswer,ConditionalDischargeID)
Select @AnswerID,ConditionalDischargeID from tblCrimeAnswerConditionalDischarge where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerConsecutiveConcurrent (CrimeAnswer,ConsecutiveConcurrentID)
Select @AnswerID,ConsecutiveConcurrentID from tblCrimeAnswerConsecutiveConcurrent where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerDefiniteSentence (CrimeAnswer,DefiniteSentenceID)
Select @AnswerID,DefiniteSentenceID from tblCrimeAnswerDefiniteSentence where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerEnd (CrimeAnswer,EndID)
Select @AnswerID,EndID from tblCrimeAnswerEnd where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerFine (CrimeAnswer,FineID)
Select @AnswerID,FineID from tblCrimeAnswerFine where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerIntermittentImprisonment (CrimeAnswer,IntermittentImprisonmentID)
Select @AnswerID,IntermittentImprisonmentID from tblCrimeAnswerIntermittentImprisonment where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerLicensePenalties (CrimeAnswer,LicensePenaltiesID)
Select @AnswerID,LicensePenaltiesID from tblCrimeAnswerLicensePenalties where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerProbation (CrimeAnswer,ProbationID)
Select @AnswerID,ProbationID from tblCrimeAnswerProbation where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerRestitutionReparation (CrimeAnswer,RestitutionReparationID)
Select @AnswerID,RestitutionReparationID from tblCrimeAnswerRestitutionReparation where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerSplitSentence (CrimeAnswer,SplitSentenceID)
Select @AnswerID,SplitSentenceID from tblCrimeAnswerSplitSentence where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerStatePrison (CrimeAnswer,StatePrisonID)
Select @AnswerID,StatePrisonID from tblCrimeAnswerStatePrison where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerSurchargeVictimAssessmentFee (CrimeAnswer,SurchargeVictimAssessmentFeeID)
Select @AnswerID,SurchargeVictimAssessmentFeeID from tblCrimeAnswerSurchargeVictimAssessmentFee where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerTransition (CrimeAnswer,TransitionID)
Select @AnswerID,TransitionID from tblCrimeAnswerTransition where CrimeAnswer=@CAID

INSERT INTO tblCrimeAnswerUnconditionalDischarge (CrimeAnswer,UnconditionalDischargeID)
Select @AnswerID,UnconditionalDischargeID from tblCrimeAnswerUnconditionalDischarge where CrimeAnswer=@CAID

FETCH CopyCrimeAnswer INTO @CAID,
@CID,
@ACate,
@FelCon,
@PCon,
@QID,
@QR,
@Attempt


 END

CLOSE CopyCrimeAnswer

DEALLOCATE CopyCrimeAnswer
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @NewCID)
End
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerSupervisedParole]    Script Date: 02/23/2011 16:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAnswerSupervisedParole]
(
@CrimeAnswerID int
)
AS
SELECT     tblSupervisedParole.Literal, tblSupervisedParole.SupervisedParoleKey, tblSupervisedParole.SupervisedParoleID
FROM         tblCrimeAnswerSupervisedParole INNER JOIN
                      tblSupervisedParole ON tblCrimeAnswerSupervisedParole.SupervisedParoleID = tblSupervisedParole.SupervisedParoleID
WHERE     (tblCrimeAnswerSupervisedParole.CrimeAnswerID = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertEmails]    Script Date: 02/23/2011 16:39:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_InsertEmails]
(
@Email nvarchar(150),
@EMailDate datetime
)
as

INSERT INTO tblEmailAddress
                      (Email, EmailDate)
VALUES     (@Email, @EMailDate)

SELECT EmailAddressID FROM tblEmailAddress WHERE Email = @Email AND EmailDate = @EmailDate
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTotalEmailsByDate]    Script Date: 02/23/2011 16:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetTotalEmailsByDate]
(
@EMailStartDate datetime,
@EMailEndDate datetime
)
as
SELECT     Count(Distinct Email)
FROM         tblEmailAddress
WHERE     EmailDate BETWEEN @EMailStartDate AND @EMailEndDate
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEmailTotalUsedByDate]    Script Date: 02/23/2011 16:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetEmailTotalUsedByDate]
(
@EMailStartDate datetime,
@EMailEndDate datetime
)
as
SELECT    Count(EMail) as Total
FROM         tblEmailAddress
WHERE     EmailDate BETWEEN @EMailStartDate AND @EMailEndDate + ' 23:59:59'
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerShock]    Script Date: 02/23/2011 16:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAnswerShock]
(
@CrimeAnswerID int
)
AS
SELECT     tblShock.Literal, tblShock.ShockKey, tblShock.ShockID
FROM         tblCrimeAnswerShock INNER JOIN
                      tblShock ON tblCrimeAnswerShock.ShockID = tblShock.ShockID
WHERE     (tblCrimeAnswerShock.CrimeAnswerID = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAgeList]    Script Date: 02/23/2011 16:39:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAgeList]
AS
SELECT     AgeCategoryID, Literal
FROM         tblAgeCategory
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeAnswerListByCrimeID]    Script Date: 02/23/2011 16:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeAnswerListByCrimeID]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAgeOptionsForCrime]    Script Date: 02/23/2011 16:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_GetAgeOptionsForCrime]
(
@CrimeID int,
@QuestionResponseID bit,
@Attempted bit
)
AS
SELECT DISTINCT ISNULL(tblAgeCategory.AgeCategoryID,'0') as AgeCategoryID, ISNULL(tblAgeCategory.Literal,'None') as Literal
FROM         tblCrimeAnswer LEFT OUTER JOIN
                      tblAgeCategory ON tblCrimeAnswer.AgeCategory = tblAgeCategory.AgeCategoryID
WHERE     (tblCrimeAnswer.CrimesID = @CrimeID) AND (tblCrimeAnswer.Attempted = @Attempted) AND 
                      (tblCrimeAnswer.QuestionsResponse = @QuestionResponseID OR
                      tblCrimeAnswer.QuestionsResponse IS NULL)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerJudicialDiversion]    Script Date: 02/23/2011 16:39:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetAnswerJudicialDiversion]
(
@CrimeAnswerID int
)
AS
SELECT     tblJudicialDiversion.Literal, tblJudicialDiversion.JudicialDiversionKey, tblJudicialDiversion.JudicialDiversionID
FROM         tblCrimeAnswerJudicialDiversion INNER JOIN
                      tblJudicialDiversion ON tblCrimeAnswerJudicialDiversion.JudicialDiversionID = tblJudicialDiversion.JudicialDiversionID
WHERE     (tblCrimeAnswerJudicialDiversion.CrimeAnswerID = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPastConvictionsList]    Script Date: 02/23/2011 16:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetPastConvictionsList]
AS
SELECT     PastConvictionsID, Literal
FROM         tblPastConvictions
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPastConvictionOptionsForCrime]    Script Date: 02/23/2011 16:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetPastConvictionOptionsForCrime]
(
@CrimeID int,
@AgeCatID int,
@QuestionResponseID bit,
@Attempted bit
)
AS
SELECT DISTINCT tblPastConvictions.PastConvictionsID, tblPastConvictions.Literal, tblCrimeAnswer.AgeCategory
FROM         tblCrimeAnswer INNER JOIN
                      tblPastConvictions ON tblCrimeAnswer.PastConvictions = tblPastConvictions.PastConvictionsID
WHERE     (tblCrimeAnswer.AgeCategory = @AgeCatID OR
                      tblCrimeAnswer.AgeCategory IS NULL) AND (tblCrimeAnswer.Attempted = @Attempted) AND (tblCrimeAnswer.CrimesID = @CrimeID) AND 
                      (tblCrimeAnswer.QuestionsResponse = @QuestionResponseID OR
                      tblCrimeAnswer.QuestionsResponse IS NULL)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerINTERIMPROBATIONSUPERVISION]    Script Date: 02/23/2011 16:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerINTERIMPROBATIONSUPERVISION]
(
@CrimeAnswerID int
)
AS
SELECT     Distinct tblINTERIMPROBATIONSUPERVISION.Literal, tblINTERIMPROBATIONSUPERVISION.INTERIMPROBATIONSUPERVISIONKey, tblINTERIMPROBATIONSUPERVISION.INTERIMPROBATIONSUPERVISIONID
FROM         tblCrimeAnswerINTERIMPROBATIONSUPERVISION INNER JOIN
                      tblINTERIMPROBATIONSUPERVISION ON tblCrimeAnswerINTERIMPROBATIONSUPERVISION.INTERIMPROBATIONSUPERVISIONID = tblINTERIMPROBATIONSUPERVISION.INTERIMPROBATIONSUPERVISIONID
WHERE     (tblCrimeAnswerINTERIMPROBATIONSUPERVISION.CrimeAnswerID = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFelonyCategoryList]    Script Date: 02/23/2011 16:39:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetFelonyCategoryList]
AS
SELECT     FelonyConvictionsID, Literal
FROM         tblFelonyConvictions
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFelonyOptionsForCrime]    Script Date: 02/23/2011 16:39:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetFelonyOptionsForCrime]
(
@CrimeID int,
@PastID int,
@AgeID int,
@Attempted bit
)
AS
SELECT DISTINCT tblCrimeAnswer.FelonyConvictions, tblFelonyConvictions.Literal
FROM         tblCrimeAnswer INNER JOIN
                      tblFelonyConvictions ON tblCrimeAnswer.FelonyConvictions = tblFelonyConvictions.FelonyConvictionsID
WHERE     (tblCrimeAnswer.CrimesID = @CrimeID) AND (tblCrimeAnswer.PastConvictions = @PastID) AND (tblCrimeAnswer.AgeCategory = @AgeID) AND (tblCrimeAnswer.Attempted = @Attempted)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPrefaceList]    Script Date: 02/23/2011 16:39:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetPrefaceList]
AS
SELECT     PrefaceID, PrefaceKey
FROM         tblPreface
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPrefacebyID]    Script Date: 02/23/2011 16:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetPrefacebyID]
(
@PrefaceID int
)
As
SELECT     Literal, PrefaceID
FROM         tblPreface
WHERE     (PrefaceID = @PrefaceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPrefaceByKey]    Script Date: 02/23/2011 16:39:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetPrefaceByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblPreface
WHERE     (PrefaceKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePrefacebyID]    Script Date: 02/23/2011 16:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdatePrefacebyID]
(
@PrefaceID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblPreface
SET              Literal =@NewLit 
WHERE     (PrefaceID = @PrefaceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerPreface]    Script Date: 02/23/2011 16:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerPreface]
(
@CrimeAnswerID int
)
AS
SELECT     tblPreface.Literal, tblPreface.PrefaceID, tblPreface.PrefaceKey
FROM         tblCrimeAnswerPreface INNER JOIN
                      tblPreface ON tblCrimeAnswerPreface.PrefaceID = tblPreface.PrefaceID
WHERE     (tblCrimeAnswerPreface.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GETALLPARAGRAPHS]    Script Date: 02/23/2011 16:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GETALLPARAGRAPHS]
AS
SELECT     PrefaceID, PrefaceKey, '"'+Literal+'"'
FROM         tblPreface

SELECT     TransitionID, TransitionKey, '"'+Literal+'"'
FROM         tblTransition

SELECT     StatePrisonID, StatePrisonKey, '"'+Literal+'"'
FROM         tblStatePrison

SELECT     DefiniteSentenceID, DefiniteSentenceKey, '"'+Literal+'"'
FROM         tblDefiniteSentence

SELECT     IntermittentImprisonmentID, IntermittentImprisonmentKey, '"'+Literal+'"'
FROM         tblIntermittentImprisonment

SELECT     ProbationID, ProbationKey+';', '"'+Literal+'"'
FROM         tblProbation

SELECT     ConditionalDischargeID, ConditionalDischargeKey+';', '"'+Literal+'"'
FROM         tblConditionalDischarge
 
SELECT     SplitsentenceID, SplitsentenceKey, '"'+Literal+'"'
FROM         tblSplitsentence

SELECT     FineID, FineKey, '"'+Literal+'"'
FROM         tblFine

SELECT     UnconditionalDischargeID, UnconditionalDischargeKey, '"'+Literal+'"'
FROM         tblUnconditionalDischarge

SELECT     RestitutionReparationID, RestitutionReparationKey, '"'+Literal+'"'
FROM         tblRestitutionReparation

SELECT     SurchargeVictimAssessmentFeeID, SurchargeVictimAssessmentFeeKey, '"'+Literal+'"'
FROM         tblSurchargeVictimAssessmentFee

SELECT LicensePenaltiesID,LicensePenaltiesKey, '"'+Literal+'"'
  FROM tblLicensePenalties

SELECT     ConsecutiveConcurrentID, ConsecutiveConcurrentKey, '"'+Literal+'"'
FROM         tblConsecutiveConcurrent
 
SELECT     EndID, EndKey, '"'+Literal+'"'
FROM         tblEnd


SELECT MitigatingFactorQuestionsID,Short,'"'+Literal+'"'
  FROM tblMitigatingFactorQuestions

SELECT QuestionsID,'"'+Literal+'"'
  FROM tblQuestions

SELECT SpecialQuestionsID,Short,'"'+Literal+'"',Criteria
  FROM tblSpecialQuestions
GO
/****** Object:  StoredProcedure [dbo].[AA_SPDELETEfromCrimetime]    Script Date: 02/23/2011 16:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[AA_SPDELETEfromCrimetime]
AS
Delete FROM tblCrimeAnswerConditionalDischarge
Delete FROM tblCrimeAnswerConsecutiveConcurrent 
Delete FROM tblCrimeAnswerDefiniteSentence 
Delete FROM tblCrimeAnswerEnd 
Delete FROM tblCrimeAnswerFine 
Delete FROM tblCrimeAnswerIntermittentImprisonment 
Delete FROM tblCrimeAnswerLicensePenalties 
Delete FROM tblCrimeAnswerPreface 
Delete FROM tblCrimeAnswerProbation 
Delete FROM tblCrimeAnswerRestitutionReparation 
Delete FROM tblCrimeAnswerSplitSentence 
Delete FROM tblCrimeAnswerStatePrison 
Delete FROM tblCrimeAnswerSurchargeVictimAssessmentFee 
Delete FROM tblCrimeAnswerTransition 
Delete FROM tblCrimeAnswerUnconditionalDischarge
Delete FROM tblCrimeAnswer
Delete from tblCrime
Delete from tblPreface
Delete from tblTransition
Delete from tblStatePrison
Delete from tblDefiniteSentence
Delete from tblintermittentImprisonment
Delete from tblProbation
Delete from tblConditionalDischarge
Delete from tblSplitsentence
Delete from tblFine
Delete from tblUnconditionalDischarge
Delete from tblRestitutionReparation
Delete from tblSurchargeVictimAssessmentFee
Delete from tblLicensePenalties
Delete from tblConsecutiveConcurrent
Delete from tblEnd
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTransitionbyID]    Script Date: 02/23/2011 16:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetTransitionbyID]
(
@TransitionID int
)
As
SELECT     Literal, TransitionID
FROM         tblTransition
WHERE     (TransitionID = @TransitionID)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateTransitionbyID]    Script Date: 02/23/2011 16:40:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateTransitionbyID]
(
@TransitionID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblTransition
SET              Literal =@NewLit 
WHERE     (TransitionID = @TransitionID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTransitionList]    Script Date: 02/23/2011 16:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetTransitionList]
AS
SELECT     TransitionID, TransitionKey
FROM         tblTransition
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTransitionByKey]    Script Date: 02/23/2011 16:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetTransitionByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblTransition
WHERE     (TransitionKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerTransition]    Script Date: 02/23/2011 16:39:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerTransition]
(
@CrimeAnswerID int
)
AS
SELECT     tblTransition.Literal, tblTransition.TransitionID, tblTransition.TransitionKey
FROM         tblTransition INNER JOIN
                      tblCrimeAnswerTransition ON tblTransition.TransitionID = tblCrimeAnswerTransition.TransitionID
WHERE     (tblCrimeAnswerTransition.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[A_ConvertDrugLawsTest]    Script Date: 02/23/2011 16:39:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[A_ConvertDrugLawsTest]
as
Begin

DECLARE  
@AgeCategory int,
@FelonyConvictions int, 
@PastConvictions int, 
@QuestionID int, 
@QuestionsResponse int, 
@Attempted bit,
@oldCrimeAnswerID int,
@newCrimeAnswerID int,
@CrimesID int,
@SentencingID int

-- declare the cursor
DECLARE CrimeANswer CURSOR FOR
SELECT     CrimeAnswerID, CrimesID, AgeCategory, FelonyConvictions, PastConvictions, QuestionID, QuestionsResponse, Attempted,druglawchanges07132009.TempID
FROM         tblCrimeAnswer INNER JOIN
                      drugchangestable2 ON tblCrimeAnswer.CrimeAnswerID = drugchangestable2.CAID INNER JOIN
                      druglawchanges07132009 ON drugchangestable2.SentencingAttachment = druglawchanges07132009.Literal


OPEN CrimeANswer
 

FETCH CrimeANswer INTO 
@oldCrimeAnswerID,
@CrimesID,
@AgeCategory,
@FelonyConvictions, 
@PastConvictions, 
@QuestionID, 
@QuestionsResponse, 
@Attempted,
@SentencingID

-- start the main processing loop.

WHILE @@Fetch_Status = 0

  BEGIN

UPDATE    tblCrimeAnswer
SET              QuestionID = 10, QuestionsResponse = 1
WHERE     (CrimeAnswerID = @oldCrimeAnswerID)

   -- This is where you perform your detailed row-by-row

   -- processing.

   -- Get the next row.
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, QuestionID, QuestionsResponse, Attempted)
VALUES     (@CrimesID,@AgeCategory,@FelonyConvictions,@PastConvictions,10,0,@Attempted)
Set @newCrimeAnswerID=@@Identity

INSERT INTO tblCrimeAnswerPreface
                      (CrimeAnswer, PrefaceID)
SELECT     @newCrimeAnswerID, PrefaceID
FROM         tblCrimeAnswerPreface AS tblCrimeAnswerPreface_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerTransition
                      (CrimeAnswer, TransitionID)
SELECT     @newCrimeAnswerID, TransitionID
FROM         tblCrimeAnswerTransition AS tblCrimeAnswerTransition_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerStatePrison
                      (CrimeAnswer, StatePrisonID)
SELECT     @newCrimeAnswerID, StatePrisonID
FROM         tblCrimeAnswerStatePrison AS tblCrimeAnswerStatePrison_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerDEFINITESENTENCE
                      (CrimeAnswer, DEFINITESENTENCEID)
SELECT     @newCrimeAnswerID, DEFINITESENTENCEID
FROM         tblCrimeAnswerDEFINITESENTENCE AS tblCrimeAnswerDEFINITESENTENCE_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerConSECutiveConcurrent
                      (CrimeAnswer, ConSECutiveConcurrentID)
SELECT     @newCrimeAnswerID, ConSECutiveConcurrentID
FROM         tblCrimeAnswerConSECutiveConcurrent AS tblCrimeAnswerConSECutiveConcurrent_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerIntermittentImprisonment
                      (CrimeAnswer, IntermittentImprisonmentID)
SELECT     @newCrimeAnswerID, IntermittentImprisonmentID
FROM         tblCrimeAnswerIntermittentImprisonment AS tblCrimeAnswerIntermittentImprisonment_1
where CrimeAnswer=@oldCrimeAnswerID


INSERT INTO tblCrimeAnswerSplitSentence
                      (CrimeAnswer, SplitSentenceID)
SELECT     @newCrimeAnswerID, SplitSentenceID
FROM         tblCrimeAnswerSplitSentence AS tblCrimeAnswerSplitSentence_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerPROBATION
                      (CrimeAnswer, PROBATIONID)
SELECT     @newCrimeAnswerID, PROBATIONID
FROM         tblCrimeAnswerPROBATION AS tblCrimeAnswerPROBATION_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerCONDITIONALDISCHARGE
                      (CrimeAnswer, CONDITIONALDISCHARGEID)
SELECT     @newCrimeAnswerID, CONDITIONALDISCHARGEID
FROM         tblCrimeAnswerCONDITIONALDISCHARGE AS tblCrimeAnswerCONDITIONALDISCHARGE_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerUNCONDITIONALDISCHARGE
                      (CrimeAnswer, UNCONDITIONALDISCHARGEID)
SELECT     @newCrimeAnswerID, UNCONDITIONALDISCHARGEID
FROM         tblCrimeAnswerUNCONDITIONALDISCHARGE AS tblCrimeAnswerUNCONDITIONALDISCHARGE_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerFINE
                      (CrimeAnswer, FINEID)
SELECT     @newCrimeAnswerID, FINEID
FROM         tblCrimeAnswerFINE AS tblCrimeAnswerFINE_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerSURCHARGEVictimAssessmentFee
                      (CrimeAnswer, SURCHARGEVictimAssessmentFeeID)
SELECT     @newCrimeAnswerID, SURCHARGEVictimAssessmentFeeID
FROM         tblCrimeAnswerSURCHARGEVictimAssessmentFee AS tblCrimeAnswerSURCHARGEVictimAssessmentFee_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerLicensePenalties
                      (CrimeAnswer, LicensePenaltiesID)
SELECT     @newCrimeAnswerID, LicensePenaltiesID
FROM         tblCrimeAnswerLicensePenalties AS tblCrimeAnswerLicensePenalties_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerRESTITUTIONREPARATION
                      (CrimeAnswer, RESTITUTIONREPARATIONID)
SELECT     @newCrimeAnswerID, RESTITUTIONREPARATIONID
FROM         tblCrimeAnswerRESTITUTIONREPARATION AS tblCrimeAnswerRESTITUTIONREPARATION_1
where CrimeAnswer=@oldCrimeAnswerID

INSERT INTO tblCrimeAnswerEnd
                      (CrimeAnswer, EndID)
SELECT     @newCrimeAnswerID, EndID
FROM         tblCrimeAnswerEnd AS tblCrimeAnswerEnd_1
where CrimeAnswer=@oldCrimeAnswerID


--INSERT INTO tblCrimeAnswerCasat
 --                     (CrimeAnswerID, CasatID)
--VALUES     (@newCrimeAnswerID,1)

--INSERT INTO tblCrimeAnswerCasat
                      --(CrimeAnswerID, CasatID)
--VALUES     (@oldCrimeAnswerID,1)


if @SentencingID in (8,9,14,17,20,23)
Begin
INSERT INTO tblCrimeAnswerSupervisedParole
                      (CrimeAnswerID, SupervisedParoleID)
VALUES     (@newCrimeAnswerID,1)
End

if @SentencingID in (5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,21,23)
Begin
INSERT INTO tblCrimeAnswerShock
                      (CrimeAnswerID, ShockID)
VALUES     (@newCrimeAnswerID,1)
End

if @SentencingID in (8,9,10,11,13,14,16,17,19,20,23)
Begin
INSERT INTO tblCrimeAnswerJudicialDiversion
                      (CrimeAnswerID, JudicialDiversionID)
VALUES     (@newCrimeAnswerID,1)
End







--
FETCH CrimeANswer INTO 
@oldCrimeAnswerID,
@CrimesID,
@AgeCategory,
@FelonyConvictions, 
@PastConvictions, 
@QuestionID, 
@QuestionsResponse, 
@Attempted,
@SentencingID

   END

CLOSE CrimeANswer

DEALLOCATE CrimeANswer

RETURN
INSERT INTO tblCrimeAnswerINTERIMPROBATIONSUPERVISION
                      (CrimeAnswerID, INTERIMPROBATIONSUPERVISIONID)
SELECT [CrimeAnswer],1
  FROM [CrimeTime].[dbo].[tblCrimeAnswerProbation]
End
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerStatePrison]    Script Date: 02/23/2011 16:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerStatePrison]
(
@CrimeAnswerID int
)
AS
SELECT     tblStatePrison.Literal, tblStatePrison.StatePrisonID, tblStatePrison.StatePrisonKey
FROM         tblStatePrison INNER JOIN
                      tblCrimeAnswerStatePrison ON tblStatePrison.StatePrisonID = tblCrimeAnswerStatePrison.StatePrisonID
WHERE     (tblCrimeAnswerStatePrison.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetStatePrisonbyID]    Script Date: 02/23/2011 16:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetStatePrisonbyID]
(
@StatePrisonID int
)
As
SELECT     Literal
FROM         tblStatePrison
WHERE     (StatePrisonID = @StatePrisonID)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateStatePrisonbyID]    Script Date: 02/23/2011 16:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateStatePrisonbyID]
(
@StatePrisonID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblStatePrison
SET              Literal =@NewLit 
WHERE     (StatePrisonID = @StatePrisonID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetStatePrisonByKey]    Script Date: 02/23/2011 16:39:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetStatePrisonByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblStatePrison
WHERE     (StatePrisonKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetStatePrisonList]    Script Date: 02/23/2011 16:39:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetStatePrisonList]
AS
SELECT     StatePrisonID, StatePrisonKey
FROM         tblStatePrison
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDefiniteSentencebyID]    Script Date: 02/23/2011 16:39:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetDefiniteSentencebyID]
(
@DefiniteSentenceID int
)
As
SELECT     Literal
FROM         tblDefiniteSentence
WHERE     (DefiniteSentenceID = @DefiniteSentenceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerDEFINITESENTENCE]    Script Date: 02/23/2011 16:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerDEFINITESENTENCE]
(
@CrimeAnswerID int
)
AS
SELECT     tblDefiniteSentence.Literal, tblDefiniteSentence.DefiniteSentenceID, tblDefiniteSentence.DefiniteSentenceKey
FROM         tblDefiniteSentence INNER JOIN
                      tblCrimeAnswerDefiniteSentence ON tblDefiniteSentence.DefiniteSentenceID = tblCrimeAnswerDefiniteSentence.DefiniteSentenceID
WHERE     (tblCrimeAnswerDefiniteSentence.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDEFINITESENTENCEByKey]    Script Date: 02/23/2011 16:39:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetDEFINITESENTENCEByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblDEFINITESENTENCE
WHERE     (DEFINITESENTENCEKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateDefiniteSentencebyID]    Script Date: 02/23/2011 16:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateDefiniteSentencebyID]
(
@DefiniteSentenceID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblDefiniteSentence
SET              Literal =@NewLit 
WHERE     (DefiniteSentenceID = @DefiniteSentenceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDefiniteSentenceList]    Script Date: 02/23/2011 16:39:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetDefiniteSentenceList]
AS
SELECT     DefiniteSentenceID, DefiniteSentenceKey
FROM         tblDefiniteSentence
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCrimeTimeUpdateInfo]    Script Date: 02/23/2011 16:39:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_InsertCrimeTimeUpdateInfo]
(
@VersionNumber nvarchar(50),
@UpdateDate datetime
)
AS
INSERT INTO tblCrimeUpdate
                      (CrimeVersion, CrimeUpdateDate)
VALUES     (@VersionNumber, @UpdateDate)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeTimeUpdateInfo]    Script Date: 02/23/2011 16:39:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeTimeUpdateInfo]
AS
SELECT  Top 1  ISNULL(CrimeVersion,'0') as CrimeVersion, CrimeUpdateDate, ISNULL(CrimeUpdateID,'0') as CrimeUpdateID
FROM         tblCrimeUpdate
ORDER BY CrimeUpdateID DESC
GO
/****** Object:  StoredProcedure [dbo].[AAAA_SPFormatKaylaSpreadsheet]    Script Date: 02/23/2011 16:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AAAA_SPFormatKaylaSpreadsheet]
AS

update kaylaspreadsheet
set UseThis=rtrim(UseThis)
update kaylaspreadsheet
set CrimeName=ltrim(CrimeName)
update kaylaspreadsheet
set CrimeName=rtrim(CrimeName)
update kaylaspreadsheet
set UseThis=ltrim(UseThis)
update kaylaspreadsheet
set Cite=rtrim(Cite)
update kaylaspreadsheet
set Cite=ltrim(Cite)
UPDATE    kaylaspreadsheet
SET   Cite =upper(Cite)
update kaylaspreadsheet
set [Level]=rtrim([Level])
update kaylaspreadsheet
set [Level]=ltrim([Level])
update kaylaspreadsheet
set Age=rtrim(Age)
update kaylaspreadsheet
set Age=ltrim(Age)
update kaylaspreadsheet
set PastConvictions=rtrim(PastConvictions)
update kaylaspreadsheet
set PastConvictions=ltrim(PastConvictions)
update kaylaspreadsheet
set FelonyLevel=rtrim(FelonyLevel)
update kaylaspreadsheet
set FelonyLevel=ltrim(FelonyLevel)

UPDATE    KaylaSpreadsheet
SET              Age = 'Youthful Offender'
WHERE     (Age = 'Youthfull Offender')
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateSpecialPopups]    Script Date: 02/23/2011 16:39:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateSpecialPopups]
(
@SID int,
@Literal nvarchar(max),
@Reason nvarchar(150)
)
AS
UPDATE    tblSpecialPopUps
SET              Literal = @Literal, Reason = @Reason
WHERE     (SpecialPopUpsID = @SID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSpecialPopupsBYID]    Script Date: 02/23/2011 16:39:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetSpecialPopupsBYID]
(
@SID int
)
AS
SELECT     Literal, Reason
FROM         tblSpecialPopUps
where SpecialPopUpsID=@SID
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSpecialPopups]    Script Date: 02/23/2011 16:39:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetSpecialPopups]
AS
SELECT     SpecialPopUpsID, Literal, Reason
FROM         tblSpecialPopUps
GO
/****** Object:  StoredProcedure [dbo].[SP_ADDSpecialPopups]    Script Date: 02/23/2011 16:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_ADDSpecialPopups]
(
@Literal nvarchar(max),
@Reason nvarchar(150)
)
AS
INSERT INTO tblSpecialPopUps
                      (Literal, Reason)
VALUES     (@Literal,@Reason)
GO
/****** Object:  StoredProcedure [dbo].[SP_VerifyUser]    Script Date: 02/23/2011 16:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_VerifyUser]
(
@User nvarchar(500),
@Password nvarchar(100),
@IP nvarchar(100)
)
AS
Declare @Us int
Declare @Stat int
Set @US=0
Set @stat=0

SELECT     @US=UserID, @stat=1
FROM         tblUser
WHERE     (Username =@User) AND ([Password] = @Password)

select @US as UserID,@stat As StatusCode
GO
/****** Object:  StoredProcedure [dbo].[AAAA_SPFormat130Spreadsheet]    Script Date: 02/23/2011 16:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AAAA_SPFormat130Spreadsheet]
AS

update NewCrime130sSpreadsheet
set CrimeName=ltrim(CrimeName)
update NewCrime130sSpreadsheet
set CrimeName=rtrim(CrimeName)
update NewCrime130sSpreadsheet
set Cite=rtrim(Cite)
update NewCrime130sSpreadsheet
set Cite=ltrim(Cite)
UPDATE    NewCrime130sSpreadsheet
SET   Cite =upper(Cite)
update NewCrime130sSpreadsheet
set [Level]=rtrim([Level])
update NewCrime130sSpreadsheet
set [Level]=ltrim([Level])
update NewCrime130sSpreadsheet
set Age=rtrim(Age)
update NewCrime130sSpreadsheet
set Age=ltrim(Age)
update NewCrime130sSpreadsheet
set PastConvictions=rtrim(PastConvictions)
update NewCrime130sSpreadsheet
set PastConvictions=ltrim(PastConvictions)
update NewCrime130sSpreadsheet
set FelonyLevel=rtrim(FelonyLevel)
update NewCrime130sSpreadsheet
set FelonyLevel=ltrim(FelonyLevel)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSpecialQuestionResponses]    Script Date: 02/23/2011 16:39:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetSpecialQuestionResponses]
(
@SpecialQuestion nvarchar(150)
)
AS
SELECT     tblSpecialQuestionsParagraphs.ParagraphsID, tblSpecialQuestionsParagraphs.ParagraphKey
FROM         tblSpecialQuestionsParagraphs INNER JOIN
                      tblSpecialQuestions ON tblSpecialQuestionsParagraphs.SpecialQuestionsID = tblSpecialQuestions.SpecialQuestionsID
WHERE     (tblSpecialQuestions.Short = @SpecialQuestion)
GO
/****** Object:  StoredProcedure [dbo].[AAAA_SPFormatoldcrimeNewTableSpreadsheet]    Script Date: 02/23/2011 16:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AAAA_SPFormatoldcrimeNewTableSpreadsheet]
AS

update OldCrimesManualSpreadsheet
set UseThis=rtrim(UseThis)
update OldCrimesManualSpreadsheet
set CrimeName=ltrim(CrimeName)
update OldCrimesManualSpreadsheet
set CrimeName=rtrim(CrimeName)
update OldCrimesManualSpreadsheet
set UseThis=ltrim(UseThis)
update OldCrimesManualSpreadsheet
set Cite=rtrim(Cite)
update OldCrimesManualSpreadsheet
set Cite=ltrim(Cite)
UPDATE    OldCrimesManualSpreadsheet
SET   Cite =upper(Cite)
update OldCrimesManualSpreadsheet
set [Level]=rtrim([Level])
update OldCrimesManualSpreadsheet
set [Level]=ltrim([Level])
update OldCrimesManualSpreadsheet
set Age=rtrim(Age)
update OldCrimesManualSpreadsheet
set Age=ltrim(Age)
update OldCrimesManualSpreadsheet
set PastConvictions=rtrim(PastConvictions)
update OldCrimesManualSpreadsheet
set PastConvictions=ltrim(PastConvictions)
update OldCrimesManualSpreadsheet
set FelonyLevel=rtrim(FelonyLevel)
update OldCrimesManualSpreadsheet
set FelonyLevel=ltrim(FelonyLevel)

UPDATE    OldCrimesManualSpreadsheet
SET              Age = 'Youthful Offender'
WHERE     (Age = 'Youthfull Offender')
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMitigatingQuestionForCrime]    Script Date: 02/23/2011 16:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetMitigatingQuestionForCrime]
(
@CrimeID int,
@AgeCatID int
)
AS
SELECT     tblMitigatingFactorQuestions.Literal, tblCrimesMitigatingFactorQuestions.CrimesID
FROM         tblCrimesMitigatingFactorQuestions INNER JOIN
                      tblMitigatingFactorQuestions ON 
                      tblCrimesMitigatingFactorQuestions.MitigatingFactorQuestionsID = tblMitigatingFactorQuestions.MitigatingFactorQuestionsID
WHERE     (tblCrimesMitigatingFactorQuestions.AgeCategory = @AgeCatID) AND (tblCrimesMitigatingFactorQuestions.CrimesID = @CrimeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMitigatingQuestionList]    Script Date: 02/23/2011 16:39:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetMitigatingQuestionList]
AS
SELECT     Short, MitigatingFactorQuestionsID
FROM         tblMitigatingFactorQuestions
GO
/****** Object:  StoredProcedure [dbo].[SP_AddCrimeAnswer]    Script Date: 02/23/2011 16:39:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_AddCrimeAnswer]
(
@CrimesID int,
@Attempt bit,
@AgeCat int,
@FelonyCon int,
@PastConv int,
@QuestionID int,
@QuestionResponse bit,
@Mitigating int
)
AS
Declare @AnswerID int
If @Mitigating is null
Begin
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, QuestionID, QuestionsResponse, Attempted)
VALUES     (@CrimesID,@AgeCat,@FelonyCon,@PastConv,@QuestionID,@QuestionResponse,@Attempt)
Set @AnswerID =@@identity
Select @AnswerID as AnswerID
End
else
Begin
INSERT INTO tblCrimesMitigatingFactorQuestions
                      (MitigatingFactorQuestionsID, AgeCategory, CrimesID)
VALUES     (@Mitigating,@AgeCat,@CrimesID)

INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, QuestionID, QuestionsResponse, Attempted)
VALUES     (@CrimesID,@AgeCat,@FelonyCon,@PastConv,@QuestionID,@QuestionResponse,@Attempt)
Set @AnswerID =@@identity
Select @AnswerID as AnswerID
End
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeAttemptPossibility]    Script Date: 02/23/2011 16:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetCrimeAttemptPossibility]
(
@CrimeID int
)
as
SELECT     Attempted
FROM         tblCrimeAnswer
WHERE     (CrimesID = @CrimeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeQuestion]    Script Date: 02/23/2011 16:39:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeQuestion]
(
@CrimeID int,
@Attempted bit
)
AS
SELECT     tblQuestions.QuestionsID,tblQuestions.Literal, tblCrimeAnswer.CrimesID, tblCrimeAnswer.Attempted
FROM         tblQuestions INNER JOIN
                      tblCrimeAnswer ON tblQuestions.QuestionsID = tblCrimeAnswer.QuestionID
WHERE     (tblCrimeAnswer.CrimesID = @CrimeID) AND (tblCrimeAnswer.Attempted = @Attempted)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeAnswerID]    Script Date: 02/23/2011 16:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeAnswerID]
(
@CrimeID int,
@AgeCat int,
@FelConvictions int,
@PastConvictions int,
@ResponseID bit,
@Attempt bit
)
AS
SELECT     CrimeAnswerID
FROM         tblCrimeAnswer
WHERE     (CrimesID = @CrimeID) AND ((AgeCategory = @AgeCat) OR (AgeCategory is null) ) AND ((FelonyConvictions = @FelConvictions) OR (FelonyConvictions is null)) AND ((PastConvictions = @PastConvictions) OR (PastConvictions is null) ) AND ((QuestionsResponse = @ResponseID) OR (QuestionsResponse is null) ) AND (Attempted = @Attempt)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddPrefaceToCrime]    Script Date: 02/23/2011 16:39:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddPrefaceToCrime]
(
@CrimeAnswerID int,
@PrefaceID int
)
AS
INSERT INTO tblCrimeAnswerPreface
                      (CrimeAnswer, PrefaceID)
VALUES     (@CrimeAnswerID,@PrefaceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_RemoveParagraphsfromCrime]    Script Date: 02/23/2011 16:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_RemoveParagraphsfromCrime]
(
@CrimeAnswerID int
)
AS
DELETE FROM tblCrimeAnswerPreface
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerTransition
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerStatePrison
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerDefiniteSentence
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerIntermittentImprisonment
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerProbation
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerConditionalDischarge
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerSplitSentence
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerFine
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerUnconditionalDischarge
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerRestitutionReparation
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerSurchargeVictimAssessmentFee
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerLicensePenalties
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerConsecutiveConcurrent
WHERE     (CrimeAnswer = @CrimeAnswerID)

DELETE FROM tblCrimeAnswerEnd
WHERE     (CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddTransitionToCrime]    Script Date: 02/23/2011 16:39:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddTransitionToCrime]
(
@CrimeAnswerID int,
@TransitionID int
)
AS
INSERT INTO tblCrimeAnswerTransition
                      (CrimeAnswer, TransitionID)
VALUES     (@CrimeAnswerID,@TransitionID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddStatePrisonToCrime]    Script Date: 02/23/2011 16:39:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddStatePrisonToCrime]
(
@CrimeAnswerID int,
@StatePrisonID int
)
AS
INSERT INTO tblCrimeAnswerStatePrison
                      (CrimeAnswer, StatePrisonID)
VALUES     (@CrimeAnswerID,@StatePrisonID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddDefiniteSentenceToCrime]    Script Date: 02/23/2011 16:39:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddDefiniteSentenceToCrime]
(
@CrimeAnswerID int,
@DefiniteSentenceID int
)
AS
INSERT INTO tblCrimeAnswerDefiniteSentence
                      (CrimeAnswer, DefiniteSentenceID)
VALUES     (@CrimeAnswerID,@DefiniteSentenceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_ReportAnswer]    Script Date: 02/23/2011 16:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ReportAnswer]
(
@CAID int,
@Issue nvarchar(500),
@EmailAddressID INT
)
AS
INSERT INTO tblCrimeAnswerIssue
                      (CrimeAnswerID, Issue, EmailAddressID, DateReported)
VALUES     (@CAID,@Issue,@EmailAddressID,GetDate())
GO
/****** Object:  StoredProcedure [dbo].[SP_MarkIssueAsFixed]    Script Date: 02/23/2011 16:39:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_MarkIssueAsFixed]
(
@IssueID int,
@FixDate datetime
)
AS
UPDATE    tblCrimeAnswerIssue
SET              Fixed =1, DateFixed =@FixDate
WHERE     (AnswerIssueID = @IssueID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddConsecutiveConcurrentToCrime]    Script Date: 02/23/2011 16:39:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddConsecutiveConcurrentToCrime]
(
@CrimeAnswerID int,
@ConsecutiveConcurrentID int
)
AS
INSERT INTO tblCrimeAnswerConsecutiveConcurrent
                      (CrimeAnswer, ConsecutiveConcurrentID)
VALUES     (@CrimeAnswerID,@ConsecutiveConcurrentID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerConSECutiveConcurrent]    Script Date: 02/23/2011 16:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerConSECutiveConcurrent]
(
@CrimeAnswerID int
)
AS
SELECT     tblConsecutiveConcurrent.Literal, tblConsecutiveConcurrent.ConsecutiveConcurrentID, tblConsecutiveConcurrent.ConsecutiveConcurrentKey
FROM         tblConsecutiveConcurrent INNER JOIN
                      tblCrimeAnswerConsecutiveConcurrent ON 
                      tblConsecutiveConcurrent.ConsecutiveConcurrentID = tblCrimeAnswerConsecutiveConcurrent.ConsecutiveConcurrentID
WHERE     (tblCrimeAnswerConsecutiveConcurrent.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEndToCrime]    Script Date: 02/23/2011 16:39:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddEndToCrime]
(
@CrimeAnswerID int,
@EndID int
)
AS
INSERT INTO tblCrimeAnswerEnd
                      (CrimeAnswer, EndID)
VALUES     (@CrimeAnswerID,@EndID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerEnd]    Script Date: 02/23/2011 16:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerEnd]
(
@CrimeAnswerID int
)
AS
SELECT     tblEnd.Literal, tblEnd.EndID, tblEnd.EndKey
FROM         tblEnd INNER JOIN
                      tblCrimeAnswerEnd ON tblEnd.EndID = tblCrimeAnswerEnd.EndID
WHERE     (tblCrimeAnswerEnd.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetIntermittentImprisonmentList]    Script Date: 02/23/2011 16:39:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetIntermittentImprisonmentList]
AS
SELECT     IntermittentImprisonmentID, IntermittentImprisonmentKey
FROM         tblIntermittentImprisonment
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateIntermittentImprisonmentbyID]    Script Date: 02/23/2011 16:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateIntermittentImprisonmentbyID]
(
@IntermittentImprisonmentID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblIntermittentImprisonment
SET              Literal =@NewLit 
WHERE     (IntermittentImprisonmentID = @IntermittentImprisonmentID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetIntermittentImprisonmentByKey]    Script Date: 02/23/2011 16:39:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetIntermittentImprisonmentByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblIntermittentImprisonment
WHERE     (IntermittentImprisonmentKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetIntermittentImprisonmentbyID]    Script Date: 02/23/2011 16:39:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetIntermittentImprisonmentbyID]
(
@IntermittentImprisonmentID int
)
As
SELECT     Literal
FROM         tblIntermittentImprisonment
WHERE     (IntermittentImprisonmentID = @IntermittentImprisonmentID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerIntermittentImprisonment]    Script Date: 02/23/2011 16:39:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerIntermittentImprisonment]
(
@CrimeAnswerID int
)
AS
SELECT     tblIntermittentImprisonment.Literal, tblIntermittentImprisonment.IntermittentImprisonmentID, 
                      tblIntermittentImprisonment.IntermittentImprisonmentKey
FROM         tblIntermittentImprisonment INNER JOIN
                      tblCrimeAnswerIntermittentImprisonment ON 
                      tblIntermittentImprisonment.IntermittentImprisonmentID = tblCrimeAnswerIntermittentImprisonment.IntermittentImprisonmentID
WHERE     (tblCrimeAnswerIntermittentImprisonment.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddUnconditionalDischargeToCrime]    Script Date: 02/23/2011 16:39:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_AddUnconditionalDischargeToCrime]
(
@CrimeAnswerID int,
@UnconditionalDischargeID int
)
AS
INSERT INTO tblCrimeAnswerUnconditionalDischarge
                      (CrimeAnswer, UnconditionalDischargeID)
VALUES     (@CrimeAnswerID,@UnconditionalDischargeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerUNCONDTIONALDISCHARGE]    Script Date: 02/23/2011 16:39:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerUNCONDTIONALDISCHARGE]
(
@CrimeAnswerID int
)
AS
SELECT     tblUnconditionalDischarge.UnconditionalDischargeID, tblUnconditionalDischarge.UnconditionalDischargeKey, tblUnconditionalDischarge.Literal
FROM         tblUnconditionalDischarge INNER JOIN
                      tblCrimeAnswerUnconditionalDischarge ON 
                      tblUnconditionalDischarge.UnconditionalDischargeID = tblCrimeAnswerUnconditionalDischarge.UnconditionalDischargeID
WHERE     (tblCrimeAnswerUnconditionalDischarge.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPROBATIONByKey]    Script Date: 02/23/2011 16:39:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetPROBATIONByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblPROBATION
WHERE     (PROBATIONKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProbationList]    Script Date: 02/23/2011 16:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetProbationList]
AS
SELECT     ProbationID, ProbationKey
FROM         tblProbation
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProbationbyID]    Script Date: 02/23/2011 16:39:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetProbationbyID]
(
@ProbationID int
)
As
SELECT     Literal
FROM         tblProbation
WHERE     (ProbationID = @ProbationID)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProbationbyID]    Script Date: 02/23/2011 16:39:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateProbationbyID]
(
@ProbationID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblProbation
SET              Literal =@NewLit 
WHERE     (ProbationID = @ProbationID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerPROBATION]    Script Date: 02/23/2011 16:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerPROBATION]
(
@CrimeAnswerID int
)
AS
SELECT     tblProbation.Literal, tblProbation.ProbationID, tblProbation.ProbationKey
FROM         tblProbation INNER JOIN
                      tblCrimeAnswerProbation ON tblProbation.ProbationID = tblCrimeAnswerProbation.ProbationID
WHERE     (tblCrimeAnswerProbation.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerRESTITUTIONREPARATION]    Script Date: 02/23/2011 16:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerRESTITUTIONREPARATION]
(
@CrimeAnswerID int
)
AS
SELECT     tblRestitutionReparation.Literal, tblRestitutionReparation.RestitutionReparationID, tblRestitutionReparation.RestitutionReparationKey
FROM         tblRestitutionReparation INNER JOIN
                      tblCrimeAnswerRestitutionReparation ON 
                      tblRestitutionReparation.RestitutionReparationID = tblCrimeAnswerRestitutionReparation.RestitutionReparationID
WHERE     (tblCrimeAnswerRestitutionReparation.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddRestitutionReparationToCrime]    Script Date: 02/23/2011 16:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddRestitutionReparationToCrime]
(
@CrimeAnswerID int,
@RestitutionReparationID int
)
AS
INSERT INTO tblCrimeAnswerRestitutionReparation
                      (CrimeAnswer, RestitutionReparationID)
VALUES     (@CrimeAnswerID,@RestitutionReparationID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCONDITIONALDISCHARGEbyID]    Script Date: 02/23/2011 16:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetCONDITIONALDISCHARGEbyID]
(
@CONDITIONALDISCHARGEID int
)
As
SELECT     Literal
FROM        tblCONDITIONALDISCHARGE
WHERE     (CONDITIONALDISCHARGEID = @CONDITIONALDISCHARGEID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCONDITIONALDISCHARGEByKey]    Script Date: 02/23/2011 16:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetCONDITIONALDISCHARGEByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblCONDITIONALDISCHARGE
WHERE     (CONDITIONALDISCHARGEKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateConditionalDischargebyID]    Script Date: 02/23/2011 16:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateConditionalDischargebyID]
(
@ConditionalDischargeID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblConditionalDischarge
SET              Literal =@NewLit 
WHERE     (ConditionalDischargeID = @ConditionalDischargeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetConditionalDischargeList]    Script Date: 02/23/2011 16:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetConditionalDischargeList]
AS
SELECT     ConditionalDischargeID, ConditionalDischargeKey
FROM         tblConditionalDischarge
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerCONDITIONALDISCHARGE]    Script Date: 02/23/2011 16:39:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerCONDITIONALDISCHARGE]
(
@CrimeAnswerID int
)
AS
SELECT     tblConditionalDischarge.Literal, tblConditionalDischarge.ConditionalDischargeID, tblConditionalDischarge.ConditionalDischargeKey
FROM         tblConditionalDischarge INNER JOIN
                      tblCrimeAnswerConditionalDischarge ON 
                      tblConditionalDischarge.ConditionalDischargeID = tblCrimeAnswerConditionalDischarge.ConditionalDischargeID
WHERE     (tblCrimeAnswerConditionalDischarge.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddSurchargeVictimAssessmentFeeToCrime]    Script Date: 02/23/2011 16:39:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddSurchargeVictimAssessmentFeeToCrime]
(
@CrimeAnswerID int,
@SurchargeVictimAssessmentFeeID int
)
AS
INSERT INTO tblCrimeAnswerSurchargeVictimAssessmentFee
                      (CrimeAnswer, SurchargeVictimAssessmentFeeID)
VALUES     (@CrimeAnswerID,@SurchargeVictimAssessmentFeeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerSURCHARGEVictimAssessmentFee]    Script Date: 02/23/2011 16:39:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerSURCHARGEVictimAssessmentFee]
(
@CrimeAnswerID int
)
AS
SELECT     tblSurchargeVictimAssessmentFee.Literal, tblSurchargeVictimAssessmentFee.SurchargeVictimAssessmentFeeID, 
                      tblSurchargeVictimAssessmentFee.SurchargeVictimAssessmentFeeKey
FROM         tblSurchargeVictimAssessmentFee INNER JOIN
                      tblCrimeAnswerSurchargeVictimAssessmentFee ON 
                      tblSurchargeVictimAssessmentFee.SurchargeVictimAssessmentFeeID = tblCrimeAnswerSurchargeVictimAssessmentFee.SurchargeVictimAssessmentFeeID
WHERE     (tblCrimeAnswerSurchargeVictimAssessmentFee.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSplitSentenceList]    Script Date: 02/23/2011 16:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetSplitSentenceList]
AS
SELECT     SplitsentenceID, SplitsentenceKey
FROM         tblSplitsentence
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSplitsentencebyID]    Script Date: 02/23/2011 16:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetSplitsentencebyID]
(
@SplitsentenceID int
)
As
SELECT     Literal
FROM         tblSplitsentence
WHERE     (SplitsentenceID = @SplitsentenceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSplitSentenceByKey]    Script Date: 02/23/2011 16:39:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetSplitSentenceByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblSplitSentence
WHERE     (SplitSentenceKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerSplitSentence]    Script Date: 02/23/2011 16:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerSplitSentence]
(
@CrimeAnswerID int
)
AS
SELECT     tblSplitsentence.Literal, tblSplitsentence.SplitsentenceID, tblSplitsentence.SplitsentenceKey
FROM         tblSplitsentence INNER JOIN
                      tblCrimeAnswerSplitSentence ON tblSplitsentence.SplitsentenceID = tblCrimeAnswerSplitSentence.SplitSentenceID
WHERE     (tblCrimeAnswerSplitSentence.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateSplitsentencebyID]    Script Date: 02/23/2011 16:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateSplitsentencebyID]
(
@SplitsentenceID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblSplitsentence
SET              Literal =@NewLit 
WHERE     (SplitsentenceID = @SplitsentenceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerLicensePenalties]    Script Date: 02/23/2011 16:39:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerLicensePenalties]
(
@CrimeAnswerID int
)
AS
SELECT     tblLicensePenalties.Literal, tblLicensePenalties.LicensePenaltiesID, tblLicensePenalties.LicensePenaltiesKey
FROM         tblLicensePenalties INNER JOIN
                      tblCrimeAnswerLicensePenalties ON tblLicensePenalties.LicensePenaltiesID = tblCrimeAnswerLicensePenalties.LicensePenaltiesID
WHERE     (tblCrimeAnswerLicensePenalties.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddLiscensePenaltiesToCrime]    Script Date: 02/23/2011 16:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_AddLiscensePenaltiesToCrime]
(
@CrimeAnswerID int,
@LiscensePenaltiesID int
)
AS
INSERT INTO tblCrimeAnswerLicensePenalties
                      (CrimeAnswer, LicensePenaltiesID)
VALUES     (@CrimeAnswerID,@LiscensePenaltiesID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFINEByKey]    Script Date: 02/23/2011 16:39:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetFINEByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblFINE
WHERE     (FINEKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAnswerFINE]    Script Date: 02/23/2011 16:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAnswerFINE]
(
@CrimeAnswerID int
)
AS
SELECT     tblFine.Literal, tblFine.FineID, tblFine.FineKey
FROM         tblFine INNER JOIN
                      tblCrimeAnswerFine ON tblFine.FineID = tblCrimeAnswerFine.FineID
WHERE     (tblCrimeAnswerFine.CrimeAnswer = @CrimeAnswerID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFinebyID]    Script Date: 02/23/2011 16:39:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetFinebyID]
(
@FineID int
)
As
SELECT     Literal
FROM        tblFine
WHERE     (FineID = @FineID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFineList]    Script Date: 02/23/2011 16:39:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetFineList]
AS
SELECT     FineID, FineKey
FROM         tblFine
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateFinebyID]    Script Date: 02/23/2011 16:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateFinebyID]
(
@FineID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblFine
SET              Literal =@NewLit 
WHERE     (FineID = @FineID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddIntermittentImprisonmentToCrime]    Script Date: 02/23/2011 16:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddIntermittentImprisonmentToCrime]
(
@CrimeAnswerID int,
@IntermittentImprisonmentID int
)
AS
INSERT INTO tblCrimeAnswerIntermittentImprisonment
                      (CrimeAnswer, IntermittentImprisonmentID)
VALUES     (@CrimeAnswerID,@IntermittentImprisonmentID)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateUnConditionalDischargebyID]    Script Date: 02/23/2011 16:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateUnConditionalDischargebyID]
(
@UnConditionalDischargeID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblUnConditionalDischarge
SET              Literal =@NewLit 
WHERE     (UnConditionalDischargeID = @UnConditionalDischargeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUNCONDTIONALDISCHARGEByKey]    Script Date: 02/23/2011 16:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetUNCONDTIONALDISCHARGEByKey]
(
@ParagraphKey nvarchar(150)
)
as

SELECT     Literal
FROM         tblUnconditionalDischarge
WHERE     (UnconditionalDischargeKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUnConditionalDischargeList]    Script Date: 02/23/2011 16:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetUnConditionalDischargeList]
AS
SELECT     UnconditionalDischargeID, UnconditionalDischargeKey
FROM         tblUnconditionalDischarge
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUnconditionalDischargebyID]    Script Date: 02/23/2011 16:39:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetUnconditionalDischargebyID]
(
@UnconditionalDischargeID int
)
As
SELECT     Literal
FROM        tblUnconditionalDischarge
WHERE     (UnconditionalDischargeID = @UnconditionalDischargeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddProbationToCrime]    Script Date: 02/23/2011 16:39:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddProbationToCrime]
(
@CrimeAnswerID int,
@ProbationID int
)
AS
INSERT INTO tblCrimeAnswerProbation
                      (CrimeAnswer, ProbationID)
VALUES     (@CrimeAnswerID,@ProbationID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRESTITUTIONREPARATIONByKey]    Script Date: 02/23/2011 16:39:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetRESTITUTIONREPARATIONByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblRESTITUTIONREPARATION
WHERE     (RESTITUTIONREPARATIONKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRestitutionReparationbyID]    Script Date: 02/23/2011 16:39:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetRestitutionReparationbyID]
(
@RestitutionReparationID int
)
As
SELECT     Literal
FROM        tblRestitutionReparation
WHERE     (RestitutionReparationID = @RestitutionReparationID)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateRestitutionReparationbyID]    Script Date: 02/23/2011 16:39:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateRestitutionReparationbyID]
(
@RestitutionReparationID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblRestitutionReparation
SET              Literal =@NewLit 
WHERE     (RestitutionReparationID = @RestitutionReparationID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRestitutionReparationList]    Script Date: 02/23/2011 16:39:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetRestitutionReparationList]
AS
SELECT     RestitutionReparationID, RestitutionReparationKey
FROM         tblRestitutionReparation
GO
/****** Object:  StoredProcedure [dbo].[SP_AddConditionalDischargeToCrime]    Script Date: 02/23/2011 16:39:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddConditionalDischargeToCrime]
(
@CrimeAnswerID int,
@ConditionalDischargeID int
)
AS
INSERT INTO tblCrimeAnswerConditionalDischarge
                      (CrimeAnswer, ConditionalDischargeID)
VALUES     (@CrimeAnswerID,@ConditionalDischargeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateSurchargeVictimAssessmentFeebyID]    Script Date: 02/23/2011 16:40:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateSurchargeVictimAssessmentFeebyID]
(
@SurchargeVictimAssessmentFeeID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblSurchargeVictimAssessmentFee
SET              Literal =@NewLit 
WHERE     (SurchargeVictimAssessmentFeeID = @SurchargeVictimAssessmentFeeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSURCHARGEVictimAssessmentFeeByKey]    Script Date: 02/23/2011 16:39:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetSURCHARGEVictimAssessmentFeeByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblSURCHARGEVictimAssessmentFee
WHERE     (SURCHARGEVictimAssessmentFeeKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSurchargeVictimAssessmentFeeList]    Script Date: 02/23/2011 16:39:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetSurchargeVictimAssessmentFeeList]
AS
SELECT     SurchargeVictimAssessmentFeeID, SurchargeVictimAssessmentFeeKey
FROM         tblSurchargeVictimAssessmentFee
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSurchargeVictimAssessmentFeebyID]    Script Date: 02/23/2011 16:39:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetSurchargeVictimAssessmentFeebyID]
(
@SurchargeVictimAssessmentFeeID int
)
As
SELECT     Literal
FROM        tblSurchargeVictimAssessmentFee
WHERE     (SurchargeVictimAssessmentFeeID = @SurchargeVictimAssessmentFeeID)
GO
/****** Object:  StoredProcedure [dbo].[SP_AddSplitSentenceToCrime]    Script Date: 02/23/2011 16:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddSplitSentenceToCrime]
(
@CrimeAnswerID int,
@SplitSentenceID int
)
AS
INSERT INTO tblCrimeAnswerSplitSentence
                      (CrimeAnswer, SplitSentenceID)
VALUES     (@CrimeAnswerID,@SplitSentenceID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLicensePenaltiesByKey]    Script Date: 02/23/2011 16:39:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetLicensePenaltiesByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblLicensePenalties
WHERE     (LicensePenaltiesKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLicensePenaltiesbyID]    Script Date: 02/23/2011 16:39:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetLicensePenaltiesbyID]
(
@LicensePenaltiesID int
)
As
SELECT     Literal
FROM        tblLicensePenalties
WHERE     (LicensePenaltiesID = @LicensePenaltiesID)
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateLicensePenaltiesbyID]    Script Date: 02/23/2011 16:39:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateLicensePenaltiesbyID]
(
@LicensePenaltiesID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblLicensePenalties
SET              Literal =@NewLit 
WHERE     (LicensePenaltiesID = @LicensePenaltiesID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetLiscensePenaltiesList]    Script Date: 02/23/2011 16:39:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetLiscensePenaltiesList]
AS
SELECT LicensePenaltiesID,LicensePenaltiesKey
  FROM tblLicensePenalties
GO
/****** Object:  StoredProcedure [dbo].[SP_AddFineToCrime]    Script Date: 02/23/2011 16:39:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_AddFineToCrime]
(
@CrimeAnswerID int,
@FineID int
)
AS
INSERT INTO tblCrimeAnswerFine
                      (CrimeAnswer, FineID)
VALUES     (@CrimeAnswerID,@FineID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetConsecutiveConcurrentbyID]    Script Date: 02/23/2011 16:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetConsecutiveConcurrentbyID]
(
@ConsecutiveConcurrentID int
)
As
SELECT     Literal
FROM        tblConsecutiveConcurrent
WHERE     (ConsecutiveConcurrentID = @ConsecutiveConcurrentID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetConSECutiveConcurrentByKey]    Script Date: 02/23/2011 16:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetConSECutiveConcurrentByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblConSECutiveConcurrent
WHERE     (ConSECutiveConcurrentKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetConsecutiveConcurrentList]    Script Date: 02/23/2011 16:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetConsecutiveConcurrentList]
AS
SELECT     ConsecutiveConcurrentID, ConsecutiveConcurrentKey
FROM         tblConsecutiveConcurrent
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateConsecutiveConcurrentbyID]    Script Date: 02/23/2011 16:39:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateConsecutiveConcurrentbyID]
(
@ConsecutiveConcurrentID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblConsecutiveConcurrent
SET              Literal =@NewLit 
WHERE     (ConsecutiveConcurrentID = @ConsecutiveConcurrentID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetENDList]    Script Date: 02/23/2011 16:39:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetENDList]
AS
SELECT     EndID, EndKey
FROM         tblEnd
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateEndbyID]    Script Date: 02/23/2011 16:39:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_UpdateEndbyID]
(
@EndID int,
@NewLit nvarchar(4000)
)
AS
UPDATE    tblEnd
SET              Literal =@NewLit 
WHERE     (EndID = @EndID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEndbyID]    Script Date: 02/23/2011 16:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetEndbyID]
(
@EndID int
)
As
SELECT     Literal
FROM        tblEnd
WHERE     (EndID = @EndID)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEndByKey]    Script Date: 02/23/2011 16:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetEndByKey]
(
@ParagraphKey nvarchar(150)
)
as
SELECT     Literal
FROM         tblEnd
WHERE     (EndKey = @ParagraphKey)
GO
/****** Object:  StoredProcedure [dbo].[SP_GetQuestion]    Script Date: 02/23/2011 16:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetQuestion]
(
@QuestionID int
)
As
SELECT     Literal
FROM         tblQuestions
where QuestionsID=@QuestionID
GO
/****** Object:  StoredProcedure [dbo].[SP_GetQuestionList]    Script Date: 02/23/2011 16:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetQuestionList]
As
SELECT     QuestionsID, Literal
FROM         tblQuestions
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertQuestiontoList]    Script Date: 02/23/2011 16:39:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_InsertQuestiontoList]
(
@Question nvarchar(500)
)
As
INSERT INTO tblQuestions
                      (Literal)
VALUES     (@Question)
GO
/****** Object:  StoredProcedure [dbo].[AAA_SPCursorNewCrime2]    Script Date: 02/23/2011 16:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[AAA_SPCursorNewCrime2]
as
Begin

DECLARE  @lawO  int,
         @CNAME     nvarchar(4000),
		 @Cite     nvarchar(4000),
         @Level     nvarchar(4000),
		 @Att  nvarchar(4000),
		 @Age	   nvarchar(4000),
		 @Past     nvarchar(4000),
		 @Felony     nvarchar(4000),
		 @Pre    nvarchar(4000),
		 @Tran    nvarchar(4000),
		 @Sta    nvarchar(4000),
		 @Def    nvarchar(4000),
		 @Int    nvarchar(4000),
		 @Probation    nvarchar(4000),
		 @Con    nvarchar(4000),
		 @Split    nvarchar(4000),
		 @Fine    nvarchar(4000),
		 @Uncond    nvarchar(4000),
		 @Rest    nvarchar(4000),
		 @Sur    nvarchar(4000),
		 @Lic    nvarchar(4000),
		 @Sec    nvarchar(4000),
		 @End    nvarchar(4000),
		 @End2    nvarchar(4000),
		 @End3    nvarchar(4000),
		 @End4    nvarchar(4000),
		 @oldCrimeID int,
		 @newCrimeID int

Set @oldCrimeID=-1
-- declare the cursor

DECLARE CrimeANswer CURSOR FOR
SELECT     lawordinal, CrimeName, Cite, [Level], Attempt, Age, PastConvictions, FelonyLevel, Preface, Transition, StatePolice, DefSentence, Interm, Probation, 
                      Conditional, Split, Fine, Unconditional, Restitution, Surcharge, License, Consec, [End], End2, End3, End4,dbo.FN_GetCrimeIDfromLawOrdinal(lawordinal)
FROM         NewCrimeSpreadsheet2
Where lawordinal is not null
 
OPEN CrimeANswer
 

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@End,
@End2,
@End3,
@End4,
@newCrimeID

-- start the main processing loop.

WHILE @@Fetch_Status = 0

  BEGIN

If @oldCrimeID=-1
Set @oldCrimeID=@newcrimeID
Else
If @oldCrimeID!=@newCrimeID
Begin
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @oldCrimeID)
Set @oldCrimeID=@newCrimeID
End

Declare @Attempt bit
If @Att='Y'
Set @Attempt=1
Else 
Set @Attempt=0

Declare @AnswerID int
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, Attempted)
VALUES     (dbo.FN_GetCrimeIDfromLawOrdinal(@lawO), dbo.FN_GetAgeID(@Age),dbo.FN_GetFelonyLevel(@Felony),dbo.FN_GetPreviousCon(@Past),@Attempt)
Set @AnswerID =@@identity
Declare @P as int
Set @P=dbo.AAFN_GetPreID(@Pre)
Exec SP_addPrefacetoCrime @AnswerID, @P
Declare @T as int
Set @T=dbo.AAFN_GetTranID(@Tran)
Exec SP_AddTransitionToCrime @AnswerID,@T
Declare @S as int
Set @S=dbo.AAFN_GetStaID(@Sta)
Exec SP_AddStatePrisonToCrime @AnswerID,@S
Declare @D as int
Set @D=dbo.AAFN_GetDefID(@Def)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D
Declare @I as int
Set @I=dbo.AAFN_GetIntID(@Int)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I
Declare @Pro as int
Set @Pro=dbo.AAFN_GetProID(@Probation)
Exec SP_AddProbationToCrime @AnswerID,@Pro
Declare @Con1 as int
Set @Con1=dbo.AAFN_GetConID(@Con)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con1
Declare @Split1 as int
Set @Split1=dbo.AAFN_GetSplitID(@Split)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split1
Declare @F as int
Set @F=dbo.AAFN_GetFineID(@Fine)
Exec SP_addFinetoCrime @AnswerID,@F
Declare @U as int
Set @U=dbo.AAFN_GetUnconditionalDischargeID(@Uncond)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U
Declare @R as int
Set @R=dbo.AAFN_GetRestitutionReparationID(@Rest)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R
Declare @Sur1 as int
Set @Sur1=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur1
Declare @L as int
Set @L=dbo.AAFN_GetLicensePenaltiesID(@Lic)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L
Declare @Sec1 as int
Set @Sec1=dbo.AAFN_GetConsecutiveConcurrentID(@Sec)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec1
Declare @E as int
Set @E=dbo.AAFN_GetEndID(@End)
Exec SP_addEndtoCrime @AnswerID,@E
Declare @E2 as int
Set @E2=dbo.AAFN_GetEndID(@End2)
Exec SP_addEndtoCrime @AnswerID,@E2
Declare @E3 as int
Set @E3=dbo.AAFN_GetEndID(@End3)
Exec SP_addEndtoCrime @AnswerID,@E3
Declare @E4 as int
Set @E4=dbo.AAFN_GetEndID(@End4)
Exec SP_addEndtoCrime @AnswerID,@E4



   -- This is where you perform your detailed row-by-row

   -- processing.

   -- Get the next row.

   FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@End,
@End2,
@End3,
@End4,
@newCrimeID             

   END

CLOSE CrimeANswer

DEALLOCATE CrimeANswer
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @newCrimeID)
RETURN

End
GO
/****** Object:  StoredProcedure [dbo].[AAA_SPCursorNewCrime4]    Script Date: 02/23/2011 16:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[AAA_SPCursorNewCrime4]
as
Begin

DECLARE  @lawO  int,
         @CNAME     nvarchar(4000),
		 @Cite     nvarchar(4000),
         @Level     nvarchar(4000),
		 @Att  nvarchar(4000),
		 @Age	   nvarchar(4000),
		 @Past     nvarchar(4000),
		 @Felony     nvarchar(4000),
		 @Pre    nvarchar(4000),
		 @Tran    nvarchar(4000),
		 @Sta    nvarchar(4000),
		 @Def    nvarchar(4000),
		 @Int    nvarchar(4000),
		 @Probation    nvarchar(4000),
		 @Con    nvarchar(4000),
		 @Split    nvarchar(4000),
		 @Fine    nvarchar(4000),
		 @Uncond    nvarchar(4000),
		 @Rest    nvarchar(4000),
		 @Sur    nvarchar(4000),
		 @Lic    nvarchar(4000),
		 @Sec    nvarchar(4000),
		 @End    nvarchar(4000),
		 @End2    nvarchar(4000),
		 @End3    nvarchar(4000),
		 @End4    nvarchar(4000),
		 @oldCrimeID int,
		 @newCrimeID int

Set @oldCrimeID=-1
-- declare the cursor

DECLARE CrimeANswer CURSOR FOR
SELECT     lawordinal, CrimeName, Cite, [Level], Attempt, Age, PastConvictions, FelonyLevel, Preface, Transition, StatePolice, DefSentence, Interm, Probation,
                      Conditional, Split, Fine, Unconditional, Restitution, Surcharge, License, Consec, [End], End2, End3, End4,dbo.FN_GetCrimeIDfromLawOrdinal(lawordinal)
FROM         NewCrimeSpreadsheet4
Where lawordinal is not null
 
OPEN CrimeANswer
 

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@End,
@End2,
@End3,
@End4,
@newCrimeID

-- start the main processing loop.

WHILE @@Fetch_Status = 0

  BEGIN

If @oldCrimeID=-1
Set @oldCrimeID=@newcrimeID
Else
If @oldCrimeID!=@newCrimeID
Begin
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @oldCrimeID)
Set @oldCrimeID=@newCrimeID
End

Declare @Attempt bit
If @Att='Y'
Set @Attempt=1
Else 
Set @Attempt=0

Declare @AnswerID int
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, Attempted)
VALUES     (dbo.FN_GetCrimeIDfromLawOrdinal(@lawO), dbo.FN_GetAgeID(@Age),dbo.FN_GetFelonyLevel(@Felony),dbo.FN_GetPreviousCon(@Past),@Attempt)
Set @AnswerID =@@identity
Declare @P as int
Set @P=dbo.AAFN_GetPreID(@Pre)
Exec SP_addPrefacetoCrime @AnswerID, @P
Declare @T as int
Set @T=dbo.AAFN_GetTranID(@Tran)
Exec SP_AddTransitionToCrime @AnswerID,@T
Declare @S as int
Set @S=dbo.AAFN_GetStaID(@Sta)
Exec SP_AddStatePrisonToCrime @AnswerID,@S
Declare @D as int
Set @D=dbo.AAFN_GetDefID(@Def)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D
Declare @I as int
Set @I=dbo.AAFN_GetIntID(@Int)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I
Declare @Pro as int
Set @Pro=dbo.AAFN_GetProID(@Probation)
Exec SP_AddProbationToCrime @AnswerID,@Pro
Declare @Con1 as int
Set @Con1=dbo.AAFN_GetConID(@Con)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con1
Declare @Split1 as int
Set @Split1=dbo.AAFN_GetSplitID(@Split)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split1
Declare @F as int
Set @F=dbo.AAFN_GetFineID(@Fine)
Exec SP_addFinetoCrime @AnswerID,@F
Declare @U as int
Set @U=dbo.AAFN_GetUnconditionalDischargeID(@Uncond)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U
Declare @R as int
Set @R=dbo.AAFN_GetRestitutionReparationID(@Rest)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R
Declare @Sur1 as int
Set @Sur1=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur1
Declare @L as int
Set @L=dbo.AAFN_GetLicensePenaltiesID(@Lic)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L
Declare @Sec1 as int
Set @Sec1=dbo.AAFN_GetConsecutiveConcurrentID(@Sec)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec1
Declare @E as int
Set @E=dbo.AAFN_GetEndID(@End)
Exec SP_addEndtoCrime @AnswerID,@E
Declare @E2 as int
Set @E2=dbo.AAFN_GetEndID(@End2)
Exec SP_addEndtoCrime @AnswerID,@E2
Declare @E3 as int
Set @E3=dbo.AAFN_GetEndID(@End3)
Exec SP_addEndtoCrime @AnswerID,@E3
Declare @E4 as int
Set @E4=dbo.AAFN_GetEndID(@End4)
Exec SP_addEndtoCrime @AnswerID,@E4



   -- This is where you perform your detailed row-by-row

   -- processing.

   -- Get the next row.

   FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@End,
@End2,
@End3,
@End4,
@newCrimeID             

   END

CLOSE CrimeANswer

DEALLOCATE CrimeANswer
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @newCrimeID)
RETURN

End
GO
/****** Object:  StoredProcedure [dbo].[AAA_SPCursorOldCrimes]    Script Date: 02/23/2011 16:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[AAA_SPCursorOldCrimes]
as
Begin

DECLARE  @lawO  int,
         @CNAME     nvarchar(4000),
		 @Cite     nvarchar(4000),
         @Level     nvarchar(4000),
		 @Att  nvarchar(4000),
		 @Age	   nvarchar(4000),
		 @Past     nvarchar(4000),
		 @Felony     nvarchar(4000),
		 @Pre    nvarchar(4000),
		 @Pre2    nvarchar(4000),
		 @Tran    nvarchar(4000),
		 @Sta    nvarchar(4000),
		 @Sta2    nvarchar(4000),
		 @Def    nvarchar(4000),
		 @Def2    nvarchar(4000),
		 @Int    nvarchar(4000),
		 @Int2    nvarchar(4000),
		 @Probation    nvarchar(4000),
		 @Probation2    nvarchar(4000),
		 @Con    nvarchar(4000),
		 @Con2    nvarchar(4000),
		 @Split    nvarchar(4000),
		 @Split2    nvarchar(4000),
		 @Fine    nvarchar(4000),
		 @Fine2    nvarchar(4000),
		 @Uncond    nvarchar(4000),
		 @Uncond2    nvarchar(4000),
		 @Rest    nvarchar(4000),
		 @Rest2    nvarchar(4000),
		 @Sur    nvarchar(4000),
		 @Sur2    nvarchar(4000),
		 @Lic    nvarchar(4000),
		 @Lic2    nvarchar(4000),
		 @Sec    nvarchar(4000),
		 @Sec2    nvarchar(4000),
		 @End    nvarchar(4000),
		 @End2    nvarchar(4000),
		 @End3    nvarchar(4000),
		 @End4    nvarchar(4000),
		 @oldCrimeID int,
		 @newCrimeID int

Set @oldCrimeID=-1
-- declare the cursor
DECLARE CrimeANswer CURSOR FOR
SELECT     lawordinal, CrimeName, Cite, [Level], Attempt, Age, PastConvictions, FelonyLevel, Preface,Preface2, Transition, StatePolice,StatePolice2, DefSentence, DefSentence2, Interm, Interm2,  Probation, Probation2, 
                      Conditional, Conditional2,  Split, Split2, Fine, Fine2, 
                      Unconditional, Unconditional2,  Restitution, Restitution2,  Surcharge, Surcharge2,  License, License2,  Consec, Consec2, [End], End2, End3, End4, 
                      dbo.FN_GetCrimeIDfromLawOrdinal(lawordinal)
FROM         KaylaSpreadsheet
WHERE     (UseThis = N'Y')
and lawordinal is not null

OPEN CrimeANswer
 

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Pre2,
@Tran,
@Sta,
@Sta2,
@Def,
@Def2,
@Int,
@Int2,
@Probation,
@Probation2,
@Con,
@Con2,
@Split,
@Split2,
@Fine,
@Fine2,
@Uncond,
@Uncond2,
@Rest,
@Rest2,
@Sur,
@Sur2,
@Lic,
@Lic2,
@Sec,
@Sec2,
@End,
@End2,
@End3,
@End4,
@newCrimeID

-- start the main processing loop.

WHILE @@Fetch_Status = 0

  BEGIN

If @oldCrimeID=-1
Set @oldCrimeID=@newcrimeID
Else
If @oldCrimeID!=@newCrimeID
Begin
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @oldCrimeID)
Set @oldCrimeID=@newCrimeID
End

Declare @Attempt bit
If @Att='Y'
Set @Attempt=1
Else 
Set @Attempt=0

Declare @AnswerID int
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, Attempted)
VALUES     (dbo.FN_GetCrimeIDfromLawOrdinal(@lawO), dbo.FN_GetAgeID(@Age),dbo.FN_GetFelonyLevel(@Felony),dbo.FN_GetPreviousCon(@Past),@Attempt)
Set @AnswerID =@@identity
Declare @P as int
Set @P=dbo.AAFN_GetPreID(@Pre)
Exec SP_addPrefacetoCrime @AnswerID, @P
Declare @P2 as int
Set @P2=dbo.AAFN_GetPreID(@Pre2)
Exec SP_addPrefacetoCrime @AnswerID, @P2
Declare @T as int
Set @T=dbo.AAFN_GetTranID(@Tran)
Exec SP_AddTransitionToCrime @AnswerID,@T
Declare @S as int
Set @S=dbo.AAFN_GetStaID(@Sta)
Exec SP_AddStatePrisonToCrime @AnswerID,@S
Declare @S2 as int
Set @S2=dbo.AAFN_GetStaID(@Sta2)
Exec SP_AddStatePrisonToCrime @AnswerID,@S2
Declare @D as int
Set @D=dbo.AAFN_GetDefID(@Def)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D
Declare @D2 as int
Set @D2=dbo.AAFN_GetDefID(@Def2)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D2
Declare @I as int
Set @I=dbo.AAFN_GetIntID(@Int)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I
Declare @I2 as int
Set @I2=dbo.AAFN_GetIntID(@Int2)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I2
Declare @Pro as int
Set @Pro=dbo.AAFN_GetProID(@Probation)
Exec SP_AddProbationToCrime @AnswerID,@Pro
Declare @Pro2 as int
Set @Pro2=dbo.AAFN_GetProID(@Probation2)
Exec SP_AddProbationToCrime @AnswerID,@Pro2
Declare @Con1 as int
Set @Con1=dbo.AAFN_GetConID(@Con)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con1
Declare @Con12 as int
Set @Con12=dbo.AAFN_GetConID(@Con2)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con12
Declare @Split1 as int
Set @Split1=dbo.AAFN_GetSplitID(@Split)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split1
Declare @Split12 as int
Set @Split12=dbo.AAFN_GetSplitID(@Split2)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split12
Declare @F as int
Set @F=dbo.AAFN_GetFineID(@Fine)
Exec SP_addFinetoCrime @AnswerID,@F
Declare @F2 as int
Set @F2=dbo.AAFN_GetFineID(@Fine2)
Exec SP_addFinetoCrime @AnswerID,@F2
Declare @U as int
Set @U=dbo.AAFN_GetUnconditionalDischargeID(@Uncond)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U
Declare @U2 as int
Set @U2=dbo.AAFN_GetUnconditionalDischargeID(@Uncond2)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U2
Declare @R as int
Set @R=dbo.AAFN_GetRestitutionReparationID(@Rest)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R
Declare @R2 as int
Set @R2=dbo.AAFN_GetRestitutionReparationID(@Rest2)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R2
Declare @Sur1 as int
Set @Sur1=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur1
Declare @Sur12 as int
Set @Sur12=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur2)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur12
Declare @L as int
Set @L=dbo.AAFN_GetLicensePenaltiesID(@Lic)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L
Declare @L2 as int
Set @L2=dbo.AAFN_GetLicensePenaltiesID(@Lic2)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L2
Declare @Sec1 as int
Set @Sec1=dbo.AAFN_GetConsecutiveConcurrentID(@Sec)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec1
Declare @Sec12 as int
Set @Sec12=dbo.AAFN_GetConsecutiveConcurrentID(@Sec2)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec12
Declare @E as int
Set @E=dbo.AAFN_GetEndID(@End)
Exec SP_addEndtoCrime @AnswerID,@E
Declare @E2 as int
Set @E2=dbo.AAFN_GetEndID(@End2)
Exec SP_addEndtoCrime @AnswerID,@E2
Declare @E3 as int
Set @E3=dbo.AAFN_GetEndID(@End3)
Exec SP_addEndtoCrime @AnswerID,@E3
Declare @E4 as int
Set @E4=dbo.AAFN_GetEndID(@End4)
Exec SP_addEndtoCrime @AnswerID,@E4



   -- This is where you perform your detailed row-by-row

   -- processing.

   -- Get the next row.

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Pre2,
@Tran,
@Sta,
@Sta2,
@Def,
@Def2,
@Int,
@Int2,
@Probation,
@Probation2,
@Con,
@Con2,
@Split,
@Split2,
@Fine,
@Fine2,
@Uncond,
@Uncond2,
@Rest,
@Rest2,
@Sur,
@Sur2,
@Lic,
@Lic2,
@Sec,
@Sec2,
@End,
@End2,
@End3,
@End4,
@newCrimeID         

   END

CLOSE CrimeANswer

DEALLOCATE CrimeANswer
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @newCrimeID)
RETURN

End
GO
/****** Object:  StoredProcedure [dbo].[AAA_SPCursorOldCrimesNewTable]    Script Date: 02/23/2011 16:39:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[AAA_SPCursorOldCrimesNewTable]
as
Begin

DECLARE  @lawO  int,
         @CNAME     nvarchar(4000),
		 @Cite     nvarchar(4000),
         @Level     nvarchar(4000),
		 @Att  nvarchar(4000),
		 @Age	   nvarchar(4000),
		 @Past     nvarchar(4000),
		 @Felony     nvarchar(4000),
		 @Pre    nvarchar(4000),
		 @Pre2    nvarchar(4000),
		 @Tran    nvarchar(4000),
		 @Sta    nvarchar(4000),
		 @Sta2    nvarchar(4000),
		 @Def    nvarchar(4000),
		 @Def2    nvarchar(4000),
		 @Int    nvarchar(4000),
		 @Int2    nvarchar(4000),
		 @Probation    nvarchar(4000),
		 @Probation2    nvarchar(4000),
		 @Con    nvarchar(4000),
		 @Con2    nvarchar(4000),
		 @Split    nvarchar(4000),
		 @Split2    nvarchar(4000),
		 @Fine    nvarchar(4000),
		 @Fine2    nvarchar(4000),
		 @Uncond    nvarchar(4000),
		 @Uncond2    nvarchar(4000),
		 @Rest    nvarchar(4000),
		 @Rest2    nvarchar(4000),
		 @Sur    nvarchar(4000),
		 @Sur2    nvarchar(4000),
		 @Lic    nvarchar(4000),
		 @Lic2    nvarchar(4000),
		 @Sec    nvarchar(4000),
		 @Sec2    nvarchar(4000),
		 @End    nvarchar(4000),
		 @End2    nvarchar(4000),
		 @End3    nvarchar(4000),
		 @End4    nvarchar(4000),
		 @oldCrimeID int,
		 @newCrimeID int

Set @oldCrimeID=-1
-- declare the cursor
DECLARE CrimeANswer CURSOR FOR
SELECT     lawordinal, CrimeName, Cite, [Level], Attempt, Age, PastConvictions, FelonyLevel, Preface,Preface2, Transition, StatePolice,StatePolice2, DefSentence, DefSentence2, Interm, Interm2,  Probation, Probation2, 
                      Conditional, Conditional2,  Split, Split2, Fine, Fine2, 
                      Unconditional, Unconditional2,  Restitution, Restitution2,  Surcharge, Surcharge2,  License, License2,  Consec, Consec2, [End], End2, End3, End4, 
                      dbo.FN_GetCrimeIDfromLawOrdinal(lawordinal)
FROM         OldCrimesManualSpreadsheet
WHERE     (UseThis = N'Y')
and lawordinal is not null

OPEN CrimeANswer
 

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Pre2,
@Tran,
@Sta,
@Sta2,
@Def,
@Def2,
@Int,
@Int2,
@Probation,
@Probation2,
@Con,
@Con2,
@Split,
@Split2,
@Fine,
@Fine2,
@Uncond,
@Uncond2,
@Rest,
@Rest2,
@Sur,
@Sur2,
@Lic,
@Lic2,
@Sec,
@Sec2,
@End,
@End2,
@End3,
@End4,
@newCrimeID

-- start the main processing loop.

WHILE @@Fetch_Status = 0

  BEGIN

If @oldCrimeID=-1
Set @oldCrimeID=@newcrimeID
Else
If @oldCrimeID!=@newCrimeID
Begin
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @oldCrimeID)
Set @oldCrimeID=@newCrimeID
End

Declare @Attempt bit
If @Att='Y'
Set @Attempt=1
Else 
Set @Attempt=0

Declare @AnswerID int
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, Attempted)
VALUES     (dbo.FN_GetCrimeIDfromLawOrdinal(@lawO), dbo.FN_GetAgeID(@Age),dbo.FN_GetFelonyLevel(@Felony),dbo.FN_GetPreviousCon(@Past),@Attempt)
Set @AnswerID =@@identity
Declare @P as int
Set @P=dbo.AAFN_GetPreID(@Pre)
Exec SP_addPrefacetoCrime @AnswerID, @P
Declare @P2 as int
Set @P2=dbo.AAFN_GetPreID(@Pre2)
Exec SP_addPrefacetoCrime @AnswerID, @P2
Declare @T as int
Set @T=dbo.AAFN_GetTranID(@Tran)
Exec SP_AddTransitionToCrime @AnswerID,@T
Declare @S as int
Set @S=dbo.AAFN_GetStaID(@Sta)
Exec SP_AddStatePrisonToCrime @AnswerID,@S
Declare @S2 as int
Set @S2=dbo.AAFN_GetStaID(@Sta2)
Exec SP_AddStatePrisonToCrime @AnswerID,@S2
Declare @D as int
Set @D=dbo.AAFN_GetDefID(@Def)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D
Declare @D2 as int
Set @D2=dbo.AAFN_GetDefID(@Def2)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D2
Declare @I as int
Set @I=dbo.AAFN_GetIntID(@Int)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I
Declare @I2 as int
Set @I2=dbo.AAFN_GetIntID(@Int2)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I2
Declare @Pro as int
Set @Pro=dbo.AAFN_GetProID(@Probation)
Exec SP_AddProbationToCrime @AnswerID,@Pro
Declare @Pro2 as int
Set @Pro2=dbo.AAFN_GetProID(@Probation2)
Exec SP_AddProbationToCrime @AnswerID,@Pro2
Declare @Con1 as int
Set @Con1=dbo.AAFN_GetConID(@Con)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con1
Declare @Con12 as int
Set @Con12=dbo.AAFN_GetConID(@Con2)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con12
Declare @Split1 as int
Set @Split1=dbo.AAFN_GetSplitID(@Split)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split1
Declare @Split12 as int
Set @Split12=dbo.AAFN_GetSplitID(@Split2)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split12
Declare @F as int
Set @F=dbo.AAFN_GetFineID(@Fine)
Exec SP_addFinetoCrime @AnswerID,@F
Declare @F2 as int
Set @F2=dbo.AAFN_GetFineID(@Fine2)
Exec SP_addFinetoCrime @AnswerID,@F2
Declare @U as int
Set @U=dbo.AAFN_GetUnconditionalDischargeID(@Uncond)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U
Declare @U2 as int
Set @U2=dbo.AAFN_GetUnconditionalDischargeID(@Uncond2)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U2
Declare @R as int
Set @R=dbo.AAFN_GetRestitutionReparationID(@Rest)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R
Declare @R2 as int
Set @R2=dbo.AAFN_GetRestitutionReparationID(@Rest2)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R2
Declare @Sur1 as int
Set @Sur1=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur1
Declare @Sur12 as int
Set @Sur12=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur2)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur12
Declare @L as int
Set @L=dbo.AAFN_GetLicensePenaltiesID(@Lic)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L
Declare @L2 as int
Set @L2=dbo.AAFN_GetLicensePenaltiesID(@Lic2)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L2
Declare @Sec1 as int
Set @Sec1=dbo.AAFN_GetConsecutiveConcurrentID(@Sec)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec1
Declare @Sec12 as int
Set @Sec12=dbo.AAFN_GetConsecutiveConcurrentID(@Sec2)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec12
Declare @E as int
Set @E=dbo.AAFN_GetEndID(@End)
Exec SP_addEndtoCrime @AnswerID,@E
Declare @E2 as int
Set @E2=dbo.AAFN_GetEndID(@End2)
Exec SP_addEndtoCrime @AnswerID,@E2
Declare @E3 as int
Set @E3=dbo.AAFN_GetEndID(@End3)
Exec SP_addEndtoCrime @AnswerID,@E3
Declare @E4 as int
Set @E4=dbo.AAFN_GetEndID(@End4)
Exec SP_addEndtoCrime @AnswerID,@E4



   -- This is where you perform your detailed row-by-row

   -- processing.

   -- Get the next row.

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Pre2,
@Tran,
@Sta,
@Sta2,
@Def,
@Def2,
@Int,
@Int2,
@Probation,
@Probation2,
@Con,
@Con2,
@Split,
@Split2,
@Fine,
@Fine2,
@Uncond,
@Uncond2,
@Rest,
@Rest2,
@Sur,
@Sur2,
@Lic,
@Lic2,
@Sec,
@Sec2,
@End,
@End2,
@End3,
@End4,
@newCrimeID         

   END

CLOSE CrimeANswer

DEALLOCATE CrimeANswer
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @newCrimeID)
RETURN

End


DELETE FROM [CrimeTime].[dbo].[OldCrimesManualSpreadsheet]
      WHERE Cite is null
GO
/****** Object:  StoredProcedure [dbo].[AAA_SPCursorNew130Crimes]    Script Date: 02/23/2011 16:39:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[AAA_SPCursorNew130Crimes]
as
Begin

DECLARE  @lawO  int,
         @CNAME     nvarchar(4000),
		 @Cite     nvarchar(4000),
         @Level     nvarchar(4000),
		 @Att  nvarchar(4000),
		 @Age	   nvarchar(4000),
		 @Past     nvarchar(4000),
		 @Felony     nvarchar(4000),
		 @Pre    nvarchar(4000),
		 @Pre2    nvarchar(4000),
		 @Tran    nvarchar(4000),
		 @Sta    nvarchar(4000),
		 @Def    nvarchar(4000),
		 @Int    nvarchar(4000),
		 @Probation    nvarchar(4000),
		 @Probation2    nvarchar(4000),
		 @Con    nvarchar(4000),
		 @Split    nvarchar(4000),
		 @Fine    nvarchar(4000),
		 @Uncond    nvarchar(4000),
		 @Rest    nvarchar(4000),
		 @Sur    nvarchar(4000),
		 @Lic    nvarchar(4000),
		 @Sec    nvarchar(4000),
		 @Sec2    nvarchar(4000),
		 @Sec3    nvarchar(4000),
		 @End    nvarchar(4000),
		 @End2    nvarchar(4000),
		 @End3    nvarchar(4000),
		 @End4    nvarchar(4000),
		 @End5    nvarchar(4000),
		 @End6    nvarchar(4000),
		 @End7    nvarchar(4000),
		 @End8    nvarchar(4000),
		 @End9    nvarchar(4000),
		 @oldCrimeID int,
		 @newCrimeID int

Set @oldCrimeID=-1
-- declare the cursor
DECLARE CrimeANswer CURSOR FOR
SELECT     lawordinal, CrimeName, Cite, [Level], Attempt, Age, PastConvictions, FelonyLevel, Preface,Preface2, Transition, StatePolice,DefSentence, Interm, Probation,Probation2, 
                      Conditional, Split, Fine, 
                      Unconditional,  Restitution, Surcharge, License, Consec, Consec2, Consec3, [End], End2, End3, End4, End5, End6, End7, End8, End9, 
                      dbo.FN_GetCrimeIDfromLawOrdinal(lawordinal)
FROM         NewCrime130sSpreadsheet
WHERE     lawordinal is not null

OPEN CrimeANswer
 

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Pre2,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Probation2,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@Sec2,
@Sec3,
@End,
@End2,
@End3,
@End4,
@End5,
@End6,
@End7,
@End8,
@End9,
@newCrimeID


-- start the main processing loop.

WHILE @@Fetch_Status = 0

  BEGIN

If @oldCrimeID=-1
Set @oldCrimeID=@newcrimeID
Else
If @oldCrimeID!=@newCrimeID
Begin
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @oldCrimeID)
Set @oldCrimeID=@newCrimeID
End

Declare @Attempt bit
If @Att='Y'
Set @Attempt=1
Else 
Set @Attempt=0

Declare @AnswerID int
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, Attempted)
VALUES     (dbo.FN_GetCrimeIDfromLawOrdinal(@lawO), dbo.FN_GetAgeID(@Age),dbo.FN_GetFelonyLevel(@Felony),dbo.FN_GetPreviousCon(@Past),@Attempt)
Set @AnswerID =@@identity
Declare @P as int
Set @P=dbo.AAFN_GetPreID(@Pre)
Exec SP_addPrefacetoCrime @AnswerID, @P
Declare @P2 as int
Set @P2=dbo.AAFN_GetPreID(@Pre2)
Exec SP_addPrefacetoCrime @AnswerID, @P2
Declare @T as int
Set @T=dbo.AAFN_GetTranID(@Tran)
Exec SP_AddTransitionToCrime @AnswerID,@T
Declare @S as int
Set @S=dbo.AAFN_GetStaID(@Sta)
Exec SP_AddStatePrisonToCrime @AnswerID,@S
Declare @D as int
Set @D=dbo.AAFN_GetDefID(@Def)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D
Declare @I as int
Set @I=dbo.AAFN_GetIntID(@Int)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I
Declare @Pro as int
Set @Pro=dbo.AAFN_GetProID(@Probation)
Exec SP_AddProbationToCrime @AnswerID,@Pro
Declare @Pro2 as int
Set @Pro2=dbo.AAFN_GetProID(@Probation2)
Exec SP_AddProbationToCrime @AnswerID,@Pro2
Declare @Con1 as int
Set @Con1=dbo.AAFN_GetConID(@Con)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con1
Declare @Split1 as int
Set @Split1=dbo.AAFN_GetSplitID(@Split)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split1
Declare @F as int
Set @F=dbo.AAFN_GetFineID(@Fine)
Exec SP_addFinetoCrime @AnswerID,@F
Declare @U as int
Set @U=dbo.AAFN_GetUnconditionalDischargeID(@Uncond)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U
Declare @R as int
Set @R=dbo.AAFN_GetRestitutionReparationID(@Rest)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R
Declare @Sur1 as int
Set @Sur1=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur1
Declare @L as int
Set @L=dbo.AAFN_GetLicensePenaltiesID(@Lic)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L
Declare @Sec1 as int
Set @Sec1=dbo.AAFN_GetConsecutiveConcurrentID(@Sec)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec1
Declare @Sec12 as int
Set @Sec12=dbo.AAFN_GetConsecutiveConcurrentID(@Sec2)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec12
Declare @Sec13 as int
Set @Sec13=dbo.AAFN_GetConsecutiveConcurrentID(@Sec3)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec13
Declare @E as int
Set @E=dbo.AAFN_GetEndID(@End)
Exec SP_addEndtoCrime @AnswerID,@E
Declare @E2 as int
Set @E2=dbo.AAFN_GetEndID(@End2)
Exec SP_addEndtoCrime @AnswerID,@E2
Declare @E3 as int
Set @E3=dbo.AAFN_GetEndID(@End3)
Exec SP_addEndtoCrime @AnswerID,@E3
Declare @E4 as int
Set @E4=dbo.AAFN_GetEndID(@End4)
Exec SP_addEndtoCrime @AnswerID,@E4
Declare @E5 as int
Set @E5=dbo.AAFN_GetEndID(@End5)
Exec SP_addEndtoCrime @AnswerID,@E5
Declare @E6 as int
Set @E6=dbo.AAFN_GetEndID(@End6)
Exec SP_addEndtoCrime @AnswerID,@E6
Declare @E7 as int
Set @E7=dbo.AAFN_GetEndID(@End7)
Exec SP_addEndtoCrime @AnswerID,@E7
Declare @E8 as int
Set @E8=dbo.AAFN_GetEndID(@End8)
Exec SP_addEndtoCrime @AnswerID,@E8
Declare @E9 as int
Set @E9=dbo.AAFN_GetEndID(@End9)
Exec SP_addEndtoCrime @AnswerID,@E9

   -- This is where you perform your detailed row-by-row

   -- processing.

   -- Get the next row.

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Pre2,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Probation2,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@Sec2,
@Sec3,
@End,
@End2,
@End3,
@End4,
@End5,
@End6,
@End7,
@End8,
@End9,
@newCrimeID
        

   END

CLOSE CrimeANswer

DEALLOCATE CrimeANswer
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @newCrimeID)
RETURN

End
GO
/****** Object:  StoredProcedure [dbo].[AAA_SPCursorNewCrime]    Script Date: 02/23/2011 16:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[AAA_SPCursorNewCrime]
as
Begin

DECLARE  @lawO  int,
         @CNAME     nvarchar(4000),
		 @Cite     nvarchar(4000),
         @Level     nvarchar(4000),
		 @Att  nvarchar(4000),
		 @Age	   nvarchar(4000),
		 @Past     nvarchar(4000),
		 @Felony     nvarchar(4000),
		 @Pre    nvarchar(4000),
		 @Tran    nvarchar(4000),
		 @Sta    nvarchar(4000),
		 @Def    nvarchar(4000),
		 @Int    nvarchar(4000),
		 @Probation    nvarchar(4000),
		 @Con    nvarchar(4000),
		 @Split    nvarchar(4000),
		 @Fine    nvarchar(4000),
		 @Uncond    nvarchar(4000),
		 @Rest    nvarchar(4000),
		 @Sur    nvarchar(4000),
		 @Lic    nvarchar(4000),
		 @Sec    nvarchar(4000),
		 @End    nvarchar(4000),
		 @End2    nvarchar(4000),
		 @End3    nvarchar(4000),
		 @End4    nvarchar(4000),
		 @oldCrimeID int,
		 @newCrimeID int

Set @oldCrimeID=-1
-- declare the cursor

DECLARE CrimeANswer CURSOR FOR
SELECT     lawordinal, CrimeName, Cite, [Level], Attempt, Age, PastConvictions, FelonyLevel, Preface, Transition, StatePolice, DefSentence, Interm, Probation, 
                      Conditional, Split, Fine, Unconditional, Restitution, Surcharge, License, Consec, [End], End2, End3, End4,dbo.FN_GetCrimeIDfromLawOrdinal(lawordinal)
FROM         NewCrimeSpreadsheet
Where lawordinal is not null
 
OPEN CrimeANswer
 

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@End,
@End2,
@End3,
@End4,
@newCrimeID

-- start the main processing loop.

WHILE @@Fetch_Status = 0

  BEGIN

If @oldCrimeID=-1
Set @oldCrimeID=@newcrimeID
Else
If @oldCrimeID!=@newCrimeID
Begin
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @oldCrimeID)
Set @oldCrimeID=@newCrimeID
End

Declare @Attempt bit
If @Att='Y'
Set @Attempt=1
Else 
Set @Attempt=0

Declare @AnswerID int
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, Attempted)
VALUES     (dbo.FN_GetCrimeIDfromLawOrdinal(@lawO), dbo.FN_GetAgeID(@Age),dbo.FN_GetFelonyLevel(@Felony),dbo.FN_GetPreviousCon(@Past),@Attempt)
Set @AnswerID =@@identity
Declare @P as int
Set @P=dbo.AAFN_GetPreID(@Pre)
Exec SP_addPrefacetoCrime @AnswerID, @P
Declare @T as int
Set @T=dbo.AAFN_GetTranID(@Tran)
Exec SP_AddTransitionToCrime @AnswerID,@T
Declare @S as int
Set @S=dbo.AAFN_GetStaID(@Sta)
Exec SP_AddStatePrisonToCrime @AnswerID,@S
Declare @D as int
Set @D=dbo.AAFN_GetDefID(@Def)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D
Declare @I as int
Set @I=dbo.AAFN_GetIntID(@Int)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I
Declare @Pro as int
Set @Pro=dbo.AAFN_GetProID(@Probation)
Exec SP_AddProbationToCrime @AnswerID,@Pro
Declare @Con1 as int
Set @Con1=dbo.AAFN_GetConID(@Con)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con1
Declare @Split1 as int
Set @Split1=dbo.AAFN_GetSplitID(@Split)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split1
Declare @F as int
Set @F=dbo.AAFN_GetFineID(@Fine)
Exec SP_addFinetoCrime @AnswerID,@F
Declare @U as int
Set @U=dbo.AAFN_GetUnconditionalDischargeID(@Uncond)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U
Declare @R as int
Set @R=dbo.AAFN_GetRestitutionReparationID(@Rest)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R
Declare @Sur1 as int
Set @Sur1=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur1
Declare @L as int
Set @L=dbo.AAFN_GetLicensePenaltiesID(@Lic)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L
Declare @Sec1 as int
Set @Sec1=dbo.AAFN_GetConsecutiveConcurrentID(@Sec)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec1
Declare @E as int
Set @E=dbo.AAFN_GetEndID(@End)
Exec SP_addEndtoCrime @AnswerID,@E
Declare @E2 as int
Set @E2=dbo.AAFN_GetEndID(@End2)
Exec SP_addEndtoCrime @AnswerID,@E2
Declare @E3 as int
Set @E3=dbo.AAFN_GetEndID(@End3)
Exec SP_addEndtoCrime @AnswerID,@E3
Declare @E4 as int
Set @E4=dbo.AAFN_GetEndID(@End4)
Exec SP_addEndtoCrime @AnswerID,@E4



   -- This is where you perform your detailed row-by-row

   -- processing.

   -- Get the next row.

   FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@End,
@End2,
@End3,
@End4,
@newCrimeID             

   END

CLOSE CrimeANswer

DEALLOCATE CrimeANswer
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @newCrimeID)
RETURN

End
GO
/****** Object:  StoredProcedure [dbo].[AAA_SPCursorNewCrime3]    Script Date: 02/23/2011 16:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[AAA_SPCursorNewCrime3]
as
Begin

DECLARE  @lawO  int,
         @CNAME     nvarchar(4000),
		 @Cite     nvarchar(4000),
         @Level     nvarchar(4000),
		 @Att  nvarchar(4000),
		 @Age	   nvarchar(4000),
		 @Past     nvarchar(4000),
		 @Felony     nvarchar(4000),
		 @Pre    nvarchar(4000),
		 @Tran    nvarchar(4000),
		 @Sta    nvarchar(4000),
		 @Def    nvarchar(4000),
		 @Int    nvarchar(4000),
		 @Probation    nvarchar(4000),
		 @Probation2    nvarchar(4000),
		 @Con    nvarchar(4000),
		 @Split    nvarchar(4000),
		 @Fine    nvarchar(4000),
		 @Uncond    nvarchar(4000),
		 @Rest    nvarchar(4000),
		 @Sur    nvarchar(4000),
		 @Lic    nvarchar(4000),
		 @Sec    nvarchar(4000),
		 @End    nvarchar(4000),
		 @End2    nvarchar(4000),
		 @End3    nvarchar(4000),
		 @End4    nvarchar(4000),
		 @oldCrimeID int,
		 @newCrimeID int

Set @oldCrimeID=-1
-- declare the cursor

DECLARE CrimeANswer CURSOR FOR
SELECT     lawordinal, CrimeName, Cite, [Level], Attempt, Age, PastConvictions, FelonyLevel, Preface, Transition, StatePolice, DefSentence, Interm, Probation, Probation2,
                      Conditional, Split, Fine, Unconditional, Restitution, Surcharge, License, Consec, [End], End2, End3, End4,dbo.FN_GetCrimeIDfromLawOrdinal(lawordinal)
FROM         NewCrimeSpreadsheet3
Where lawordinal is not null
 
OPEN CrimeANswer
 

FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Probation2,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@End,
@End2,
@End3,
@End4,
@newCrimeID

-- start the main processing loop.

WHILE @@Fetch_Status = 0

  BEGIN

If @oldCrimeID=-1
Set @oldCrimeID=@newcrimeID
Else
If @oldCrimeID!=@newCrimeID
Begin
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @oldCrimeID)
Set @oldCrimeID=@newCrimeID
End

Declare @Attempt bit
If @Att='Y'
Set @Attempt=1
Else 
Set @Attempt=0

Declare @AnswerID int
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, FelonyConvictions, PastConvictions, Attempted)
VALUES     (dbo.FN_GetCrimeIDfromLawOrdinal(@lawO), dbo.FN_GetAgeID(@Age),dbo.FN_GetFelonyLevel(@Felony),dbo.FN_GetPreviousCon(@Past),@Attempt)
Set @AnswerID =@@identity
Declare @P as int
Set @P=dbo.AAFN_GetPreID(@Pre)
Exec SP_addPrefacetoCrime @AnswerID, @P
Declare @T as int
Set @T=dbo.AAFN_GetTranID(@Tran)
Exec SP_AddTransitionToCrime @AnswerID,@T
Declare @S as int
Set @S=dbo.AAFN_GetStaID(@Sta)
Exec SP_AddStatePrisonToCrime @AnswerID,@S
Declare @D as int
Set @D=dbo.AAFN_GetDefID(@Def)
Exec SP_AddDefiniteSentenceToCrime @AnswerID,@D
Declare @I as int
Set @I=dbo.AAFN_GetIntID(@Int)
Exec SP_AddIntermittentImprisonmentToCrime @AnswerID,@I
Declare @Pro as int
Set @Pro=dbo.AAFN_GetProID(@Probation)
Exec SP_AddProbationToCrime @AnswerID,@Pro
Declare @Pro2 as int
Set @Pro2=dbo.AAFN_GetProID(@Probation2)
Exec SP_AddProbationToCrime @AnswerID,@Pro2
Declare @Con1 as int
Set @Con1=dbo.AAFN_GetConID(@Con)
Exec SP_AddConditionalDischargeToCrime @AnswerID,@Con1
Declare @Split1 as int
Set @Split1=dbo.AAFN_GetSplitID(@Split)
Exec SP_AddSplitSentenceToCrime @AnswerID,@Split1
Declare @F as int
Set @F=dbo.AAFN_GetFineID(@Fine)
Exec SP_addFinetoCrime @AnswerID,@F
Declare @U as int
Set @U=dbo.AAFN_GetUnconditionalDischargeID(@Uncond)
Exec SP_AddUnconditionalDischargeToCrime @AnswerID,@U
Declare @R as int
Set @R=dbo.AAFN_GetRestitutionReparationID(@Rest)
Exec SP_AddRestitutionReparationToCrime @AnswerID,@R
Declare @Sur1 as int
Set @Sur1=dbo.AAFN_GetSurchargeVictimAssessmentFeeID(@Sur)
Exec SP_AddSurchargeVictimAssessmentFeeToCrime @AnswerID,@Sur1
Declare @L as int
Set @L=dbo.AAFN_GetLicensePenaltiesID(@Lic)
Exec SP_AddLiscensePenaltiesToCrime @AnswerID,@L
Declare @Sec1 as int
Set @Sec1=dbo.AAFN_GetConsecutiveConcurrentID(@Sec)
Exec SP_AddConsecutiveConcurrentToCrime @AnswerID,@Sec1
Declare @E as int
Set @E=dbo.AAFN_GetEndID(@End)
Exec SP_addEndtoCrime @AnswerID,@E
Declare @E2 as int
Set @E2=dbo.AAFN_GetEndID(@End2)
Exec SP_addEndtoCrime @AnswerID,@E2
Declare @E3 as int
Set @E3=dbo.AAFN_GetEndID(@End3)
Exec SP_addEndtoCrime @AnswerID,@E3
Declare @E4 as int
Set @E4=dbo.AAFN_GetEndID(@End4)
Exec SP_addEndtoCrime @AnswerID,@E4



   -- This is where you perform your detailed row-by-row

   -- processing.

   -- Get the next row.

   FETCH CrimeANswer INTO @lawO,
@CNAME,
@Cite,
@Level,
@Att,
@Age,
@Past,
@Felony,
@Pre,
@Tran,
@Sta,
@Def,
@Int,
@Probation,
@Probation2,
@Con,
@Split,
@Fine,
@Uncond,
@Rest,
@Sur,
@Lic,
@Sec,
@End,
@End2,
@End3,
@End4,
@newCrimeID             

   END

CLOSE CrimeANswer

DEALLOCATE CrimeANswer
UPDATE    tblCrimes
SET              Viewable = 1
WHERE     (CrimesID = @newCrimeID)
RETURN

End
GO
/****** Object:  StoredProcedure [dbo].[SP_GET220CRIMESTUFF]    Script Date: 02/23/2011 16:39:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GET220CRIMESTUFF]
AS
SELECT     tblCrimes.full_law_description, 
tblCrimes.title, 
tblCrimes.section, 
tblCrimes.subsection, 
tblCrimes.Viewable, 
tblCrimes.class, 
tblCrimes.nys_law_category, 
tblCrimeAnswer.CrimeAnswerID, 
dbo.FN_GetAgeCatLiteral(tblCrimeAnswer.AgeCategory) as AgeCategory, 
dbo.FN_GetFelonyCatLiteral(tblCrimeAnswer.FelonyConvictions) as FelonyConvictions, 
dbo.FN_GetPastCOnvLiteral(tblCrimeAnswer.PastConvictions) as PastConvictions, 
dbo.FN_GetTrueFalse(tblCrimeAnswer.Attempted) as Attempted
,dbo.FN_GetCrimeANswerPreface(CrimeAnswerID) as 'Preface'
,dbo.FN_GetCrimeANswerTransition(CrimeAnswerID) as 'Transition'
,dbo.FN_GetCrimeANswerStatePrison(CrimeAnswerID) as 'StatePrison'
,dbo.FN_GetCrimeANswerDEFINITESENTENCE(CrimeAnswerID) as 'DefSent'
,dbo.FN_GetCrimeANswerIntermittentImprisonment(CrimeAnswerID) as 'INT'
,dbo.FN_GetCrimeANswerPROBATION(CrimeAnswerID) as 'Probation'
,dbo.FN_GetCrimeANswerCONDITIONALDISCHARGE(CrimeAnswerID) as 'CondDisch'
,dbo.FN_GetCrimeANswerSplitSentence(CrimeAnswerID) as 'Split'
,dbo.FN_GetCrimeANswerFine(CrimeAnswerID) as 'Fine'
,dbo.FN_GetCrimeANswerUNCONDTIONALDISCHARGE(CrimeAnswerID) as 'UncondDisch'
,dbo.FN_GetCrimeANswerRESTITUTIONREPARATION(CrimeAnswerID) as 'Rest'
,dbo.FN_GetCrimeANswerSURCHARGEVictimAssessmentFee(CrimeAnswerID) as 'Surcharge'
,dbo.FN_GetCrimeANswerLicensePenalties(CrimeAnswerID) as 'Liscense'
,dbo.FN_GetCrimeANswerConSECutiveConcurrent(CrimeAnswerID) as 'Consec'
,[dbo].[FN_GetCrimeANswerEnd](CrimeAnswerID) as 'END'
FROM         tblCrimeAnswer INNER JOIN
                      tblCrimes ON tblCrimeAnswer.CrimesID = tblCrimes.CrimesID
where Viewable=1 and section like '%220.%' or section like '%221.%'
order by section,subsection
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEmailTotalUniqueUsedByDate]    Script Date: 02/23/2011 16:39:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetEmailTotalUniqueUsedByDate]
(
@EMailStartDate datetime,
@EMailEndDate datetime
)
as
SELECT    Distinct EMail, dbo.FN_GetTotal(Email,@EMailStartDate,@EMailEndDate) as Total
FROM         tblEmailAddress
WHERE     EmailDate BETWEEN @EMailStartDate AND @EMailEndDate + ' 23:59:59'
GO
/****** Object:  StoredProcedure [dbo].[AA_SPInsertfromNewCrimetoCrimeAnswer]    Script Date: 02/23/2011 16:39:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AA_SPInsertfromNewCrimetoCrimeAnswer]
AS
INSERT INTO tblCrimeAnswer
                      (CrimesID, AgeCategory, PastConvictions, FelonyConvictions, Attempted)
SELECT     dbo.FN_GetCrimeIDfromLawOrdinal(lawordinal), dbo.FN_GetAgeID(Age), dbo.FN_GetPreviousCon(PastConvictions), dbo.FN_GetFelonyLevel(FelonyLevel), dbo.FN_GetATtempt(Attempt)
FROM         NewCrimeSpreadsheet
GO
/****** Object:  StoredProcedure [dbo].[AASP_InsertLawOrdinalAfterExcelforKaylaSPreadsheet]    Script Date: 02/23/2011 16:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AASP_InsertLawOrdinalAfterExcelforKaylaSPreadsheet]
AS

UPDATE    KaylaSpreadsheet
SET              PastConvictions = N'2 or more'
WHERE     (PastConvictions = N'2')

UPDATE    KaylaSpreadsheet
SET              Age = 'Youthfull Offender'
WHERE     (Age = 'Nouthfull Offender')

DECLARE	@return_value int

EXEC	@return_value = [dbo].[AASP_InsertLawOrdinalforKaylaSPreadsheet]

SELECT	'Return Value' = @return_value

Select count(*) as 'Law Ord Null' from KaylaSpreadsheet where lawordinal is null AND (UseThis = N'Y')
GO
/****** Object:  StoredProcedure [dbo].[AASP_InsertLawOrdinalAfterExcelforNewCrimeSPreadsheet]    Script Date: 02/23/2011 16:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AASP_InsertLawOrdinalAfterExcelforNewCrimeSPreadsheet]
AS
UPDATE    NewCrimeSpreadsheet
SET              Cite ='PL 270.35'
WHERE     (Cite = N'PL 270.53')

UPDATE    NewCrimeSpreadsheet
SET              PastConvictions = N'2 or more'
WHERE     (PastConvictions = N'2')

UPDATE    NewCrimeSpreadsheet
SET              Cite = 'VTL 1192 (2-A)'
WHERE     (Cite = 'VTL 1192(2-A)')

UPDATE    NewCrimeSpreadsheet
SET           PastConvictions = Null
WHERE     (Cite = 'VTL 1192 (2-A)')
 

UPDATE    NewCrimeSpreadsheet
SET              FelonyLevel = NULL
WHERE     (PastConvictions = N'0')

UPDATE    NewCrimeSpreadsheet
SET              Age = 'Youthful Offender'
WHERE     (Age = N'Youthful')


DECLARE	@return_value int

EXEC	@return_value = [dbo].[AASP_InsertLawOrdinalforNewCrime]


UPDATE    NewCrimeSpreadsheet
SET              lawordinal = N'7581'
WHERE     (Cite = 'VTL 1192 (2-A)')

SELECT	'Return Value' = @return_value

Select count(*)as 'Law Ord Null' from NewCrimeSpreadsheet where lawordinal is null
GO
/****** Object:  StoredProcedure [dbo].[AASP_InsertLawOrdinalAfterExcelforNewCrime130sSPreadsheet]    Script Date: 02/23/2011 16:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AASP_InsertLawOrdinalAfterExcelforNewCrime130sSPreadsheet]
AS
UPDATE    NewCrime130sSpreadsheet
SET              PastConvictions = N'2 or more'
WHERE     (PastConvictions = N'2')

UPDATE    NewCrime130sSpreadsheet
SET              FelonyLevel = NULL
WHERE     (PastConvictions = N'0')

UPDATE    NewCrime130sSpreadsheet
SET              Age = 'Youthful Offender'
WHERE     (Age = N'Youthful')


DECLARE	@return_value int

EXEC	@return_value = [dbo].[AASP_InsertLawOrdinalforNewCrime130s]

SELECT	'Return Value' = @return_value

Select count(*)as 'Law Ord Null' from NewCrime130sSpreadsheet where lawordinal is null
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFullCrimeList]    Script Date: 02/23/2011 16:39:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetFullCrimeList]
AS
SELECT     law_ordinal,CrimesID, full_law_description as Name, dbo.FN_GetFullCite(title, section, subsection) as Cite, dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) as Level
FROM         tblCrimes
order by title
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeList]    Script Date: 02/23/2011 16:39:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeList]
AS


SELECT     tblCrimes.CrimesID, tblCrimes.full_law_description AS Name, dbo.FN_GetFullCite(title, section, subsection) as Cite, dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) as Level, tblCrimes.repeal_date, tblSpecialPopUps.Literal
FROM         tblCrimes Left outer join
                      tblCrimesSpecialPopups ON tblCrimes.CrimesID = tblCrimesSpecialPopups.CrimesID LEFT OUTER JOIN
                      tblSpecialPopUps ON tblCrimesSpecialPopups.SpecialPopUpsID = tblSpecialPopUps.SpecialPopUpsID LEFT OUTER JOIN
                      tblLawClass ON tblCrimes.class = tblLawClass.Short LEFT OUTER JOIN
                      tblLawCategory ON tblCrimes.nys_law_category = tblLawCategory.Short
WHERE     (tblCrimes.Viewable = 1)
order by Cite
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeListPLONLY]    Script Date: 02/23/2011 16:39:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeListPLONLY]
AS


SELECT     ISNULL(tblCrimes.law_ordinal, '0') AS law_ordinal, tblCrimes.CrimesID, tblCrimes.full_law_description AS Name, dbo.FN_GetFullCite(title, section, subsection) as Cite, dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) as Level, tblCrimes.repeal_date, 
                      tblSpecialPopUps.Literal
FROM         tblCrimes Left outer join
                      tblCrimesSpecialPopups ON tblCrimes.CrimesID = tblCrimesSpecialPopups.CrimesID Left outer join
                      tblSpecialPopUps ON tblCrimesSpecialPopups.SpecialPopUpsID = tblSpecialPopUps.SpecialPopUpsID
where Viewable=1 and title='PL'
order by Cite
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeListSearched]    Script Date: 02/23/2011 16:39:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeListSearched]
(
@SearchText nvarchar(100)
)
AS
SELECT     ISNULL(law_ordinal,'0') as law_ordinal,CrimesID, full_law_description as Name, dbo.FN_GetFullCite(title, section, subsection) as Cite, dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) as Level
FROM         tblCrimes
where section Like '%'+@SearchText+'%'
order by Name
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAssumptionInfo]    Script Date: 02/23/2011 16:39:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetAssumptionInfo]
(
@CrimeAnswerID int
)
AS
Declare @Attempted as bit

SELECT    @Attempted = Attempted
FROM         tblCrimeAnswer
WHERE     (CrimeAnswerID = @CrimeAnswerID)

If @Attempted='True'
Begin
SELECT     tblCrimes.full_law_description AS Name, dbo.FN_GetFullCite(title, section, subsection) as CITE, 
                      tblAgeCategory.Literal AS Age, ISNULL(tblFelonyConvictions.Literal, N'') AS FelConvictions, ISNULL(tblPastConvictions.Literal, N'') AS PastConvictions, 
                      dbo.FN_GetFullLevel(attempted_class,attempted_nys_law_category,attempted_vf_indicator) as FelonyLevel, tblCrimeAnswer.Attempted
FROM         tblCrimeAnswer Left outer join
                      tblCrimes ON tblCrimeAnswer.CrimesID = tblCrimes.CrimesID Left outer join
                      tblFelonyConvictions ON tblCrimeAnswer.FelonyConvictions = tblFelonyConvictions.FelonyConvictionsID Left outer join
                      tblAgeCategory ON tblCrimeAnswer.AgeCategory = tblAgeCategory.AgeCategoryID Left outer join
                      tblPastConvictions ON tblCrimeAnswer.PastConvictions = tblPastConvictions.PastConvictionsID Left outer join
                      tblLawClass ON tblCrimes.class = tblLawClass.Short Left outer join
                      tblLawCategory ON tblCrimes.nys_law_category = tblLawCategory.Short
WHERE     (tblCrimeAnswer.CrimeAnswerID = @CrimeAnswerID)
End
Else
Begin
SELECT     tblCrimes.full_law_description AS Name, dbo.FN_GetFullCite(title, section, subsection) as CITE, 
                      tblAgeCategory.Literal AS Age, ISNULL(tblFelonyConvictions.Literal, N'') AS FelConvictions, ISNULL(tblPastConvictions.Literal, N'') AS PastConvictions, 
                      dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) as FelonyLevel, tblCrimeAnswer.Attempted
FROM         tblCrimeAnswer Left outer join
                      tblCrimes ON tblCrimeAnswer.CrimesID = tblCrimes.CrimesID Left outer join
                      tblFelonyConvictions ON tblCrimeAnswer.FelonyConvictions = tblFelonyConvictions.FelonyConvictionsID Left outer join
                      tblAgeCategory ON tblCrimeAnswer.AgeCategory = tblAgeCategory.AgeCategoryID Left outer join
                      tblPastConvictions ON tblCrimeAnswer.PastConvictions = tblPastConvictions.PastConvictionsID Left outer join
                      tblLawClass ON tblCrimes.class = tblLawClass.Short Left outer join
                      tblLawCategory ON tblCrimes.nys_law_category = tblLawCategory.Short
WHERE     (tblCrimeAnswer.CrimeAnswerID = @CrimeAnswerID)
End
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeListCORONLY]    Script Date: 02/23/2011 16:39:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCrimeListCORONLY] 
AS
BEGIN
	SELECT ISNULL(tblCrimes.law_ordinal, '0') AS law_ordinal, tblCrimes.CrimesID, tblCrimes.full_law_description AS Name, dbo.FN_GetFullCite(title, 		section, subsection) AS Cite, dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) AS Level, tblCrimes.repeal_date, 
            	tblSpecialPopUps.Literal
	FROM tblCrimes LEFT OUTER JOIN
             tblCrimesSpecialPopups ON tblCrimes.CrimesID = tblCrimesSpecialPopups.CrimesID LEFT OUTER JOIN
             tblSpecialPopUps ON tblCrimesSpecialPopups.SpecialPopUpsID = tblSpecialPopUps.SpecialPopUpsID
	WHERE Viewable=1 AND title='COR'
	ORDER BY Cite
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeListVTLONLY]    Script Date: 02/23/2011 16:39:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeListVTLONLY]
AS
SELECT     ISNULL(tblCrimes.law_ordinal, '0') AS law_ordinal, tblCrimes.CrimesID, tblCrimes.full_law_description AS Name, dbo.FN_GetFullCite(title, section, subsection) as Cite, dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) as Level, tblCrimes.repeal_date, 
                      tblSpecialPopUps.Literal
FROM         tblCrimes Left outer join
                      tblCrimesSpecialPopups ON tblCrimes.CrimesID = tblCrimesSpecialPopups.CrimesID Left outer join
                      tblSpecialPopUps ON tblCrimesSpecialPopups.SpecialPopUpsID = tblSpecialPopUps.SpecialPopUpsID
where Viewable=1 and title='VTL'
order by Cite
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCrimeTIMEListSearched]    Script Date: 02/23/2011 16:39:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetCrimeTIMEListSearched]
(
@SearchText nvarchar(100)
)
AS
SELECT     ISNULL(tblCrimes.law_ordinal, '0') AS law_ordinal, tblCrimes.CrimesID, tblCrimes.full_law_description AS Name, dbo.FN_GetFullCite(title, section, subsection) as Cite, dbo.FN_GetFullLevel(class,nys_law_category, vf_indicator) as Level, tblCrimes.repeal_date, 
                      tblSpecialPopUps.Literal
FROM         tblCrimes Left outer join
                      tblCrimesSpecialPopups ON tblCrimes.CrimesID = tblCrimesSpecialPopups.CrimesID Left outer join
                      tblSpecialPopUps ON tblCrimesSpecialPopups.SpecialPopUpsID = tblSpecialPopUps.SpecialPopUpsID
where (section Like '%'+@SearchText+'%' or (full_law_description Like '%'+@SearchText+'%') OR
                      (statute Like '%'+@SearchText+'%')) and Viewable=1
order by Cite
GO
