<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false" CodeFile="CrimeTimeHelp.aspx.vb" Inherits="Help_CrimeTimeHelp"  %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="MainDiv center ui-corner-all">
<h2>CrimeTime Online &ndash; Help</h2>
<p>CrimeTime Online (CrimeTime) quickly calculates permissible sentences for New York crimes, taking into account the conviction and the defendant's age and criminal history. CrimeTime is free sentencing software created by George Dentes in 1996. In 2008, the New York Prosecutors Training Institute Inc. (NYPTI) embarked on a major overhaul of George&rsquo;s original programming, and made it a web-based application rather than a stand alone Windows only application. CrimeTime Online was released for beta testing in November and, in keeping with George&rsquo;s intent, will be released to the general public in December of 2008. For more information about George Dentes or the history of CrimeTime please <a href="./CrimeTimeHistory.aspx">click here.</a></p>
<p>NYPTI provides CrimeTime Online (CrimeTime) for educational purposes only. CrimeTime should not be used as a substitute for independent legal research, and is not legal advice. If you are not a lawyer and need legal advice you should contact a lawyer. If you are a lawyer, you should research the information you are looking for. Use CrimeTime at your own risk.</p>
<ul class="unorderlistnobullet">
<li><a href="#HowTo">How to Use CrimeTime Online</a></li>
<li><a href="#Definitions">Definitions/Factors Affecting Sentencing</a></li>
<li><a href="#Attempted">Attempted Crimes</a></li>
<li><a href="#AgeClassification">Age Classification</a></li>
<li><a href="#Youthful">Youthful Offenders</a></li>
<li><a href="#Juvenile">Juvenile Offenders</a></li>
<li><a href="#FelonyHistory">Felony History</a></li>
<li><a href="#Violent">Violent Felonies</a></li>
<li><a href="#FelonySentencing">Felony Sentencing Category</a></li>
<li><a href="#PersistantFelony">Persistent Felony Offender (Penal Law &sect; 70.10)</a></li>
<li><a href="#PleaBargaining">Plea Bargaining Restrictions</a></li>
</ul>


 <h2 id="HowTo">How to Use CrimeTime Online</h2>
<h4>Choosing an Offense:</h4>
<p>CrimeTime Online allows users to search for crimes in a few different ways.</p>
<ul>
<li>Users may search for crimes by scrolling through a list sorted by cite, name or level. To sort, simply click on the Cite, Name, or Level links.<br />
    <img src="./images/SearchResultsBar.gif" alt="Search Results Bar" width="590" height="24" /></li>
<li>Users can also search for crimes by entering statute numbers and clicking search (i.e. 120 for Assault and Related Offenses &sect;&sect; 120.00-120.60).<br />
    <img src="./images/SearchCriteria.gif" alt="Search Criteria" width="657" height="59" />
</li>
<li>Clicking on the name of any crime will open new browser window displaying the statutory text of the crime.</li>
</ul>
<h4>Factors That Affect Sentencing Possibilities:</h4>
<p>Once you find the crime you are looking for, click on &ldquo;Select This Crime&rdquo; and answer a series of questions to help determine the sentencing possibilities based on the crime, age of the defendant and criminal history. Once you finish answering the questions hit submit.</p>
    <img src="./images/Factors.gif" alt="Factors that Affect Sentencing Possibilities" width="852" height="237" />
<h4>The Answer:</h4>
<table width="600">
<tr>
<td><p><img alt="Answer ScreenShot" style="float: right; padding: 0px 0px 0px 0px;" width="198" height="338" src="./images/Answers.gif"/>After hitting &ldquo;Submit,&rdquo; a new browser window will open displaying the sentencing possibilities for the crime chosen and the questions answered.</p>
<p>There are numerous factors that go into determining the sentencing possibilities for any crime (i.e. age of defendant, criminal history, etc). CrimeTime Online is intended for use by attorneys who understand the different elements that affect sentencing. Some of these elements are explained below. Thus, the information provided should be used at your own risk. NYPTI is in no way liable for any answers provided by CrimeTime Online.</p>
</td>
</tr>
</table>

<h2 id="Definitions">Definitions/Factors Affecting Sentencing</h2>
<h4 id="Attempted">Attempted Crimes</h4>
<p>To determine the sentencing possibilities for an attempted crime, select the underlying crime, then choose yes from the pull down asking if the crime is &ldquo;an attempt at this crime&rdquo;.</p>
    <img src="./images/Attempt.gif" alt="Attempt DropDown Screenshot" width="263" height="78" />
