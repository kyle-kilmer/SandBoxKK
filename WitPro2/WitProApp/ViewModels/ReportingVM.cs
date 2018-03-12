using System.Collections.Generic;
using WitProApp.Models;

namespace WitProApp.ViewModels
{
    public class ReportingVM
    {
        public string CountyName { get; set; }
        public bool MetroYN { get; set; }
        public ICollection<Case> Cases { get; set; }
        public ICollection<Dispersal> Dispersals { get; set; }

    }
}