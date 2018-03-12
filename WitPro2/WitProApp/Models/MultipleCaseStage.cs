using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WitProApp.Models
{
    public class MultipleCaseStage
    {
        [Key, Column(Order = 0)]
        public int CaseID { get; set; }

        [Key, Column(Order = 1)]
        public int CaseStageID { get; set; }

        public virtual Case Case { get; set; }
        public virtual CaseStage CaseStage { get; set; }
    }
}