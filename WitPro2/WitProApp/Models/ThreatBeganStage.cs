using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class ThreatBeganStage
    {
        public int ThreatBeganStageID { get; set; }

        [StringLength(75)]
        [Display(Name = "Stage Threat Began")]
        public string DisplayName { get; set; }

        public int? Active { get; set; }

        public virtual ICollection<Case> Cases { get; set; }
    }
}