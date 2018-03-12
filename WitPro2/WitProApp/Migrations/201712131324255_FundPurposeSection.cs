namespace WitProApp.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class FundPurposeSection : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Case", "NumAdultsMale", c => c.Int());
            AddColumn("dbo.Case", "NumAdultsFemale", c => c.Int());
            AddColumn("dbo.Case", "NumChildren", c => c.Int());
            AddColumn("dbo.Case", "SpecialNeedsYN", c => c.Boolean(nullable: false));
            AddColumn("dbo.Case", "FundsPurposeNotes", c => c.String(maxLength: 255));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Case", "FundsPurposeNotes");
            DropColumn("dbo.Case", "SpecialNeedsYN");
            DropColumn("dbo.Case", "NumChildren");
            DropColumn("dbo.Case", "NumAdultsFemale");
            DropColumn("dbo.Case", "NumAdultsMale");
        }
    }
}
