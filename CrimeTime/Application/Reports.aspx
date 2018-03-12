<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false" CodeFile="Reports.aspx.vb" Inherits="Reports" title="NYPTI CrimeTime - Administrative Reports" %>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="MainDiv center ui-corner-all">
<p>Please input a Start Date and End Date for the report you wish to run.</p>
<table>
<tr>
<td>Start Date:</td>
<td><asp:TextBox ID="StartDate" runat="server" class="dateField"></asp:TextBox></td>
<td>End Date:</td>
<td><asp:TextBox ID="EndDate" runat="server" class="dateField"></asp:TextBox></td>
</tr>
</table>
<asp:Button ID="TotalUsers" runat="server" Text="Total Number of uses" class="nyptiButton"/>
<asp:Button ID="UniqueUsers" runat="server" Text="Unique Users and number of uses per" class="nyptiButton"/>
<asp:Button ID="CrimeAnswerIssues" runat="server" Text="Issue Report" class="nyptiButton"/>
<br />
<br />
<div id="TotalU" runat="server" visible="false">
<asp:Literal ID="LitTotalUsers" runat="server"></asp:Literal>
</div>
<div id="UniqueU" runat="server" visible="false">
<asp:GridView ID="UniqueUGridView" runat="server" CellPadding="4" 
        ForeColor="#333333" GridLines="None">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#2461BF" />
    <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SP_GetEmailTotalUniqueUsedByDate"
      ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
      
</div>
<div id="Issues" runat="server" visible="false">
<asp:GridView ID="IssueGridView" runat="server" CellPadding="4" ForeColor="#333333" 
        GridLines="None" Width="1050" DataKeyNames="AnswerIssueID,Attempted,QuestionID,QuestionsResponse,Date Fixed,Fixed" AutoGenerateColumns="False">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
        <asp:BoundField HeaderText="Crime Name"  DataField="Crime Name" ItemStyle-Width="75" HeaderStyle-Width="75" />
        <asp:BoundField HeaderText="Age" DataField="AGE" ItemStyle-Width="75" HeaderStyle-Width="75"  />
        <asp:BoundField HeaderText="Past Felony Convictions" DataField="Past Convictions" ItemStyle-Width="75" HeaderStyle-Width="75" />
        <asp:BoundField HeaderText="Felony Sentencing Cat" DataField="Fel Sentencing Cat" ItemStyle-Width="75" HeaderStyle-Width="75" />
        <asp:BoundField HeaderText="Issue" ItemStyle-Width="450" HeaderStyle-Width="450"  DataField="Issue" />
        <asp:TemplateField HeaderText="QuestionID" ItemStyle-Width="75" HeaderStyle-Width="75" >
        <ItemTemplate>
        <asp:Literal ID="Question" runat="server"></asp:Literal>
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Question Response" ItemStyle-Width="75" HeaderStyle-Width="75" >
        <ItemTemplate>
        <asp:Literal ID="QuestionResponse" runat="server"></asp:Literal>
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Date Fixed" ItemStyle-Width="75" HeaderStyle-Width="75" >
        <ItemTemplate>
        <asp:Literal ID="DFixed" runat="server"></asp:Literal>
        </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="" ItemStyle-Width="75" HeaderStyle-Width="75" >
        <ItemTemplate>
        <asp:Button ID="FixIT" runat="server" Text="Mark As Fixed" CommandName="FixtheIssue"/>
        </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#2461BF" />
    <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" SelectCommand="SP_GetIssues"
      ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
</div>
</div>
</asp:Content>

