using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using WitProApp.DAL;
using WitProApp.Models;

namespace WitProApp.Controllers
{
    public class CasesController : Controller
    {
        private WitProContext db = new WitProContext();

        // GET: Cases
        public ActionResult Index(int recentMonthsFilter = 6)
        {
            ViewBag.ShowLast6Months = (recentMonthsFilter == 6) ? true : false; 
            var ageToDisplayMonths = System.DateTime.Now.Date.AddMonths(- recentMonthsFilter);
            var cases = db.Cases
                .Include(c => c.ApprovalStatus)
                .Include(c => c.CaseType)
                .Include(c => c.CaseStage)
                .Include(c => c.Charge)
                .Include(c => c.Contact)
                .Include(c => c.County)
                .Include(c => c.Employee)
                .Include(c => c.ThreatCharge)
                .Include(c => c.ThreatType)
                .Include(c => c.Dispersal)
                .Include(c => c.StatusReason)
                .Where(c => c.Active == 1)
                .Where(c => c.InitialContactDate >= ageToDisplayMonths)
                .OrderByDescending(c => c.InitialContactDate)
                .ThenByDescending(c => c.CaseID);
            return View(cases.ToList());
        }


        // GET: Cases/Create
        public ActionResult Create()
        {
            ViewBag.ApprovalStatusID = new SelectList(db.ApprovalStatus, "ApprovalStatusID", "DisplayName");
            ViewBag.CaseStageID = new MultiSelectList(db.CaseStage, "CaseStageID", "DisplayName");
            ViewBag.CaseTypeID = new MultiSelectList(db.CaseType, "CaseTypeID", "DisplayName");
            ViewBag.ChargeID = new MultiSelectList(db.Charge, "ChargeID", "DisplayName");
            ViewBag.CountyID = new SelectList(db.County, "CountyID", "CountyName");
            ViewBag.EmployeeID = new SelectList(db.Employee, "EmployeeID", "FullName");
            ViewBag.ThreatChargeID = new SelectList(db.ThreatCharge, "ThreatChargeID", "DisplayName");
            ViewBag.ThreatTypeID = new MultiSelectList(db.ThreatType, "ThreatTypeID", "DisplayName");
            ViewBag.StatusReasonID = new SelectList(db.StatusReason, "StatusReasonID", "DisplayName");

            int nextCaseNumberBase = -999;
            string currentYear = System.DateTime.Now.Year.ToString();

            var casetemp = db.Cases
                .Where(c => c.CreatedDate.Year.ToString() == currentYear) 
                .OrderByDescending(c => c.CaseID).FirstOrDefault();

            if (casetemp == null) 
            {
                nextCaseNumberBase = 1;
            }
            else
            {
                string lastCaseNumber = casetemp.NYPTICaseNumber.Substring(0, 3);
                nextCaseNumberBase = int.Parse(lastCaseNumber) + 1;
            }
                 

            Case newCase = new Case
            {
                NYPTICaseNumber = nextCaseNumberBase.ToString("D3") + "-" + currentYear.ToString()
            };

            newCase.InitialContactDate = System.DateTime.Now.Date;

            return View(newCase);
        }

        //[HttpPost]
        public JsonResult GetContacts(int? countyID)
        {
            db.Configuration.LazyLoadingEnabled = false;
            List<Contact> contacts = new List<Contact>();
            contacts = db.Contact
                .Where(c => c.CountyID == countyID)
                .Where(c => c.Active == 1)
                .ToList();
            return Json(contacts);
        }

        // POST: Cases/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]

