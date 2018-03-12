using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class ThreatType
    {
        public int ThreatTypeID { get; set; }

        [StringLength(75)]
        [Display(Name = "How Threats Conveyed")]
        public string DisplayName { get; set; }

        public int? Active { get; set; }

        public virtual ICollection<MultipleThreatType> Cases { get; set; }
    }
}