using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WitProApp.Models
{
    public class MultipleThreatType
    {
        [Key, Column(Order = 0)]
        public int CaseID { get; set; }

        [Key, Column(Order = 1)]
        public int ThreatTypeID { get; set; }

        public virtual Case Case { get; set; }
        public virtual ThreatType ThreatType { get; set; }
    }
}