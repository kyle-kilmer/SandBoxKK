using System.Web.Mvc;

namespace WitProApp.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Reports()
        {
            return View();
        }

        //public ActionResult SeedDB()
        //{
        //    var seed = new WitProApp.Other.SeedScript();
        //    seed.AddInitialValues();
        //    return RedirectToAction("Index","Cases");

        //}
    }
}