        public ActionResult Create([Bind(Include = "CaseID,NYPTICaseNumber,CountyCaseNumber,InitialContactDate,EmployeeID,CountyID,ContactID,ChargeID,CaseTypeID,CaseStageID," +
                                        "ThreatTypeID,ThreatBeganDate,FactsOfCase,ThreatChargeID,Plan,CaseNotes,NumAdultsMale,NumAdultsFemale,NumChildren,SpecialNeedsYN,FundsPurposeNotes,Link1,Link2,Link3")] Case @case)
        {


            if (ModelState.IsValid)
            {
                @case = AddUpdateCaseTypes(@case, false);
                @case = AddUpdateCaseStage(@case, false);
                @case = AddUpdateCharge(@case, false);
                @case = AddUpdateThreatType(@case, false);
                @case.Active = 1;
                @case.CreatedDate = System.DateTime.Now;
                db.Cases.Add(@case);
                db.SaveChanges();
                TempData["UserMessage"] = "Your case has been created";
                return RedirectToAction("Edit", "Cases", new { id = @case.CaseID });
            }

            ViewBag.ApprovalStatusID = new SelectList(db.ApprovalStatus, "ApprovalStatusID", "DisplayName", @case.ApprovalStatusID);
            ViewBag.CaseStageID = new MultiSelectList(db.CaseStage, "CaseStageID", "DisplayName", @case.CaseStage != null ? @case.CaseStage.Select(c => c.CaseStageID).ToList() : @case.CaseStageID);
            ViewBag.CaseTypeID = new MultiSelectList(db.CaseType, "CaseTypeID", "DisplayName", @case.CaseType != null ? @case.CaseType.Select(c => c.CaseTypeID).ToList() : @case.CaseTypeID);
            ViewBag.ChargeID = new MultiSelectList(db.Charge, "ChargeID", "DisplayName", @case.Charge != null ? @case.Charge.Select(c => c.ChargeID).ToList() : @case.ChargeID);
            ViewBag.CountyID = new SelectList(db.County, "CountyID", "CountyName", @case.CountyID);
            ViewBag.EmployeeID = new SelectList(db.Employee, "EmployeeID", "Email", @case.EmployeeID);
            ViewBag.ThreatChargeID = new SelectList(db.ThreatCharge, "ThreatChargeID", "DisplayName", @case.ThreatChargeID);
            ViewBag.ThreatTypeID = new MultiSelectList(db.ThreatType, "ThreatTypeID", "DisplayName", @case.ThreatType != null ? @case.ThreatType.Select(c => c.ThreatTypeID).ToList() : @case.ThreatTypeID);
            ViewBag.StatusReasonID = new SelectList(db.StatusReason, "StatusReasonID", "DisplayName", @case.StatusReasonID);
            return View(@case);
        }

        // GET: Cases/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Case @case = db.Cases.Find(id);
            if (@case == null)
            {
                return HttpNotFound();
            }            
            ViewBag.ApprovalStatusID = new SelectList(db.ApprovalStatus, "ApprovalStatusID", "DisplayName", @case.ApprovalStatusID);
            ViewBag.CaseStageID = new MultiSelectList(db.CaseStage, "CaseStageID", "DisplayName", @case.CaseStage.Select(c => c.CaseStageID).ToList());
            ViewBag.CaseTypeID = new MultiSelectList(db.CaseType, "CaseTypeID", "DisplayName", @case.CaseType.Select(c => c.CaseTypeID).ToList());
            ViewBag.ChargeID = new MultiSelectList(db.Charge, "ChargeID", "DisplayName", @case.Charge.Select(c => c.ChargeID).ToList());
            ViewBag.ContactID = new SelectList(db.Contact, "ContactID", "FullName", @case.ContactID);
            ViewBag.CountyID = new SelectList(db.County, "CountyID", "CountyName", @case.CountyID);
            ViewBag.EmployeeID = new SelectList(db.Employee, "EmployeeID", "FullName", @case.EmployeeID);
            ViewBag.ThreatChargeID = new SelectList(db.ThreatCharge, "ThreatChargeID", "DisplayName", @case.ThreatChargeID);
            ViewBag.ThreatTypeID = new MultiSelectList(db.ThreatType, "ThreatTypeID", "DisplayName", @case.ThreatType.Select(c => c.ThreatTypeID).ToList());
            ViewBag.StatusReasonID = new SelectList(db.StatusReason, "StatusReasonID", "DisplayName", @case.StatusReasonID);
            return View(@case);
        }

