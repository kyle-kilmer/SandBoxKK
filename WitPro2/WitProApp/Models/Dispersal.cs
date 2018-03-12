using System;
using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class Dispersal
    {
        public int DispersalID { get; set; }

        public int CaseID { get; set; }


        [Display(Name = "Date Requested*")]
        [Required]
        [DataType(DataType.Text)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime? DispersalRequestDate { get; set; }

        

        [Display(Name = "Amount Requested")]
        [DataType(DataType.Currency)]
        public decimal? AmountRequested { get; set; }


        public int? DispersalApprovalStatusID { get; set; }
        public virtual ApprovalStatus ApprovalStatus { get; set; }

        [Display(Name = "Reason if not Approved")]
        [StringLength(125)]
        public string DisperalApprovalStatusReason { get; set; }

        [Display(Name = "Amount Approved")]
        [DataType(DataType.Currency)]
        public decimal? AmountApproved { get; set; }

        [Display(Name = "Check Number")]
        public string CheckNumber { get; set; }


        [Display(Name = "Date Sent")]
        [DataType(DataType.Text)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime? DateSent { get; set; }

        [Display(Name = "Date Cleared")]
        [DataType(DataType.Text)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime? DateCleared { get; set; }

        [Display(Name = "Amount Returned")]
        [DataType(DataType.Currency)]
        public decimal? AmountReturned { get; set; }

        [Display(Name = "Date Returned")]
        [DataType(DataType.Text)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime? DateReturned { get; set; }

        [StringLength(255)]
        [DataType(DataType.MultilineText)]
        [Display(Name = "Dispersal Notes")]
        public string DispersalNotes { get; set; }

        public int? GrantTypeID { get; set; }
        public virtual GrantType GrantType { get; set; }

        public int? Active { get; set; }

        public virtual Case Case { get; set; }


    }
}