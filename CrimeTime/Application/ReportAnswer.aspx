<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false" CodeFile="ReportAnswer.aspx.vb" Inherits="ReportAnswer" %>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="MainDiv center ui-corner-all centered">
    <h5>Please let us know what you believe is wrong with this answer.</h5>
    <asp:TextBox ID="ReportReason" runat="server" Rows="5" TextMode="MultiLine" Width="400"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredReason" runat="server" ControlToValidate="ReportReason" ErrorMessage="Please input a reason"></asp:RequiredFieldValidator>
    <br />
    <asp:Button ID="sbm_button" runat="server" Text="Report Answer" class="nyptiButton" />
    <br />
    <asp:Label ID="Thanks" runat="server" CssClass="errortext"></asp:Label>
    <asp:Label ID="lblError" runat="server"></asp:Label>
    </div>
</asp:Content>

