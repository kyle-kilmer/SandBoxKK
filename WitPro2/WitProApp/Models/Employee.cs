using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    [DisplayColumn("Email")]
    public class Employee
    {
        public int EmployeeID { get; set; }

        [Required]
        [StringLength(75)]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required]
        [StringLength(75)]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Display(Name = "Initial NYPTI Contact*")]
        public string FullName { get {
                return LastName+", "+FirstName;
            } }

        [StringLength(75)]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        public int? Active { get; set; }

        public virtual ICollection<Case> Cases { get; set; }
    }
}