        // POST: Cases/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CaseID,NYPTICaseNumber,CountyCaseNumber,InitialContactDate,CountyID,EmployeeID,ContactID,ChargeID,CaseTypeID,CaseStageID,ThreatTypeID," +
            "ThreatBeganDate,FactsOfCase,ThreatChargeID,ApprovalStatusID,StatusReasonID,Plan,ClosingLetterReceivedDate,CaseDisposition,WitnessThreatsInDispo,DateFinalTallyReturned,CaseNotes," +
            "Dispersal,Active,CreatedDate,StatusReasonOther,NumAdultsMale,NumAdultsFemale,NumChildren,SpecialNeedsYN,FundsPurposeNotes,Link1,Link2,Link3")] Case @case)
        {
            if (ModelState.IsValid)
            {
                @case = AddUpdateCaseTypes(@case, true);
                @case = AddUpdateCaseStage(@case, true);
                @case = AddUpdateCharge(@case, true);
                @case = AddUpdateThreatType(@case, true);
                db.Entry(@case).State = EntityState.Modified;                
                db.SaveChanges();
                TempData["UserMessage"] = "Your changes were saved";
                return RedirectToAction("Edit", "Cases", new { id = @case.CaseID });
            }
            ViewBag.ApprovalStatusID = new SelectList(db.ApprovalStatus, "ApprovalStatusID", "DisplayName", @case.ApprovalStatusID);
            ViewBag.CaseStageID = new MultiSelectList(db.CaseStage, "CaseStageID", "DisplayName", @case.CaseStage != null ? @case.CaseStage.Select(c => c.CaseStageID).ToList() : @case.CaseStageID);
            ViewBag.CaseTypeID = new MultiSelectList(db.CaseType, "CaseTypeID", "DisplayName", @case.CaseType != null ? @case.CaseType.Select(c => c.CaseTypeID).ToList() : @case.CaseTypeID);
            ViewBag.ChargeID = new MultiSelectList(db.Charge, "ChargeID", "DisplayName", @case.Charge != null ? @case.Charge.Select(c => c.ChargeID).ToList() : @case.ChargeID);            
            ViewBag.CountyID = new SelectList(db.County, "CountyID", "CountyName", @case.CountyID);
            ViewBag.ContactID = new SelectList(db.Contact, "ContactID", "FullName", @case.ContactID);
            ViewBag.EmployeeID = new SelectList(db.Employee, "EmployeeID", "Email", @case.EmployeeID);
            ViewBag.ThreatChargeID = new SelectList(db.ThreatCharge, "ThreatChargeID", "DisplayName", @case.ThreatChargeID);
            ViewBag.ThreatTypeID = new MultiSelectList(db.ThreatType, "ThreatTypeID", "DisplayName", @case.ThreatType != null ? @case.ThreatType.Select(c => c.ThreatTypeID).ToList() : @case.ThreatTypeID);
            ViewBag.StatusReasonID = new SelectList(db.StatusReason, "StatusReasonID", "DisplayName", @case.StatusReasonID);
            return View(@case);
        }

        public Case AddUpdateCaseTypes(Case input, bool delete)
        {
            if (input.CaseTypeID != null)
            {
                foreach (var CaseTypeID in input.CaseTypeID)
                {
                    MultipleCaseTypes caseTypes = db.CaseCaseTypes.Find(input.CaseID, CaseTypeID);
                    if (caseTypes == null)
                    {
                        if (input.CaseType == null)
                        {
                            input.CaseType = new List<MultipleCaseTypes>();
                        }
                        var child = new MultipleCaseTypes { CaseID = input.CaseID, CaseTypeID = CaseTypeID };
                        db.CaseCaseTypes.Add(child);
                    }
                }
                if (delete)
                {
                    var toDelete = db.CaseCaseTypes.Where(c => c.CaseID == input.CaseID && !input.CaseTypeID.Contains(c.CaseTypeID)).ToList();
                    db.CaseCaseTypes.RemoveRange(toDelete);
                }
            }
            else
            {
                var toDelete = db.CaseCaseTypes.Where(c => c.CaseID == input.CaseID).ToList();
                db.CaseCaseTypes.RemoveRange(toDelete);
            }
            return input;
        }

        public Case AddUpdateCharge(Case input, bool delete)
        {
            if (input.ChargeID != null)
            {
                foreach (var ChargeID in input.ChargeID)
                {
                    var caseCharges = db.CaseCharges.Find(input.CaseID, ChargeID);
                    if (caseCharges == null)
                    {
                        if (input.Charge == null)
                        {
                            input.Charge = new List<MultipleCharge>();
                        }
                        var child = new MultipleCharge { CaseID = input.CaseID, ChargeID = ChargeID };
                        db.CaseCharges.Add(child);
                    }
                }
                if (delete)
                {
                    var toDelete = db.CaseCharges.Where(c => c.CaseID == input.CaseID && !input.ChargeID.Contains(c.ChargeID)).ToList();
                    db.CaseCharges.RemoveRange(toDelete);
                }
            }       
            else
            {
                var toDelete = db.CaseCharges.Where(c => c.CaseID == input.CaseID).ToList();
                db.CaseCharges.RemoveRange(toDelete);
            }
            return input;
        }

        public Case AddUpdateCaseStage(Case input, bool delete)
        {
            if (input.CaseStageID != null)
            {
                foreach (var caseStageID in input.CaseStageID)
                {
                    var caseStage = db.CaseCaseStage.Find(input.CaseID, caseStageID);
                    if (caseStage == null)
                    {
                        if (input.CaseStage == null)
                        {
                            input.CaseStage = new List<MultipleCaseStage>();
                        }
                        var child = new MultipleCaseStage { CaseID = input.CaseID, CaseStageID = caseStageID };
                        db.CaseCaseStage.Add(child);
                    }
                }
                if (delete)
                {
                    var toDelete = db.CaseCaseStage.Where(c => c.CaseID == input.CaseID && !input.CaseStageID.Contains(c.CaseStageID)).ToList();
                    db.CaseCaseStage.RemoveRange(toDelete);
                }
            }    
            else
            {
                var toDelete = db.CaseCaseStage.Where(c => c.CaseID == input.CaseID).ToList();
                db.CaseCaseStage.RemoveRange(toDelete);
            }
            return input;
        }

        public Case AddUpdateThreatType(Case input, bool delete)
        {
            if (input.ThreatTypeID != null)
            {
                foreach (var ThreatTypeID in input.ThreatTypeID)
                {
                    var caseThreatType = db.CaseThreatType.Find(input.CaseID, ThreatTypeID);
                    if (caseThreatType == null)
                    {
                        if (input.ThreatType == null)
                        {
                            input.ThreatType = new List<MultipleThreatType>();
                        }
                        var child = new MultipleThreatType { CaseID = input.CaseID, ThreatTypeID = ThreatTypeID };
                        db.CaseThreatType.Add(child);
                    }
                }
                if (delete)
                {
                    var toDelete = db.CaseThreatType.Where(c => c.CaseID == input.CaseID && !input.ThreatTypeID.Contains(c.ThreatTypeID)).ToList();
                    db.CaseThreatType.RemoveRange(toDelete);
                }
            }     
            else
            {
                var toDelete = db.CaseThreatType.Where(c => c.CaseID == input.CaseID).ToList();
                db.CaseThreatType.RemoveRange(toDelete);
            }
            return input;
        }

        // GET: Cases/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Case @case = db.Cases.Find(id);
            if (@case == null)
            {
                return HttpNotFound();
            }
            return View(@case);
        }

        // POST: Cases/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Case @case = db.Cases.Find(id);
            @case.Active = 0;
            db.SaveChanges();
            return RedirectToAction("Index");
        }

       

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
