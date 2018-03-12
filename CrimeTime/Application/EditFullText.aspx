<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditFullText.aspx.vb" Inherits="EditFullText" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Text of Statute</title>
    <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:TextBox ID="FullText" TextMode="MultiLine" Rows="20" ReadOnly="false" Width="648px" runat="server"></asp:TextBox>
    </div>
    <asp:Button ID="Editor" runat="server" Text="Update Statutory Text" /><br />
    <asp:label ID="lblErrors" runat="server" CssClass="errortext"></asp:label>
    
    
    
    </form>
</body>
</html>
