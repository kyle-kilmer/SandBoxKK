USE [CrimeTime]
GO
/****** Object:  View [dbo].[CrimeParagraphCount]    Script Date: 02/23/2011 16:41:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CrimeParagraphCount]
AS
SELECT     TOP (10) dbo.tblCrimes.full_law_description, dbo.tblCrimes.title, dbo.tblCrimes.section, dbo.tblCrimes.subsection, dbo.tblCrimeAnswer.CrimesID, 
                      dbo.tblCrimeAnswer.CrimeAnswerID,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerPreface
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Pref,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerTransition
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS [Tran],
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerStatePrison
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS State,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerDefiniteSentence
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Definite,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerIntermittentImprisonment
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Int,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerProbation
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Probation,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerConditionalDischarge
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS CondDisch,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerSplitSentence
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Split,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerFine
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Fine,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerUnconditionalDischarge
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS UnconDis,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerRestitutionReparation
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Rest,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerSurchargeVictimAssessmentFee
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Surcharge,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerLicensePenalties
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Lisc,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerConsecutiveConcurrent
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS Consec,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.tblCrimeAnswerEnd
                            WHERE      (CrimeAnswer = dbo.tblCrimeAnswer.CrimeAnswerID)) AS [End]
FROM         dbo.tblCrimeAnswer INNER JOIN
                      dbo.tblCrimes ON dbo.tblCrimeAnswer.CrimesID = dbo.tblCrimes.CrimesID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[20] 2[27] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblCrimeAnswer"
            Begin Extent = 
               Top = 7
               Left = 230
               Bottom = 115
               Right = 405
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblCrimes"
            Begin Extent = 
               Top = 6
               Left = 443
               Bottom = 114
               Right = 683
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 1650
         Width = 1815
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 2610
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CrimeParagraphCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CrimeParagraphCount'
GO
/****** Object:  View [dbo].[CrimeIssues]    Script Date: 02/23/2011 16:41:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CrimeIssues]
AS
SELECT     dbo.tblCrimeAnswer.CrimeAnswerID, dbo.tblCrimeAnswer.CrimesID, 
                      CASE dbo.tblCrimeAnswer.AgeCategory WHEN 1 THEN 'Adult' WHEN 2 THEN 'Youth' WHEN 3 THEN 'Juvi' ELSE 'non selected' END AS Age, 
                      CASE dbo.tblCrimeAnswer.FelonyConvictions WHEN 1 THEN 'first offender' WHEN 2 THEN 'second offender now convicted of 1st VFO' WHEN 3 THEN 'second offender now convicted of 2nd VFO'
                       WHEN 4 THEN 'Persistent Violent Offender' ELSE 'non selected' END AS Felony_Sentences, 
                      CASE dbo.tblCrimeAnswer.PastConvictions WHEN 1 THEN 'Zero' WHEN 2 THEN 'one' WHEN 3 THEN 'two or more' ELSE 'non selected' END AS Past_Felony,
                       dbo.tblCrimeAnswer.QuestionID, dbo.tblCrimeAnswer.QuestionsResponse, dbo.tblCrimeAnswer.Attempted, dbo.tblCrimeAnswerIssue.AnswerIssueID, 
                      dbo.tblCrimeAnswerIssue.CrimeAnswerID AS Expr1, dbo.tblCrimeAnswerIssue.Issue, dbo.tblCrimeAnswerIssue.Fixed, 
                      dbo.tblCrimeAnswerIssue.DateFixed, dbo.tblCrimes.CrimesID AS Expr2, dbo.tblCrimes.law_ordinal, 
                      dbo.tblCrimes.title, dbo.tblCrimes.section, dbo.tblCrimes.subsection, dbo.tblCrimes.class, dbo.tblCrimes.nys_law_category,  
                      dbo.tblCrimes.selected_laws_indicator, dbo.tblCrimes.deprecated, dbo.tblCrimes.deprecated_by, dbo.tblCrimes.effective_date, 
                      dbo.tblCrimes.repeal_date, dbo.tblCrimes.jo_indicator, dbo.tblCrimes.attempted_nys_law_category, dbo.tblCrimes.attempted_class, 
                      dbo.tblCrimes.vf_indicator, dbo.tblCrimes.attempted_vf_indicator, dbo.tblCrimes.Viewable
FROM         dbo.tblCrimeAnswer INNER JOIN
                      dbo.tblCrimeAnswerIssue ON dbo.tblCrimeAnswer.CrimeAnswerID = dbo.tblCrimeAnswerIssue.CrimeAnswerID INNER JOIN
                      dbo.tblCrimes ON dbo.tblCrimeAnswer.CrimesID = dbo.tblCrimes.CrimesID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblCrimeAnswer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tblCrimeAnswerIssue"
            Begin Extent = 
               Top = 21
               Left = 332
               Bottom = 129
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblCrimes"
            Begin Extent = 
               Top = 190
               Left = 310
               Bottom = 298
               Right = 534
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 34
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2160
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CrimeIssues'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CrimeIssues'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CrimeIssues'
GO
