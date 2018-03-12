using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using WitProApp.DAL;
using WitProApp.ViewModels;

namespace WitProApp.Controllers
{
    public class ReportsController : Controller
    {

        private WitProContext db = new WitProContext();

        public ActionResult Reports(string dateStart, string dateEnd)
        {

            //default to the beginning of the current year to the present day
            if (dateStart == null)
            {
                dateStart = "1/01/" + System.DateTime.Now.Year.ToString();
            }
            if (dateEnd == null)
            {
                dateEnd = System.DateTime.Now.ToShortDateString();
            }

            ViewBag.dateStart = dateStart;
            ViewBag.dateEnd = dateEnd;

            DateTime startDate = DateTime.Parse(dateStart);
            DateTime endDate = DateTime.Parse(dateEnd);

            //get all dispersals
            var cases = db.Cases
                .Include(c => c.Dispersal)
                .Where(c => c.Active == 1)
                .Where(c => c.InitialContactDate >= startDate && c.InitialContactDate <= endDate)
                .ToList();


            //get summary info
            ViewBag.metro8Cases = cases.Where(c => c.County.Metro8Indicator == true).Count();
            ViewBag.nonMetro8Cases = cases.Where(c => c.County.Metro8Indicator == false).Count();

            decimal? metro8Total = 0;
            decimal? nonMetro8Total = 0;

            foreach (var cs in cases)
            {
                if(cs.Dispersal.Count() > 0)
                {
                    var caseDispersals = db.Dispersals
                        .Where(d => d.CaseID == cs.CaseID)
                        .Where(d => d.Active == 1)
                        .ToList();

                    if (cs.County.Metro8Indicator == true)
                    {
                        foreach(var dispersal in caseDispersals)
                        {
                            metro8Total += dispersal.AmountApproved.HasValue ? dispersal.AmountApproved : 0;
                        }
                    }
                    else
                    {
                        foreach (var dispersal in caseDispersals)
                        {
                            nonMetro8Total += dispersal.AmountApproved.HasValue ? dispersal.AmountApproved : 0;
                        }
                    }
                }

            }

            ViewBag.metro8Contributions = metro8Total;
            ViewBag.nonMetro8Contributions = nonMetro8Total;





            //display details (each county)

            List<ReportingVM> CountyList = new List<ReportingVM>();

            var counties = db.County
                .Include(c => c.Cases)
                .ToList();

        
            foreach(var cty in counties)
            {
                ReportingVM rVM = new ReportingVM();
                rVM.CountyName = cty.CountyName;
                rVM.MetroYN = cty.Metro8Indicator;

                rVM.Cases = db.Cases
                            .Where(c => c.County.CountyName == cty.CountyName)
                            .Where(c => c.InitialContactDate >= startDate && c.InitialContactDate <= endDate)
                            .Where(c => c.Active == 1)
                            .ToList();

                rVM.Dispersals = db.Dispersals
                                .Where(d => d.Case.County.CountyName == cty.CountyName)
                                .Where(d => d.Active == 1)
                                .Where(d => d.Case.InitialContactDate >= startDate && d.Case.InitialContactDate <= endDate)
                                .Where(d => d.Case.Active == 1)
                                .ToList();
                                
                CountyList.Add(rVM);   

            }
                


            return View(CountyList.ToList());

         }

        public ActionResult ExportToExcel()
        {
            string header = "County Name,NYPTI Case #,County #,Metro 8?,Amount Requested,Amount Approved\n";

            string csv = string.Concat(from cnty in db.County
                                       join c in db.Cases on cnty.CountyID equals c.CountyID 
                                       join disp in db.Dispersals on c.CaseID equals disp.CaseID into cd
                                       from caseDispersal in cd.DefaultIfEmpty()

                                       select cnty.CountyName + "," +
                                            c.NYPTICaseNumber + "," +
                                            c.CountyCaseNumber + "," +
                                           cnty.Metro8Indicator + "," +
                                           caseDispersal.AmountRequested + "," +
                                           caseDispersal.AmountApproved + ","
                                            + "\n");

            return File(new System.Text.UTF8Encoding().GetBytes(string.Concat(header, csv)), "text/csv", "WitnessProtectionList.csv");

        }



    }
}