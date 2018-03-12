<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="Answer.aspx.vb" Inherits="Answer" Title="NYPTI CrimeTime - Answer" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Answers" class="MainDiv center ui-corner-all">
        <div class="centered">
            <asp:Button ID="Back1" Text="Back to Qualifying Questions" runat="server" class="nyptiButton center" />
            <asp:Button ID="SearchReturn1" Text="Back to Search Screen" runat="server" class="nyptiButton center" />
        </div>
        <br />
        <div class="ui-widget-content ui-corner-all">
             <h2 class="centered">
                Assumptions</h2>
            <table>
                <tr>
                    <td>
                        <span style="font-weight: bolder;">Offense:</span>
                    </td>
                    <td>
                        <asp:Label ID="lblOffense" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px;">
                        <span style="font-weight: bolder;">Age category:</span>
                    </td>
                    <td>
                        <asp:Label ID="lblAge" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr id="Feloffender" runat="server">
                    <td>
                        <span style="font-weight: bolder;">Felony offender category:</span>
                    </td>
                    <td>
                        <asp:Label ID="lblFelonyoffender" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            </div> <br />
            <div class="ui-widget-content ui-corner-all">
            <h3 class="centered">
                Answer</h3>
                            <asp:Label ID="lblPreface" runat="server"></asp:Label>
                            <asp:Label ID="lblTransition" runat="server"></asp:Label>
                            <asp:Label ID="lblStatePRISON" runat="server"></asp:Label>
                            <asp:Label ID="lblDEFINITESENTENCE" runat="server"></asp:Label>
                            <asp:Label ID="lblIntermittentImprisonment" runat="server"></asp:Label>
                            <asp:Label ID="lblPROBATION" runat="server"></asp:Label>
                            <asp:Label ID="lblCONDITIONALDISCHARGE" runat="server"></asp:Label>
                            <asp:Label ID="lblSplitSentence" runat="server"></asp:Label>
                            <asp:Label ID="lblFINE" runat="server"></asp:Label>
                            <asp:Label ID="lblUNCONDTIONALDISCHARGE" runat="server"></asp:Label>
                            <asp:Label ID="lblRESTITUTIONREPARATION" runat="server"></asp:Label>
                            <asp:Label ID="lblSURCHARGEVictimAssessmentFee" runat="server"></asp:Label>
                            <asp:Label ID="lblLicensePenalties" runat="server"></asp:Label>
                            <asp:Label ID="lblConSECutiveConcurrent" runat="server"></asp:Label>
                            <asp:Label ID="lblEnd" runat="server"></asp:Label>
            <br />
        </div> <br />
        <div class="centered">
            <asp:Button ID="Back2" Text="Back to Qualifying Questions" runat="server" class="nyptiButton center" />
            <asp:Button ID="SearchReturn2" Text="Back to Search Screen" runat="server" class="nyptiButton center" />
            <br />
            <br />
            <div class="ui-state-highlight ui-corner-all center" style="width:80%">
                If you believe there to be something wrong with this answer please click
                <asp:HyperLink ID="Reporter" runat="server" Target="_blank">here</asp:HyperLink>.</div>
            <br />
        </div>
    </div>
</asp:Content>
