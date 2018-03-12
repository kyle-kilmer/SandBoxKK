using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WitProApp.Models
{
    public class MultipleCharge
    {
        [Key, Column(Order = 0)]
        public int CaseID { get; set; }

        [Key, Column(Order = 1)]
        public int ChargeID { get; set; }

        public virtual Case Case { get; set; }
        public virtual Charge Charge { get; set; }
    }
}