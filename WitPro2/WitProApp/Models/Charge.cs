using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class Charge
    {
        public int ChargeID { get; set; }
    

        [StringLength(255)]
        [Display(Name = "Charge")]
        public string DisplayName { get; set; }
        
        public int? Active { get; set; }

        public virtual ICollection<MultipleCharge> Cases { get; set; }
    }
}