<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="Criteria.aspx.vb" Inherits="Criteria" Title="NYPTI CRIMETIME - Felony Sentencing Category Criteria" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="MainDiv center ui-corner-all">
       <div class="centered">
        <asp:Button ID="Close1" OnClientClick="javascript:CloseWindow()" Text="Close Window"
            runat="server" class="nyptiButton center" />
            </div>
        <h4>
            Criteria for Felony Sentencing Category</h4>
        <div>
            <ul>
                <li><a href="#firstfel">1st Felony Offender</a></li>
                <li><a href="#secondfel">2nd Felony Offender</a></li>
                <li><a href="#secondfeldrug">2nd Felony Drug Offender</a></li>
                <li><a href="#secondfeldrugVFO">2nd Felony Drug Offender with prior VFO</a></li>
                <li><a href="#secondfelfirstVFO">2nd Felony Offender, Now Convicted of 1st VFO</a></li>
                <li><a href="#secondfelsecondVFO">2nd Felony Offender, Now Convicted of 2nd VFO</a></li>
                <li><a href="#secondfelchild">2nd Child Sexual Assault Felony Offender</a></li>
                <li><a href="#persistantNonViolent">Persistent Felony Offender</a></li>
                <li><a href="#persistant">Persistent Violent Felony Offender</a></li>
            </ul>
        </div>
        <div>
            <h5 id="#firstfel">
                1st Felony Offender</h5>
            <p>
                Select '1st felony offender' if this is the first time the defendant has ever been
                convicted of a felony, or if none of the other selections applies.</p>
        </div>
        <div>
            <h5 id="#secondfel">
                2nd Felony Offender</h5>
            <p>
                Select '2nd felony offender' if the defendant has at least one previous felony conviction
                meeting the requirements of Penal Law 70.06(1)(b), summarized as follows:<br />
                -- sentence upon the previous conviction must have been imposed before commission
                of the present felony, and<br />
                -- sentence upon the previous conviction must have been imposed not more than ten
                years before commission of the present felony, excluding any periods of incarceration.
                <br />
                Note that the previous felony conviction need not be for a felony defined in the
                Penal Law. People v Shannon, 89 NY2d 1000.
            </p>
        </div>
        <div>
            <h5 id="#secondfeldrug">
                2nd Felony Drug Offender</h5>
            <p>
                Select '2nd felony drug offender' if the present offense is a felony defined in
                Penal Law article 220 or 221 and if the defendant has at least one previous felony
                conviction meeting the requirements of Penal Law 70.06(1)(b), summarized as follows:
                <br />
                -- sentence upon the previous conviction must have been imposed before commission
                of the present felony, and
                <br />
                -- sentence upon the previous conviction must have been imposed not more than ten
                years before commission of the present felony, excluding any periods of incarceration.
                <br />
                Note that the previous felony conviction need not be for a felony defined in the
                Penal Law. People v Shannon, 89 NY2d 1000.
            </p>
        </div>
        <div>
            <h5 id="#secondfeldrugVFO">
                2nd Felony Drug Offender with prior VFO</h5>
            <p>
                Select '2nd felony drug offender with prior VFO' if the present offense is a felony
                defined in Penal Law article 220 or 221 and if the defendant has at least one previous
                violent felony conviction (see Penal Law 70.02[1]) meeting the requirements of Penal
                Law 70.06(1)(b), summarized as follows:
                <br />
                -- sentence upon the previous conviction must have been imposed before commission
                of the present felony, and
                <br />
                -- sentence upon the previous conviction must have been imposed not more than ten
                years before commission of the present felony, excluding any periods of incarceration.
                <br />
                Note that the previous felony conviction need not be for a felony defined in the
                Penal Law. People v Shannon, 89 NY2d 1000.
            </p>
        </div>
        <div>
            <h5 id="#secondfelfirstVFO">
                2nd Felony Offender, Now Convicted of 1st VFO</h5>
            <p>
                Select '2nd felony offender, now convicted of 1st VFO' if the defendant has at least
                one previous felony conviction meeting the requirements of Penal Law 70.06(1)(b),
                summarized as follows:
                <br />
                -- the previous felony conviction was NOT for a violent felony offense, and
                <br />
                -- sentence upon the previous conviction was imposed before commission of the present
                felony, and
                <br />
                -- sentence upon the previous conviction was imposed not more than ten years before
                commission of the present felony, excluding any periods of incarceration.
                <br />
                Note that the previous felony conviction need not be for a felony defined in the
                Penal Law. People v Shannon, 89 NY2d 1000.
            </p>
        </div>
        <div>
            <h5 id="#secondfelsecondVFO">
                2nd Felony Offender, Now Convicted of 2nd VFO</h5>
            <p>
                Select '2nd felony offender, now convicted of 2nd VFO' if the defendant has at least
                one previous felony conviction meeting the requirements of Penal Law 70.04(1)(b),
                summarized as follows:
                <br />
                -- the previous felony conviction was for a violent felony offense defined in Penal
                Law 70.02(1) or for a class A felony (other than one defined in Penal Law article
                220), and
                <br />
                -- sentence upon the previous conviction was imposed before commission of the present
                felony, and
                <br />
                -- sentence upon the previous conviction was imposed not more than ten years before
                commission of the present felony, excluding any periods of incarceration.
            </p>
        </div>
        <div>
            <h5 id="#secondfelchild">
                2nd Child Sexual Assault Felony Offender</h5>
            <p>
                Select '2nd child sexual assault felony offender' if the present crime includes
                an element of committing or attempting to commit 'sexual conduct' as defined in
                Penal Law 130.00(10), if the present crime was committed against a child less than
                15 years old, and if the defendant has at least one previous felony conviction meeting
                the requirements of Penal Law 70.07(3), summarized as follows:
                <br />
                -- the previous felony conviction was also for a crime including an element of such
                sexual conduct committed against a child less than 15 years old,
                <br />
                -- sentence upon the previous conviction was imposed before commission of the present
                felony, and
                <br />
                -- sentence upon the previous conviction was imposed not more than fifteen years
                before commission of the present felony, excluding any periods of incarceration.
            </p>
        </div>
        <div>
            <h5 id="persistantNonViolent">
                Persistent Felony Offender</h5>
            <p>
                Select 'persistent felony offender' if the defendant is not a persistent violent
                felony offender as defined in Penal Law 70.08, but now stands convicted of a felony
                and has at least two previous felony convictions meeting the requirements of Penal
                Law 70.10(1)(b) and (c), summarized as follows:
                <br />
                -- each conviction is of a felony in this state, or of a crime in any other jurisdiction,
                provided:
                <br />
                -- the sentence on each exceeded one year,
                <br />
                -- the defendant committed the second crime after being incarcerated for the first
                crime,
                <br />
                -- the sentences were imposed before commission of the present felony, and
                <br />
                -- the sentences were for crimes other than persistent sexual abuse, as defined
                in Penal Law 130.53, and were not pardoned on the ground of innocence.
                <br />
                Note that the designation of a defendant as a persistent felony offender is discretionary,
                not mandatory. Its procedure is set forth by CPL 400.20. A defendant may be categorized
                as a persistent felony offender if the court, after a hearing on the issue, "is
                of the opinion that the history and characteristics of the defendant and the nature
                and circumstances of his criminal conduct indicate that extended incarceration and
                life-time supervision will best serve the public interest." Penal Law 70.10(2).
            </p>
        </div>
        <div>
            <h5 id="#persistant">
                Persistent Violent Felony Offender</h5>
            <p>
                Select 'persistent violent felony offender' if the defendant has at least two previous
                felony convictions meeting the requirements of Penal Law 70.04(1)(b), summarized
                as follows:
                <br />
                -- both previous felony convictions were for a violent felony offenses defined in
                Penal Law 70.02(1) or for class A felonies (other than one defined in Penal Law
                article 220), and
                <br />
                -- the sentence on the first felony was imposed before commission of the second
                felony, and the sentence on the second felony was imposed before commission of the
                present felony (People v Morse, 62 NY2d 205), and
                <br />
                -- sentence upon each of the previous felony convictions was imposed not more than
                ten years before commission of the present felony, excluding any periods of incarceration.
            </p>
        </div>
         <div class="centered">
        <asp:Button ID="Close2" OnClientClick="javascript:CloseWindow()" Text="Close Window"
            runat="server" class="nyptiButton center" Style="width: 125px" />
            </div>
        <br />
        <br />
    </div>
</asp:Content>
