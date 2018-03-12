using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using WitProApp.DAL;
using WitProApp.Models;

namespace WitProApp.Controllers
{
    public class GrantTypesController : Controller
    {
        private WitProContext db = new WitProContext();

        // GET: GrantTypes
        public ActionResult Index()
        {
            return View(db.GrantType.ToList());
        }

        // GET: GrantTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: GrantTypes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "GrantTypeID,DisplayName")] GrantType grantType)
        {
            if (ModelState.IsValid)
            {
                db.GrantType.Add(grantType);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(grantType);
        }

        // GET: GrantTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            GrantType grantType = db.GrantType.Find(id);
            if (grantType == null)
            {
                return HttpNotFound();
            }
            return View(grantType);
        }

        // POST: GrantTypes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "GrantTypeID,DisplayName")] GrantType grantType)
        {
            if (ModelState.IsValid)
            {
                db.Entry(grantType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(grantType);
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
