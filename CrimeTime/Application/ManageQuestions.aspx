<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="ManageQuestions.aspx.vb" Inherits="ManageQuestions" Title="NYPTI CrimeTime - Manage Questions" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="MainDiv center ui-corner-all centered">
        <asp:HiddenField ID="HiddenQuestionID" runat="server" />
        <div style="width: 100%;">
            <label>
                Question:</label>
            <br />
            <div style="color: Red; font-size: large;">
                <asp:Label ID="ErrorLabel" runat="server"></asp:Label>
            </div>
            <asp:TextBox ID="QuestionText" runat="server" TextMode="MultiLine" Rows="7" Width="300"></asp:TextBox>
            <%--<asp:RequiredFieldValidator ID="QuestionRequired" ControlToValidate="QuestionText"
                runat="server" ErrorMessage="Please input a Question"></asp:RequiredFieldValidator>--%>
            <br />
            <br />
            <asp:Button ID="AddQuestion" runat="server" Text="Add Question" class="nyptiButton" />
            <asp:Button ID="UpdateQuestion" runat="server" Text="Update Question" Visible="false"
                class="nyptiButton" />
            <asp:Button ID="ClearFields" runat="server" Text="Clear" CausesValidation="false"
                class="nyptiButton" />
            <asp:Button ID="ReturntoCT" runat="server" Text="Return to Administration" CausesValidation="false"
                class="nyptiButton" />
        </div>
        <br />
        <br />
        <div>
            <asp:GridView ID="QuestionsGrid" runat="server" CellPadding="4" ForeColor="#333333"
                GridLines="None" DataKeyNames="QuestionsID" AutoGenerateColumns="False">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <%--<asp:TemplateField HeaderText="Edit">
                        <ItemTemplate>
                            <asp:Button ID="EditButton" runat="server" Text="Edit" CommandName="EditQuestion"
                                CausesValidation="false" class="nyptiButton" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="EditButton" runat="server" ToolTip="Edit Question" ImageUrl="images/Edit.png"
                                CommandName="EditQuestion" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="DeleteButton" runat="server" ToolTip="Delete Question" ImageUrl="images/trash.png"
                                CommandName="DeleteQuestion" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this Question?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HtmlEncode="true" HeaderText="Question Text" DataField="Literal" />
                </Columns>
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
