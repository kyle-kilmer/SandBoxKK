<%@ Page Title="NYPTI CrimeTime - Add, Edit or Remove Paragraphs" Language="VB" MasterPageFile="~/NYPTICrimeTime.master"
    AutoEventWireup="false" CodeFile="Paragraphs.aspx.vb" Inherits="Paragraph" %>

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

    <button onclick="window.close()" class="nyptiButton">
        Close</button>
    <br />
    <div style="color: Red; font-size: large;">
        <asp:Label ID="lblResult" runat="server"></asp:Label>
    </div>
    <div class="GridTable ui-corner-all" style="text-align: center">

        <asp:GridView ID="ParagraphCategories" runat="server" AutoGenerateColumns="False" CellPadding="1" GridLines="None" DataKeyNames="ParagraphCategoryID"
            CssClass="catGrid" ShowHeader="false">
            <Columns>
                <asp:TemplateField >
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td colspan="2">
                                    <span id="chevron" class="ui-icon ui-icon-carat-1-e accord" style="display: inline-block;"></span>
                                    <%# Eval("Literal")%>
                                   
                                </td>
                            </tr>
                            <tr>
                                <%--indent the permutation grid--%>
                                <td style="width: 25px;"></td>
                                <td>

                                    <asp:GridView ID="gvParagraphs" runat="server" CellPadding="1"
                                        GridLines="None" DataKeyNames="ParagraphID, Literal, CategoryID" AutoGenerateColumns="False"
                                        OnRowDataBound="OnGridRDB" OnRowCommand="OnRowCommand" CssClass="mGrid" AlternatingRowStyle-CssClass="alter" Style="display: none;">
                                        <Columns>
                                            <asp:TemplateField>
                                               <HeaderTemplate>
                                                   <asp:HyperLink ID="AddNew" runat="server" Text="Add New Paragraph" ToolTip="Add New Paragraph in this Category" style="color:white"/>
                                                   <%--<asp:Button ID="btnAddNew" Text="Add Paragraph" runat="server" CssClass="nyptiButton" CommandName="AddParagraph" CommandArgument='<%# Eval("CategoryID")%>' />--%>
                                               </HeaderTemplate>
                                                <ItemTemplate>
                                                    <div style="width:145px">
                                                    <asp:HyperLink ID="EditSentence" runat="server">
                                                        <asp:Image ID="EditButton" runat="server" ToolTip="Edit Paragraph" ImageUrl="images/Edit.png" />
                                                    </asp:HyperLink>
                                                    <asp:ImageButton ID="DeleteButton" runat="server" ToolTip="Delete Paragraph" ImageUrl="images/trash.png"
                                                        CommandName="DeleteParagraph" CommandArgument='<%# Eval("ParagraphID")%>' 
                                                        OnClientClick="return confirm('Are you sure you want to delete this paragraph?');" />
                                                     <asp:HyperLink ID="WhereUsed" runat="server">
                                                        <asp:Image ID="WhereUsedbtn" runat="server" ToolTip="Where is this paragraph used?" ImageUrl="images/search.png" />
                                                    </asp:HyperLink>
                                                    <asp:HyperLink ID="AddToMultiple" runat="server">
                                                        <asp:Image ID="btnAddToMultiple" runat="server" ToolTip="Add Paragraph to Multiple Law Permutations" ImageUrl="images/AddMultiple.png" />
                                                    </asp:HyperLink>
                                                        </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="ParagraphKey" DataField="ParagraphKey" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Paragraph
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="ParaLabel" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>

                                    </asp:GridView>

                                </td>
                            </tr>
                        </table>

                    </ItemTemplate>

                </asp:TemplateField>

        <%--        <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnAddNew" Text="Add Paragraph" runat="server" CssClass="nyptiButton" CommandName="AddParagraph" CommandArgument='<%# CType(Container,GridViewRow).RowIndex %>' />
                    </ItemTemplate>
                </asp:TemplateField>--%>

            </Columns>

        </asp:GridView>

    </div>
</asp:Content>
