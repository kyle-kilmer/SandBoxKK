-- All create table scripts

/*
   Tuesday, December 3, 20134:20:57 PM
   User: 
   Server: 3500MTW81\SQL2008
   Database: CrimeTime
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Answers
	(
	AnswerID int NOT NULL IDENTITY (1, 1),
	sourceID int NULL,
	CategoryID int NULL,
	TopicKey nvarchar(MAX) NULL,
	Literal nvarchar(MAX) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Answers ADD CONSTRAINT
	PK_Answers PRIMARY KEY CLUSTERED 
	(
	AnswerID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT


/*
   Friday, December 6, 201312:33:34 PM
   User: 
   Server: 3500MTW81\SQL2008
   Database: CrimeTime
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.AnswerLinks
	(
	AnswerLinkID int NOT NULL,
	CrimeAnswerID int NOT NULL,
	sourceID int NOT NULL,
	CategoryID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.AnswerLinks ADD CONSTRAINT
	PK_AnswerLinks PRIMARY KEY CLUSTERED 
	(
	AnswerLinkID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.AnswerLinks SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'CONTROL') as Contr_Per 


/* Making AnswerLinkID an identity column */
/*
   Friday, December 6, 201312:36:47 PM
   User: 
   Server: 3500MTW81\SQL2008
   Database: CrimeTime
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_AnswerLinks
	(
	AnswerLinkID int NOT NULL IDENTITY (1, 1),
	CrimeAnswerID int NOT NULL,
	sourceID int NOT NULL,
	CategoryID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_AnswerLinks SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_AnswerLinks ON
GO
IF EXISTS(SELECT * FROM dbo.AnswerLinks)
	 EXEC('INSERT INTO dbo.Tmp_AnswerLinks (AnswerLinkID, CrimeAnswerID, sourceID, CategoryID)
		SELECT AnswerLinkID, CrimeAnswerID, sourceID, CategoryID FROM dbo.AnswerLinks WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_AnswerLinks OFF
GO
DROP TABLE dbo.AnswerLinks
GO
EXECUTE sp_rename N'dbo.Tmp_AnswerLinks', N'AnswerLinks', 'OBJECT' 
GO
ALTER TABLE dbo.AnswerLinks ADD CONSTRAINT
	PK_AnswerLinks PRIMARY KEY CLUSTERED 
	(
	AnswerLinkID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'CONTROL') as Contr_Per 


/* Adding AnswerID column to AnswerLinks table */
/*
   Friday, December 6, 20131:21:43 PM
   User: 
   Server: 3500MTW81\SQL2008
   Database: CrimeTime
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.AnswerLinks ADD
	AnswerID int NULL
GO
ALTER TABLE dbo.AnswerLinks SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'CONTROL') as Contr_Per 



/*
   Tuesday, December 10, 201311:20:44 AM
   User: 
   Server: 3500MTW81\SQL2008
   Database: CrimeTime
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_AnswerLinks
	(
	AnswerLinkID int NOT NULL IDENTITY (1, 1),
	CrimeAnswerID int NOT NULL,
	sourceID int NULL,
	CategoryID int NOT NULL,
	AnswerID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_AnswerLinks SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_AnswerLinks ON
GO
IF EXISTS(SELECT * FROM dbo.AnswerLinks)
	 EXEC('INSERT INTO dbo.Tmp_AnswerLinks (AnswerLinkID, CrimeAnswerID, sourceID, CategoryID, AnswerID)
		SELECT AnswerLinkID, CrimeAnswerID, sourceID, CategoryID, AnswerID FROM dbo.AnswerLinks WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_AnswerLinks OFF
GO
DROP TABLE dbo.AnswerLinks
GO
EXECUTE sp_rename N'dbo.Tmp_AnswerLinks', N'AnswerLinks', 'OBJECT' 
GO
ALTER TABLE dbo.AnswerLinks ADD CONSTRAINT
	PK_AnswerLinks PRIMARY KEY CLUSTERED 
	(
	AnswerLinkID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.AnswerLinks', 'Object', 'CONTROL') as Contr_Per 



/*
   Friday, December 6, 20139:58:25 AM
   User: 
   Server: 3500MTW81\SQL2008
   Database: CrimeTime
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Category
	(
	CategoryID int NOT NULL IDENTITY (1, 1),
	Literal nvarchar(100) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Category ADD CONSTRAINT
	PK_Category PRIMARY KEY CLUSTERED 
	(
	CategoryID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Category SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.Category', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.Category', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.Category', 'Object', 'CONTROL') as Contr_Per 



--Deleting duplicate records from old tables before import
DELETE tblCrimeAnswerCasat
FROM tblCrimeAnswerCasat
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerCasatID) as RowId, CrimeAnswerID, CasatID
                FROM tblCrimeAnswerCasat
                GROUP BY CrimeAnswerID, CasatID
) as KeepRows ON
                tblCrimeAnswerCasat.CrimeAnswerCasatID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerConditionalDischarge
FROM tblCrimeAnswerConditionalDischarge
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerConditionalDischargeID) as RowId, CrimeAnswer, ConditionalDischargeID
                FROM tblCrimeAnswerConditionalDischarge
                GROUP BY CrimeAnswer, ConditionalDischargeID
) as KeepRows ON
                tblCrimeAnswerConditionalDischarge.CrimeAnswerConditionalDischargeID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerConsecutiveConcurrent
FROM tblCrimeAnswerConsecutiveConcurrent
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerConsecutiveConcurrentID) as RowId, CrimeAnswer, ConsecutiveConcurrentID
                FROM tblCrimeAnswerConsecutiveConcurrent
                GROUP BY CrimeAnswer, ConsecutiveConcurrentID
) as KeepRows ON
                tblCrimeAnswerConsecutiveConcurrent.CrimeAnswerConsecutiveConcurrentID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerDefiniteSentence
FROM tblCrimeAnswerDefiniteSentence
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerDefiniteSentenceID) as RowId, CrimeAnswer, DefiniteSentenceID
                FROM tblCrimeAnswerDefiniteSentence
                GROUP BY CrimeAnswer, DefiniteSentenceID
) as KeepRows ON
                tblCrimeAnswerDefiniteSentence.CrimeAnswerDefiniteSentenceID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerEnd
FROM tblCrimeAnswerEnd
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerEndID) as RowId, CrimeAnswer, EndID
                FROM tblCrimeAnswerEnd
                GROUP BY CrimeAnswer, EndID
) as KeepRows ON
                tblCrimeAnswerEnd.CrimeAnswerEndID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerFine
FROM tblCrimeAnswerFine
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerFineID) as RowId, CrimeAnswer, FineID
                FROM tblCrimeAnswerFine
                GROUP BY CrimeAnswer, FineID
) as KeepRows ON
                tblCrimeAnswerFine.CrimeAnswerFineID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerINTERIMPROBATIONSUPERVISION
FROM tblCrimeAnswerINTERIMPROBATIONSUPERVISION
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerINTERIMPROBATIONSUPERVISIONID) as RowId, CrimeAnswerID, INTERIMPROBATIONSUPERVISIONID
                FROM tblCrimeAnswerINTERIMPROBATIONSUPERVISION
                GROUP BY CrimeAnswerID, INTERIMPROBATIONSUPERVISIONID
) as KeepRows ON
                tblCrimeAnswerINTERIMPROBATIONSUPERVISION.CrimeAnswerINTERIMPROBATIONSUPERVISIONID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerIntermittentImprisonment
FROM tblCrimeAnswerIntermittentImprisonment
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerIntermittentImprisonmentID) as RowId, CrimeAnswer, IntermittentImprisonmentID
                FROM tblCrimeAnswerIntermittentImprisonment
                GROUP BY CrimeAnswer, IntermittentImprisonmentID
) as KeepRows ON
                tblCrimeAnswerIntermittentImprisonment.CrimeAnswerIntermittentImprisonmentID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerLicensePenalties
FROM tblCrimeAnswerLicensePenalties
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerLicensePenaltiesID) as RowId, CrimeAnswer, LicensePenaltiesID
                FROM tblCrimeAnswerLicensePenalties
                GROUP BY CrimeAnswer, LicensePenaltiesID
) as KeepRows ON
                tblCrimeAnswerLicensePenalties.CrimeAnswerLicensePenaltiesID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerPreface
FROM tblCrimeAnswerPreface
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerPrefaceID) as RowId, CrimeAnswer, PrefaceID
                FROM tblCrimeAnswerPreface
                GROUP BY CrimeAnswer, PrefaceID
) as KeepRows ON
                tblCrimeAnswerPreface.CrimeAnswerPrefaceID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerProbation
FROM tblCrimeAnswerProbation
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerProbationID) as RowId, CrimeAnswer, ProbationID
                FROM tblCrimeAnswerProbation
                GROUP BY CrimeAnswer, ProbationID
) as KeepRows ON
                tblCrimeAnswerProbation.CrimeAnswerProbationID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerRestitutionReparation
FROM tblCrimeAnswerRestitutionReparation
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerRestitutionReparationID) as RowId, CrimeAnswer, RestitutionReparationID
                FROM tblCrimeAnswerRestitutionReparation
                GROUP BY CrimeAnswer, RestitutionReparationID
) as KeepRows ON
                tblCrimeAnswerRestitutionReparation.CrimeAnswerRestitutionReparationID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerSplitSentence
FROM tblCrimeAnswerSplitSentence
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerSplitSentence) as RowId, CrimeAnswer, SplitSentenceID
                FROM tblCrimeAnswerSplitSentence
                GROUP BY CrimeAnswer, SplitSentenceID
) as KeepRows ON
                tblCrimeAnswerSplitSentence.CrimeAnswerSplitSentence = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerStatePrison
FROM tblCrimeAnswerStatePrison
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerStatePrisonID) as RowId, CrimeAnswer, StatePrisonID
                FROM tblCrimeAnswerStatePrison
                GROUP BY CrimeAnswer, StatePrisonID
) as KeepRows ON
                tblCrimeAnswerStatePrison.CrimeAnswerStatePrisonID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerSurchargeVictimAssessmentFee
FROM tblCrimeAnswerSurchargeVictimAssessmentFee
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerSurchargeVictimAssessmentFeeID) as RowId, CrimeAnswer, SurchargeVictimAssessmentFeeID
                FROM tblCrimeAnswerSurchargeVictimAssessmentFee
                GROUP BY CrimeAnswer, SurchargeVictimAssessmentFeeID
) as KeepRows ON
                tblCrimeAnswerSurchargeVictimAssessmentFee.CrimeAnswerSurchargeVictimAssessmentFeeID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



DELETE tblCrimeAnswerUnconditionalDischarge
FROM tblCrimeAnswerUnconditionalDischarge
LEFT OUTER JOIN (
                SELECT MIN(CrimeAnswerUnconditionalDischargeID) as RowId, CrimeAnswer, UnconditionalDischargeID
                FROM tblCrimeAnswerUnconditionalDischarge
                GROUP BY CrimeAnswer, UnconditionalDischargeID
) as KeepRows ON
                tblCrimeAnswerUnconditionalDischarge.CrimeAnswerUnconditionalDischargeID = KeepRows.RowId
WHERE
                KeepRows.RowId IS NULL



-- All data entry/import scripts

-- Inserting data into Categories Table
Insert Into Category (Literal) Values ('Preface')
Insert Into Category (Literal) Values ('Transition')
Insert Into Category (Literal) Values ('State Prison')
Insert Into Category (Literal) Values ('DefiniteSentence')
Insert Into Category (Literal) Values ('Intermittent Imprisonment')
Insert Into Category (Literal) Values ('Probation')
Insert Into Category (Literal) Values ('Conditional Discharge')
Insert Into Category (Literal) Values ('Split Sentence')
Insert Into Category (Literal) Values ('Fine')
Insert Into Category (Literal) Values ('Unconditional Discharge')
Insert Into Category (Literal) Values ('Restitution/Reparation')
Insert Into Category (Literal) Values ('Surcharge/Victim Assessment Fee')
Insert Into Category (Literal) Values ('License Penalties')
Insert Into Category (Literal) Values ('Consecutive/Concurrent')
Insert Into Category (Literal) Values ('END')
Insert Into Category (Literal) Values ('CASAT')
Insert Into Category (Literal) Values ('Supervised Parole')
Insert Into Category (Literal) Values ('Judicial Diversion')
Insert Into Category (Literal) Values ('Shock')
Insert Into Category (Literal) Values ('Interim Probation Supervision')


-- Importing data into Answers table.
Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select PrefaceID, Literal, PrefaceKey, 1
From tblPreface


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select TransitionID, Literal, TransitionKey, 2
From tblTransition


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select StatePrisonID, Literal, StatePrisonKey, 3
From tblStatePrison


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select DefiniteSentenceID, Literal, DefiniteSentenceKey, 4
From tblDefiniteSentence


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select IntermittentImprisonmentID, Literal, IntermittentImprisonmentKey, 5
From tblIntermittentImprisonment


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select ProbationID, Literal, ProbationKey, 6
From tblProbation


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select ConditionalDischargeID, Literal, ConditionalDischargeKey, 7
From tblConditionalDischarge


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select SplitsentenceID, Literal, SplitsentenceKey, 8
From tblSplitsentence


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select FineID, Literal, FineKey, 9
From tblFine


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select UnconditionalDischargeID, Literal, UnconditionalDischargeKey, 10
From tblUnconditionalDischarge


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select RestitutionReparationID, Literal, RestitutionReparationKey, 11
From tblRestitutionReparation


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select SurchargeVictimAssessmentFeeID, Literal, SurchargeVictimAssessmentFeeKey, 12
From tblSurchargeVictimAssessmentFee


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select LicensePenaltiesID, Literal, LicensePenaltiesKey, 13
From tblLicensePenalties


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select ConsecutiveConcurrentID, Literal, ConsecutiveConcurrentKey, 14
From tblConsecutiveConcurrent


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select EndID, Literal, EndKey, 15
From tblEnd

Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select CASATID, Literal, CASATKey, 16
From tblCASAT

Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select SupervisedParoleID, Literal, SupervisedParoleKey, 17
From tblSupervisedParole


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select JudicialDiversionID, Literal, JudicialDiversionKey, 18
From tblJudicialDiversion


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select ShockID, Literal, ShockKey, 19
From tblShock


Insert Into Answers (sourceID, Literal, TopicKey, CategoryID)
Select InterimProbationSupervisionID, Literal, InterimProbationSupervisionKey, 20
From tblInterimProbationSupervision


-- Importing data into AnswerLinks table
Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerPrefaceID, 1, Answers.AnswerID
From tblCrimeAnswerPreface Inner Join Answers on tblCrimeAnswerPreface.PrefaceID = Answers.sourceID
where Answers.CategoryID = 1;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerTransitionID, 2, Answers.AnswerID
From tblCrimeAnswerTransition Inner Join Answers on tblCrimeAnswerTransition.TransitionID = Answers.sourceID
where Answers.CategoryID = 2;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerStatePrisonID, 3, Answers.AnswerID
From tblCrimeAnswerStatePrison Inner Join Answers on StatePrisonID = sourceID
where Answers.CategoryID = 3;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerDefiniteSentenceID, 4, Answers.AnswerID
From tblCrimeAnswerDefiniteSentence Inner Join Answers on tblCrimeAnswerDefiniteSentence.DefiniteSentenceID = Answers.sourceID
where Answers.CategoryID = 4;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerIntermittentImprisonmentID, 5, Answers.AnswerID
From tblCrimeAnswerIntermittentImprisonment Inner Join Answers on tblCrimeAnswerIntermittentImprisonment.IntermittentImprisonmentID = Answers.sourceID
where Answers.CategoryID = 5;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerProbationID, 6, Answers.AnswerID
From tblCrimeAnswerProbation Inner Join Answers on tblCrimeAnswerProbation.ProbationID = Answers.sourceID
where Answers.CategoryID = 6;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerConditionalDischargeID, 7, Answers.AnswerID
From tblCrimeAnswerConditionalDischarge Inner Join Answers on tblCrimeAnswerConditionalDischarge.ConditionalDischargeID = Answers.sourceID
where Answers.CategoryID = 7;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerSplitsentence, 8, Answers.AnswerID
From tblCrimeAnswerSplitsentence Inner Join Answers on tblCrimeAnswerSplitsentence.SplitSentenceID = Answers.sourceID
where Answers.CategoryID = 8;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerFineID, 9, Answers.AnswerID
From tblCrimeAnswerFine Inner Join Answers on tblCrimeAnswerFine.FineID = Answers.sourceID
where Answers.CategoryID = 9;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerUnconditionalDischargeID, 10, Answers.AnswerID
From tblCrimeAnswerUnconditionalDischarge Inner Join Answers on tblCrimeAnswerUnconditionalDischarge.UnconditionalDischargeID = Answers.sourceID
where Answers.CategoryID = 10;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerRestitutionReparationID, 11, Answers.AnswerID
From tblCrimeAnswerRestitutionReparation Inner Join Answers on tblCrimeAnswerRestitutionReparation.RestitutionReparationID = Answers.sourceID
where Answers.CategoryID = 11;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerSurchargeVictimAssessmentFeeID, 12, Answers.AnswerID
From tblCrimeAnswerSurchargeVictimAssessmentFee Inner Join Answers on tblCrimeAnswerSurchargeVictimAssessmentFee.SurchargeVictimAssessmentFeeID = Answers.sourceID
where Answers.CategoryID = 12;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerLicensePenaltiesID, 13, LicensePenaltiesID
From tblCrimeAnswerLicensePenalties Inner Join Answers on tblCrimeAnswerLicensePenalties.LicensePenaltiesID = Answers.sourceID
where Answers.CategoryID = 13;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerConsecutiveConcurrentID, 14, Answers.AnswerID
From tblCrimeAnswerConsecutiveConcurrent Inner Join Answers on tblCrimeAnswerConsecutiveConcurrent.ConsecutiveConcurrentID = Answers.sourceID
where Answers.CategoryID = 14;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswer, CrimeAnswerEndID, 15, Answers.AnswerID
From tblCrimeAnswerEnd Inner Join Answers on tblCrimeAnswerEnd.EndID = Answers.sourceID
where Answers.CategoryID = 15;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select distinct CrimeAnswerID, CrimeAnswerCASATID, 16, Answers.AnswerID
From tblCrimeAnswerCASAT Inner Join Answers on tblCrimeAnswerCASAT.CASATID = Answers.sourceID
where Answers.CategoryID = 16;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select CrimeAnswerid, CrimeAnswerSupervisedParoleID, 17, Answers.AnswerID
From tblCrimeAnswerSupervisedParole Inner Join Answers on tblCrimeAnswerSupervisedParole.SupervisedParoleID = Answers.sourceID
where Answers.CategoryID = 17;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select distinct CrimeAnswerID, CrimeAnswerJudicialDiversionID, 18, Answers.AnswerID
From tblCrimeAnswerJudicialDiversion Inner Join Answers on tblCrimeAnswerJudicialDiversion.JudicialDiversionID = Answers.sourceID
where Answers.CategoryID = 18;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select distinct CrimeAnswerID, CrimeAnswerShockID, 19, Answers.AnswerID
From tblCrimeAnswerShock Inner Join Answers on tblCrimeAnswerShock.ShockID = Answers.sourceID
where Answers.CategoryID = 19;

Insert Into AnswerLinks (CrimeAnswerID, sourceID, CategoryID, AnswerID)
Select distinct CrimeAnswerID, CrimeAnswerInterimProbationSupervisionID, 20, Answers.AnswerID
From tblCrimeAnswerInterimProbationSupervision Inner Join Answers on tblCrimeAnswerInterimProbationSupervision.InterimProbationSupervisionID = Answers.sourceID
where Answers.CategoryID = 20;