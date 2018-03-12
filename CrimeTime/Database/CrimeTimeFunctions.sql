USE [CrimeTime]
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetLOCITE]    Script Date: 02/23/2011 16:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetLOCITE]
(
@Title nvarchar(100),
@Section nvarchar(100),
@SubSection nvarchar(100)
)
returns nvarchar(4000)
Begin
Declare @LoCite nvarchar(4000)
If len(@Subsection)>0
Set @LoCite=@Title + ' ' + @Section + ' ' + @Subsection
Else
Set @LoCite=@Title + ' ' + @Section 
return @LoCite
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetATtempt]    Script Date: 02/23/2011 16:40:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetATtempt]
(
@Att nvarchar(200)
)
returns bit
AS
Begin
Declare @Attempt as bit
Set @Attempt=0
If @Att='Y'
set @Attempt=1
Return @Attempt
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetTrueFalse]    Script Date: 02/23/2011 16:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_GetTrueFalse]
(
@boolean bit
)
returns nvarchar(max)
as
Begin
Declare @bool as nvarchar(max)
If @boolean=1
Begin
Set @bool='Yes'
End
Else
Begin
Set @bool='No'
End
return @bool

end
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeIDfromLawOrdinal]    Script Date: 02/23/2011 16:40:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeIDfromLawOrdinal]
(
@LawOrdinal int
)
returns int
AS
Begin
Declare @CID as int
SELECT    @CID = CrimesID
FROM         tblCrimes
WHERE     (law_ordinal = @LawOrdinal)
Return @CID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetTotal]    Script Date: 02/23/2011 16:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_GetTotal]
(
@Email nvarchar(150),
@EMailStartDate datetime,
@EMailEndDate datetime
)
returns int
as
Begin
Declare @Total int
SELECT    @Total =Count(Email)
FROM         tblEmailAddress
WHERE     EmailDate BETWEEN @EMailStartDate AND @EMailEndDate and Email=@Email

return @Total
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetAgeID]    Script Date: 02/23/2011 16:40:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_GetAgeID]
(
@Age nvarchar(100)
)
returns int
AS
Begin
Declare @AID as int
SELECT   @AID =  AgeCategoryID
FROM         tblAgeCategory
WHERE     (Literal = @Age)
Return @AID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetAgeCatLiteral]    Script Date: 02/23/2011 16:40:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetAgeCatLiteral]
(
@AgeCatID int
)
returns nvarchar(max)
as
Begin
Declare @Age as nvarchar(max)
select @Age =literal from tblagecategory where agecategoryid=@AgeCatID
return @Age 
end
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetPreviousCon]    Script Date: 02/23/2011 16:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_GetPreviousCon]
(
@Prev nvarchar(200)
)
returns int
AS
Begin
Declare @PID as int
If @Prev='2'
Set @Prev='2 or more'

SELECT   @PID =  PastConvictionsID
FROM         tblPastConvictions
WHERE     (Literal = @Prev)


Return @PID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetPastCOnvLiteral]    Script Date: 02/23/2011 16:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetPastCOnvLiteral]
(
@PastCOnvID int
)
returns nvarchar(max)
as
Begin
Declare @PastCOnv as nvarchar(max)
select @PastCOnv =literal from tblpastconvictions where pastconvictionsid=@PastCOnvID
return @PastCOnv 
end
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetFelonyCatLiteral]    Script Date: 02/23/2011 16:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetFelonyCatLiteral]
(
@FelonyCatID int
)
returns nvarchar(max)
as
Begin
Declare @Fel as nvarchar(max)
SELECT     @Fel =Literal
FROM         tblFelonyConvictions
WHERE     (FelonyConvictionsID = @FelonyCatID)
return @Fel 
end
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetFelonyLevel]    Script Date: 02/23/2011 16:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetFelonyLevel]
(
@Fel nvarchar(200)
)
returns int
AS
Begin
Declare @FID as int
SELECT  @FID=   FelonyConvictionsID
FROM         tblFelonyConvictions
WHERE     (Literal = @Fel)
Return @FID
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetPreID]    Script Date: 02/23/2011 16:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetPreID]
(
@preface nvarchar(4000)
)
returns int
Begin
Declare @PID int
SELECT     @PID=PrefaceID
FROM         tblPreface
WHERE     (PrefaceKey = @preface)
return @PID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerPreface]    Script Date: 02/23/2011 16:40:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerPreface]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @PrefaceLITs nvarchar(max)

