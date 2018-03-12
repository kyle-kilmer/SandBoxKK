using System.ComponentModel.DataAnnotations;

namespace WitProApp.Models
{
    public class Attachment
    {
        public int AttachmentID { get; set; }
        public virtual int CaseID { get; set; }
        public Case Case { get; set; }

        public string Name { get; set; }
        public string ContentType { get; set; }
        public byte[] Data { get; set; }

        [Display(Name = "Uploaded Date")]
        public string UploadDate { get; set; }
    }
}