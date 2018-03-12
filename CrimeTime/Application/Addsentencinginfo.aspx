<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="Addsentencinginfo.aspx.vb" Inherits="Addsentencinginfo" Title="NYPTI CrimeTime - Add Sentencing Information" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            //iToggle can be found here: http://plugins.jquery.com/itoggle/
            $('.iToggle').iToggle({ speed: 100 });
        });
        var el;

        $("select")
        .each(function () {
            el = $(this);
            el.data("origWidth", el.outerWidth()) // IE 8 can haz padding
        })
        .mouseenter(function () {
            $(this).css("width", "auto");
        })
        .bind("blur change", function () {
            el = $(this);
            el.css("width", el.data("origWidth"));
        });
        function changeViewStatus() {
            $.ajax({
                type: "POST"
                , url: "Addsentencinginfo.aspx/changeViewStatus"
                , data: '{CID: "' + <%= Request("CID")%> + '" }'
                , contentType: "application/json; charset=utf-8"
                , dataType: "json",
            })
        };
    </script>
    <center>
        <div>
            <input ID="chkViewStatus" type="checkbox" class="iToggle" data-label-on="Active" data-label-off="Inactive" runat="server" onchange="changeViewStatus()" />
        </div>
        <div>
            <asp:Label ID="CrimeName" runat="server"></asp:Label>
            <asp:Button ID="EditLawButton" runat="server" Text="Edit Title" class="nyptiButton" />
        </div>
        <asp:Label ID="lblError" runat="server"></asp:Label>
        <div id="RadioButtonWrapper" runat="server" style="background-color: #C0C0C0; width: 55%;
            overflow: auto; min-width: 500px; height: auto;">
            <table>
                <tr>
                    <td align="center" valign="middle" style="width: 20%;">
                        <div>
                            <label>
                                Qualifying Question
                            </label>
                            <br />
                            <asp:Button ID="AddQuestions" runat="server" Text="Add/Edit Questions"
                    CausesValidation="false" class="nyptiButton" />
                        </div>
                    </td>
                    <td>
                        <div style="overflow: auto; height: 140px;">
                            <asp:RadioButtonList ID="Questions" runat="server">
                            </asp:RadioButtonList>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td align="center" valign="middle">
                        <div>
                            <label style="padding-top: 25px;">
                                Mitigating Factor
                            </label>
                        </div>
                    </td>
                    <td>
                        <div style="overflow: auto; height: 140px;">
                            <asp:RadioButtonList ID="Mitigating" runat="server">
                            </asp:RadioButtonList>
                        </div>
                    </td>
                </tr>
            </table>
            <div style="width: 100%; float: left; height: 33px">
                <asp:Button ID="ChangeQuestion" runat="server" Text="Update Qualifying Question and Mitigating Factor Selection" CausesValidation="false"
                    class="nyptiButton" />
            </div>
        </div>

        <br />
        <div id="ButtonWrapper">
           <asp:Button ID="CopyButton" runat="server" Text="Copy All Permutations" class="nyptiButton" />
            <asp:Button ID="PasteButton" runat="server" Text="Paste Permutations" Enabled="false"
                class="nyptiButton" OnClientClick="return confirm('Are you sure you want to add the copied Permutations with accompanying Paragraph Selection?');" />
        </div>
        <div>
            <ul style="list-style: none; text-align: left; padding-left: 25%;">
                <li>
                    <label>
                        <strong>Selected Question:</strong></label>
                    <asp:Label ID="lblQuestion" runat="server"></asp:Label></li>
                <li>
                    <label>
                        <strong>Mitigating Factor:</strong>
                    </label>
                    <asp:Label ID="lblMitigating" runat="server"></asp:Label></li>
            </ul>
            <asp:GridView ID="CrimeAnswerGridview" DataSourceID="SqlDataSource1" DataKeyNames="CrimeAnswerID"
                runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333"
                GridLines="None">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="EditButton" runat="server" ToolTip="Edit Permutation Paragraph Selection" ImageUrl="images/Edit.png"
                                CommandName="EditSentence" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                            <asp:ImageButton ID="DeleteButton" runat="server" ToolTip="Delete Permutation" ImageUrl="images/trash.png"
                                CommandName="DeleteSentence" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this permutation?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Attempt" NullDisplayText="" DataField="Attempted" />
                    <asp:BoundField HeaderText="Qualifying Question Response" NullDisplayText="" DataField="QuestionsResponse" />
                    <asp:BoundField HeaderText="Age" NullDisplayText="" DataField="AgeCat" />
                    <asp:BoundField HeaderText="Past Convictions" NullDisplayText="" DataField="PastConCat" />
                    <asp:BoundField HeaderText="Felony Cat" NullDisplayText="" DataField="FelonyCat" />
                    
                </Columns>
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <AlternatingRowStyle BackColor="White" />
             
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SP_GetCrimeAnswerListByCrimeID"
                ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
        </div>
        <div id="AddPermutationWrapper">
            <table>
                <tr>
                    <td>
                        Attempted Crime
                    </td>
                    <td>
                        <asp:DropDownList ID="Attempted" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Qualifying Question Response
                    </td>
                    <td>
                        <asp:DropDownList ID="QuestionResponses" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Age Category
                    </td>
                    <td>
                        <asp:DropDownList ID="AgeCat" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Past Felony Convictions
                    </td>
                    <td>
                        <asp:DropDownList ID="PastCon" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Felony Sentencing Category
                    </td>
                    <td>
                        <asp:DropDownList ID="FelCat" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <asp:Button ID="AddPermutation" runat="server" Text="Add Permutation" class="nyptiButton" OnClientClick="return confirm('Are you sure you want to add a NEW Permutation with these criteria to the list of Permutations?');" />
        </div>
    </center>
</asp:Content>
