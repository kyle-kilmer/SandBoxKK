namespace WitProApp.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class initial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.ApprovalStatus",
                c => new
                    {
                        ApprovalStatusID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 75),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.ApprovalStatusID);
            
            CreateTable(
                "dbo.Case",
                c => new
                    {
                        CaseID = c.Int(nullable: false, identity: true),
                        NYPTICaseNumber = c.String(maxLength: 50),
                        CountyCaseNumber = c.String(),
                        InitialContactDate = c.DateTime(nullable: false),
                        EmployeeID = c.Int(nullable: false),
                        CountyID = c.Int(),
                        ContactID = c.Int(),
                        ChargeID = c.Int(),
                        ChargeOther = c.String(maxLength: 150),
                        CaseTypeID = c.Int(),
                        CaseStageID = c.Int(),
                        ThreatTypeID = c.Int(),
                        ThreatBeganDate = c.String(maxLength: 150),
                        FactsOfCase = c.String(maxLength: 1500),
                        ThreatChargeID = c.Int(),
                        ApprovalStatusID = c.Int(),
                        StatusReasonID = c.Int(),
                        StatusReasonOther = c.String(maxLength: 150),
                        Plan = c.String(maxLength: 255),
                        ClosingLetterReceivedDate = c.DateTime(),
                        CaseDisposition = c.String(maxLength: 255),
                        WitnessThreatsInDispo = c.Int(),
                        DateFinalTallyReturned = c.DateTime(),
                        CaseNotes = c.String(maxLength: 255),
                        Active = c.Int(),
                        CreatedDate = c.DateTime(nullable: false),
                        ThreatBeganStage_ThreatBeganStageID = c.Int(),
                    })
                .PrimaryKey(t => t.CaseID)
                .ForeignKey("dbo.ApprovalStatus", t => t.ApprovalStatusID)
                .ForeignKey("dbo.CaseStage", t => t.CaseStageID)
                .ForeignKey("dbo.CaseType", t => t.CaseTypeID)
                .ForeignKey("dbo.Charge", t => t.ChargeID)
                .ForeignKey("dbo.Contact", t => t.ContactID)
                .ForeignKey("dbo.County", t => t.CountyID)
                .ForeignKey("dbo.Employee", t => t.EmployeeID, cascadeDelete: true)
                .ForeignKey("dbo.StatusReason", t => t.StatusReasonID)
                .ForeignKey("dbo.ThreatCharge", t => t.ThreatChargeID)
                .ForeignKey("dbo.ThreatType", t => t.ThreatTypeID)
                .ForeignKey("dbo.ThreatBeganStage", t => t.ThreatBeganStage_ThreatBeganStageID)
                .Index(t => t.EmployeeID)
                .Index(t => t.CountyID)
                .Index(t => t.ContactID)
                .Index(t => t.ChargeID)
                .Index(t => t.CaseTypeID)
                .Index(t => t.CaseStageID)
                .Index(t => t.ThreatTypeID)
                .Index(t => t.ThreatChargeID)
                .Index(t => t.ApprovalStatusID)
                .Index(t => t.StatusReasonID)
                .Index(t => t.ThreatBeganStage_ThreatBeganStageID);
            
            CreateTable(
                "dbo.CaseStage",
                c => new
                    {
                        CaseStageID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 75),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.CaseStageID);
            
            CreateTable(
                "dbo.CaseType",
                c => new
                    {
                        CaseTypeID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 75),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.CaseTypeID);
            
            CreateTable(
                "dbo.Charge",
                c => new
                    {
                        ChargeID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 255),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.ChargeID);
            
            CreateTable(
                "dbo.Contact",
                c => new
                    {
                        ContactID = c.Int(nullable: false, identity: true),
                        FirstName = c.String(maxLength: 75),
                        LastName = c.String(maxLength: 75),
                        Title = c.String(maxLength: 75),
                        CountyID = c.Int(),
                        Email = c.String(maxLength: 75),
                        PhoneNumberOffice = c.String(maxLength: 30),
                        PhoneNumberMobile = c.String(maxLength: 30),
                        FaxNumber = c.String(maxLength: 30),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.ContactID)
                .ForeignKey("dbo.County", t => t.CountyID)
                .Index(t => t.CountyID);
            
            CreateTable(
                "dbo.County",
                c => new
                    {
                        CountyID = c.Int(nullable: false, identity: true),
                        CountyName = c.String(maxLength: 75),
                        Metro8Indicator = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.CountyID);
            
            CreateTable(
                "dbo.Dispersal",
                c => new
                    {
                        DispersalID = c.Int(nullable: false, identity: true),
                        CaseID = c.Int(nullable: false),
                        DispersalRequestDate = c.DateTime(nullable: false),
                        AmountRequested = c.Decimal(precision: 18, scale: 2),
                        DispersalApprovalStatusID = c.Int(),
                        DisperalApprovalStatusReason = c.String(maxLength: 125),
                        AmountApproved = c.Decimal(precision: 18, scale: 2),
                        CheckNumber = c.String(),
                        DateSent = c.DateTime(),
                        DateCleared = c.DateTime(),
                        AmountReturned = c.Decimal(precision: 18, scale: 2),
                        DateReturned = c.DateTime(),
                        DispersalNotes = c.String(maxLength: 255),
                        GrantTypeID = c.Int(),
                        Active = c.Int(),
                        ApprovalStatus_ApprovalStatusID = c.Int(),
                    })
                .PrimaryKey(t => t.DispersalID)
                .ForeignKey("dbo.ApprovalStatus", t => t.ApprovalStatus_ApprovalStatusID)
                .ForeignKey("dbo.Case", t => t.CaseID, cascadeDelete: true)
                .ForeignKey("dbo.GrantType", t => t.GrantTypeID)
                .Index(t => t.CaseID)
                .Index(t => t.GrantTypeID)
                .Index(t => t.ApprovalStatus_ApprovalStatusID);
            
            CreateTable(
                "dbo.GrantType",
                c => new
                    {
                        GrantTypeID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 75),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.GrantTypeID);
            
            CreateTable(
                "dbo.Employee",
                c => new
                    {
                        EmployeeID = c.Int(nullable: false, identity: true),
                        FirstName = c.String(nullable: false, maxLength: 75),
                        LastName = c.String(nullable: false, maxLength: 75),
                        Email = c.String(maxLength: 75),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.EmployeeID);
            
            CreateTable(
                "dbo.StatusReason",
                c => new
                    {
                        StatusReasonID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 125),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.StatusReasonID);
            
            CreateTable(
                "dbo.ThreatCharge",
                c => new
                    {
                        ThreatChargeID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 75),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.ThreatChargeID);
            
            CreateTable(
                "dbo.ThreatType",
                c => new
                    {
                        ThreatTypeID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 75),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.ThreatTypeID);
            
            CreateTable(
                "dbo.ThreatBeganStage",
                c => new
                    {
                        ThreatBeganStageID = c.Int(nullable: false, identity: true),
                        DisplayName = c.String(maxLength: 75),
                        Active = c.Int(),
                    })
                .PrimaryKey(t => t.ThreatBeganStageID);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Case", "ThreatBeganStage_ThreatBeganStageID", "dbo.ThreatBeganStage");
            DropForeignKey("dbo.Case", "ThreatTypeID", "dbo.ThreatType");
            DropForeignKey("dbo.Case", "ThreatChargeID", "dbo.ThreatCharge");
            DropForeignKey("dbo.Case", "StatusReasonID", "dbo.StatusReason");
            DropForeignKey("dbo.Case", "EmployeeID", "dbo.Employee");
            DropForeignKey("dbo.Dispersal", "GrantTypeID", "dbo.GrantType");
            DropForeignKey("dbo.Dispersal", "CaseID", "dbo.Case");
            DropForeignKey("dbo.Dispersal", "ApprovalStatus_ApprovalStatusID", "dbo.ApprovalStatus");
            DropForeignKey("dbo.Contact", "CountyID", "dbo.County");
            DropForeignKey("dbo.Case", "CountyID", "dbo.County");
            DropForeignKey("dbo.Case", "ContactID", "dbo.Contact");
            DropForeignKey("dbo.Case", "ChargeID", "dbo.Charge");
            DropForeignKey("dbo.Case", "CaseTypeID", "dbo.CaseType");
            DropForeignKey("dbo.Case", "CaseStageID", "dbo.CaseStage");
            DropForeignKey("dbo.Case", "ApprovalStatusID", "dbo.ApprovalStatus");
            DropIndex("dbo.Dispersal", new[] { "ApprovalStatus_ApprovalStatusID" });
            DropIndex("dbo.Dispersal", new[] { "GrantTypeID" });
            DropIndex("dbo.Dispersal", new[] { "CaseID" });
            DropIndex("dbo.Contact", new[] { "CountyID" });
            DropIndex("dbo.Case", new[] { "ThreatBeganStage_ThreatBeganStageID" });
            DropIndex("dbo.Case", new[] { "StatusReasonID" });
            DropIndex("dbo.Case", new[] { "ApprovalStatusID" });
            DropIndex("dbo.Case", new[] { "ThreatChargeID" });
            DropIndex("dbo.Case", new[] { "ThreatTypeID" });
            DropIndex("dbo.Case", new[] { "CaseStageID" });
            DropIndex("dbo.Case", new[] { "CaseTypeID" });
            DropIndex("dbo.Case", new[] { "ChargeID" });
            DropIndex("dbo.Case", new[] { "ContactID" });
            DropIndex("dbo.Case", new[] { "CountyID" });
            DropIndex("dbo.Case", new[] { "EmployeeID" });
            DropTable("dbo.ThreatBeganStage");
            DropTable("dbo.ThreatType");
            DropTable("dbo.ThreatCharge");
            DropTable("dbo.StatusReason");
            DropTable("dbo.Employee");
            DropTable("dbo.GrantType");
            DropTable("dbo.Dispersal");
            DropTable("dbo.County");
            DropTable("dbo.Contact");
            DropTable("dbo.Charge");
            DropTable("dbo.CaseType");
            DropTable("dbo.CaseStage");
            DropTable("dbo.Case");
            DropTable("dbo.ApprovalStatus");
        }
    }
}
