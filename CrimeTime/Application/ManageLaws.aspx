<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false" CodeFile="ManageLaws.aspx.vb" Inherits="ManageLaws" Title="NYPTI CrimeTime - Manage Laws" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="MainDiv center ui-corner-all">
        <asp:Panel ID="SearchPanel" DefaultButton="Search" runat="server" class="centered">
            <asp:TextBox ID="SearchCriteria" runat="server"></asp:TextBox>
            <asp:Button ID="Search" runat="server" Text="Search" class="nyptiButton" ToolTip="Search through citations" />
            &nbsp;
            <asp:Button ID="AddLaw" runat="server" Text="Add New Law" class="nyptiButton" />
        </asp:Panel>
        <asp:GridView ID="fulllistofCrimesGrid" runat="server" AllowPaging="True" AllowSorting="True"
            CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="20"
            AutoGenerateColumns="False" DataKeyNames="CrimesID,Name,law_ordinal">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:TemplateField HeaderText="Viewable">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# If(Eval("Viewable"), "<b>Yes</b>", "")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                    <ItemTemplate>
                        <asp:HyperLink ID="FullText" runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Cite" ReadOnly="true" DataField="Cite" SortExpression="Cite" />
                <asp:BoundField HeaderText="Level" ReadOnly="true" DataField="Level" SortExpression="Level" />
                <%-- <asp:TemplateField HeaderText="" ShowHeader="false">
            <ItemTemplate>
            <asp:HyperLink ID="Sentencing" Text="Add Sentencing Options" runat="server"></asp:HyperLink>
            </ItemTemplate>
            </asp:TemplateField>--%>
            </Columns>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />

        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SP_GetFullCrimeList"
            ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" SelectCommand="SP_GetCrimeListSearched"
            ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </div>
</asp:Content>

