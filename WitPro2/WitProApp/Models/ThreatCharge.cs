using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class ThreatCharge
    {
        public int ThreatChargeID { get; set; }

        [StringLength(75)]
        [Display(Name = "Threat Charge")]
        public string DisplayName { get; set; }

        public int? Active { get; set; }

        public virtual ICollection<Case> Cases { get; set; }
    }
}