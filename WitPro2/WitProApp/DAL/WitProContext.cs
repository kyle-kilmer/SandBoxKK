using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using WitProApp.Models;

namespace WitProApp.DAL
{
    public class WitProContext : DbContext
    {

        public WitProContext() : base("WitProContext")
        {
        }

        public DbSet<Case> Cases { get; set; }
        public DbSet<CaseStage> CaseStage { get; set; }
        public DbSet<CaseType> CaseType { get; set; }
        public DbSet<Charge> Charge { get; set; }
        public DbSet<Contact> Contact { get; set; }
        public DbSet<County> County { get; set; }
        public DbSet<Employee> Employee { get; set; }
        public DbSet<ThreatBeganStage> ThreatBeganStage { get; set; }
        public DbSet<ThreatCharge> ThreatCharge { get; set; }
        public DbSet<ThreatType> ThreatType { get; set; }
        public DbSet<ApprovalStatus> ApprovalStatus { get; set; }
        public DbSet<GrantType> GrantType { get; set; }
        public DbSet<StatusReason> StatusReason { get; set; }
        public DbSet<Dispersal> Dispersals { get; set; }
        public DbSet<MultipleCaseTypes> CaseCaseTypes { get; set; }
        public DbSet<MultipleCharge> CaseCharges { get; set; }
        public DbSet<MultipleCaseStage> CaseCaseStage { get; set; }
        public DbSet<MultipleThreatType> CaseThreatType { get; set; }
        public DbSet<Attachment> Attachments { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();            
        }        


    }
}