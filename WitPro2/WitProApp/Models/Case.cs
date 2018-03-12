using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace WitProApp.Models
{
    public class Case
    {
        
        public int CaseID { get; set; }

        [StringLength(50)]
        [Display(Name = "NYPTI Case Number")]
        public string NYPTICaseNumber { get; set; }

        
        [Display(Name = "County Case Number")]
        public string CountyCaseNumber { get; set; }

        [Required]
        [Display(Name = "Initial Contact Date")]
        [DataType(DataType.Text)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime? InitialContactDate { get; set; }


        [Required(ErrorMessage = "Choosing a NYPTI contact person is required")]
        public int? EmployeeID { get; set; }
        public virtual Employee Employee { get; set; }

        [Required(ErrorMessage = "Choosing a county is required")]
        public int? CountyID { get; set; }
        public virtual County County { get; set; }

        public int? ContactID { get; set; }
        public virtual Contact Contact { get; set; }

        
        public List<int> ChargeID { get; set; }
        public virtual ICollection<MultipleCharge> Charge { get; set; }

        [StringLength(150)]
        [Display(Name = "Charge (if other)")]
        public string ChargeOther { get; set; }

        [Display(Name = "Case Type")]
        public List<int> CaseTypeID { get; set; }
        public virtual ICollection<MultipleCaseTypes> CaseType { get; set; }

        [Display(Name = "Case Stage")]
        public List<int> CaseStageID { get; set; }
        public virtual ICollection<MultipleCaseStage> CaseStage { get; set; }

        public List<int> ThreatTypeID { get; set; }
        public virtual ICollection<MultipleThreatType> ThreatType { get; set; }

        [Display(Name = "When Threats Began")]
        [StringLength(150)]
        public String ThreatBeganDate { get; set; }

        [StringLength(1500)]
        [DataType(DataType.MultilineText)]
        [Display(Name = "Brief Facts of Case")]
        public string FactsOfCase { get; set; }


        [Display(Name = "Charge for Threats")]
        public int? ThreatChargeID { get; set; }
        public virtual ThreatCharge ThreatCharge { get; set; }

        public int? ApprovalStatusID { get; set; }
        public virtual ApprovalStatus ApprovalStatus { get; set; }

        public int? StatusReasonID { get; set; }
        public virtual StatusReason StatusReason { get; set; }


        [Display(Name = "Status Reason (if other)")]
        [StringLength(150)]
        public String StatusReasonOther { get; set; }

        [StringLength(255)]
        [DataType(DataType.MultilineText)]
        public string Plan { get; set; }


        //--------Funds For Section-----------
        [Display(Name = "# of Adults (male)")]
        [Range(0, 100, ErrorMessage = "Only positive numbers are allowed")]
        public int? NumAdultsMale { get; set; }

        [Display(Name = "# of Adults (female)")]
        [Range(0, 100, ErrorMessage = "Only positive numbers are allowed")]
        public int? NumAdultsFemale { get; set; }

        [Display(Name = "# of Children (under 18)")]
        [Range(0, 100, ErrorMessage = "Only positive numbers are allowed")]
        public int? NumChildren { get; set; }

        [Display(Name = "Any with Special Needs")]
        public bool SpecialNeedsYN { get; set; }

        [Display(Name = "Fund Purpose Notes")]
        [StringLength(255)]
        [DataType(DataType.MultilineText)]
        public string FundsPurposeNotes { get; set; }
        
        //-----End Funds For Section-----------


        [DataType(DataType.Text)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        [Display(Name = "Date Closing Letter Received")]
        public DateTime? ClosingLetterReceivedDate { get; set; }

        [StringLength(255)]
        [Display(Name = "Case Disposition")]
        public string CaseDisposition { get; set; }

        [Display(Name = "Witness Threats in Disposition?")]
        public int? WitnessThreatsInDispo { get; set; }

        [DataType(DataType.Text)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        [Display(Name = "Date Final Tally Returned")]
        public DateTime? DateFinalTallyReturned { get; set; }

        [StringLength(255)]
        [DataType(DataType.MultilineText)]
        [Display(Name = "Notes About Case")]
        public string CaseNotes { get; set; }

        [StringLength(1000)]
        [Display(Name = "Reference Link 1")]
        public string Link1 { get; set; }

        [StringLength(1000)]
        [Display(Name = "Reference Link 2")]
        public string Link2 { get; set; }

        [StringLength(1000)]
        [Display(Name = "Reference Link 3")]
        public string Link3 { get; set; }

        public virtual ICollection<Dispersal> Dispersal { get; set; }

        public int? Active { get; set; }

        [ScaffoldColumn(false)]
        public DateTime CreatedDate { get; set; }

        public virtual ICollection<Attachment> Attachments { get; set; }



    }
}