using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class ApprovalStatus
    {
        public int ApprovalStatusID { get; set; }


        [StringLength(75)]
        [Display(Name = "Approval Status")]
        public string DisplayName { get; set; }
        public int? Active { get; set; }

        public virtual ICollection<Case> Cases { get; set; }
        public virtual ICollection<Dispersal> Dispersals { get; set; }
    }
}