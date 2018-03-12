<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb"  Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NYPTI CrimeTime - Login</title>
    <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Login ID="Login1" class="center centered msgDiv ui-corner-all"  runat="Server"
           InstructionText="Please enter your username and password" 
           DisplayRememberMe="False">
       <LayoutTemplate>
           <table  cellpadding="4" cellspacing="0" >
               <tr>
                   <td>
                       <table border="0" cellpadding="0">
                           <tr>
                               <td align="center" colspan="2" 
                                   style="color:White;background-color:#0155b5;font-weight:bold;">
                                   Administrator Login</td>
                           </tr>
                           <tr>
                               <td align="center" colspan="2">
                                   Please enter your username and password</td>
                           </tr>
                           <tr>
                               <td align="right">
                                   <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                               </td>
                               <td>
                                   <asp:TextBox ID="UserName" Width="150px"  runat="server"></asp:TextBox>
                                   <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                       ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                       ToolTip="UserName is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                               </td>
                           </tr>
                           <tr>
                               <td align="right">
                                   <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                               </td>
                               <td>
                                   <asp:TextBox ID="Password" Width="150px" runat="server" TextMode="Password"></asp:TextBox>
                                   <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                       ControlToValidate="Password" ErrorMessage="Password is required." 
                                       ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                               </td>
                           </tr>
                           <tr>
                               <td align="center" colspan="2" style="color:Red;">
                                   <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                               </td>
                           </tr>
                           <tr>
                               <td align="right" colspan="2">
                                   <asp:Button ID="LoginButton" runat="server" class="nyptiButton"
                                        CommandName="Login"  Text="Login" ValidationGroup="Login1" />
                               </td>
                           </tr>
                       </table>
                   </td>
               </tr>
           </table>
       </LayoutTemplate>
     </asp:Login>
    </div>
    </form>
</body>
</html>
