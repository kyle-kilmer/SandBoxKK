using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class GrantType
    {
        public int GrantTypeID { get; set; }

        [StringLength(75)]
        [Display(Name = "Grant")]
        public string DisplayName { get; set; }

        public int? Active { get; set; }

        public ICollection<Dispersal> Dispersals { get; set; }
    }
}