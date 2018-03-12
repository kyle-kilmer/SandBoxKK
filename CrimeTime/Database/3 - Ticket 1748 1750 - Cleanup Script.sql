-- This script will delete all old tables and stored procedures that become unneccessary after updating for Ticket 1748
-- This Script must be run twice because some objects are not removed the first time due to constraints.

-- Deleting Tables

DROP TABLE tblPreface
GO

DROP TABLE tblTransition
GO

DROP TABLE tblStatePrison
GO

DROP TABLE tblDefiniteSentence
GO

DROP TABLE tblIntermittentImprisonment
GO

DROP TABLE tblProbation
GO

DROP TABLE tblConditionalDischarge
GO

DROP TABLE tblSplitSentence
GO

DROP TABLE tblFine
GO

DROP TABLE tblUnconditionalDischarge
GO

DROP TABLE tblRestitutionReparation
GO

DROP TABLE tblSurchargeVictimAssessmentFee
GO

DROP TABLE tblLicensePenalties
GO

DROP TABLE tblConsecutiveConcurrent
GO

DROP TABLE tblEnd
GO

DROP TABLE tblCasat
GO

DROP TABLE tblSupervisedParole
GO

DROP TABLE tblJudicialDiversion
GO

DROP TABLE tblShock
GO

DROP TABLE tblInterimProbationSupervision
GO

DROP TABLE tblCrimeAnswerPreface
GO

DROP TABLE tblCrimeAnswerTransition
GO

DROP TABLE tblCrimeAnswerStatePrison
GO

DROP TABLE tblCrimeAnswerDefiniteSentence
GO

DROP TABLE tblCrimeAnswerIntermittentImprisonment
GO

DROP TABLE tblCrimeAnswerProbation
GO

DROP TABLE tblCrimeAnswerConditionalDischarge
GO

DROP TABLE tblCrimeAnswerSplitSentence
GO

DROP TABLE tblCrimeAnswerFine
GO

DROP TABLE tblCrimeAnswerUnconditionalDischarge
GO

DROP TABLE tblCrimeAnswerRestitutionReparation
GO

DROP TABLE tblCrimeAnswerSurchargeVictimAssessmentFee
GO

DROP TABLE tblCrimeAnswerLicensePenalties
GO

DROP TABLE tblCrimeAnswerConsecutiveConcurrent
GO

DROP TABLE tblCrimeAnswerEnd
GO

DROP TABLE tblCrimeAnswerCasat
GO

DROP TABLE tblCrimeAnswerSupervisedParole
GO

DROP TABLE tblCrimeAnswerJudicialDiversion
GO

DROP TABLE tblCrimeAnswerShock
GO

DROP TABLE tblCrimeAnswerInterimProbationSupervision
GO

DROP TABLE drugchangestable2
GO

DROP TABLE druglawchanges07132009
GO

DROP TABLE KaylaSpreadsheet
GO

DROP TABLE NewCrime130sSpreadsheet
GO

DROP TABLE NewCrimeSpreadsheet
GO

DROP TABLE NewCrimeSpreadsheet2
GO

DROP TABLE NewCrimeSpreadsheet3
GO

DROP TABLE NewCrimeSpreadsheet4
GO

DROP TABLE OldCrimesManualSpreadsheet
GO

DROP TABLE tblDBInfo
GO

-- Deleting Stored Procedures

DROP PROCEDURE SP_GetPrefaceList
GO

DROP PROCEDURE SP_GetTransitionList
GO

DROP PROCEDURE SP_GetStatePrisonList
GO

DROP PROCEDURE SP_GetDefiniteSentenceList
GO

DROP PROCEDURE SP_GetIntermittentImprisonmentList
GO

DROP PROCEDURE SP_GetProbationList
GO

DROP PROCEDURE SP_GetConditionalDischargeList
GO

DROP PROCEDURE SP_GetSplitSentenceList
GO

DROP PROCEDURE SP_GetFineList
GO

DROP PROCEDURE SP_GetUnconditionalDischargeList
GO

DROP PROCEDURE SP_GetRestitutionReparationList
GO

DROP PROCEDURE SP_GetSurchargeVictimAssessmentFeeList
GO

DROP PROCEDURE SP_GetLiscensePenaltiesList
GO

DROP PROCEDURE SP_GetConsecutiveConcurrentList
GO

DROP PROCEDURE SP_GetEndList
GO

DROP PROCEDURE SP_AddPrefaceToCrime
GO

DROP PROCEDURE SP_AddTransitionToCrime
GO

DROP PROCEDURE SP_AddStatePrisonToCrime
GO

DROP PROCEDURE SP_AddDefiniteSentenceToCrime
GO