SELECT     @PrefaceLITs=COALESCE(@PrefaceLITs +',','')+ tblPreface.PrefaceKey
FROM         tblCrimeAnswerPreface INNER JOIN
                      tblPreface ON tblCrimeAnswerPreface.PrefaceID = tblPreface.PrefaceID where crimeanswer=@CAID
return @PrefaceLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetTranID]    Script Date: 02/23/2011 16:40:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetTranID]
(
@transition nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=transitionID
FROM         tbltransition
WHERE     (transitionKey = @transition)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerTransition]    Script Date: 02/23/2011 16:40:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerTransition]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @TransitionLITs nvarchar(max)

SELECT     @TransitionLITs=COALESCE(@TransitionLITs +',','')+ tblTransition.TransitionKey
FROM         tblCrimeAnswerTransition INNER JOIN
                      tblTransition ON tblCrimeAnswerTransition.TransitionID = tblTransition.TransitionID where crimeanswer=@CAID
return @TransitionLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetSTAID]    Script Date: 02/23/2011 16:40:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetSTAID]
(
@stateprison nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=stateprisonID
FROM         tblstateprison
WHERE     (stateprisonKey = @stateprison)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerStatePRISON]    Script Date: 02/23/2011 16:40:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerStatePRISON]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @StatePRISONLITs nvarchar(max)

SELECT     @StatePRISONLITs=COALESCE(@StatePRISONLITs +',','')+ tblStatePRISON.StatePRISONKey
FROM         tblCrimeAnswerStatePRISON INNER JOIN
                      tblStatePRISON ON tblCrimeAnswerStatePRISON.StatePRISONID = tblStatePRISON.StatePRISONID where crimeanswer=@CAID
return @StatePRISONLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerDEFINITESENTENCE]    Script Date: 02/23/2011 16:40:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerDEFINITESENTENCE]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @DEFINITESENTENCELITs nvarchar(max)

SELECT     @DEFINITESENTENCELITs=COALESCE(@DEFINITESENTENCELITs +',','')+ tblDEFINITESENTENCE.DEFINITESENTENCEKey
FROM         tblCrimeAnswerDEFINITESENTENCE INNER JOIN
                      tblDEFINITESENTENCE ON tblCrimeAnswerDEFINITESENTENCE.DEFINITESENTENCEID = tblDEFINITESENTENCE.DEFINITESENTENCEID where crimeanswer=@CAID
return @DEFINITESENTENCELits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetDEFID]    Script Date: 02/23/2011 16:40:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetDEFID]
(
@DefiniteSentence nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=DefiniteSentenceID
FROM         tblDefiniteSentence
WHERE     (DefiniteSentenceKey = @DefiniteSentence)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetFullTitle]    Script Date: 02/23/2011 16:40:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetFullTitle]
(
@Title nvarchar(10)
)
returns nvarchar(100)
AS
Begin
Declare @LawTitle as nvarchar(100)
SELECT   @LawTitle=  Literal
FROM         tblLawTitle
WHERE     (abbreviation = @Title)
return @LawTitle
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetSpecialPopupText]    Script Date: 02/23/2011 16:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetSpecialPopupText]
(
@CrimesID int
)
returns nvarchar(max)
AS
Begin
Declare @Text nvarchar(max)
SELECT     @Text=tblSpecialPopUps.Literal
FROM         tblSpecialPopUps INNER JOIN
                      tblCrimesSpecialPopups ON tblSpecialPopUps.SpecialPopUpsID = tblCrimesSpecialPopups.SpecialPopUpsID
WHERE     (tblCrimesSpecialPopups.CrimesID = @CrimesID)
return @Text
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetFullCategory]    Script Date: 02/23/2011 16:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetFullCategory]
(
@Code nvarchar(10)
)
returns nvarchar(150)
AS
BEGIN
Declare @Category as nvarchar(150)

