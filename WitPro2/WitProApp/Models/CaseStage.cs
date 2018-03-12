using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class CaseStage
    {
        public int CaseStageID { get; set; }

        [StringLength(75)]
        [Display(Name = "Case Stage")]
        public string DisplayName { get; set; }
        public int? Active { get; set; }

        public virtual ICollection<MultipleCaseStage> Cases { get; set; }
    }
}