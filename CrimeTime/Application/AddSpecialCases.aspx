<%@ Page Language="VB" validateRequest="false"  MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false" CodeFile="AddSpecialCases.aspx.vb" Inherits="AddSpecialCases" title="Untitled Page" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:HiddenField ID="SpecialID" runat="server" />
Popup:<br />
<asp:TextBox ID="SpecialPopup" runat="server" TextMode="MultiLine" Width="500px" Rows="10"></asp:TextBox>
<br />
Reason<br />
<asp:TextBox ID="PopUpReason" runat="server" TextMode="MultiLine" Width="500px" Rows="5"></asp:TextBox>
<br />
<asp:Button ID="AddSpecial" runat="server" Text="Add" />
<asp:Button ID="Update" runat="server" Text="Update" />
<asp:GridView ID="SpecialPopupGridview" DataKeyNames="SpecialPopUpsID" 
        runat="server" CellPadding="4" 
        ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
        <asp:BoundField HeaderText="SpecialPopUpText" DataField="Literal">
            <ItemStyle Width="500px" />
        </asp:BoundField>
        <asp:BoundField HeaderText="Reason Created" DataField="Reason">
             <ItemStyle Width="100px" />
        </asp:BoundField>
        <asp:TemplateField HeaderText="Edit">
        <ItemTemplate>
        <asp:Button ID="EDITOR" runat="server" CommandName="EditPopup" Text="Edit Popup" />
        </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#2461BF" />
    <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SP_GetSpecialPopups"
      ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
</asp:Content>

