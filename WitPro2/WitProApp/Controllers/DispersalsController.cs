using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using WitProApp.DAL;
using WitProApp.Models;

namespace WitProApp.Controllers
{
    public class DispersalsController : Controller
    {
        private WitProContext db = new WitProContext();

        // GET: Dispersals
        public ActionResult Index()
        {
            return View(db.Dispersals.ToList());
        }

       
        // GET: Dispersals/Create
        public ActionResult Create(int? caseID)
        {
            ViewBag.GrantTypeID = new SelectList(db.GrantType, "GrantTypeID", "DisplayName");
            ViewBag.ApprovalStatusID = new SelectList(db.ApprovalStatus, "ApprovalStatusID", "DisplayName");

            Dispersal dispersal = new Dispersal();
            dispersal.CaseID = caseID.GetValueOrDefault();

            return View(dispersal);
        }

        // POST: Dispersals/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "DispersalID,CaseID,DispersalRequestDate,CheckNumber,AmountRequested,DispersalApprovalStatusID,DisperalApprovalStatusReason,AmountApproved,DateSent,DateCleared,AmountReturned,DateReturned,GrantTypeID,DispersalNotes,Active")] Dispersal dispersal)
        {
            if (ModelState.IsValid)
            {
                dispersal.Active = 1;
                db.Dispersals.Add(dispersal);
                db.SaveChanges();
                TempData["UserMessage"] = "Your dispersal was created";
                return RedirectToAction("Edit", "Cases", new { id = dispersal.CaseID });
            }
            ViewBag.GrantTypeID = new SelectList(db.GrantType, "GrantTypeID", "DisplayName", dispersal.GrantTypeID);
            ViewBag.ApprovalStatusID = new SelectList(db.ApprovalStatus, "ApprovalStatusID", "DisplayName", dispersal.DispersalApprovalStatusID);

            return View(dispersal);
        }

        // GET: Dispersals/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Dispersal dispersal = db.Dispersals.Find(id);
            if (dispersal == null)
            {
                return HttpNotFound();
            }
            ViewBag.GrantTypeID = new SelectList(db.GrantType, "GrantTypeID", "DisplayName", dispersal.GrantTypeID);
            ViewBag.ApprovalStatusID = new SelectList(db.ApprovalStatus, "ApprovalStatusID", "DisplayName", dispersal.DispersalApprovalStatusID);
            return View(dispersal);
        }

        // POST: Dispersals/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "DispersalID,CaseID,DispersalRequestDate,CheckNumber,AmountRequested,DispersalApprovalStatusID,DisperalApprovalStatusReason,AmountApproved,DateSent,DateCleared,AmountReturned,DateReturned,GrantTypeID,DispersalNotes,Active")] Dispersal dispersal)
        {
            if (ModelState.IsValid)
            {
                db.Entry(dispersal).State = EntityState.Modified;
                db.SaveChanges();
                TempData["UserMessage"] = "Your changes were saved";
                return RedirectToAction("Edit","Cases", new { id = dispersal.CaseID });
            }
            ViewBag.GrantTypeID = new SelectList(db.GrantType, "GrantTypeID", "DisplayName", dispersal.GrantTypeID);
            ViewBag.ApprovalStatusID = new SelectList(db.ApprovalStatus, "ApprovalStatusID", "DisplayName", dispersal.DispersalApprovalStatusID);
            return View(dispersal);
        }

        // GET: Dispersals/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Dispersal dispersal = db.Dispersals.Find(id);
            if (dispersal == null)
            {
                return HttpNotFound();
            }
            return View(dispersal);
        }

        // POST: Dispersals/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Dispersal dispersal = db.Dispersals.Find(id);
            dispersal.Active = 0;
            db.SaveChanges();
            return RedirectToAction("Edit", "Cases", new { id = dispersal.CaseID });
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