DROP PROCEDURE SP_AddToIntermittentImprisonmentCrime
GO

DROP PROCEDURE SP_AddProbationToCrime
GO

DROP PROCEDURE SP_AddConditionalDischargeToCrime
GO

DROP PROCEDURE SP_AddSplitSentenceToCrime
GO

DROP PROCEDURE SP_AddFineToCrime
GO

DROP PROCEDURE SP_AddUnconditionalDischargeToCrime
GO

DROP PROCEDURE SP_AddRestitutionReparationToCrime
GO

DROP PROCEDURE SP_AddToSurchargeVictimAssessmentFeeCrime
GO

DROP PROCEDURE SP_AddLicensePenaltiesToCrime
GO

DROP PROCEDURE SP_AddConsecutiveConcurrentToCrime
GO

DROP PROCEDURE SP_AddEndToCrime
GO

DROP PROCEDURE SP_GetAnswerCASAT
GO

DROP PROCEDURE SP_GetAnswerConditionalDischarge
GO

DROP PROCEDURE SP_GetAnswerConsecutiveConcurrent
GO

DROP PROCEDURE SP_GetAnswerDefiniteSentence
GO

DROP PROCEDURE SP_GetAnswerEnd
GO

DROP PROCEDURE SP_GetAnswerFine
GO

DROP PROCEDURE SP_GetAnswerIterimProbationSupervision
GO

DROP PROCEDURE SP_GetAnswerIntermittentImprisonment
GO

DROP PROCEDURE SP_GetAnswerJudicialDiversion
GO

DROP PROCEDURE SP_GetAnswerLicensePenalties
GO

DROP PROCEDURE SP_GetAnswerPreface
GO

DROP PROCEDURE SP_GetAnswerProbation
GO

DROP PROCEDURE SP_GetAnswerShock
GO

DROP PROCEDURE SP_GetAnswerSplitSentence
GO

DROP PROCEDURE SP_GetAnswerStatePrison
GO

DROP PROCEDURE SP_GetAnswerSupervisedParole
GO

DROP PROCEDURE SP_GetAnswerSurchargeVictimAssessmentFee
GO

DROP PROCEDURE SP_GetAnswerTransition
GO

DROP PROCEDURE SP_GetAnswerUnConditionalDischarge
GO

DROP PROCEDURE SP_GetAnswerRestitutionReparation
GO

DROP PROCEDURE SP_GetPrefaceByKey
GO

DROP PROCEDURE SP_GetTransitionByKey
GO

DROP PROCEDURE SP_GetStatePrisonByKey
GO

DROP PROCEDURE SP_GetDefiniteSentenceByKey
GO

DROP PROCEDURE SP_GetIntermittentImprisonmentByKey
GO

DROP PROCEDURE SP_GetProbationByKey
GO

DROP PROCEDURE SP_GetConditionalDischargeByKey
GO

DROP PROCEDURE SP_GetSplitSentenceByKey
GO

DROP PROCEDURE SP_GetFineByKey
GO

DROP PROCEDURE SP_GetUnconditionalDischargeByKey
GO

DROP PROCEDURE SP_GetRestitutionReparationByKey
GO

DROP PROCEDURE SP_GetVictimAssessmentFeeByKey
GO

DROP PROCEDURE SP_GetLicensePenaltiesByKey
GO

DROP PROCEDURE SP_GetConsecutiveConcurrentByKey
GO

DROP PROCEDURE SP_GetEndByKey
GO

DROP PROCEDURE A_ConvertDrugLawsTest
GO

DROP PROCEDURE A_GetListofCrimeswith14paragraphtypes
GO

DROP PROCEDURE AA_SPDELETEfromCrimetime
GO

DROP PROCEDURE AA_SPDELETEfromCrimetimeAnswers
GO

DROP PROCEDURE AA_SPInsertfromNewCrimetoCrimeAnswer
GO

DROP PROCEDURE AA_SPTruncatefromCrimetimeAnswers
GO

DROP PROCEDURE AAA_SPCursorNew130Crimes
GO

DROP PROCEDURE AAA_SPCursorNewCrime
GO

DROP PROCEDURE AAA_SPCursorNewCrime2
GO

DROP PROCEDURE AAA_SPCursorNewCrime3
GO

DROP PROCEDURE AAA_SPCursorNewCrime4
GO

DROP PROCEDURE AAA_SPCursorOldCrimes
GO

DROP PROCEDURE AAA_SPCursorOldCrimesNewTable
GO

DROP PROCEDURE AAAA_SPFormat130Spreadsheet
GO

DROP PROCEDURE AAAA_SPFormatKaylaSpreadsheet
GO

