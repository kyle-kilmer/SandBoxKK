namespace WitProApp.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddUploadDateAndCaseID : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Attachment", "CaseID", c => c.Int(nullable: false));
            AddColumn("dbo.Attachment", "UploadDate", c => c.String());
            CreateIndex("dbo.Attachment", "CaseID");
            AddForeignKey("dbo.Attachment", "CaseID", "dbo.Case", "CaseID", cascadeDelete: true);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Attachment", "CaseID", "dbo.Case");
            DropIndex("dbo.Attachment", new[] { "CaseID" });
            DropColumn("dbo.Attachment", "UploadDate");
            DropColumn("dbo.Attachment", "CaseID");
        }
    }
}
