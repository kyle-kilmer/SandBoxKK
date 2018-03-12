<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="Administration.aspx.vb" Inherits="Administration" Title="NYPTI CrimeTime - Administration" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="MainDiv center ui-corner-all centered">
        <asp:HiddenField ID="Versioninfo" runat="server" />
        <asp:HiddenField ID="Dateinfo" runat="server" />
        <div id="Admin" runat="server">
            <asp:Button ID="AddLaws" runat="server" CausesValidation="false" Text="Manage Laws"
                class="nyptiButton" />
            <button onclick="window.open('./Paragraphs.aspx', '_blank'); return false" class="nyptiButton">
            Paragraphs</button>
            <%--<asp:Button ID="EditParagraphs" runat="server" Text="Edit Paragraphs" CausesValidation="false"
                class="nyptiButton" />--%>
            <asp:Button ID="RunReports" runat="server" Text="Reports" CausesValidation="false"
                class="nyptiButton" />
        </div>
        <table>
            <tr>
                <td>
                    Crime Time Version
                </td>
                <td>
                    <asp:Label ID="CTVersion" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Last Updated
                </td>
                <td>
                    <asp:Label ID="LastUpdate" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    New Version Number
                </td>
                <td>
                    <asp:TextBox ID="NewVersion" runat="server"></asp:TextBox>
                    <asp:CustomValidator ControlToValidate="NewVersion" ID="NewVersionCustomValidator"
                        Display="None" runat="server" ErrorMessage="Please input a version number that is larger then the old number"></asp:CustomValidator>
                    <asp:RequiredFieldValidator ID="NewversionRequired" runat="server" ControlToValidate="NewVersion"
                        ErrorMessage="Please input a version Number" Display="None"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="NewVersionDataType" Display="None" runat="server" ErrorMessage="Please input a version Number"
                        ControlToValidate="NewVersion" Operator="DataTypeCheck" Type="Double"></asp:CompareValidator>
                </td>
            </tr>
        </table>
        <asp:Button ID="MakenewVersionNumber" runat="server" Text="Update Version Info" class="nyptiButton" />
        <asp:ValidationSummary ID="ValidSummary" DisplayMode="SingleParagraph" runat="server" />
    </div>
</asp:Content>
