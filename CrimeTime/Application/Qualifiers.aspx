<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="Qualifiers.aspx.vb" Inherits="Qualifiers" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="MainDiv ui-corner-all center">
        <div style="text-align:center">
        <h4 style="margin: 3px;"><asp:Label ID="CrimeName" runat="server"></asp:Label></h4>
        <input type="button" id="Returner" value="Return to Search Results" runat="server"
            onclick="history.go(-1)" class="nyptiButton hideForMobile" />
            </div>
        <div id="AttemptedQuestion" visible="false" runat="server">
            <table>
                <tr>
                    <td>
                        Is this an attempt at this crime?
                    </td>
                    <td>
                        <asp:DropDownList ID="Attempted" AutoPostBack="True" runat="server" class="nyptiDropdown">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div id="QualifierQuestion" visible="false" runat="server" >
            Qualifying Question:
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblQQuestion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="QuestionResponses" runat="server" AutoPostBack="True" class="nyptiDropdown">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div id="AgeCategory" visible="false" runat="server">
            <table>
                <tr>
                    <td>
                        Age Category:
                    </td>
                    <td>
                        <asp:DropDownList ID="AgeCat" runat="server" AutoPostBack="True" class="nyptiDropdown">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div id="Mitigating" visible="false" runat="server">
            Mitigating Factor:
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblMitigating" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="lstMitigating" runat="server" AutoPostBack="True" class="nyptiDropdown">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div id="PastConvictions" runat="server" visible="false">
            <table>
                <tr>
                    <td>
                        Past Felony Convictions
                    </td>
                    <td>
                        <asp:DropDownList ID="PastCon" runat="server" AutoPostBack="True" class="nyptiDropdown">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div id="FelonyCat" runat="server" visible="false">
            <table>
                <tr>
                    <td>
                        Felony Sentencing Category
                    </td>
                    <td>
                        <asp:DropDownList ID="FelCat" runat="server" AutoPostBack="True" class="nyptiDropdown">
                        </asp:DropDownList><br />
                         To view the criteria for the various categories <a href="Criteria.aspx" target="_blank">click here</a>
                    </td>
                    <td>
                       
                    </td>
                </tr>
            </table>
        </div>
        <div id="PersistantFelon" runat="server" visible="false">
            <table>
                <tr>
                    <td>
                        Do the prior felony convictions meet the criteria for a persistent felony offender
                        under Penal Law 70.10?
                    </td>
                    <td>
                        <asp:DropDownList ID="Persistant" runat="server" AutoPostBack="True" class="nyptiDropdown">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align:center">
            <p>
                To determine the sentencing possibilities for this crime please click the Submit
                button.
            </p>
        </div>
        <div id="buttondiv" style="text-align:center">
            <asp:Button ID="sbm_button" runat="server" Text="Submit" class="nyptiButton" /><br /> 
        </div>
        <div>
            <asp:Label ID="lblerrors" CssClass="errortext" runat="server" style="text-align:center"></asp:Label>
        </div>
    </div>
</asp:Content>
