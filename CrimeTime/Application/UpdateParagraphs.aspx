<%@ Page Language="VB" ValidateRequest="false" MasterPageFile="~/NYPTICrimeTime.master"
    AutoEventWireup="false" CodeFile="UpdateParagraphs.aspx.vb" Inherits="UpdateParagraphs"
    Title="NYPTI CrimeTime - Update Paragraphs" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- Getting tinyMCE javascript files -->
    <script type="text/javascript" src="tinymce/tinymce.min.js"></script>
    <!-- Initializing textarea controls -->
    <script type="text/javascript">
        tinymce.init({
            selector: "textarea",
            theme: "modern",
            entity_encoding: "raw",
            plugins: [
        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime media nonbreaking save table contextmenu directionality",
        "paste textcolor"
    ],
            toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
            toolbar2: "print preview media | forecolor backcolor emoticons",
            image_advtab: true
        });
    </script>
    <asp:HiddenField ID="ParagraphKeyID" runat="server" />
    <asp:HiddenField ID="ParagraphTypeID" runat="server" />
    <center>
        <table>
            <tr>
                <td>
                    <strong>
                        <asp:Literal ID="ParagraphKey" runat="server"></asp:Literal></strong>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:TextBox ID="UParagraphs" CausesValidation="false" runat="server" Height="200"
                        Width="700" MaxLength="4000" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="UpdateParagraph" runat="server" Text="Update" CausesValidation="false"
                        class="nyptiButton" />
                    &nbsp;
                    <asp:Button ID="ClearParagraph" runat="server" Text="Clear" CausesValidation="false"
                        class="nyptiButton" />
                    &nbsp;
                    <asp:Button ID="CancelButton" runat="server" Text="Back" CausesValidation="false"
                        class="nyptiButton" />
                </td>
            </tr>
        </table>
        <asp:Label ID="lblResult" runat="server"></asp:Label><br />
        <asp:Label ID="lblError" runat="server"></asp:Label>
    </center>
    <table id="DropdownTable" runat="server">
        <tr>
            <td>
                Preface
            </td>
            <td>
                <asp:ListBox ID="PrefaceList" Rows="1" AutoPostBack="True" runat="server"></asp:ListBox>
            </td>
            <td>
                Transition
            </td>
            <td>
                <asp:ListBox ID="TransitionList" Rows="1" AutoPostBack="True" runat="server"></asp:ListBox>
            </td>
            <td>
                State Prison
            </td>
            <td>
                <asp:ListBox ID="StatePrisonList" Rows="1" AutoPostBack="True" runat="server"></asp:ListBox>
            </td>
        </tr>
        <tr>
            <td>
                Definite Sentence
            </td>
            <td>
                <asp:ListBox ID="DefiniteSentenceList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
            <td>
                Intermittent Imprisonment
            </td>
            <td>
                <asp:ListBox ID="IntermittentImprisonmentList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
            <td>
                Probation
            </td>
            <td>
                <asp:ListBox ID="ProbationList" Rows="1" AutoPostBack="True" runat="server"></asp:ListBox>
            </td>
        </tr>
        <tr>
            <td>
                Conditional Discharge
            </td>
            <td>
                <asp:ListBox ID="ConditionalDischargeList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
            <td>
                Split Sentence
            </td>
            <td>
                <asp:ListBox ID="SplitSentenceList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
            <td>
                Fine
            </td>
            <td>
                <asp:ListBox ID="FineList" Rows="1" AutoPostBack="True" runat="server"></asp:ListBox>
            </td>
        </tr>
        <tr>
            <td>
                Unconditional Discharge
            </td>
            <td>
                <asp:ListBox ID="UnconditionalDischargeList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
            <td>
                Restitution/Reparation
            </td>
            <td>
                <asp:ListBox ID="RestitutionReparationList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
            <td>
                Surcharge/Victim Assessment Fee
            </td>
            <td>
                <asp:ListBox ID="SurchargeVictimAssessmentFeeList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
        </tr>
        <tr>
            <td>
                License Penalties
            </td>
            <td>
                <asp:ListBox ID="LicensePenaltiesList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
            <td>
                Consecutive/Concurrent
            </td>
            <td>
                <asp:ListBox ID="ConsecutiveConcurrentList" Rows="1" AutoPostBack="True" runat="server">
                </asp:ListBox>
            </td>
            <td>
                END
            </td>
            <td>
                <asp:ListBox ID="ENDList" Rows="1" AutoPostBack="True" runat="server"></asp:ListBox>
            </td>
        </tr>
    </table>
</asp:Content>