<p>Penal Law &sect; 110.00 states: &ldquo;A person is guilty of an attempt to commit a crime when, with intent to commit a crime, he engages in conduct which tends to effect the commission of such crime.&rdquo;</p>
<p>Although it is illogical to charge a defendant with attempting certain crimes, such as strict liability crimes and crimes of recklessness (see <i>People v Campbell</i>, 72 NY2d 602), the flexible rules surrounding plea bargaining permit defendants to plead guilty to attempts to commit such crimes (see, e.g., <i>People v Foster</i>, 19 NY2d 150, and CPL 220.20).</p>
<p>Because the doctrine of attempt can apply only to a crime, and because the term &ldquo;crime&rdquo; includes only felonies and misdemeanors (Penal Law &sect; 10.00[6]), CrimeTime will not process attempts at violations.</p>
<p>For crimes involving allegations of drunk or unlicensed driving, special plea bargaining rules require pleas to the crimes specified in the Vehicle and Traffic Law, all of which are completed offenses (see VTL 1192[10][a]-[b] and 511[5]). See also <i>People v Prescott</i>, 95 NY2d 655 (2001) (attempted VTL offenses are not legally cognizable). Accordingly, CrimeTime refuses to process attempts at VTL offenses.</p>

<h4 id="AgeClassification">Age Classification</h4>
<p>If the defendant&rsquo;s age affects the sentencing possibilities, CrimeTime Online displays the potential age classifications and prompts the user to select one. There may be up to three that apply:</p>
<ul>
<li><i>Adult offender</i>: Any defendant who was 19 years old or older at the time of the crime must be sentenced as an adult.</li>
<li><i>Youthful Offender</i>: If the defendant was 16, 17, or 18 years old at the time of the crime, the court will generally have discretion to sentence the defendant as a youthful offender rather than as an adult. See <a href="#Youthful">Youthful Offenders</a>.</li>
<li><i>Juvenile Offender</i>: If the defendant was 13, 14, or 15 years old at the time of the crime and committed one of the violent felonies listed in Penal Law &sect; 10.00(18), the defendant may be sentenced as a juvenile offender or, in some cases, a youthful offender. See <a href="#Juvenile">Juvenile Offenders</a>.</li>
</ul>

<h4 id="Youthful">Youthful Offenders</h4>
<p>If the defendant committed a crime while 16, 17, or 18 years old, the defendant will generally be eligible for sentencing as a youthful offender. See article 720 of the Criminal Procedure Law.</p>
<p>If youthful offender treatment is granted, the conviction is replaced with a &ldquo;youthful offender finding,&rdquo; and the conviction is no longer deemed a criminal conviction. CPL 720.35.</p>
<p>The definition of &ldquo;eligible youth&rdquo; excludes the following classes of defendants, who must be sentenced as adults (CPL 720.10[2]):</p>
<ul>
    <li>Those who have previously been afforded youthful offender treatment after 
        conviction of a felony, and</li>
    <li>Those who have previously been adjudicated a juvenile delinquent after 
        committing a designated felony as defined in the family court act, and</li>
    <li>Those who have previously been convicted and sentenced for a felony as an adult, 
        and</li>
    <li>Those who currently stand convicted of class A-I or A-II felonies, and</li>
    <li>Those who currently stand convicted of &ldquo;armed felonies&rdquo; (see CPL 1.20[41] for 
        the definition), unless special mitigating circumstances are found, and</li>
    <li>Those who currently stand convicted of Rape 1, Criminal Sexual Act 1, or 
        Aggravated Sexual Abuse, unless special mitigating circumstances are found.</li>

</ul>


    <p>
        On the other hand, an eligible youth MUST be accorded youthful treatment if the 
        current conviction is had in a local criminal court and the youth has not 
        previously been convicted of a crime or afforded youthful offender treatment 
        (CPL 720.20[1][b]).</p>
    <p>
        Youthful offenders are NOT subject to the Sex Offender Registration Act, as 
        Correction Law 168-a speaks of persons &ldquo;convicted&rdquo; of certain offenses, and YO 
        adjudications replace convictions (see People v. Floyd, 61 NY2d 895). 
        Additionally, YOs are not subject to the $50 dollar Sex Offender Registration 
        Fee</p>
    <p>
        Youthful offenders are NOT required to provide a DNA sample, as Executive Law 
        995(7) speaks of persons &ldquo;convicted&rdquo; of certain offenses, and YO adjudications 
        replace convictions (see People v. Floyd, 61 NY2d 895). Additionally, YOs are 
        not subject to the $50 dollar DNA databank fee. Penal Law &sect; 60.35(10).</p>
    <p>
        &nbsp;</p>


