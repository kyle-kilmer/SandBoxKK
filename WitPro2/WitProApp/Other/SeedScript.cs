using System.Collections.Generic;
using WitProApp.DAL;
using WitProApp.Models;

namespace WitProApp.Other
{
    public class SeedScript
    {
        public void AddInitialValues()
        {
            var context = new WitProContext();

            //add to migration
            //var seed = new WitProApp.Other.SeedScript();
            //seed.AddInitialValues();

            var counties = new List<County>
            {
                new County{CountyName="Albany"},
                new County{CountyName="Allegany"},
                new County{CountyName="Bronx",Metro8Indicator=true},
                new County{CountyName="Broome"},
                new County{CountyName="Cattaraugus"},
                new County{CountyName="Cayuga"},
                new County{CountyName="Chautauqua"},
                new County{CountyName="Chemung"},
                new County{CountyName="Chenango"},
                new County{CountyName="Clinton"},
                new County{CountyName="Columbia"},
                new County{CountyName="Cortland"},
                new County{CountyName="Delaware"},
                new County{CountyName="Dutchess"},
                new County{CountyName="Erie"},
                new County{CountyName="Essex"},
                new County{CountyName="Franklin"},
                new County{CountyName="Fulton"},
                new County{CountyName="Genesee"},
                new County{CountyName="Greene"},
                new County{CountyName="Hamilton"},
                new County{CountyName="Herkimer"},
                new County{CountyName="Jefferson"},
                new County{CountyName="Kings",Metro8Indicator=true},
                new County{CountyName="Lewis"},
                new County{CountyName="Livingston"},
                new County{CountyName="Madison"},
                new County{CountyName="Monroe"},
                new County{CountyName="Montgomery"},
                new County{CountyName="Nassau",Metro8Indicator=true},
                new County{CountyName="New York",Metro8Indicator=true},
                new County{CountyName="Niagara"},
                new County{CountyName="Oneida"},
                new County{CountyName="Onondaga"},
                new County{CountyName="Ontario"},
                new County{CountyName="Orange"},
                new County{CountyName="Orleans"},
                new County{CountyName="Oswego"},
                new County{CountyName="Otsego"},
                new County{CountyName="Putnam"},
                new County{CountyName="Queens",Metro8Indicator=true},
                new County{CountyName="Rensselaer"},
                new County{CountyName="Richmond",Metro8Indicator=true},
                new County{CountyName="Rockland"},
                new County{CountyName="St Lawrence"},
                new County{CountyName="Saratoga"},
                new County{CountyName="Schenectady"},
                new County{CountyName="Schoharie"},
                new County{CountyName="Schuyler"},
                new County{CountyName="Seneca"},
                new County{CountyName="Steuben"},
                new County{CountyName="Suffolk",Metro8Indicator=true},
                new County{CountyName="Sullivan"},
                new County{CountyName="Tioga"},
                new County{CountyName="Tompkins"},
                new County{CountyName="Ulster"},
                new County{CountyName="Warren"},
                new County{CountyName="Washington"},
                new County{CountyName="Wayne"},
                new County{CountyName="Westchester",Metro8Indicator=true},
                new County{CountyName="Wyoming"},
                new County{CountyName="Yates"}
            };

            counties.ForEach(c => context.County.Add(c));
            context.SaveChanges();

            var employees = new List<Employee>
            {

                new Employee{FirstName="Susan",LastName="Valle",Email="susan.valle@nypti.org", Active=1},
                new Employee{FirstName="Debbie",LastName="Peskin",Email="debbie.peskin@nypti.org", Active=1},
                new Employee{FirstName="Bill",LastName="Callahan",Email="william.callahan@nypti.org", Active=1},
                new Employee{FirstName="Laura",LastName="Peletier",Email="laura.peletier@nypti.org", Active=1},
                new Employee{FirstName="John",LastName="O'Mara",Email="john.omarar@nypti.org", Active=1}
            };

            employees.ForEach(e => context.Employee.Add(e));
            context.SaveChanges();

            //contacts
            var contacts = new List<Contact>
            {
                new Contact{FirstName="Amanda",LastName="Kyle-Sprague",Title=null,CountyID=1,Email="amanda.kyle-sprague@albanycountyny.gov",PhoneNumberOffice="518-275-4734",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Kathryn",LastName="Merrick",Title=null,CountyID=1,Email="Kathryn.Merrick@albanycountyny.com",PhoneNumberOffice="518-275-4716",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Derek",LastName="Lynton",Title=null,CountyID=3,Email="",PhoneNumberOffice="718-838-6647",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Josh",LastName="Shapiro",Title=null,CountyID=4,Email="",PhoneNumberOffice="607-778-2302",PhoneNumberMobile="631-379-7458",FaxNumber="",Active=1},
                new Contact{FirstName="Valerie",LastName="Rettig",Title=null,CountyID=7,Email="Rettigv@co.chautauqua.ny.us",PhoneNumberOffice="716 753-4630",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Philip",LastName="Williams",Title=null,CountyID=11,Email="philip.williams@columbiacountyny.gov",PhoneNumberOffice="518-828-3414",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Sharon",LastName="Simon",Title=null,CountyID=15,Email="",PhoneNumberOffice="716-858-4625",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Paul",LastName="Gliatta",Title=null,CountyID=24,Email="Gliattap@Brooklynda.org",PhoneNumberOffice="718 250-4844",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Jane",LastName="Kim",Title=null,CountyID=24,Email="",PhoneNumberOffice="718-250-4721",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Sam",LastName="Soprano",Title=null,CountyID=28,Email="ssoprano@monroecounty.gov",PhoneNumberOffice="585-753=4592",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Donna",LastName="Hansen",Title=null,CountyID=31,Email="",PhoneNumberOffice="212-335-9008",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Lisa",LastName="Barry",Title=null,CountyID=32,Email="",PhoneNumberOffice="",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="John",LastName="Granchelli",Title=null,CountyID=32,Email="john.granchelli@niagaracounty.com",PhoneNumberOffice="(716) 439-7069",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Heather",LastName="Sloma",Title=null,CountyID=32,Email="heather.sloma@niagaracounty.com",PhoneNumberOffice="716-439-7094",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Todd",LastName="Carville",Title=null,CountyID=33,Email="tcarville@ocgov.net",PhoneNumberOffice="315-798-6038",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Pete",LastName="Small",Title=null,CountyID=34,Email="petersmall@ongov.net",PhoneNumberOffice="315-435-3916  x4343",PhoneNumberMobile="315-409-6292",FaxNumber="",Active=1},
                new Contact{FirstName="John",LastName="Heppes",Title=null,CountyID=36,Email="jheppes@orangecountygov.com",PhoneNumberOffice="",PhoneNumberMobile="845-291-7601",FaxNumber="845-291-4089",Active=1},
                new Contact{FirstName="Mike",LastName="Grasso",Title=null,CountyID=36,Email="",PhoneNumberOffice="845-291-2585",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Mark",LastName="Moody",Title=null,CountyID=38,Email="mmoody@oswegocounty.com",PhoneNumberOffice="315-349-8425",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Daniel",LastName="O'Brien",Title=null,CountyID=41,Email="DMOBrien@queensda.org",PhoneNumberOffice="718-286-6630",PhoneNumberMobile="917 642-2979",FaxNumber="",Active=1},
                new Contact{FirstName="Elizabeth",LastName="Haldeman",Title=null,CountyID=42,Email="",PhoneNumberOffice="518-270-4063",PhoneNumberMobile="518-859-5965",FaxNumber="",Active=1},
                new Contact{FirstName="Sean",LastName="Brannigan",Title=null,CountyID=43,Email="Sean.Brannigan@rcda.nyc.gov",PhoneNumberOffice="718-556-7033",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Erin",LastName="Pierone",Title=null,CountyID=46,Email="epierone@saratogacountyny.gov",PhoneNumberOffice="518-885-2263",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Mollie",LastName="Benware",Title=null,CountyID=46,Email="mbenware@saratogacountyny.gov",PhoneNumberOffice="518-885-2263",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Denise",LastName="Haley",Title=null,CountyID=47,Email="",PhoneNumberOffice="518-388-4364 x4135",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Kristen",LastName="Plyter",Title=null,CountyID=49,Email="",PhoneNumberOffice="607-535-8387",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Steve",LastName="Vandervelden",Title=null,CountyID=60,Email="",PhoneNumberOffice="914-995-3326",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Michelle",LastName="Barber",Title=null,CountyID=55,Email="",PhoneNumberOffice="607-274-5461",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Eric",LastName="Paulding",Title=null,CountyID=56,Email="epau@co.ulster.ny.us",PhoneNumberOffice="845-340-3981",PhoneNumberMobile="845-784-6785",FaxNumber="",Active=1},
                new Contact{FirstName="Valerie",LastName="Hill",Title=null,CountyID=56,Email="vhil@co.ulster.ny.us",PhoneNumberOffice="845-340-3280",PhoneNumberMobile="",FaxNumber="finance person",Active=1},
                new Contact{FirstName="Elizabeth",LastName="Culmone-Mills",Title=null,CountyID=56,Email="ecul@co.ulster.ny.us",PhoneNumberOffice="845-340-1687",PhoneNumberMobile="",FaxNumber="",Active=1},
                new Contact{FirstName="Joey",LastName="Drillings",Title=null,CountyID=56,Email="",PhoneNumberOffice="845-334-5725",PhoneNumberMobile="",FaxNumber="",Active=1},


            };
            contacts.ForEach(c => context.Contact.Add(c));
            context.SaveChanges();

            //CaseStage
            var CaseStages = new List<CaseStage>
            {
                new CaseStage{DisplayName="Pre-Arrest", Active=1},
                new CaseStage{DisplayName="Pre-GJ", Active=1},
                new CaseStage{DisplayName="GJ", Active=1},
                new CaseStage{DisplayName="Post-GJ", Active=1},
                new CaseStage{DisplayName="Pre-Trial", Active=1},
                new CaseStage{DisplayName="Trial", Active=1},
                new CaseStage{DisplayName="Post-Trial", Active=1}
            };
            CaseStages.ForEach(c => context.CaseStage.Add(c));
            context.SaveChanges();


            //CaseType
            var CaseTypes = new List<CaseType>
            {
                new CaseType{DisplayName="Homicide",Active=1},
                new CaseType{DisplayName="Homicide/Assault of a Law Enforcement Official",Active=1},
                new CaseType{DisplayName="Gang Related",Active=1},
                new CaseType{DisplayName="DV",Active=1},
                new CaseType{DisplayName="Narcotics",Active=1},
                new CaseType{DisplayName="Sexual Assault",Active=1},
                new CaseType{DisplayName="Child Abuse",Active=1},
                new CaseType{DisplayName="Gun",Active=1},
                new CaseType{DisplayName="Financial",Active=1},
                new CaseType{DisplayName="DWI",Active=1},
                new CaseType{DisplayName="Corruption/Fraud",Active=1},
                new CaseType{DisplayName="Assault",Active=1},
                new CaseType{DisplayName="Hate Crime",Active=1}
            };
            CaseTypes.ForEach(c => context.CaseType.Add(c));
            context.SaveChanges();

            //ThreatBeganStage
            var ThreatBeganStages = new List<ThreatBeganStage>
            {
                new ThreatBeganStage{DisplayName="Pre-Arrest", Active=1},
                new ThreatBeganStage{DisplayName="Pre-GJ", Active=1},
                new ThreatBeganStage{DisplayName="Indicted", Active=1},
                new ThreatBeganStage{DisplayName="Pre-Trial", Active=1},
                new ThreatBeganStage{DisplayName="Trial", Active=1},
                new ThreatBeganStage{DisplayName="Post-Trial", Active=1}
            };
            ThreatBeganStages.ForEach(c => context.ThreatBeganStage.Add(c));
            context.SaveChanges();

            //ThreatCharge
            var ThreatCharges = new List<ThreatCharge>
            {
                new ThreatCharge{DisplayName="Witness Intimidation - 1st degree",Active=1},
                new ThreatCharge{DisplayName="Witness Intimidation - 2nd degree",Active=1},
                new ThreatCharge{DisplayName="Witness Intimidation - 3rd degree",Active=1},
                new ThreatCharge{DisplayName="Witness Tampering - 1st degree  ",Active=1},
                new ThreatCharge{DisplayName="Witness Tampering - 2nd degree",Active=1},
                new ThreatCharge{DisplayName="Witness Tampering - 3rd degree",Active=1},
                new ThreatCharge{DisplayName="Murder 1 - contract",Active=1},
                new ThreatCharge{DisplayName="Murder 1 - contract (attempted)",Active=1},
                new ThreatCharge{DisplayName="Murder 1 - witness elimination",Active=1},
                new ThreatCharge{DisplayName="Murder 1 - witness elimination (attempted)",Active=1},
                new ThreatCharge{DisplayName="Conspiracy - 1st degree",Active=1},
                new ThreatCharge{DisplayName="Conspiracy - 2nd degree",Active=1},
                new ThreatCharge{DisplayName="Conspiracy - 3rd degree",Active=1},
                new ThreatCharge{DisplayName="Conspiracy - 4th degree",Active=1},
                new ThreatCharge{DisplayName="Conspiracy - 5th degree",Active=1},
                new ThreatCharge{DisplayName="None",Active=1},
                new ThreatCharge{DisplayName="Currently Investigating",Active=1}
            };
            ThreatCharges.ForEach(t => context.ThreatCharge.Add(t));
            context.SaveChanges();

            //ThreatType
            var tt = new List<ThreatType>
            {
                new ThreatType{DisplayName="Physical Attack",Active=1},
                new ThreatType{DisplayName="In Person, at or near court",Active=1},
                new ThreatType{DisplayName="In Person, at or near home",Active=1},
                new ThreatType{DisplayName="On Street",Active=1},
                new ThreatType{DisplayName="Social Media",Active=1},
                new ThreatType{DisplayName="Word on the Street",Active=1},
                new ThreatType{DisplayName="Third Party Contacted",Active=1},
                new ThreatType{DisplayName="Jail Call",Active=1},
                new ThreatType{DisplayName="Letter",Active=1},
                new ThreatType{DisplayName="Phone Call",Active=1},
                new ThreatType{DisplayName="Text",Active=1},
                new ThreatType{DisplayName="Investigation Revealed",Active=1}
            };
            tt.ForEach(t => context.ThreatType.Add(t));
            context.SaveChanges();

            //ApprovalType
            var ApprovalStatuses = new List<ApprovalStatus>
            {
                new ApprovalStatus{DisplayName="Approved",Active=1},
                new ApprovalStatus{DisplayName="Considering",Active=1},
                new ApprovalStatus{DisplayName="Denied",Active=1}
            };
            ApprovalStatuses.ForEach(a => context.ApprovalStatus.Add(a));
            context.SaveChanges();

            //Charge
            var Charges = new List<Charge>
            {
                new Charge{DisplayName="Murder 1",Active=1},
                new Charge{DisplayName="Murder 1 (attempted)",Active=1},
                new Charge{DisplayName="Murder 2",Active=1},
                new Charge{DisplayName="Murder 2 (attempted)",Active=1},
                new Charge{DisplayName="Homicide (other)",Active=1},
                new Charge{DisplayName="Assault 1",Active=1},
                new Charge{DisplayName="Assault 2",Active=1},
                new Charge{DisplayName="Assault 3",Active=1},
                new Charge{DisplayName="Gang Assault B",Active=1},
                new Charge{DisplayName="Gang Assault C",Active=1},
                new Charge{DisplayName="Sexual Assault B",Active=1},
                new Charge{DisplayName="Sexual Assault C",Active=1},
                new Charge{DisplayName="Sexual Assault Other (state below)",Active=1},
                new Charge{DisplayName="Robbery 1",Active=1},
                new Charge{DisplayName="Robbery 2",Active=1},
                new Charge{DisplayName="Burglary 1",Active=1},
                new Charge{DisplayName="Burglary 2",Active=1},
                new Charge{DisplayName="Arson 1",Active=1},
                new Charge{DisplayName="Arson 2",Active=1},
                new Charge{DisplayName="Arson 3",Active=1},
                new Charge{DisplayName="Arson (other)",Active=1},
                new Charge{DisplayName="Criminal Possesion of a Weapon 1",Active=1},
                new Charge{DisplayName="Criminal Possesion of a Weapon 2",Active=1},
                new Charge{DisplayName="Criminal Possesion of a Weapon 3",Active=1},
                new Charge{DisplayName="Criminal Possesion of a Weapon Other (state below)",Active=1},
                new Charge{DisplayName="DWI Charge",Active=1},
                new Charge{DisplayName="Financial Crime",Active=1},
                new Charge{DisplayName="Other (state below)",Active=1}
            };

            Charges.ForEach(t => context.Charge.Add(t));
            context.SaveChanges();

            var grants = new List<GrantType>
            {
                new GrantType{DisplayName="C444475", Active=1}
            };

            grants.ForEach(g => context.GrantType.Add(g));
            context.SaveChanges();

            var statusReasons = new List<StatusReason>
            {
                new StatusReason{DisplayName="County Already Paid",Active=1},
                new StatusReason{DisplayName="Threats Not Verified",Active=1},
                new StatusReason{DisplayName="Confidential Informant",Active=1},
                new StatusReason{DisplayName="Other (state below)",Active=1}
            };

            statusReasons.ForEach(s => context.StatusReason.Add(s));
            context.SaveChanges();
        }

    }
}