DROP PROCEDURE AAAA_SPFormatoldcrimeNewTableSpreadsheet
GO

DROP PROCEDURE AASP_CopyAnswerstoNewCrime
GO

DROP PROCEDURE AASP_GetLawOrdinalforNewCrime
GO

DROP PROCEDURE AASP_InsertLawOrdinalAfterExcelforKaylaSPreadsheet
GO

DROP PROCEDURE AASP_InsertLawOrdinalAfterExcelforNewCrime130sSPreadsheet
GO

DROP PROCEDURE AASP_InsertLawOrdinalAfterExcelforNewCrimeSPreadsheet
GO

DROP PROCEDURE AASP_InsertLawOrdinalforKaylaSPreadsheet
GO

DROP PROCEDURE AASP_InsertLawOrdinalforNewCrime
GO

DROP PROCEDURE AASP_InsertLawOrdinalforNewCrime130s
GO

DROP PROCEDURE SP_AddIntermittentImprisonmentToCrime
GO

DROP PROCEDURE SP_AddLiscensePenaltiesToCrime
GO

DROP PROCEDURE SP_AddSurchargeVictimAssessmentFeeToCrime
GO

DROP PROCEDURE SP_GET220CRIMESTUFF
GO

DROP PROCEDURE SP_GETALLPARAGRAPHS
GO

DROP PROCEDURE SP_GetAnswerINTERIMPROBATIONSUPERVISION
GO

DROP PROCEDURE SP_GetCrimeAnswers
GO

DROP PROCEDURE SP_GetRepealInfo
GO

DROP PROCEDURE SP_GetTotalEmailsByDate
GO

-- Deleteing functions

DROP FUNCTION AAFN_GetConID
GO

DROP FUNCTION AAFN_GetConsecutiveConcurrentID
GO

DROP FUNCTION AAFN_GetDEFID
GO

DROP FUNCTION AAFN_GetEndID
GO

DROP FUNCTION AAFN_GetFineID
GO

DROP FUNCTION AAFN_GetIntID
GO

DROP FUNCTION AAFN_GetLicensePenaltiesID
GO

DROP FUNCTION AAFN_GetLOCITE
GO

DROP FUNCTION AAFN_GetPreID
GO

DROP FUNCTION AAFN_GetProID
GO

DROP FUNCTION AAFN_GetRestitutionReparationID
GO

DROP FUNCTION AAFN_GetSplitID
GO

DROP FUNCTION AAFN_GetSTAID
GO

DROP FUNCTION AAFN_GetSurchargeVictimAssessmentFeeID
GO

DROP FUNCTION AAFN_GetTranID
GO

DROP FUNCTION AAFN_GetUnconditionalDischargeID
GO

DROP FUNCTION FN_GetAgeCatLiteral
GO

DROP FUNCTION FN_GetAgeID
GO

DROP FUNCTION FN_GetATtempt
GO

DROP FUNCTION FN_GetCrimeANswerCONDITIONALDISCHARGE
GO

DROP FUNCTION FN_GetCrimeANswerConSECutiveConcurrent
GO

DROP FUNCTION FN_GetCrimeANswerDEFINITESENTENCE
GO

DROP FUNCTION FN_GetCrimeANswerEnd
GO

DROP FUNCTION FN_GetCrimeANswerFINE
GO

DROP FUNCTION FN_GetCrimeANswerIntermittentImprisonment
GO

DROP FUNCTION FN_GetCrimeANswerLicensePenalties
GO

DROP FUNCTION FN_GetCrimeANswerPreface
GO

DROP FUNCTION FN_GetCrimeANswerPROBATION
GO

DROP FUNCTION FN_GetCrimeANswerRESTITUTIONREPARATION
GO

DROP FUNCTION FN_GetCrimeANswerSplitSentence
GO

DROP FUNCTION FN_GetCrimeANswerStatePRISON
GO

DROP FUNCTION FN_GetCrimeANswerSURCHARGEVictimAssessmentFee
GO

DROP FUNCTION FN_GetCrimeANswerTransition
GO

DROP FUNCTION FN_GetCrimeANswerUNCONDTIONALDISCHARGE
GO

DROP FUNCTION FN_GetCrimeIDfromLawOrdinal
GO

DROP FUNCTION FN_GetFelonyCatLiteral
GO

DROP FUNCTION FN_GetFelonyLevel
GO

DROP FUNCTION FN_GetPastCOnvLiteral
GO

DROP FUNCTION FN_GetPreviousCon
GO

DROP FUNCTION FN_GetSpecialPopupText
GO

DROP FUNCTION FN_GetTrueFalse
GO
