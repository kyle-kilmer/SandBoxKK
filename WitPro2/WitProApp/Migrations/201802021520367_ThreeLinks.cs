namespace WitProApp.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ThreeLinks : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Case", "Link3", c => c.String(maxLength: 1000));
            AlterColumn("dbo.Case", "Link1", c => c.String(maxLength: 1000));
            AlterColumn("dbo.Case", "Link2", c => c.String(maxLength: 1000));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Case", "Link2", c => c.String(maxLength: 255));
            AlterColumn("dbo.Case", "Link1", c => c.String(maxLength: 255));
            DropColumn("dbo.Case", "Link3");
        }
    }
}
