using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class CaseType
    {
        public int CaseTypeID { get; set; }

        [StringLength(75)]
        [Display(Name = "Case Type")]
        public string DisplayName { get; set; }
        public int? Active { get; set; }

        public virtual ICollection<MultipleCaseTypes> Cases { get; set; }
    }
}