<%@ Page Title="NYPTI CrimeTime - Add, Edit or Remove Paragraphs" Language="VB" MasterPageFile="~/NYPTICrimeTime.master"
    AutoEventWireup="false" CodeFile="ParagraphUsage.aspx.vb" Inherits="ParagraphUsage" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
            <div style="text-align: left; width: 90%">
                <asp:Label ID="Paragraph" runat="server"></asp:Label>
            </div>

            <hr />
            <asp:Button ID="btnRemoveFromPermutations" runat="server" CssClass="nyptiButton" Text ="Remove Paragraph from Selected Permutations" OnClientClick="return confirm('Are you sure you want to remove this Paragraph from the selected Permutations (this cannot be undone)?');" />
            <div style="color: Red; font-size: large; ">
                <asp:Label ID="lblResult" runat="server"></asp:Label>
            </div>
        </div>
        <br />
        <asp:GridView ID="gvLawUsed" runat="server" AutoGenerateColumns="False" CellPadding="4" GridLines="None" DataKeyNames="CrimesID"
            CssClass="catGrid" ShowHeader="false">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td colspan="2">
                                    <span id="chevron" class="ui-icon ui-icon-carat-1-e accord" style="display: inline-block;"></span>
                                    <%# Eval("Cite") & " - <span style='color: " & If(Eval("Level").ToString.Contains("Misdemeanor"), "#A36CC8", "") & If(Eval("Level").ToString.Contains("Felony"), "#C55151", "") & ";'>" & Eval("Level") & "</span> - " & Eval("Name")%>
                                   
                                </td>
                            </tr>
                            <tr>
                                <%--indent the permutation grid--%>
                                <td style="width: 25px"></td>
                                <td>
                                    <asp:GridView ID="gvPermutations" runat="server" CellPadding="4"
                                        GridLines="None" DataKeyNames="CrimeAnswerID" AutoGenerateColumns="False"
                                        OnRowCommand="gvPermutations_RowCommand" CssClass="mGrid" AlternatingRowStyle-CssClass="alter" Style="display: none;">
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
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="EditButton" runat="server" ToolTip="Edit Permutation" ImageUrl="images/Edit.png"
                                                        CommandName="EditSentence" CommandArgument='<%# Bind("CrimeAnswerID")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>Attempt</HeaderTemplate>
                                                <ItemTemplate>
                                                    <%# IIf(CBool(Eval("Attempted")), "Yes", "No")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                              <asp:TemplateField>
                                                <HeaderTemplate>Qualifying Question Response</HeaderTemplate>
                                                <ItemTemplate>
                                                    <%# If(IsDBNull(Eval("QuestionsResponse")), "", IIf(CBool(Eval("QuestionsResponse")), "Yes", "No"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Age" NullDisplayText="" DataField="Age" />
                                            <asp:BoundField HeaderText="Past Convictions" NullDisplayText="" DataField="PastConvictions" />
                                            <asp:BoundField HeaderText="Felony Cat" NullDisplayText="" DataField="FelonyCategory" />
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
