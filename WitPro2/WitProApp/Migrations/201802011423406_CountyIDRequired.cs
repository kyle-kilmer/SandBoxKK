namespace WitProApp.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CountyIDRequired : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Case", "CountyID", "dbo.County");
            DropIndex("dbo.Case", new[] { "CountyID" });
            AlterColumn("dbo.Case", "CountyID", c => c.Int(nullable: false));
            CreateIndex("dbo.Case", "CountyID");
            AddForeignKey("dbo.Case", "CountyID", "dbo.County", "CountyID", cascadeDelete: true);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Case", "CountyID", "dbo.County");
            DropIndex("dbo.Case", new[] { "CountyID" });
            AlterColumn("dbo.Case", "CountyID", c => c.Int());
            CreateIndex("dbo.Case", "CountyID");
            AddForeignKey("dbo.Case", "CountyID", "dbo.County", "CountyID");
        }
    }
}
