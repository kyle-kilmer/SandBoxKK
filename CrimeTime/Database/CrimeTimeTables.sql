USE [CrimeTime]
GO
/****** Object:  Table [dbo].[tblCASAT]    Script Date: 02/23/2011 16:34:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCASAT](
	[CASATID] [int] IDENTITY(1,1) NOT NULL,
	[CasatKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblCASAT] PRIMARY KEY CLUSTERED 
(
	[CASATID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimes]    Script Date: 02/23/2011 16:35:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimes](
	[CrimesID] [int] IDENTITY(1,1) NOT NULL,
	[law_ordinal] [int] NULL,
	[full_law_description] [nvarchar](max) NULL,
	[title] [nvarchar](3) NULL,
	[section] [nvarchar](9) NULL,
	[subsection] [nvarchar](12) NULL,
	[class] [nvarchar](4) NULL,
	[nys_law_category] [nvarchar](1000) NULL,
	[statute] [nvarchar](max) NULL,
	[selected_laws_indicator] [bit] NULL,
	[deprecated] [bit] NULL,
	[deprecated_by] [nvarchar](12) NULL,
	[effective_date] [datetime] NULL,
	[repeal_date] [datetime] NULL,
	[jo_indicator] [int] NULL,
	[attempted_nys_law_category] [nvarchar](1) NULL,
	[attempted_class] [nvarchar](4) NULL,
	[vf_indicator] [nvarchar](4) NULL,
	[attempted_vf_indicator] [nvarchar](4) NULL,
	[Viewable] [bit] NULL CONSTRAINT [DF_tblCrimes_Viewable]  DEFAULT ((0)),
	[original_full_law_description] [nvarchar](max) NULL,
 CONSTRAINT [PK__tblCrimes__76B698BF] PRIMARY KEY CLUSTERED 
(
	[CrimesID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSupervisedParole]    Script Date: 02/23/2011 16:36:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSupervisedParole](
	[SupervisedParoleID] [int] IDENTITY(1,1) NOT NULL,
	[SupervisedParoleKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblSupervisedParole] PRIMARY KEY CLUSTERED 
(
	[SupervisedParoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblEmailAddress]    Script Date: 02/23/2011 16:35:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmailAddress](
	[EmailAddressID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](150) NULL,
	[EmailDate] [datetime] NULL,
 CONSTRAINT [PK_tblEmailAddress] PRIMARY KEY CLUSTERED 
(
	[EmailAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblShock]    Script Date: 02/23/2011 16:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblShock](
	[ShockID] [int] IDENTITY(1,1) NOT NULL,
	[ShockKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblShock] PRIMARY KEY CLUSTERED 
(
	[ShockID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAgeCategory]    Script Date: 02/23/2011 16:34:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAgeCategory](
	[AgeCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Literal] [nvarchar](100) NULL,
 CONSTRAINT [PK_tblAgeCategory] PRIMARY KEY CLUSTERED 
(
	[AgeCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblJudicialDiversion]    Script Date: 02/23/2011 16:35:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblJudicialDiversion](
	[JudicialDiversionID] [int] IDENTITY(1,1) NOT NULL,
	[JudicialDiversionKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblJudicialDiversion] PRIMARY KEY CLUSTERED 
(
	[JudicialDiversionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPastConvictions]    Script Date: 02/23/2011 16:36:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPastConvictions](
	[PastConvictionsID] [int] IDENTITY(1,1) NOT NULL,
	[Literal] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblPastConvictions] PRIMARY KEY CLUSTERED 
(
	[PastConvictionsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblINTERIMPROBATIONSUPERVISION]    Script Date: 02/23/2011 16:35:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblINTERIMPROBATIONSUPERVISION](
	[INTERIMPROBATIONSUPERVISIONID] [int] IDENTITY(1,1) NOT NULL,
	[INTERIMPROBATIONSUPERVISIONKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblINTERIMPROBATIONSUPERVISION] PRIMARY KEY CLUSTERED 
(
	[INTERIMPROBATIONSUPERVISIONID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFelonyConvictions]    Script Date: 02/23/2011 16:35:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFelonyConvictions](
	[FelonyConvictionsID] [int] IDENTITY(1,1) NOT NULL,
	[Literal] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblFelonyConvictions] PRIMARY KEY CLUSTERED 
(
	[FelonyConvictionsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPreface]    Script Date: 02/23/2011 16:36:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPreface](
	[PrefaceID] [int] IDENTITY(1,1) NOT NULL,
	[PrefaceKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblPreface] PRIMARY KEY CLUSTERED 
(
	[PrefaceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTransition]    Script Date: 02/23/2011 16:36:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTransition](
	[TransitionID] [int] IDENTITY(1,1) NOT NULL,
	[TransitionKey] [nvarchar](50) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblTransition] PRIMARY KEY CLUSTERED 
(
	[TransitionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStatePrison]    Script Date: 02/23/2011 16:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatePrison](
	[StatePrisonID] [int] IDENTITY(1,1) NOT NULL,
	[StatePrisonKey] [nvarchar](50) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblState Prison] PRIMARY KEY CLUSTERED 
(
	[StatePrisonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDefiniteSentence]    Script Date: 02/23/2011 16:35:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDefiniteSentence](
	[DefiniteSentenceID] [int] IDENTITY(1,1) NOT NULL,
	[DefiniteSentenceKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblDefiniteSentence] PRIMARY KEY CLUSTERED 
(
	[DefiniteSentenceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewCrimeSpreadsheet]    Script Date: 02/23/2011 16:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewCrimeSpreadsheet](
	[lawordinal] [nvarchar](4000) NULL,
	[CrimeName] [nvarchar](4000) NULL,
	[Cite] [nvarchar](4000) NULL,
	[Level] [nvarchar](4000) NULL,
	[Attempt] [nvarchar](4000) NULL,
	[Age] [nvarchar](4000) NULL,
	[PastConvictions] [nvarchar](4000) NULL,
	[FelonyLevel] [nvarchar](4000) NULL,
	[Preface] [nvarchar](4000) NULL,
	[Transition] [nvarchar](4000) NULL,
	[StatePolice] [nvarchar](4000) NULL,
	[DefSentence] [nvarchar](4000) NULL,
	[Interm] [nvarchar](4000) NULL,
	[Probation] [nvarchar](4000) NULL,
	[Conditional] [nvarchar](4000) NULL,
	[Split] [nvarchar](4000) NULL,
	[Fine] [nvarchar](4000) NULL,
	[Unconditional] [nvarchar](4000) NULL,
	[Restitution] [nvarchar](4000) NULL,
	[Surcharge] [nvarchar](4000) NULL,
	[License] [nvarchar](4000) NULL,
	[Consec] [nvarchar](4000) NULL,
	[End] [nvarchar](4000) NULL,
	[End2] [nvarchar](4000) NULL,
	[End3] [nvarchar](4000) NULL,
	[End4] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLawTitle]    Script Date: 02/23/2011 16:35:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLawTitle](
	[LawTitleID] [int] IDENTITY(1,1) NOT NULL,
	[abbreviation] [nvarchar](15) NULL,
	[Literal] [nvarchar](100) NULL,
 CONSTRAINT [PK_tblLawTitle] PRIMARY KEY CLUSTERED 
(
	[LawTitleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[druglawchanges07132009]    Script Date: 02/23/2011 16:32:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[druglawchanges07132009](
	[TempID] [int] IDENTITY(1,1) NOT NULL,
	[Literal] [nvarchar](150) NULL,
 CONSTRAINT [PK_07132009druglawchanges] PRIMARY KEY CLUSTERED 
(
	[TempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSpecialPopUps]    Script Date: 02/23/2011 16:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSpecialPopUps](
	[SpecialPopUpsID] [int] IDENTITY(1,1) NOT NULL,
	[Literal] [nvarchar](max) NULL,
	[Reason] [nvarchar](150) NULL,
 CONSTRAINT [PK_tblSpecialPopUps] PRIMARY KEY CLUSTERED 
(
	[SpecialPopUpsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 02/23/2011 16:36:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](25) NULL,
	[LastName] [nvarchar](25) NULL,
	[Middle] [nvarchar](2) NULL,
	[Suffix] [nvarchar](50) NULL,
	[Password] [nvarchar](15) NULL,
	[Username] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Address2] [nvarchar](150) NULL,
	[Zipcode] [nvarchar](10) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Title] [nvarchar](50) NULL,
	[Office] [nvarchar](50) NULL,
	[Department] [nvarchar](150) NULL,
	[ADALength] [decimal](18, 2) NULL,
	[City] [nvarchar](50) NULL,
	[IsAdmin] [bit] NOT NULL CONSTRAINT [DF_tblUser_IsAdmin]  DEFAULT ((0)),
	[CountyID] [int] NULL,
	[StateID] [int] NULL,
	[NewlyAdmitted] [bit] NULL,
	[CourseOwner] [bit] NOT NULL CONSTRAINT [DF_tblUser_CourseOwner]  DEFAULT ((0)),
	[SupervisorName] [nvarchar](50) NULL,
	[SupervisorPhone] [nvarchar](50) NULL,
	[SupervisorEmail] [nvarchar](50) NULL,
	[DateApplied] [datetime] NULL,
	[DateApproved] [datetime] NULL,
	[PasswordChange] [bit] NULL CONSTRAINT [DF_tblUser_PasswordChange]  DEFAULT ((0)),
	[DateDenied] [datetime] NULL,
	[ByWho] [int] NULL,
	[DenialReason] [nvarchar](1000) NULL,
	[ActiveUser] [bit] NOT NULL CONSTRAINT [DF_tblUser_ActiveUser]  DEFAULT ((1)),
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[drugchangestable2]    Script Date: 02/23/2011 16:32:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[drugchangestable2](
	[TempID] [int] IDENTITY(1,1) NOT NULL,
	[CAID] [int] NULL,
	[SentencingAttachment] [nvarchar](max) NULL,
 CONSTRAINT [PK_drugchangestable2] PRIMARY KEY CLUSTERED 
(
	[TempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewCrimeSpreadsheet2]    Script Date: 02/23/2011 16:33:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewCrimeSpreadsheet2](
	[lawordinal] [nvarchar](4000) NULL,
	[CrimeName] [nvarchar](4000) NULL,
	[Cite] [nvarchar](4000) NULL,
	[Level] [nvarchar](4000) NULL,
	[Attempt] [nvarchar](4000) NULL,
	[Age] [nvarchar](4000) NULL,
	[PastConvictions] [nvarchar](4000) NULL,
	[FelonyLevel] [nvarchar](4000) NULL,
	[Preface] [nvarchar](4000) NULL,
	[Transition] [nvarchar](4000) NULL,
	[StatePolice] [nvarchar](4000) NULL,
	[DefSentence] [nvarchar](4000) NULL,
	[Interm] [nvarchar](4000) NULL,
	[Probation] [nvarchar](4000) NULL,
	[Conditional] [nvarchar](4000) NULL,
	[Split] [nvarchar](4000) NULL,
	[Fine] [nvarchar](4000) NULL,
	[Unconditional] [nvarchar](4000) NULL,
	[Restitution] [nvarchar](4000) NULL,
	[Surcharge] [nvarchar](4000) NULL,
	[License] [nvarchar](4000) NULL,
	[Consec] [nvarchar](4000) NULL,
	[End] [nvarchar](4000) NULL,
	[End2] [nvarchar](4000) NULL,
	[End3] [nvarchar](4000) NULL,
	[End4] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDBInfo]    Script Date: 02/23/2011 16:35:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDBInfo](
	[version] [nvarchar](20) NULL,
	[date] [smalldatetime] NULL,
	[Disclaimer] [nvarchar](max) NULL,
	[codedVersion] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblParagraphs]    Script Date: 02/23/2011 16:35:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblParagraphs](
	[ParagraphsID] [int] IDENTITY(1,1) NOT NULL,
	[Literal] [nvarchar](100) NULL,
 CONSTRAINT [PK_tblParagraphs] PRIMARY KEY CLUSTERED 
(
	[ParagraphsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewCrimeSpreadsheet3]    Script Date: 02/23/2011 16:33:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewCrimeSpreadsheet3](
	[lawordinal] [nvarchar](4000) NULL,
	[CrimeName] [nvarchar](4000) NULL,
	[Cite] [nvarchar](4000) NULL,
	[Level] [nvarchar](4000) NULL,
	[Attempt] [nvarchar](4000) NULL,
	[Age] [nvarchar](4000) NULL,
	[PastConvictions] [nvarchar](4000) NULL,
	[FelonyLevel] [nvarchar](4000) NULL,
	[Preface] [nvarchar](4000) NULL,
	[Transition] [nvarchar](4000) NULL,
	[StatePolice] [nvarchar](4000) NULL,
	[DefSentence] [nvarchar](4000) NULL,
	[Interm] [nvarchar](4000) NULL,
	[Probation] [nvarchar](4000) NULL,
	[Probation2] [nvarchar](4000) NULL,
	[Conditional] [nvarchar](4000) NULL,
	[Split] [nvarchar](4000) NULL,
	[Fine] [nvarchar](4000) NULL,
	[Unconditional] [nvarchar](4000) NULL,
	[Restitution] [nvarchar](4000) NULL,
	[Surcharge] [nvarchar](4000) NULL,
	[License] [nvarchar](4000) NULL,
	[Consec] [nvarchar](4000) NULL,
	[End] [nvarchar](4000) NULL,
	[End2] [nvarchar](4000) NULL,
	[End3] [nvarchar](4000) NULL,
	[End4] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewCrimeSpreadsheet4]    Script Date: 02/23/2011 16:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewCrimeSpreadsheet4](
	[lawordinal] [nvarchar](4000) NULL,
	[CrimeName] [nvarchar](4000) NULL,
	[Cite] [nvarchar](4000) NULL,
	[Level] [nvarchar](4000) NULL,
	[Attempt] [nvarchar](4000) NULL,
	[Age] [nvarchar](4000) NULL,
	[PastConvictions] [nvarchar](4000) NULL,
	[FelonyLevel] [nvarchar](4000) NULL,
	[Preface] [nvarchar](4000) NULL,
	[Transition] [nvarchar](4000) NULL,
	[StatePolice] [nvarchar](4000) NULL,
	[DefSentence] [nvarchar](4000) NULL,
	[Interm] [nvarchar](4000) NULL,
	[Probation] [nvarchar](4000) NULL,
	[Conditional] [nvarchar](4000) NULL,
	[Split] [nvarchar](4000) NULL,
	[Fine] [nvarchar](4000) NULL,
	[Unconditional] [nvarchar](4000) NULL,
	[Restitution] [nvarchar](4000) NULL,
	[Surcharge] [nvarchar](4000) NULL,
	[License] [nvarchar](4000) NULL,
	[Consec] [nvarchar](4000) NULL,
	[End] [nvarchar](4000) NULL,
	[End2] [nvarchar](4000) NULL,
	[End3] [nvarchar](4000) NULL,
	[End4] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewCrime130sSpreadsheet]    Script Date: 02/23/2011 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewCrime130sSpreadsheet](
	[lawordinal] [nvarchar](4000) NULL,
	[CrimeName] [nvarchar](4000) NULL,
	[Cite] [nvarchar](4000) NULL,
	[Level] [nvarchar](4000) NULL,
	[Attempt] [nvarchar](4000) NULL,
	[Age] [nvarchar](4000) NULL,
	[PastConvictions] [nvarchar](4000) NULL,
	[FelonyLevel] [nvarchar](4000) NULL,
	[Preface] [nvarchar](4000) NULL,
	[Preface2] [nvarchar](4000) NULL,
	[Transition] [nvarchar](4000) NULL,
	[StatePolice] [nvarchar](4000) NULL,
	[DefSentence] [nvarchar](4000) NULL,
	[Interm] [nvarchar](4000) NULL,
	[Probation] [nvarchar](4000) NULL,
	[Probation2] [nvarchar](4000) NULL,
	[Conditional] [nvarchar](4000) NULL,
	[Split] [nvarchar](4000) NULL,
	[Fine] [nvarchar](4000) NULL,
	[Unconditional] [nvarchar](4000) NULL,
	[Restitution] [nvarchar](4000) NULL,
	[Surcharge] [nvarchar](4000) NULL,
	[License] [nvarchar](4000) NULL,
	[Consec] [nvarchar](4000) NULL,
	[Consec2] [nvarchar](4000) NULL,
	[Consec3] [nvarchar](4000) NULL,
	[End] [nvarchar](4000) NULL,
	[End2] [nvarchar](4000) NULL,
	[End3] [nvarchar](4000) NULL,
	[End4] [nvarchar](4000) NULL,
	[End5] [nvarchar](4000) NULL,
	[End6] [nvarchar](4000) NULL,
	[End7] [nvarchar](4000) NULL,
	[End8] [nvarchar](4000) NULL,
	[End9] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSpecialQuestions]    Script Date: 02/23/2011 16:36:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSpecialQuestions](
	[SpecialQuestionsID] [int] IDENTITY(1,1) NOT NULL,
	[Short] [nvarchar](50) NULL,
	[Literal] [nvarchar](500) NULL,
	[Criteria] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblSpecialQuestions] PRIMARY KEY CLUSTERED 
(
	[SpecialQuestionsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLawCategory]    Script Date: 02/23/2011 16:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLawCategory](
	[LawCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Short] [nvarchar](50) NULL,
	[Literal] [nvarchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeUpdate]    Script Date: 02/23/2011 16:35:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeUpdate](
	[CrimeUpdateID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeVersion] [nvarchar](50) NULL,
	[CrimeUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_tblCrimeUpdate] PRIMARY KEY CLUSTERED 
(
	[CrimeUpdateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KaylaSpreadsheet]    Script Date: 02/23/2011 16:33:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KaylaSpreadsheet](
	[lawordinal] [nvarchar](4000) NULL,
	[UseThis] [nvarchar](4000) NULL,
	[CrimeName] [nvarchar](4000) NULL,
	[Cite] [nvarchar](4000) NULL,
	[Level] [nvarchar](4000) NULL,
	[Attempt] [nvarchar](4000) NULL,
	[Age] [nvarchar](4000) NULL,
	[PastConvictions] [nvarchar](4000) NULL,
	[FelonyLevel] [nvarchar](4000) NULL,
	[Preface] [nvarchar](4000) NULL,
	[Preface2] [nvarchar](4000) NULL,
	[Transition] [nvarchar](4000) NULL,
	[StatePolice] [nvarchar](4000) NULL,
	[StatePolice2] [nvarchar](4000) NULL,
	[DefSentence] [nvarchar](4000) NULL,
	[DefSentence2] [nvarchar](4000) NULL,
	[Interm] [nvarchar](4000) NULL,
	[Interm2] [nvarchar](4000) NULL,
	[Probation] [nvarchar](4000) NULL,
	[Probation2] [nvarchar](4000) NULL,
	[Conditional] [nvarchar](4000) NULL,
	[Conditional2] [nvarchar](4000) NULL,
	[Split] [nvarchar](4000) NULL,
	[Split2] [nvarchar](4000) NULL,
	[Fine] [nvarchar](4000) NULL,
	[Fine2] [nvarchar](4000) NULL,
	[Unconditional] [nvarchar](4000) NULL,
	[Unconditional2] [nvarchar](4000) NULL,
	[Restitution] [nvarchar](4000) NULL,
	[Restitution2] [nvarchar](4000) NULL,
	[Surcharge] [nvarchar](4000) NULL,
	[Surcharge2] [nvarchar](4000) NULL,
	[License] [nvarchar](4000) NULL,
	[License2] [nvarchar](4000) NULL,
	[Consec] [nvarchar](4000) NULL,
	[Consec2] [nvarchar](4000) NULL,
	[End] [nvarchar](4000) NULL,
	[End2] [nvarchar](4000) NULL,
	[End3] [nvarchar](4000) NULL,
	[End4] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL,
	[ro_num] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_KaylaSpreadsheet] PRIMARY KEY CLUSTERED 
(
	[ro_num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OldCrimesManualSpreadsheet]    Script Date: 02/23/2011 16:34:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OldCrimesManualSpreadsheet](
	[lawordinal] [nvarchar](4000) NULL,
	[UseThis] [nvarchar](4000) NULL,
	[CrimeName] [nvarchar](4000) NULL,
	[Cite] [nvarchar](4000) NULL,
	[Level] [nvarchar](4000) NULL,
	[Attempt] [nvarchar](4000) NULL,
	[Age] [nvarchar](4000) NULL,
	[PastConvictions] [nvarchar](4000) NULL,
	[FelonyLevel] [nvarchar](4000) NULL,
	[Preface] [nvarchar](4000) NULL,
	[Preface2] [nvarchar](4000) NULL,
	[Transition] [nvarchar](4000) NULL,
	[StatePolice] [nvarchar](4000) NULL,
	[StatePolice2] [nvarchar](4000) NULL,
	[DefSentence] [nvarchar](4000) NULL,
	[DefSentence2] [nvarchar](4000) NULL,
	[Interm] [nvarchar](4000) NULL,
	[Interm2] [nvarchar](4000) NULL,
	[Probation] [nvarchar](4000) NULL,
	[Probation2] [nvarchar](4000) NULL,
	[Conditional] [nvarchar](4000) NULL,
	[Conditional2] [nvarchar](4000) NULL,
	[Split] [nvarchar](4000) NULL,
	[Split2] [nvarchar](4000) NULL,
	[Fine] [nvarchar](4000) NULL,
	[Fine2] [nvarchar](4000) NULL,
	[Unconditional] [nvarchar](4000) NULL,
	[Unconditional2] [nvarchar](4000) NULL,
	[Restitution] [nvarchar](4000) NULL,
	[Restitution2] [nvarchar](4000) NULL,
	[Surcharge] [nvarchar](4000) NULL,
	[Surcharge2] [nvarchar](4000) NULL,
	[License] [nvarchar](4000) NULL,
	[License2] [nvarchar](4000) NULL,
	[Consec] [nvarchar](4000) NULL,
	[Consec2] [nvarchar](4000) NULL,
	[End] [nvarchar](4000) NULL,
	[End2] [nvarchar](4000) NULL,
	[End3] [nvarchar](4000) NULL,
	[End4] [nvarchar](4000) NULL,
	[Comments] [nvarchar](4000) NULL,
	[ro_num] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_OldCrimesManualSpreadsheet] PRIMARY KEY CLUSTERED 
(
	[ro_num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMitigatingFactorQuestions]    Script Date: 02/23/2011 16:35:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMitigatingFactorQuestions](
	[MitigatingFactorQuestionsID] [int] IDENTITY(1,1) NOT NULL,
	[Short] [nvarchar](100) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblMitigatingFactorQuestions] PRIMARY KEY CLUSTERED 
(
	[MitigatingFactorQuestionsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswer]    Script Date: 02/23/2011 16:34:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswer](
	[CrimeAnswerID] [int] IDENTITY(1,1) NOT NULL,
	[CrimesID] [int] NULL,
	[AgeCategory] [int] NULL,
	[FelonyConvictions] [int] NULL,
	[PastConvictions] [int] NULL,
	[QuestionID] [int] NULL,
	[QuestionsResponse] [bit] NULL,
	[Attempted] [bit] NULL,
 CONSTRAINT [PK_CrimeAnswer] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblIntermittentImprisonment]    Script Date: 02/23/2011 16:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblIntermittentImprisonment](
	[IntermittentImprisonmentID] [int] IDENTITY(1,1) NOT NULL,
	[IntermittentImprisonmentKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblIntermittentImprisonment] PRIMARY KEY CLUSTERED 
(
	[IntermittentImprisonmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProbation]    Script Date: 02/23/2011 16:36:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProbation](
	[ProbationID] [int] IDENTITY(1,1) NOT NULL,
	[ProbationKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblProbation] PRIMARY KEY CLUSTERED 
(
	[ProbationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblConditionalDischarge]    Script Date: 02/23/2011 16:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblConditionalDischarge](
	[ConditionalDischargeID] [int] IDENTITY(1,1) NOT NULL,
	[ConditionalDischargeKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblConditionalDishcarge] PRIMARY KEY CLUSTERED 
(
	[ConditionalDischargeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSplitsentence]    Script Date: 02/23/2011 16:36:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSplitsentence](
	[SplitsentenceID] [int] IDENTITY(1,1) NOT NULL,
	[SplitsentenceKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblSplitsentence] PRIMARY KEY CLUSTERED 
(
	[SplitsentenceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFine]    Script Date: 02/23/2011 16:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFine](
	[FineID] [int] IDENTITY(1,1) NOT NULL,
	[FineKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblFine] PRIMARY KEY CLUSTERED 
(
	[FineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUnconditionalDischarge]    Script Date: 02/23/2011 16:36:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUnconditionalDischarge](
	[UnconditionalDischargeID] [int] IDENTITY(1,1) NOT NULL,
	[UnconditionalDischargeKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblUnconditionalDischarge] PRIMARY KEY CLUSTERED 
(
	[UnconditionalDischargeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLawClass]    Script Date: 02/23/2011 16:35:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLawClass](
	[LawClassID] [int] IDENTITY(1,1) NOT NULL,
	[Short] [nvarchar](4) NULL,
	[Literal] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRestitutionReparation]    Script Date: 02/23/2011 16:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRestitutionReparation](
	[RestitutionReparationID] [int] IDENTITY(1,1) NOT NULL,
	[RestitutionReparationKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblRestitutionReparation] PRIMARY KEY CLUSTERED 
(
	[RestitutionReparationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSurchargeVictimAssessmentFee]    Script Date: 02/23/2011 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSurchargeVictimAssessmentFee](
	[SurchargeVictimAssessmentFeeID] [int] IDENTITY(1,1) NOT NULL,
	[SurchargeVictimAssessmentFeeKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblSurchargeVictimAssessmentFee] PRIMARY KEY CLUSTERED 
(
	[SurchargeVictimAssessmentFeeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLicensePenalties]    Script Date: 02/23/2011 16:35:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLicensePenalties](
	[LicensePenaltiesID] [int] IDENTITY(1,1) NOT NULL,
	[LicensePenaltiesKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblLiscensePenalties] PRIMARY KEY CLUSTERED 
(
	[LicensePenaltiesID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblConsecutiveConcurrent]    Script Date: 02/23/2011 16:34:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblConsecutiveConcurrent](
	[ConsecutiveConcurrentID] [int] IDENTITY(1,1) NOT NULL,
	[ConsecutiveConcurrentKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblConsecutiveConcurrent] PRIMARY KEY CLUSTERED 
(
	[ConsecutiveConcurrentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblEnd]    Script Date: 02/23/2011 16:35:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEnd](
	[EndID] [int] IDENTITY(1,1) NOT NULL,
	[EndKey] [nvarchar](150) NULL,
	[Literal] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblEnd] PRIMARY KEY CLUSTERED 
(
	[EndID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblQuestions]    Script Date: 02/23/2011 16:36:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblQuestions](
	[QuestionsID] [int] IDENTITY(1,1) NOT NULL,
	[Literal] [nvarchar](500) NULL,
 CONSTRAINT [PK_tblQuestions] PRIMARY KEY CLUSTERED 
(
	[QuestionsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerCasat]    Script Date: 02/23/2011 16:34:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerCasat](
	[CrimeAnswerCasatID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswerID] [int] NULL,
	[CasatID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerCasat] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerCasatID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimesSpecialPopups]    Script Date: 02/23/2011 16:35:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimesSpecialPopups](
	[CrimesSpecialPopupsID] [int] IDENTITY(1,1) NOT NULL,
	[CrimesID] [int] NULL,
	[SpecialPopUpsID] [int] NULL,
 CONSTRAINT [PK_tblCrimesSpecialPopups] PRIMARY KEY CLUSTERED 
(
	[CrimesSpecialPopupsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimesMitigatingFactorQuestions]    Script Date: 02/23/2011 16:35:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimesMitigatingFactorQuestions](
	[CrimesMitigatingFactorQuestionsID] [int] IDENTITY(1,1) NOT NULL,
	[MitigatingFactorQuestionsID] [int] NULL,
	[AgeCategory] [int] NULL,
	[CrimesID] [int] NULL,
 CONSTRAINT [PK_tblCrimesMitigatingFactorQuestions] PRIMARY KEY CLUSTERED 
(
	[CrimesMitigatingFactorQuestionsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerSupervisedParole]    Script Date: 02/23/2011 16:35:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerSupervisedParole](
	[CrimeAnswerSupervisedParoleID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswerid] [int] NULL,
	[SupervisedParoleID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerSupervisedParole] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerSupervisedParoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerIssue]    Script Date: 02/23/2011 16:34:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerIssue](
	[AnswerIssueID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswerID] [int] NULL,
	[Issue] [nvarchar](500) NULL,
	[Fixed] [bit] NULL,
	[DateFixed] [datetime] NULL,
	[DateReported] [datetime] NULL,
	[EmailAddressID] [int] NULL,
 CONSTRAINT [PK_tblAnswerIssue] PRIMARY KEY CLUSTERED 
(
	[AnswerIssueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerShock]    Script Date: 02/23/2011 16:35:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerShock](
	[CrimeAnswerShockID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswerID] [int] NULL,
	[ShockID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerShock] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerShockID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerJudicialDiversion]    Script Date: 02/23/2011 16:34:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerJudicialDiversion](
	[CrimeAnswerJudicialDiversionID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswerID] [int] NULL,
	[JudicialDiversionID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerJudicialDiversion] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerJudicialDiversionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerINTERIMPROBATIONSUPERVISION]    Script Date: 02/23/2011 16:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerINTERIMPROBATIONSUPERVISION](
	[CrimeAnswerINTERIMPROBATIONSUPERVISIONID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswerID] [int] NULL,
	[INTERIMPROBATIONSUPERVISIONID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerINTERIMPROBATIONSUPERVISION] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerINTERIMPROBATIONSUPERVISIONID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerPreface]    Script Date: 02/23/2011 16:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerPreface](
	[CrimeAnswerPrefaceID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[PrefaceID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerPreface] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerPrefaceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerTransition]    Script Date: 02/23/2011 16:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerTransition](
	[CrimeAnswerTransitionID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[TransitionID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerTransition] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerTransitionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerStatePrison]    Script Date: 02/23/2011 16:35:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerStatePrison](
	[CrimeAnswerStatePrisonID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[StatePrisonID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerStatePrison] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerStatePrisonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerDefiniteSentence]    Script Date: 02/23/2011 16:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerDefiniteSentence](
	[CrimeAnswerDefiniteSentenceID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[DefiniteSentenceID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerDefiniteSentence] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerDefiniteSentenceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSpecialQuestionsParagraphs]    Script Date: 02/23/2011 16:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSpecialQuestionsParagraphs](
	[SpecialQuestionsParagraphsID] [int] IDENTITY(1,1) NOT NULL,
	[SpecialQuestionsID] [int] NULL,
	[ParagraphsID] [int] NULL,
	[ParagraphKey] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblSpecialQuestionsParagraphs] PRIMARY KEY CLUSTERED 
(
	[SpecialQuestionsParagraphsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerConsecutiveConcurrent]    Script Date: 02/23/2011 16:34:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerConsecutiveConcurrent](
	[CrimeAnswerConsecutiveConcurrentID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[ConsecutiveConcurrentID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerConsecutiveConcurrent] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerConsecutiveConcurrentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerUnconditionalDischarge]    Script Date: 02/23/2011 16:35:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerUnconditionalDischarge](
	[CrimeAnswerUnconditionalDischargeID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[UnconditionalDischargeID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerUnconditionalDischarge] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerUnconditionalDischargeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerEnd]    Script Date: 02/23/2011 16:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerEnd](
	[CrimeAnswerEndID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[EndID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerEnd] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerEndID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerIntermittentImprisonment]    Script Date: 02/23/2011 16:34:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerIntermittentImprisonment](
	[CrimeAnswerIntermittentImprisonmentID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[IntermittentImprisonmentID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerIntermittentImprisonment] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerIntermittentImprisonmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerLicensePenalties]    Script Date: 02/23/2011 16:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerLicensePenalties](
	[CrimeAnswerLicensePenaltiesID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[LicensePenaltiesID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerLiscensePenalties] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerLicensePenaltiesID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerSurchargeVictimAssessmentFee]    Script Date: 02/23/2011 16:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerSurchargeVictimAssessmentFee](
	[CrimeAnswerSurchargeVictimAssessmentFeeID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[SurchargeVictimAssessmentFeeID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerSurchargeVictimAssessmentFee] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerSurchargeVictimAssessmentFeeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerRestitutionReparation]    Script Date: 02/23/2011 16:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerRestitutionReparation](
	[CrimeAnswerRestitutionReparationID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[RestitutionReparationID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerRestitutionReparation] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerRestitutionReparationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerFine]    Script Date: 02/23/2011 16:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerFine](
	[CrimeAnswerFineID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[FineID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerFine] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerFineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerSplitSentence]    Script Date: 02/23/2011 16:35:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerSplitSentence](
	[CrimeAnswerSplitSentence] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[SplitSentenceID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerSplitSentence] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerSplitSentence] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerConditionalDischarge]    Script Date: 02/23/2011 16:34:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerConditionalDischarge](
	[CrimeAnswerConditionalDischargeID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[ConditionalDischargeID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerConditionalDischarge] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerConditionalDischargeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCrimeAnswerProbation]    Script Date: 02/23/2011 16:35:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCrimeAnswerProbation](
	[CrimeAnswerProbationID] [int] IDENTITY(1,1) NOT NULL,
	[CrimeAnswer] [int] NULL,
	[ProbationID] [int] NULL,
 CONSTRAINT [PK_tblCrimeAnswerProbation] PRIMARY KEY CLUSTERED 
(
	[CrimeAnswerProbationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerCasat_tblCASAT]    Script Date: 02/23/2011 16:34:33 ******/