SELECT @Category= Literal
FROM         tblLawCategory
WHERE     (Short = @Code)
return @Category
END
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerConSECutiveConcurrent]    Script Date: 02/23/2011 16:40:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerConSECutiveConcurrent]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @ConSECutiveConcurrentLITs nvarchar(max)

SELECT     @ConSECutiveConcurrentLITs=COALESCE(@ConSECutiveConcurrentLITs +',','')+ tblConSECutiveConcurrent.ConSECutiveConcurrentKey
FROM         tblCrimeAnswerConSECutiveConcurrent INNER JOIN
                      tblConSECutiveConcurrent ON tblCrimeAnswerConSECutiveConcurrent.ConSECutiveConcurrentID = tblConSECutiveConcurrent.ConSECutiveConcurrentID where crimeanswer=@CAID
return @ConSECutiveConcurrentLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerEnd]    Script Date: 02/23/2011 16:40:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_GetCrimeANswerEnd]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @ENDLITs nvarchar(max)

SELECT     @ENDLITs=COALESCE(@ENDLITs +',','')+ tblEnd.EndKey
FROM         tblCrimeAnswerEnd INNER JOIN
                      tblEnd ON tblCrimeAnswerEnd.EndID = tblEnd.EndID where crimeanswer=@CAID
return @EndLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetIntID]    Script Date: 02/23/2011 16:40:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetIntID]
(
@IntermittentImprisonment nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=IntermittentImprisonmentID
FROM         tblIntermittentImprisonment
WHERE     (IntermittentImprisonmentKey = @IntermittentImprisonment)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerIntermittentImprisonment]    Script Date: 02/23/2011 16:40:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerIntermittentImprisonment]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @IntermittentImprisonmentLITs nvarchar(max)

SELECT     @IntermittentImprisonmentLITs=COALESCE(@IntermittentImprisonmentLITs +',','')+ tblIntermittentImprisonment.IntermittentImprisonmentKey
FROM         tblCrimeAnswerIntermittentImprisonment INNER JOIN
                      tblIntermittentImprisonment ON tblCrimeAnswerIntermittentImprisonment.IntermittentImprisonmentID = tblIntermittentImprisonment.IntermittentImprisonmentID where crimeanswer=@CAID
return @IntermittentImprisonmentLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerUNCONDTIONALDISCHARGE]    Script Date: 02/23/2011 16:40:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_GetCrimeANswerUNCONDTIONALDISCHARGE]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @UNCONDTIONALDISCHARGELITs nvarchar(max)

SELECT     @UNCONDTIONALDISCHARGELITs=COALESCE(@UNCONDTIONALDISCHARGELITs +',','')+ tblUNCONdiTIONALDISCHARGE.UNCONDiTIONALDISCHARGEKey
FROM         tblCrimeAnswerUNCONDiTIONALDISCHARGE INNER JOIN
                      tblUNCONDiTIONALDISCHARGE ON tblCrimeAnswerUNCONDiTIONALDISCHARGE.UNCONDiTIONALDISCHARGEID = tblUNCONDiTIONALDISCHARGE.UNCONDiTIONALDISCHARGEID where crimeanswer=@CAID
return @UNCONDTIONALDISCHARGELits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetProID]    Script Date: 02/23/2011 16:40:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetProID]
(
@Probation nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=ProbationID
FROM         tblProbation
WHERE     (ProbationKey = @Probation)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerPROBATION]    Script Date: 02/23/2011 16:40:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerPROBATION]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @PROBATIONLITs nvarchar(max)

SELECT     @PROBATIONLITs=COALESCE(@PROBATIONLITs +',','')+ tblPROBATION.PROBATIONKey
FROM         tblCrimeAnswerPROBATION INNER JOIN
                      tblPROBATION ON tblCrimeAnswerPROBATION.PROBATIONID = tblPROBATION.PROBATIONID where crimeanswer=@CAID
return @PROBATIONLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerRESTITUTIONREPARATION]    Script Date: 02/23/2011 16:40:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerRESTITUTIONREPARATION]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @RESTITUTIONREPARATIONLITs nvarchar(max)

