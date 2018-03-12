using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WitProApp.Models
{
    public class MultipleCaseTypes
    {
        [Key, Column(Order = 0)]
        public int CaseID { get; set; }

        [Key, Column(Order = 1)]
        public int CaseTypeID { get; set; }

        public virtual Case Case { get; set; }
        public virtual CaseType CaseType { get; set; }
    }
}