ALTER TABLE [dbo].[tblCrimeAnswerCasat]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerCasat_tblCASAT] FOREIGN KEY([CasatID])
REFERENCES [dbo].[tblCASAT] ([CASATID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerCasat] CHECK CONSTRAINT [FK_tblCrimeAnswerCasat_tblCASAT]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerCasat_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:33 ******/
ALTER TABLE [dbo].[tblCrimeAnswerCasat]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerCasat_tblCrimeAnswer] FOREIGN KEY([CrimeAnswerID])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerCasat] CHECK CONSTRAINT [FK_tblCrimeAnswerCasat_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerConditionalDischarge_tblConditionalDishcarge]    Script Date: 02/23/2011 16:34:35 ******/
ALTER TABLE [dbo].[tblCrimeAnswerConditionalDischarge]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerConditionalDischarge_tblConditionalDishcarge] FOREIGN KEY([ConditionalDischargeID])
REFERENCES [dbo].[tblConditionalDischarge] ([ConditionalDischargeID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerConditionalDischarge] CHECK CONSTRAINT [FK_tblCrimeAnswerConditionalDischarge_tblConditionalDishcarge]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerConditionalDischarge_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:35 ******/
ALTER TABLE [dbo].[tblCrimeAnswerConditionalDischarge]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerConditionalDischarge_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerConditionalDischarge] CHECK CONSTRAINT [FK_tblCrimeAnswerConditionalDischarge_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerConsecutiveConcurrent_tblConsecutiveConcurrent]    Script Date: 02/23/2011 16:34:37 ******/
ALTER TABLE [dbo].[tblCrimeAnswerConsecutiveConcurrent]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerConsecutiveConcurrent_tblConsecutiveConcurrent] FOREIGN KEY([ConsecutiveConcurrentID])
REFERENCES [dbo].[tblConsecutiveConcurrent] ([ConsecutiveConcurrentID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerConsecutiveConcurrent] CHECK CONSTRAINT [FK_tblCrimeAnswerConsecutiveConcurrent_tblConsecutiveConcurrent]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerConsecutiveConcurrent_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:38 ******/
ALTER TABLE [dbo].[tblCrimeAnswerConsecutiveConcurrent]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerConsecutiveConcurrent_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerConsecutiveConcurrent] CHECK CONSTRAINT [FK_tblCrimeAnswerConsecutiveConcurrent_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerDefiniteSentence_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:39 ******/
ALTER TABLE [dbo].[tblCrimeAnswerDefiniteSentence]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerDefiniteSentence_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerDefiniteSentence] CHECK CONSTRAINT [FK_tblCrimeAnswerDefiniteSentence_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerDefiniteSentence_tblDefiniteSentence]    Script Date: 02/23/2011 16:34:40 ******/
ALTER TABLE [dbo].[tblCrimeAnswerDefiniteSentence]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerDefiniteSentence_tblDefiniteSentence] FOREIGN KEY([DefiniteSentenceID])
REFERENCES [dbo].[tblDefiniteSentence] ([DefiniteSentenceID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerDefiniteSentence] CHECK CONSTRAINT [FK_tblCrimeAnswerDefiniteSentence_tblDefiniteSentence]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerEnd_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:42 ******/
ALTER TABLE [dbo].[tblCrimeAnswerEnd]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerEnd_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerEnd] CHECK CONSTRAINT [FK_tblCrimeAnswerEnd_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerEnd_tblEnd]    Script Date: 02/23/2011 16:34:42 ******/
ALTER TABLE [dbo].[tblCrimeAnswerEnd]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerEnd_tblEnd] FOREIGN KEY([EndID])
REFERENCES [dbo].[tblEnd] ([EndID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerEnd] CHECK CONSTRAINT [FK_tblCrimeAnswerEnd_tblEnd]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerFine_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:44 ******/
ALTER TABLE [dbo].[tblCrimeAnswerFine]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerFine_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerFine] CHECK CONSTRAINT [FK_tblCrimeAnswerFine_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerFine_tblFine]    Script Date: 02/23/2011 16:34:44 ******/
ALTER TABLE [dbo].[tblCrimeAnswerFine]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerFine_tblFine] FOREIGN KEY([FineID])
REFERENCES [dbo].[tblFine] ([FineID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerFine] CHECK CONSTRAINT [FK_tblCrimeAnswerFine_tblFine]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerINTERIMPROBATIONSUPERVISION_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:46 ******/
ALTER TABLE [dbo].[tblCrimeAnswerINTERIMPROBATIONSUPERVISION]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerINTERIMPROBATIONSUPERVISION_tblCrimeAnswer] FOREIGN KEY([CrimeAnswerID])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerINTERIMPROBATIONSUPERVISION] CHECK CONSTRAINT [FK_tblCrimeAnswerINTERIMPROBATIONSUPERVISION_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerINTERIMPROBATIONSUPERVISION_tblINTERIMPROBATIONSUPERVISION]    Script Date: 02/23/2011 16:34:46 ******/
ALTER TABLE [dbo].[tblCrimeAnswerINTERIMPROBATIONSUPERVISION]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerINTERIMPROBATIONSUPERVISION_tblINTERIMPROBATIONSUPERVISION] FOREIGN KEY([INTERIMPROBATIONSUPERVISIONID])
REFERENCES [dbo].[tblINTERIMPROBATIONSUPERVISION] ([INTERIMPROBATIONSUPERVISIONID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerINTERIMPROBATIONSUPERVISION] CHECK CONSTRAINT [FK_tblCrimeAnswerINTERIMPROBATIONSUPERVISION_tblINTERIMPROBATIONSUPERVISION]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerIntermittentImprisonment_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:48 ******/
ALTER TABLE [dbo].[tblCrimeAnswerIntermittentImprisonment]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerIntermittentImprisonment_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerIntermittentImprisonment] CHECK CONSTRAINT [FK_tblCrimeAnswerIntermittentImprisonment_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerIntermittentImprisonment_tblIntermittentImprisonment]    Script Date: 02/23/2011 16:34:48 ******/
ALTER TABLE [dbo].[tblCrimeAnswerIntermittentImprisonment]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerIntermittentImprisonment_tblIntermittentImprisonment] FOREIGN KEY([IntermittentImprisonmentID])
REFERENCES [dbo].[tblIntermittentImprisonment] ([IntermittentImprisonmentID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerIntermittentImprisonment] CHECK CONSTRAINT [FK_tblCrimeAnswerIntermittentImprisonment_tblIntermittentImprisonment]
GO
/****** Object:  ForeignKey [FK_tblAnswerIssue_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:52 ******/
ALTER TABLE [dbo].[tblCrimeAnswerIssue]  WITH CHECK ADD  CONSTRAINT [FK_tblAnswerIssue_tblCrimeAnswer] FOREIGN KEY([CrimeAnswerID])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerIssue] CHECK CONSTRAINT [FK_tblAnswerIssue_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerIssue_tblEmailAddress]    Script Date: 02/23/2011 16:34:52 ******/
ALTER TABLE [dbo].[tblCrimeAnswerIssue]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerIssue_tblEmailAddress] FOREIGN KEY([EmailAddressID])
REFERENCES [dbo].[tblEmailAddress] ([EmailAddressID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerIssue] CHECK CONSTRAINT [FK_tblCrimeAnswerIssue_tblEmailAddress]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerJudicialDiversion_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:54 ******/
ALTER TABLE [dbo].[tblCrimeAnswerJudicialDiversion]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerJudicialDiversion_tblCrimeAnswer] FOREIGN KEY([CrimeAnswerID])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerJudicialDiversion] CHECK CONSTRAINT [FK_tblCrimeAnswerJudicialDiversion_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerJudicialDiversion_tblJudicialDiversion]    Script Date: 02/23/2011 16:34:54 ******/
ALTER TABLE [dbo].[tblCrimeAnswerJudicialDiversion]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerJudicialDiversion_tblJudicialDiversion] FOREIGN KEY([JudicialDiversionID])
REFERENCES [dbo].[tblJudicialDiversion] ([JudicialDiversionID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerJudicialDiversion] CHECK CONSTRAINT [FK_tblCrimeAnswerJudicialDiversion_tblJudicialDiversion]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerLiscensePenalties_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:56 ******/
ALTER TABLE [dbo].[tblCrimeAnswerLicensePenalties]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerLiscensePenalties_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerLicensePenalties] CHECK CONSTRAINT [FK_tblCrimeAnswerLiscensePenalties_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerLiscensePenalties_tblLiscensePenalties]    Script Date: 02/23/2011 16:34:56 ******/
ALTER TABLE [dbo].[tblCrimeAnswerLicensePenalties]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerLiscensePenalties_tblLiscensePenalties] FOREIGN KEY([LicensePenaltiesID])
REFERENCES [dbo].[tblLicensePenalties] ([LicensePenaltiesID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerLicensePenalties] CHECK CONSTRAINT [FK_tblCrimeAnswerLiscensePenalties_tblLiscensePenalties]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerPreface_tblCrimeAnswer]    Script Date: 02/23/2011 16:34:58 ******/
ALTER TABLE [dbo].[tblCrimeAnswerPreface]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerPreface_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerPreface] CHECK CONSTRAINT [FK_tblCrimeAnswerPreface_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerPreface_tblPreface]    Script Date: 02/23/2011 16:34:59 ******/
ALTER TABLE [dbo].[tblCrimeAnswerPreface]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerPreface_tblPreface] FOREIGN KEY([PrefaceID])
REFERENCES [dbo].[tblPreface] ([PrefaceID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerPreface] CHECK CONSTRAINT [FK_tblCrimeAnswerPreface_tblPreface]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerProbation_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:01 ******/
ALTER TABLE [dbo].[tblCrimeAnswerProbation]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerProbation_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerProbation] CHECK CONSTRAINT [FK_tblCrimeAnswerProbation_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerProbation_tblProbation]    Script Date: 02/23/2011 16:35:01 ******/
ALTER TABLE [dbo].[tblCrimeAnswerProbation]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerProbation_tblProbation] FOREIGN KEY([ProbationID])
REFERENCES [dbo].[tblProbation] ([ProbationID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerProbation] CHECK CONSTRAINT [FK_tblCrimeAnswerProbation_tblProbation]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerRestitutionReparation_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:03 ******/
ALTER TABLE [dbo].[tblCrimeAnswerRestitutionReparation]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerRestitutionReparation_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerRestitutionReparation] CHECK CONSTRAINT [FK_tblCrimeAnswerRestitutionReparation_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerRestitutionReparation_tblRestitutionReparation]    Script Date: 02/23/2011 16:35:03 ******/
ALTER TABLE [dbo].[tblCrimeAnswerRestitutionReparation]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerRestitutionReparation_tblRestitutionReparation] FOREIGN KEY([RestitutionReparationID])
REFERENCES [dbo].[tblRestitutionReparation] ([RestitutionReparationID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerRestitutionReparation] CHECK CONSTRAINT [FK_tblCrimeAnswerRestitutionReparation_tblRestitutionReparation]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerShock_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:05 ******/
ALTER TABLE [dbo].[tblCrimeAnswerShock]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerShock_tblCrimeAnswer] FOREIGN KEY([CrimeAnswerID])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerShock] CHECK CONSTRAINT [FK_tblCrimeAnswerShock_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerShock_tblShock]    Script Date: 02/23/2011 16:35:05 ******/
ALTER TABLE [dbo].[tblCrimeAnswerShock]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerShock_tblShock] FOREIGN KEY([ShockID])
REFERENCES [dbo].[tblShock] ([ShockID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerShock] CHECK CONSTRAINT [FK_tblCrimeAnswerShock_tblShock]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerSplitSentence_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:07 ******/
ALTER TABLE [dbo].[tblCrimeAnswerSplitSentence]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerSplitSentence_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerSplitSentence] CHECK CONSTRAINT [FK_tblCrimeAnswerSplitSentence_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerSplitSentence_tblSplitsentence]    Script Date: 02/23/2011 16:35:07 ******/
ALTER TABLE [dbo].[tblCrimeAnswerSplitSentence]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerSplitSentence_tblSplitsentence] FOREIGN KEY([SplitSentenceID])
REFERENCES [dbo].[tblSplitsentence] ([SplitsentenceID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerSplitSentence] CHECK CONSTRAINT [FK_tblCrimeAnswerSplitSentence_tblSplitsentence]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerStatePrison_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:09 ******/
ALTER TABLE [dbo].[tblCrimeAnswerStatePrison]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerStatePrison_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerStatePrison] CHECK CONSTRAINT [FK_tblCrimeAnswerStatePrison_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerStatePrison_tblStatePrison]    Script Date: 02/23/2011 16:35:09 ******/
ALTER TABLE [dbo].[tblCrimeAnswerStatePrison]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerStatePrison_tblStatePrison] FOREIGN KEY([StatePrisonID])
REFERENCES [dbo].[tblStatePrison] ([StatePrisonID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerStatePrison] CHECK CONSTRAINT [FK_tblCrimeAnswerStatePrison_tblStatePrison]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerSupervisedParole_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:11 ******/
ALTER TABLE [dbo].[tblCrimeAnswerSupervisedParole]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerSupervisedParole_tblCrimeAnswer] FOREIGN KEY([CrimeAnswerid])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerSupervisedParole] CHECK CONSTRAINT [FK_tblCrimeAnswerSupervisedParole_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerSupervisedParole_tblSupervisedParole]    Script Date: 02/23/2011 16:35:11 ******/
ALTER TABLE [dbo].[tblCrimeAnswerSupervisedParole]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerSupervisedParole_tblSupervisedParole] FOREIGN KEY([SupervisedParoleID])
REFERENCES [dbo].[tblSupervisedParole] ([SupervisedParoleID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerSupervisedParole] CHECK CONSTRAINT [FK_tblCrimeAnswerSupervisedParole_tblSupervisedParole]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerSurchargeVictimAssessmentFee_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:13 ******/
ALTER TABLE [dbo].[tblCrimeAnswerSurchargeVictimAssessmentFee]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerSurchargeVictimAssessmentFee_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerSurchargeVictimAssessmentFee] CHECK CONSTRAINT [FK_tblCrimeAnswerSurchargeVictimAssessmentFee_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerSurchargeVictimAssessmentFee_tblSurchargeVictimAssessmentFee]    Script Date: 02/23/2011 16:35:14 ******/
ALTER TABLE [dbo].[tblCrimeAnswerSurchargeVictimAssessmentFee]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerSurchargeVictimAssessmentFee_tblSurchargeVictimAssessmentFee] FOREIGN KEY([SurchargeVictimAssessmentFeeID])
REFERENCES [dbo].[tblSurchargeVictimAssessmentFee] ([SurchargeVictimAssessmentFeeID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerSurchargeVictimAssessmentFee] CHECK CONSTRAINT [FK_tblCrimeAnswerSurchargeVictimAssessmentFee_tblSurchargeVictimAssessmentFee]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerTransition_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:16 ******/
ALTER TABLE [dbo].[tblCrimeAnswerTransition]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerTransition_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerTransition] CHECK CONSTRAINT [FK_tblCrimeAnswerTransition_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerTransition_tblTransition]    Script Date: 02/23/2011 16:35:16 ******/
ALTER TABLE [dbo].[tblCrimeAnswerTransition]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerTransition_tblTransition] FOREIGN KEY([TransitionID])
REFERENCES [dbo].[tblTransition] ([TransitionID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerTransition] CHECK CONSTRAINT [FK_tblCrimeAnswerTransition_tblTransition]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerUnconditionalDischarge_tblCrimeAnswer]    Script Date: 02/23/2011 16:35:18 ******/
ALTER TABLE [dbo].[tblCrimeAnswerUnconditionalDischarge]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerUnconditionalDischarge_tblCrimeAnswer] FOREIGN KEY([CrimeAnswer])
REFERENCES [dbo].[tblCrimeAnswer] ([CrimeAnswerID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerUnconditionalDischarge] CHECK CONSTRAINT [FK_tblCrimeAnswerUnconditionalDischarge_tblCrimeAnswer]
GO
/****** Object:  ForeignKey [FK_tblCrimeAnswerUnconditionalDischarge_tblUnconditionalDischarge]    Script Date: 02/23/2011 16:35:18 ******/
ALTER TABLE [dbo].[tblCrimeAnswerUnconditionalDischarge]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimeAnswerUnconditionalDischarge_tblUnconditionalDischarge] FOREIGN KEY([UnconditionalDischargeID])
REFERENCES [dbo].[tblUnconditionalDischarge] ([UnconditionalDischargeID])
GO
ALTER TABLE [dbo].[tblCrimeAnswerUnconditionalDischarge] CHECK CONSTRAINT [FK_tblCrimeAnswerUnconditionalDischarge_tblUnconditionalDischarge]
GO
/****** Object:  ForeignKey [FK_tblCrimesMitigatingFactorQuestions_tblAgeCategory]    Script Date: 02/23/2011 16:35:30 ******/
ALTER TABLE [dbo].[tblCrimesMitigatingFactorQuestions]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimesMitigatingFactorQuestions_tblAgeCategory] FOREIGN KEY([AgeCategory])
REFERENCES [dbo].[tblAgeCategory] ([AgeCategoryID])
GO
ALTER TABLE [dbo].[tblCrimesMitigatingFactorQuestions] CHECK CONSTRAINT [FK_tblCrimesMitigatingFactorQuestions_tblAgeCategory]
GO
/****** Object:  ForeignKey [FK_tblCrimesMitigatingFactorQuestions_tblCrimes]    Script Date: 02/23/2011 16:35:30 ******/
ALTER TABLE [dbo].[tblCrimesMitigatingFactorQuestions]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimesMitigatingFactorQuestions_tblCrimes] FOREIGN KEY([CrimesID])
REFERENCES [dbo].[tblCrimes] ([CrimesID])
GO
ALTER TABLE [dbo].[tblCrimesMitigatingFactorQuestions] CHECK CONSTRAINT [FK_tblCrimesMitigatingFactorQuestions_tblCrimes]
GO
/****** Object:  ForeignKey [FK_tblCrimesMitigatingFactorQuestions_tblMitigatingFactorQuestions]    Script Date: 02/23/2011 16:35:30 ******/
ALTER TABLE [dbo].[tblCrimesMitigatingFactorQuestions]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimesMitigatingFactorQuestions_tblMitigatingFactorQuestions] FOREIGN KEY([MitigatingFactorQuestionsID])
REFERENCES [dbo].[tblMitigatingFactorQuestions] ([MitigatingFactorQuestionsID])
GO
ALTER TABLE [dbo].[tblCrimesMitigatingFactorQuestions] CHECK CONSTRAINT [FK_tblCrimesMitigatingFactorQuestions_tblMitigatingFactorQuestions]
GO
/****** Object:  ForeignKey [FK_tblCrimesSpecialPopups_tblCrimes]    Script Date: 02/23/2011 16:35:32 ******/
ALTER TABLE [dbo].[tblCrimesSpecialPopups]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimesSpecialPopups_tblCrimes] FOREIGN KEY([CrimesID])
REFERENCES [dbo].[tblCrimes] ([CrimesID])
GO
ALTER TABLE [dbo].[tblCrimesSpecialPopups] CHECK CONSTRAINT [FK_tblCrimesSpecialPopups_tblCrimes]
GO
/****** Object:  ForeignKey [FK_tblCrimesSpecialPopups_tblSpecialPopUps]    Script Date: 02/23/2011 16:35:32 ******/
ALTER TABLE [dbo].[tblCrimesSpecialPopups]  WITH CHECK ADD  CONSTRAINT [FK_tblCrimesSpecialPopups_tblSpecialPopUps] FOREIGN KEY([SpecialPopUpsID])
REFERENCES [dbo].[tblSpecialPopUps] ([SpecialPopUpsID])
GO
ALTER TABLE [dbo].[tblCrimesSpecialPopups] CHECK CONSTRAINT [FK_tblCrimesSpecialPopups_tblSpecialPopUps]
GO
/****** Object:  ForeignKey [FK_tblSpecialQuestionsParagraphs_tblParagraphs]    Script Date: 02/23/2011 16:36:15 ******/
ALTER TABLE [dbo].[tblSpecialQuestionsParagraphs]  WITH CHECK ADD  CONSTRAINT [FK_tblSpecialQuestionsParagraphs_tblParagraphs] FOREIGN KEY([ParagraphsID])
REFERENCES [dbo].[tblParagraphs] ([ParagraphsID])
GO
ALTER TABLE [dbo].[tblSpecialQuestionsParagraphs] CHECK CONSTRAINT [FK_tblSpecialQuestionsParagraphs_tblParagraphs]
GO
/****** Object:  ForeignKey [FK_tblSpecialQuestionsParagraphs_tblSpecialQuestions]    Script Date: 02/23/2011 16:36:15 ******/
ALTER TABLE [dbo].[tblSpecialQuestionsParagraphs]  WITH CHECK ADD  CONSTRAINT [FK_tblSpecialQuestionsParagraphs_tblSpecialQuestions] FOREIGN KEY([SpecialQuestionsID])
REFERENCES [dbo].[tblSpecialQuestions] ([SpecialQuestionsID])
GO
ALTER TABLE [dbo].[tblSpecialQuestionsParagraphs] CHECK CONSTRAINT [FK_tblSpecialQuestionsParagraphs_tblSpecialQuestions]
GO
