using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WitProApp.DAL;
using WitProApp.Models;

namespace WitProApp.Controllers
{
    public class AttachmentController : Controller
    {
        private WitProContext db = new WitProContext();

        // GET: Attachment
        public ActionResult Index(int CaseID)
        {
            ViewBag.CaseID = CaseID;
            return View(GetFiles(CaseID));
        }

        [HttpPost]
        public ActionResult Index(HttpPostedFileBase postedFile, int CaseID)
        {
            ViewBag.CaseID = CaseID;

            var attachment = new Attachment();
            byte[] bytes;
            using (BinaryReader br = new BinaryReader(postedFile.InputStream))
            {
                bytes = br.ReadBytes(postedFile.ContentLength);
            }
            if (ModelState.IsValid)
            {
                attachment.Name = Path.GetFileName(postedFile.FileName);
                attachment.ContentType = postedFile.ContentType;
                attachment.Data = bytes;
                attachment.CaseID = CaseID;
                attachment.UploadDate = DateTime.Now.ToShortDateString();

                db.Attachments.Add(attachment);
                db.SaveChanges();
                TempData["UserMessage"] = "Your attachment has been added";
            }

            return View(GetFiles(CaseID));
        }

        [HttpPost]
        public FileResult DownloadFile(int? fileId)
        {
            byte[] bytes;
            string fileName, contentType;

            var attachment = db.Attachments.Where(a => a.AttachmentID == fileId).FirstOrDefault();

            contentType = attachment.ContentType.ToString();
            fileName = attachment.Name.ToString();
            bytes = (byte[])attachment.Data;

            return File(bytes, contentType, fileName);
        }

        private List<Attachment> GetFiles(int caseID)
        {

            var attachments = db.Attachments.Where(a => a.CaseID == caseID);
            return attachments.ToList();

        }
    }
}