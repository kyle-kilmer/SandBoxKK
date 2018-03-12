<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="_Default" Title="CrimeTime Online" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
   <script type="text/javascript">
       $(function () {
           xmlhttp = new XMLHttpRequest();
           xmlhttp.open("GET", "MaintenanceMessage.xml", false);
           xmlhttp.send();
           xmlDoc = xmlhttp.responseXML;
                     
           var startDateTime = new Date(xmlDoc.getElementsByTagName("displayStartDateTime")[0].childNodes[0].nodeValue);
           var endDateDateTime = new Date(xmlDoc.getElementsByTagName("displayEndDateTime")[0].childNodes[0].nodeValue);

           //conver to epoch time
           startDateTime = startDateTime.getTime();
           endDateDateTime = endDateDateTime.getTime();

           var message = xmlDoc.getElementsByTagName("message")[0].childNodes[0].nodeValue;
           
           var today = (new Date().getTime());

           if (today >= startDateTime && today <= endDateDateTime) {
               $("#maintenanceMsg").html(message);
               $("#maintenanceMsg").show();
           }
       });
    </script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div id="maintenanceMsg" class="disclaimerDiv ui-corner-all center centered" style="font-size:large; color: firebrick; font-weight:bolder; display:none">
           ***CrimeTime will be down for maintenance from X to Y.***
        </div>
    <asp:Panel ID="Mainpanel" runat="server" DefaultButton="AcceptDisclaimer" class="MainDiv ui-corner-all center"
        Style="text-align: center;">
<div id="accordion">
    
            <h2>
                Disclaimers</h2>
            <div  >
              <div id="main">
                <p>
                    
                    NYPTI provides CrimeTime Online (CrimeTime) for educational purposes only. CrimeTime
                    should not be used as a substitute for independent legal research, and is not legal
                    advice. If you are not a lawyer and need legal advice you should contact a lawyer.
                    If you are a lawyer you should research the information you are looking for. Use
                    CrimeTime at your own risk.
                </p>
                <p>
                    NYPTI is furnishing CrimeTime "as is," and waives all liability. NYPTI does not
                    provide any warranty of this program/website whatsoever, whether express, implied,
                    or statutory, including, but not limited to, any warranty of merchantability or
                    fitness for a particular purpose or any warranty that the contents of the item will
                    be error-free.
                </p>
                <p>
                    In no respect shall NYPTI incur any liability for any damages, including, but not
                    limited to, direct, indirect, special, or consequential damages arising out of,
                    resulting from, or any way connected to the use of CrimeTime, whether or not based
                    upon warranty, contract, tort, or otherwise; whether or not injury was sustained
                    by persons or property or otherwise; and whether or not loss was sustained from,
                    or arose out of, the results of, CrimeTime, or any services that may be provided
                    by NYPTI.
                </p>
                <p>
                    You agree to use CrimeTime at your own risk and will verify any answer given with
                    sufficient independent legal research. By entering your valid e-mail address and
                    clicking enter you agree to these terms.</p>

           </div> 
                
                <!-- Amazon banner code----------     
                 <div >  
