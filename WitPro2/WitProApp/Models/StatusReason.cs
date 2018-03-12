using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class StatusReason
    {
        public int StatusReasonID { get; set; }

        [StringLength(125)]
        [Display(Name = "Status Reason (if not approved)")]
        public string DisplayName { get; set; }

        [ScaffoldColumn(false)]
        public int? Active { get; set; }

        public virtual ICollection<Case> Cases { get; set; }
    }
}