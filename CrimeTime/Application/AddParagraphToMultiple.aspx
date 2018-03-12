<%@ Page Title="NYPTI CrimeTime - Add Paragraph to Multiple Law Permutations" Language="VB" MasterPageFile="~/NYPTICrimeTime.master"
    AutoEventWireup="false" CodeFile="AddParagraphToMultiple.aspx.vb" Inherits="AddParagraphToMultiple" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/select2.css" rel="stylesheet" type="text/css" />
    <script src="js/select2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".accord").on
            $(".accord").click(function () {
                if ($(this).hasClass("ui-icon-carat-1-e")) {
                    $(this).closest("tr").next().find("table").show("blind", 500);
                } else {
                    $(this).closest("tr").next().find("table").hide("blind", 500);
                }
                $(this).toggleClass("ui-icon-carat-1-e");
                $(this).toggleClass("ui-icon-carat-1-s");
            });
            $(".NYPTIMultiSelectBox").select2({
                placeholder: "Select 1 or more items to filter",
                allowClear: true
            });
        });

    </script>
    <script type="text/javascript">
        function selectAll(e) {
            //get the table that contains the check box that was clicked
            var table = $("#" + e.id).closest("table");
            //set each checkbox to the same state as the header checkbox (the calling checkbox)
            $('td input:checkbox', table).prop('checked', e.checked);
        }
    </script>

    <div class="GridTable ui-corner-all" style="text-align: center">
          <div style="width: 50%" class="ParagraphTextDiv ui-corner-all center centered">
            <asp:Label ID="Label1" runat="server" Font-Size="Larger">Paragraph Text</asp:Label>
            <div style="text-align: left;">
                <asp:Label ID="Paragraph" runat="server"></asp:Label>
            </div>
              <hr />
            <div style="text-align: right">
                <asp:ListBox ID="lbFilterSelect" runat="server" SelectionMode="Multiple" class="NYPTIMultiSelectBox" Width="50%">
                    <asp:ListItem Value="AF">Class A Felony</asp:ListItem>
                    <asp:ListItem Value="BF">Class B Felony</asp:ListItem>
                    <asp:ListItem Value="CF">Class C Felony</asp:ListItem>
                    <asp:ListItem Value="DF">Class D Felony</asp:ListItem>
                    <asp:ListItem Value="EF">Class E Felony</asp:ListItem>
                    <asp:ListItem Value="AM">Class A Misdemeanor</asp:ListItem>
                    <asp:ListItem Value="BM">Class B Misdemeanor</asp:ListItem>
                    <asp:ListItem Value="V">Violation</asp:ListItem>
                    <asp:ListItem Value="I">Infraction</asp:ListItem>
                </asp:ListBox>
                <asp:Button ID="btnFilter" runat="server" CssClass="nyptiButton" Text ="Filter" />
                <asp:Button ID="btnAddToPermutations" runat="server" CssClass="nyptiButton" Text ="Add Paragraph to Selected Permutations" />
            </div>
            <div style="color: Red; font-size: large;">
                <asp:Label ID="lblResult" runat="server"></asp:Label>
            </div>
        </div>
        <br />
        <asp:GridView ID="gvLawUsed" runat="server" AutoGenerateColumns="False" CellPadding="4" GridLines="None" DataKeyNames="CrimesID"
            CssClass="catGrid" ShowHeader="false" >
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <%--Use a table so that the permutation grid appears under (instead of next to) the law title and name--%>
                        <table>
                            <tr>
                                <td colspan="2">
                                    <span id="test" class="ui-icon ui-icon-carat-1-e accord" style="display: inline-block;"></span>
                                    <%# Eval("Cite") & " - <span style='color: " & If(Eval("Level").ToString.Contains("Misdemeanor"), "#A36CC8", "") & If(Eval("Level").ToString.Contains("Felony"), "#C55151", "") & ";'>" & Eval("Level") & "</span> - " & Eval("Name")%>
                                </td>
                            </tr>
                            <tr >
                                <%--indent the permutation grid--%>
                                <td style="width: 25px"></td>
                                <td>
                                    <asp:GridView ID="gvPermutations" runat="server" CellPadding="4"
                                        GridLines="None" DataKeyNames="CrimeAnswerID" AutoGenerateColumns="False"
                                        OnRowCommand="gvPermutations_RowCommand" CssClass="mGrid" AlternatingRowStyle-CssClass="alter" style="display:none;">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <input id="chkAll2" onclick="javascript: selectAll(this)" runat="server" type="checkbox" />
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>Attempt</HeaderTemplate>
                                                <ItemTemplate>
                                                    <%# IIf(CBool(Eval("Attempted")), "Yes", "No")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Level" NullDisplayText="" DataField="Level" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>Qualifying Question Response</HeaderTemplate>
                                                <ItemTemplate>
                                                    <%# If(IsDBNull(Eval("QuestionsResponse")), "", IIf(CBool(Eval("QuestionsResponse")), "Yes", "No"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Age" NullDisplayText="" DataField="AgeCat" />
                                            <asp:BoundField HeaderText="Past Convictions" NullDisplayText="" DataField="PastConCat" />
                                            <asp:BoundField HeaderText="Felony Cat" NullDisplayText="" DataField="FelonyCat" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>

                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
