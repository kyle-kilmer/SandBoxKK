using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class County
    {
        public int CountyID { get; set; }

        [StringLength(75)]
        [Display(Name = "County*")]
        public string CountyName { get; set; }

        
        public bool Metro8Indicator { get; set; }

        public ICollection<Case> Cases { get; set; }
    }
}