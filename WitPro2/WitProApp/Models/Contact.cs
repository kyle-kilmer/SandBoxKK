using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class Contact
    {
        public int ContactID { get; set; }

        [StringLength(75)]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [StringLength(75)]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Display(Name = "County Contact")]
        public string FullName
        {
            get
            {
                return LastName + ", " + FirstName;
            }
        }

        [StringLength(75)]
        public string Title { get; set; }

        public int? CountyID { get; set; }
        public virtual County County { get; set; }

        [StringLength(75)]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [StringLength(30)]
        [Display(Name = "Office Phone Number")]
        public string PhoneNumberOffice { get; set; }

        [StringLength(30)]
        [Display(Name = "Mobile Phone Number")]
        public string PhoneNumberMobile { get; set; }

        [StringLength(30)]
        [Display(Name = "Fax Number")]
        public string FaxNumber { get; set; }

        public int? Active { get; set; }

        public virtual ICollection<Case> Cases { get; set; }
    }
}