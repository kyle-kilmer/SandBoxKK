namespace WitProApp.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedReferenceLinks : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Case", "Link1", c => c.String(maxLength: 255));
            AddColumn("dbo.Case", "Link2", c => c.String(maxLength: 255));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Case", "Link2");
            DropColumn("dbo.Case", "Link1");
        }
    }
}
