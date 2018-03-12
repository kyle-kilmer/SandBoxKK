namespace WitProApp.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class multipleValues : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Case", "CaseStageID", "dbo.CaseStage");
            DropForeignKey("dbo.Case", "CaseTypeID", "dbo.CaseType");
            DropForeignKey("dbo.Case", "ChargeID", "dbo.Charge");
            DropForeignKey("dbo.Case", "ThreatTypeID", "dbo.ThreatType");
            DropIndex("dbo.Case", new[] { "ChargeID" });
            DropIndex("dbo.Case", new[] { "CaseTypeID" });
            DropIndex("dbo.Case", new[] { "CaseStageID" });
            DropIndex("dbo.Case", new[] { "ThreatTypeID" });            
            CreateTable(
                "dbo.MultipleCaseStage",
                c => new
                    {
                        CaseID = c.Int(nullable: false),
                        CaseStageID = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.CaseID, t.CaseStageID })
                .ForeignKey("dbo.Case", t => t.CaseID, cascadeDelete: true)
                .ForeignKey("dbo.CaseStage", t => t.CaseStageID, cascadeDelete: true)
                .Index(t => t.CaseID)
                .Index(t => t.CaseStageID);
            
            CreateTable(
                "dbo.MultipleCaseTypes",
                c => new
                    {
                        CaseID = c.Int(nullable: false),
                        CaseTypeID = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.CaseID, t.CaseTypeID })
                .ForeignKey("dbo.Case", t => t.CaseID, cascadeDelete: true)
                .ForeignKey("dbo.CaseType", t => t.CaseTypeID, cascadeDelete: true)
                .Index(t => t.CaseID)
                .Index(t => t.CaseTypeID);
            
            CreateTable(
                "dbo.MultipleCharge",
                c => new
                    {
                        CaseID = c.Int(nullable: false),
                        ChargeID = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.CaseID, t.ChargeID })
                .ForeignKey("dbo.Case", t => t.CaseID, cascadeDelete: true)
                .ForeignKey("dbo.Charge", t => t.ChargeID, cascadeDelete: true)
                .Index(t => t.CaseID)
                .Index(t => t.ChargeID);
            
            CreateTable(
                "dbo.MultipleThreatType",
                c => new
                    {
                        CaseID = c.Int(nullable: false),
                        ThreatTypeID = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.CaseID, t.ThreatTypeID })
                .ForeignKey("dbo.Case", t => t.CaseID, cascadeDelete: true)
                .ForeignKey("dbo.ThreatType", t => t.ThreatTypeID, cascadeDelete: true)
                .Index(t => t.CaseID)
                .Index(t => t.ThreatTypeID);
            
            DropColumn("dbo.Case", "ChargeID");
            DropColumn("dbo.Case", "CaseTypeID");
            DropColumn("dbo.Case", "CaseStageID");
            DropColumn("dbo.Case", "ThreatTypeID");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Case", "ThreatTypeID", c => c.Int());
            AddColumn("dbo.Case", "CaseStageID", c => c.Int());
            AddColumn("dbo.Case", "CaseTypeID", c => c.Int());
            AddColumn("dbo.Case", "ChargeID", c => c.Int());
            DropForeignKey("dbo.MultipleThreatType", "ThreatTypeID", "dbo.ThreatType");
            DropForeignKey("dbo.MultipleCharge", "ChargeID", "dbo.Charge");
            DropForeignKey("dbo.MultipleCaseTypes", "CaseTypeID", "dbo.CaseType");
            DropForeignKey("dbo.MultipleCaseStage", "CaseStageID", "dbo.CaseStage");
            DropForeignKey("dbo.MultipleThreatType", "CaseID", "dbo.Case");
            DropForeignKey("dbo.MultipleCharge", "CaseID", "dbo.Case");
            DropForeignKey("dbo.MultipleCaseTypes", "CaseID", "dbo.Case");
            DropForeignKey("dbo.MultipleCaseStage", "CaseID", "dbo.Case");
            DropIndex("dbo.MultipleThreatType", new[] { "ThreatTypeID" });
            DropIndex("dbo.MultipleThreatType", new[] { "CaseID" });
            DropIndex("dbo.MultipleCharge", new[] { "ChargeID" });
            DropIndex("dbo.MultipleCharge", new[] { "CaseID" });
            DropIndex("dbo.MultipleCaseTypes", new[] { "CaseTypeID" });
            DropIndex("dbo.MultipleCaseTypes", new[] { "CaseID" });
            DropIndex("dbo.MultipleCaseStage", new[] { "CaseStageID" });
            DropIndex("dbo.MultipleCaseStage", new[] { "CaseID" });
            DropTable("dbo.MultipleThreatType");
            DropTable("dbo.MultipleCharge");
            DropTable("dbo.MultipleCaseTypes");
            DropTable("dbo.MultipleCaseStage");            
            CreateIndex("dbo.Case", "ThreatTypeID");
            CreateIndex("dbo.Case", "CaseStageID");
            CreateIndex("dbo.Case", "CaseTypeID");
            CreateIndex("dbo.Case", "ChargeID");
            AddForeignKey("dbo.Case", "ThreatTypeID", "dbo.ThreatType", "ThreatTypeID");
            AddForeignKey("dbo.Case", "ChargeID", "dbo.Charge", "ChargeID");
            AddForeignKey("dbo.Case", "CaseTypeID", "dbo.CaseType", "CaseTypeID");
            AddForeignKey("dbo.Case", "CaseStageID", "dbo.CaseStage", "CaseStageID");
        }
    }
}