SELECT     @RESTITUTIONREPARATIONLITs=COALESCE(@RESTITUTIONREPARATIONLITs +',','')+ tblRESTITUTIONREPARATION.RESTITUTIONREPARATIONKey
FROM         tblCrimeAnswerRESTITUTIONREPARATION INNER JOIN
                      tblRESTITUTIONREPARATION ON tblCrimeAnswerRESTITUTIONREPARATION.RESTITUTIONREPARATIONID = tblRESTITUTIONREPARATION.RESTITUTIONREPARATIONID where crimeanswer=@CAID
return @RESTITUTIONREPARATIONLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetConID]    Script Date: 02/23/2011 16:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetConID]
(
@ConditionalDischarge nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=ConditionalDischargeID
FROM         tblConditionalDischarge
WHERE     (ConditionalDischargeKey = @ConditionalDischarge)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerCONDITIONALDISCHARGE]    Script Date: 02/23/2011 16:40:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerCONDITIONALDISCHARGE]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @CONDITIONALDISCHARGELITs nvarchar(max)

SELECT     @CONDITIONALDISCHARGELITs=COALESCE(@CONDITIONALDISCHARGELITs +',','')+ tblCONDITIONALDISCHARGE.CONDITIONALDISCHARGEKey
FROM         tblCrimeAnswerCONDITIONALDISCHARGE INNER JOIN
                      tblCONDITIONALDISCHARGE ON tblCrimeAnswerCONDITIONALDISCHARGE.CONDITIONALDISCHARGEID = tblCONDITIONALDISCHARGE.CONDITIONALDISCHARGEID where crimeanswer=@CAID
return @CONDITIONALDISCHARGELits
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerSURCHARGEVictimAssessmentFee]    Script Date: 02/23/2011 16:40:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerSURCHARGEVictimAssessmentFee]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @SURCHARGEVictimAssessmentFeeLITs nvarchar(max)

SELECT     @SURCHARGEVictimAssessmentFeeLITs=COALESCE(@SURCHARGEVictimAssessmentFeeLITs +',','')+ tblSURCHARGEVictimAssessmentFee.SURCHARGEVictimAssessmentFeeKey
FROM         tblCrimeAnswerSURCHARGEVictimAssessmentFee INNER JOIN
                      tblSURCHARGEVictimAssessmentFee ON tblCrimeAnswerSURCHARGEVictimAssessmentFee.SURCHARGEVictimAssessmentFeeID = tblSURCHARGEVictimAssessmentFee.SURCHARGEVictimAssessmentFeeID where crimeanswer=@CAID
return @SURCHARGEVictimAssessmentFeeLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetSplitID]    Script Date: 02/23/2011 16:40:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetSplitID]
(
@Splitsentence nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=SplitsentenceID
FROM         tblSplitsentence
WHERE     (SplitsentenceKey = @Splitsentence)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerSplitSentence]    Script Date: 02/23/2011 16:40:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerSplitSentence]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @SplitSentenceLITs nvarchar(max)

SELECT     @SplitSentenceLITs=COALESCE(@SplitSentenceLITs +',','')+ tblSplitSentence.SplitSentenceKey
FROM         tblCrimeAnswerSplitSentence INNER JOIN
                      tblSplitSentence ON tblCrimeAnswerSplitSentence.SplitSentenceID = tblSplitSentence.SplitSentenceID where crimeanswer=@CAID
return @SplitSentenceLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerLicensePenalties]    Script Date: 02/23/2011 16:40:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerLicensePenalties]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @LicensePenaltiesLITs nvarchar(max)

SELECT     @LicensePenaltiesLITs=COALESCE(@LicensePenaltiesLITs +',','')+ tblLicensePenalties.LicensePenaltiesKey
FROM         tblCrimeAnswerLicensePenalties INNER JOIN
                      tblLicensePenalties ON tblCrimeAnswerLicensePenalties.LicensePenaltiesID = tblLicensePenalties.LicensePenaltiesID where crimeanswer=@CAID
return @LicensePenaltiesLits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetFineID]    Script Date: 02/23/2011 16:40:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetFineID]
(
@Fine nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=FineID
FROM         tblFine
WHERE     (FineKey = @Fine)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetCrimeANswerFINE]    Script Date: 02/23/2011 16:40:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetCrimeANswerFINE]
(
@CAID int
)
returns nvarchar(max)
AS
Begin
Declare @FINELITs nvarchar(max)