<div id="amznCharityBanner"><script type="text/javascript">(function () { var iFrame = document.createElement('iframe'); iFrame.style.display = 'none'; iFrame.style.border = "none"; iFrame.width = 310; iFrame.height = 256; iFrame.setAttribute && iFrame.setAttribute('scrolling', 'no'); iFrame.setAttribute('frameborder', '0'); setTimeout(function () { var contents = (iFrame.contentWindow) ? iFrame.contentWindow : (iFrame.contentDocument.document) ? iFrame.contentDocument.document : iFrame.contentDocument; contents.document.open(); contents.document.write(decodeURIComponent("%3Cdiv%20id%3D%22amznCharityBannerInner%22%3E%3Ca%20href%3D%22https%3A%2F%2Fsmile.amazon.com%2Fch%2F11-3289827%22%20target%3D%22_blank%22%3E%3Cdiv%20class%3D%22text%22%20height%3D%22%22%3E%3Cdiv%20class%3D%22support-wrapper%22%3E%3Cdiv%20class%3D%22support%22%20style%3D%22line-height%3A%2028px%3B%20font-size%3A%2025px%3B%20margin-top%3A%201px%3B%20margin-bottom%3A%201px%3B%22%3EHelp%20Support%20%3Cspan%20id%3D%22charity-name%22%20style%3D%22display%3A%20inline-block%3B%22%3ENew%20York%20Prosecutors%20Training%20Institute%20Inc.%3C%2Fspan%3E%3C%2Fdiv%3E%3C%2Fdiv%3E%3Cp%20class%3D%22when-shop%22%3EWhen%20you%20shop%20at%20%3Cb%3Esmile.amazon.com%2C%3C%2Fb%3E%3C%2Fp%3E%3Cp%20class%3D%22donates%22%3EAmazon%20donates.%3C%2Fp%3E%3C%2Fdiv%3E%3C%2Fa%3E%3C%2Fdiv%3E%3Cstyle%3E%23amznCharityBannerInner%7Bbackground-image%3Aurl(https%3A%2F%2Fimages-na.ssl-images-amazon.com%2Fimages%2FG%2F01%2Fx-locale%2Fpaladin%2Fcharitycentral%2Fbanner-background-image._CB309675353_.png)%3Bwidth%3A300px%3Bheight%3A250px%3Bposition%3Arelative%7D%23amznCharityBannerInner%20a%7Bdisplay%3Ablock%3Bwidth%3A100%25%3Bheight%3A100%25%3Bposition%3Arelative%3Bcolor%3A%23000%3Btext-decoration%3Anone%7D.text%7Bposition%3Aabsolute%3Btop%3A20px%3Bleft%3A15px%3Bright%3A15px%3Bbottom%3A100px%7D.support-wrapper%7Boverflow%3Ahidden%3Bmax-height%3A86px%7D.support%7Bfont-family%3AArial%2Csans%3Bfont-weight%3A700%3Bline-height%3A28px%3Bfont-size%3A25px%3Bcolor%3A%23333%3Btext-align%3Acenter%3Bmargin%3A0%3Bpadding%3A0%3Bbackground%3A0%200%7D.when-shop%7Bfont-family%3AArial%2Csans%3Bfont-size%3A15px%3Bfont-weight%3A400%3Bline-height%3A25px%3Bcolor%3A%23333%3Btext-align%3Acenter%3Bmargin%3A0%3Bpadding%3A0%3Bbackground%3A0%200%7D.donates%7Bfont-family%3AArial%2Csans%3Bfont-size%3A15px%3Bfont-weight%3A400%3Bline-height%3A21px%3Bcolor%3A%23333%3Btext-align%3Acenter%3Bmargin%3A0%3Bpadding%3A0%3Bbackground%3A0%200%7D%3C%2Fstyle%3E")); contents.document.close(); iFrame.style.display = 'block'; }); document.getElementById('amznCharityBanner').appendChild(iFrame); })(); </script></div>
               </div>
     

-->


    </div>
       
            <h2>
                What is CrimeTime Online?</h2>
            <div>
                <p>
                    CrimeTime Online is free sentencing software created by George Dentes in 1996. In
                    2008, the New York Prosecutors Training Institute Inc. (NYPTI) embarked on a major
                    overhaul of George’s original programming, and made it a web-based application rather
                    than a stand alone, Windows only application. CrimeTime Online was released for
                    beta testing in November 2008 and, in keeping with George’s intent, released to
                    the general public in December 2008. For more information about George Dentes or
                    the history of CrimeTime please <a href="CrimeTimeHistory.aspx">click here</a>.
                </p>
                <p>
                    For the New York State Laws hyperlinked from CrimeTime Online, NYPTI leverages the New York State 
                    Senate’s Open Legislation service to incorporate bills and laws on various projects. Open Legislation is a 
                    publicly available web service that allows developers to integrate New York State legislative data into 
                    websites and applications.  When necessary, laws are updated weekly on Fridays.   
                    More information can be found at <a href="http://legislation.nysenate.gov/public" target="_blank">http://legislation.nysenate.gov/public</a> 
                </p>
            </div>
            <h2>
                What Does CrimeTime Do?</h2>
            <div>
                <p>
                    CrimeTime quickly calculates permissible sentences for New York crimes, taking into
                    account the conviction and the defendant's age and criminal history.
                </p>
            </div>
        </div>
        <br />
        <div class="msgDiv ui-corner-all center" style="width: 280px">
            <asp:Label ID="EmailLabel" runat="server">Enter your email address and click below to enter the site</asp:Label>
            <asp:TextBox ID="EmailInfo" runat="server" ></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="EmailInfo"
                Display="None" ErrorMessage="Please input a valid Email Address"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="EmailValidator" ControlToValidate="EmailInfo"
                runat="server" Display="None" ErrorMessage="Please input the email address in the correct format (i.e.  Username@domain.com)"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            <br />
            <asp:Button ID="AcceptDisclaimer" runat="server" Text="I agree to the terms above."
                class="nyptiButton" />
            <br />
        </div>
        <asp:ValidationSummary ID="Validsummary" runat="server" />
        <br />
    </asp:Panel>
</asp:Content>