<h4 id="Juvenile">Juvenile Offenders</h4>
    <p>If the defendant was 13, 14, or 15 years old at the time of the crime, and if he 
        is convicted of one of the following designated offenses, he is a juvenile 
        offender and may be sentenced as such (Penal Law &sect; 10.00[18]):</p>
    <ul class="unorderlistnobullet">
    <li>For 13 year-olds:</li>
    <li>Murder 2 (sub 1 & 2)</li>
    </ul>
    <ul class="unorderlistnobullet">
    <li>For 14 & 15 year-olds:</li>
    <li>Aggravated Sexual Abuse 1</li>
    <li>Arson 1</li>
    <li>Arson 2</li>
    <li>Assault 1 (sub 1 & 2)</li>
    <li>Attempted Kidnapping 1</li>
    <li>Attempted Murder 2</li>
    <li>Burglary 1</li>
    <li>Burglary 2 (sub 1)</li>
    <li>CPW 2 (on school grounds)</li>
    <li>Criminal Sexual Act 1 (sub 1 & 2)</li>
    <li>Kidnapping 1</li>
    <li>Manslaughter 1</li>
    <li>Murder 2</li>
    <li>Rape 1 (sub 1 & 2)</li>
    <li>Robbery 1</li>
    <li>Robbery 2 (sub 2)</li>
    <li>Or any of the above as a Sexually Motivated Felony (P.L. &sect; 130.91).</li>
    </ul>
    <p> The statutory provisions for the crimes above are found in Penal Law &sect; 
        10.00[18].</p>
    <p>Although juvenile offenders must receive sentences of imprisonment, the court 
        will usually have the option of imposing a youthful offender sentence instead. 
        Penal Law &sect; 60.10(1). Presumably, the option of youthful offender treatment is 
        available only for crimes for which a 16, 17, or 18 year-old could receive 
        youthful offender treatment.</p>
    
    <h4 id="FelonyHistory">Felony History</h4>
    <p>Repeat felony offenders face enhanced prison terms. The number and timing of the previous convictions are important factors, as is the classification of an offense as a violent felony offense.</p>
    <p>If the defendant is to be sentenced on a felony, the defendant&rsquo;s previous felony convictions must be considered in arriving at the sentencing possibilities. CrimeTime first prompts the user to enter the number of previous felony convictions, and if the number is one or more, CrimeTime displays a drop down menu prompting the user to select the defendant&rsquo;s &ldquo;Felony Sentencing Category.&rdqou;</p>

<h4 id="Violent">Violent Felonies</h4>
<p>The violent felony offenses are listed in Penal Law &sect; 70.02(1).</p>
<h4 id="FelonySentencing">Felony Sentencing Category</h4>
<p>The Felony Sentencing Category drop down menu is displayed if the current crime is a Penal Law felony and if the defendant had one or more previous felony convictions.</p>
<p>When the drop down menu is displayed, the user selects the appropriate category.</p>
<p>Only the applicable categories are valid choices. For example, if the current felony is a not a violent felony offense, the categories requiring the current felony to be a violent felony offense are not available.</p>

<p>The criteria for the various categories are discussed below.</p>
<p>If the option of two or more prior convictions is chosen, a question will be displayed asking whether the prior felony convictions meet the criteria for a persistent felony offender under Penal Law &sect; 70.10. If yes is chosen, the answer displayed will include sentencing options for both a predicate felon and a potentially persistent felon.</p>
<p>If the present crime is felony but not a Penal Law felony (e.g., Driving While Intoxicated as a felony), the Felony Sentencing Category pull down is not displayed, because the various repeat-felony categories in the pull down are applicable only to Penal Law felonies. If the number of previous felony convictions is two or more, the persistent felony offender question will be displayed, as that category does not require that the current felony be a Penal Law felony. See Penal Law &sect; 70.10.</p>
<h4 id="PersistantFelony">Persistent Felony Offender (Penal Law &sect; 70.10)</h4>
<p>If a defendant is being sentenced for a felony and has previously been convicted of two or more felonies, he may qualify for sentencing as a persistent felony offender under Penal Law &sect; 70.10. CrimeTime will ask the user to indicate if the defendant meets the criteria of that section.</p>
<p>Note that the criteria for a persistent felony offender under this section are different from a persistent violent felony offender under Penal Law &sect; 70.08.</p>