SELECT     @FINELITs=COALESCE(@FINELITs +',','')+ tblFINE.FINEKey
FROM         tblCrimeAnswerFINE INNER JOIN
                      tblFINE ON tblCrimeAnswerFINE.FINEID = tblFINE.FINEID where crimeanswer=@CAID
return @FINELits
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetUnconditionalDischargeID]    Script Date: 02/23/2011 16:40:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[AAFN_GetUnconditionalDischargeID]
(
@UnconditionalDischarge nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=UnconditionalDischargeID
FROM         tblUnconditionalDischarge
WHERE     (UnconditionalDischargeKey = @UnconditionalDischarge)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetFullClass]    Script Date: 02/23/2011 16:40:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_GetFullClass]
(
@Code nvarchar(10)
)
returns nvarchar(150)
AS
BEGIN
Declare @Class as nvarchar(150)
SELECT @Class= Literal
FROM         tblLawClass
WHERE     (Short = @Code)
return @Class
END
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetRestitutionReparationID]    Script Date: 02/23/2011 16:40:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetRestitutionReparationID]
(
@RestitutionReparation nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=RestitutionReparationID
FROM         tblRestitutionReparation
WHERE     (RestitutionReparationKey = @RestitutionReparation)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetSurchargeVictimAssessmentFeeID]    Script Date: 02/23/2011 16:40:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetSurchargeVictimAssessmentFeeID]
(
@SurchargeVictimAssessmentFee nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=SurchargeVictimAssessmentFeeID
FROM         tblSurchargeVictimAssessmentFee
WHERE     (SurchargeVictimAssessmentFeeKey = @SurchargeVictimAssessmentFee)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetLicensePenaltiesID]    Script Date: 02/23/2011 16:40:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetLicensePenaltiesID]
(
@LicensePenalties nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=LicensePenaltiesID
FROM         tblLicensePenalties
WHERE     (LicensePenaltiesKey = @LicensePenalties)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetConsecutiveConcurrentID]    Script Date: 02/23/2011 16:40:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetConsecutiveConcurrentID]
(
@ConsecutiveConcurrent nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=ConsecutiveConcurrentID
FROM         tblConsecutiveConcurrent
WHERE     (ConsecutiveConcurrentKey = @ConsecutiveConcurrent)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[AAFN_GetEndID]    Script Date: 02/23/2011 16:40:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AAFN_GetEndID]
(
@End nvarchar(4000)
)
returns int
Begin
Declare @TID int
SELECT     @TID=EndID
FROM         tblEnd
WHERE     (EndKey = @End)
return @TID
End
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetFullLevel]    Script Date: 02/23/2011 16:40:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_GetFullLevel]
(
@class nvarchar(50),
@Category nvarchar(50),
@vf nvarchar(4)
)
returns nvarchar(150)
AS
BEGIN
Declare @level nvarchar(150)
Declare @C nvarchar(50)
Declare @Cat nvarchar(50)

Set @C=ISNULL(dbo.FN_GetFullClass(@class),'-2')
Set @Cat=ISNULL(dbo.FN_GetFullCategory(@Category),'-2')

if @vf='V' 
Set @Cat='violent ' + @Cat

if @C='-2'
BEGIN
if @Cat='-2'
Set  @level= ''
Else
Set @level= @cat
END
else
BEGIN
if @Cat='-2'
Set  @level=@C
Else
set @level=@C + ' ' +@Cat
End
return @level
END
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetFullCite]    Script Date: 02/23/2011 16:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_GetFullCite]
(
@Title nvarchar(10),
@section nvarchar(50),
@subsection nvarchar(50)
)
returns nvarchar(150)
AS
BEGIN
Declare @cite nvarchar(150)
Declare @LawTitle nvarchar(100)
Select @LawTitle=dbo.FN_GetFullTitle(@Title)

If Len(@subsection)=0
Set @cite=@LawTitle + ' ' + @section
else
Set @cite=@LawTitle + ' ' + @section + ' (' + Lower(@subsection) + ')'
return @cite
END
GO
