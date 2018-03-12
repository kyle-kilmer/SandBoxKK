<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/NYPTICrimeTime.master"
    ValidateRequest="false" CodeFile="AddParagraphs.aspx.vb" Inherits="AddParagraphs"
    Title="NYPTI CrimeTime - Add New Paragraph" %>

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
    <div class="MainDiv center ui-corner-all centered">
        <center>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="CategoryLabel" runat="server">Select Category</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="CategoryList" runat="server" Enabled="false">
                            <asp:ListItem Value="-1" Text=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="KeyLabel" runat="server">Enter Paragraph Key:</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="KeyTextBox" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:TextBox ID="ParagraphTextBox" runat="server" Height="200" Width="200" MaxLength="4000"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:Button ID="AddButton" Text="Add Paragraph" runat="server" CausesValidation="false"
                class="nyptiButton" />
            &nbsp;
            <asp:Button ID="ClearButton" Text="Clear" runat="server" CausesValidation="false"
                class="nyptiButton" />
            &nbsp;
            <asp:Button ID="ReturnButton" Text="Back" runat="server" CausesValidation="false"
                class="nyptiButton" />
            <br />
            <asp:Label ID="lblResult" runat="server"></asp:Label><br />
            <asp:Label ID="lblError" runat="server"></asp:Label>
        </center>
    </div>
</asp:Content>