<h4 id="PleaBargaining">Plea Bargaining Restrictions</h4>
<p>Criminal Procedure Law 220.10(5) contains the following felony plea bargaining restrictions for indictments. By operation of CPL 200.15, these restrictions also apply to superior court informations. The restrictions are:</p>
<ul>
<li>If the indictment charges a class A-I or A-II felony defined in Penal Law article 220 or an attempt to commit such a felony, a guilty plea must include at least a plea of guilty to a class B.</li>
<li>If the indictment charges any other class A felony, a guilty plea must include at least a plea of guilty to a class C violent felony.</li>
<li>If the indictment charges a class B violent felony that is also an "armed felony" (defined in CPL 1.20[41]), a guilty plea must include at least a plea of guilty to a class C violent felony.</li>
<li>If the indictment charges a class B violent felony, a guilty plea must include at least a plea of guilty to a class D violent felony.</li>
<li>If the indictment charges a class B felony defined in Penal Law article 220, a guilty plea must include at least a plea of guilty to a class D felony.</li>
<li>If the indictment charges any other class B felony, a guilty plea must include at least a plea of guilty to a felony.</li>
<li>If the indictment charges a class C violent felony, a guilty plea must include at least a plea of guilty to a class D violent felony.</li>
<li>If the indictment charges a class D violent felony involving possession of a firearm, a guilty plea must include at least a plea of guilty to a class E violent felony, but a defendant not convicted of a class A misdemeanor in the preceding 5 years may be eligible for a misdemeanor plea.</li>
<li>If the indictment charges any felony against a defendant who is a predicate felon, a guilty plea must include at least a plea of guilty to a felony.</li>
<li>If the indictment charges the class E felony of aggravated harassment of an employee by an inmate, a guilty plea must include at least a plea of guilty to a class E felony.</li>
</ul>
<p>There are also plea bargaining restrictions for some violations of the Vehicle and Traffic Law, including the following:</p>
<ul>
<li>For DWI cases, if the defendant is charged with a violation of subdivision 2, 3, 4, or 4a of VTL 1192, any guilty plea satisfying the charge must include a guilty plea to one of the subdivisions of VTL 1192, unless the district attorney determines that no such charge is warranted, in which case the district attorney may consent, and the court may allow, a disposition to another charge. VTL 1192(10)(a)(i). In addition, if the defendant is charged with subdivision 2, 3, 4, or 4-a of VTL 1192, the court may only accept a plea to subdivision one of VTL 1192 in satisfaction if such plea includes a condition that the defendant attend and complete drug treatment. VTL1192 (10)(a)(ii).</li>
<li>For DWI cases, if the defendant is charged with a violation of subdivision 2-a of VTL1192, any guilty plea satisfying the charge must include a guilty plea to subdivision 2,2a,or 3 of VTL 1192, unless the District Attorney determines that no such charge is warranted, in which case the district attorney may consent, and the court may allow, a disposition to another charge. No such plea to another charge shall be accepted by the court unless it includes a condition that the defendant attempt and complete drug treatment. VTL 1192(10)(d)</li>
<li>For DWI cases, if the defendant is charged with a violation of subdivision 1 or 6 of VTL 1192 while operating a commercial motor vehicle, any guilty plea satisfying the charge must include a guilty plea to one of the subdivisions of VTL 1192, unless the district attorney determines that no such charge is warranted, in which case the district attorney may consent, and the court may allow, a disposition to another charge. VTL 1192(10)(b).</li>
<li>For DWI cases, if the defendant is charged with a violation of subdivision 1 of VTL 1192 and was under the age of twenty-one at the time of the offense, any guilty plea satisfying the charge must include a guilty plea to a violation of that subdivision, unless the district attorney determines that no such charge is warranted, in which case the district attorney may consent, and the court may allow, a disposition to another charge. VTL 1192(10)(a)(iii). If both parties consent, the court may instead allow the satisfaction of the charge by the defendant&rsquo;s agreement to be subject to the action of the Commission of Motor Vehicles pursuant to VTL 1194-a. VTL 1192(10)(c).</li>
<li>For cases of aggravated unlicensed operation of a motor vehicle, if the defendant is charged with a violation of VTL 511, any guilty plea satisfying the charge must include a guilty plea to an offense defined in VTL 511, unless the district attorney determines that no such charge is warranted, in which case the district attorney may consent, and the court may allow, a disposition to another charge. VTL 511(5).</li>
</ul>
</div>
</asp:Content>

