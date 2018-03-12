<%@ Page Title="NYPTI CrimeTime - Add New Law" Language="VB" MasterPageFile="~/NYPTICrimeTime.master"
    AutoEventWireup="false" CodeFile="AddLaw.aspx.vb" Inherits="AddLaw" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- Scripts for datepicker --%>
    <%--<script type="text/javascript">
        $(function () {
            $("#ContentPlaceHolder1_EffectiveDateTextBox").datepicker();
            $("#ContentPlaceHolder1_RepealDateTextBox").datepicker();
        });
    </script>--%>
    <div class="MainDiv center ui-corner-all">
        <center>
            <table>
                <tr>
                    <td align="right">
                        Law Ordinal:
                    </td>
                    <td>
                        <asp:TextBox ID="LawOrdinalTextBox" runat="server"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="LawOrdinalValidator" ControlToValidate="LawOrdinalTextBox"
                            Text="Law Ordinal is required" runat="server" />--%>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <label style="color: Red;">
                            *</label>Title:
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Height="66px"
                            Width="228px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <label style="color: Red;">
                            *</label>Statute:
                    </td>
                    <td>
                        <asp:DropDownList ID="TitleTextBox" runat="server">
                            <asp:ListItem Text="PL"></asp:ListItem>
                            <asp:ListItem Text="VTL"></asp:ListItem>
                            <asp:ListItem Text="COR"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <label style="color: Red;">
                            *</label>Section:
                    </td>
                    <td>
                        <asp:TextBox ID="SectionTextBox" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Subsection:
                    </td>
                    <td>
                        <asp:TextBox ID="SubsectionTextBox" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <label style="color: Red;">
                            *</label>NYS Law Category:
                    </td>
                    <td>
                        <asp:DropDownList ID="LawCategoryTextBox" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <%--<asp:ListItem Text="B"></asp:ListItem>
                            <asp:ListItem Text="E"></asp:ListItem>
                            <asp:ListItem Text="F"></asp:ListItem>
                            <asp:ListItem Text="L"></asp:ListItem>
                            <asp:ListItem Text="M"></asp:ListItem>
                            <asp:ListItem Text="V"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <label style="color: Red;">
                            *</label>Class:
                    </td>
                    <td>
                        <asp:DropDownList ID="ClassTextBox" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <%--<asp:ListItem Text="A"></asp:ListItem>
                            <asp:ListItem Text="B"></asp:ListItem>
                            <asp:ListItem Text="C"></asp:ListItem>
                            <asp:ListItem Text="D"></asp:ListItem>
                            <asp:ListItem Text="E"></asp:ListItem>
                            <asp:ListItem Text="F"></asp:ListItem>
                            <asp:ListItem Text="U"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <label style="color: Red;">
                            *</label>Attempted NYS Law Category:
                    </td>
                    <td>
                        <asp:DropDownList ID="AttemptedLawCategoryTextBox" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <%--<asp:ListItem Text="B"></asp:ListItem>
                            <asp:ListItem Text="E"></asp:ListItem>
                            <asp:ListItem Text="F"></asp:ListItem>
                            <asp:ListItem Text="L"></asp:ListItem>
                            <asp:ListItem Text="M"></asp:ListItem>
                            <asp:ListItem Text="V"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <label style="color: Red;">
                            *</label>Attempted Class:
                    </td>
                    <td>
                        <asp:DropDownList ID="AttemptedClassTextBox" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <%--<asp:ListItem Text="A"></asp:ListItem>
                            <asp:ListItem Text="B"></asp:ListItem>
                            <asp:ListItem Text="C"></asp:ListItem>
                            <asp:ListItem Text="D"></asp:ListItem>
                            <asp:ListItem Text="E"></asp:ListItem>
                            <asp:ListItem Text="F"></asp:ListItem>
                            <asp:ListItem Text="U"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <%--<tr>
                    <td align="right">
                        Statue:
                    </td>
                    <td>
                        <asp:TextBox ID="StatueTextBox" runat="server"></asp:TextBox>
                    </td>
                </tr>--%>
                <tr>
                    <td align="right">
                        Effective Date:
                    </td>
                    <td>
                        <asp:TextBox ID="EffectiveDateTextBox" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Repeal Date:
                    </td>
                    <td>
                        <asp:TextBox ID="RepealDateTextBox" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Image ID="InfoButton1" runat="server" ImageUrl="images/information.png" Height="16" Width="16" />
                        Violent Felony Indicator:
                    </td>
                    <td>
                        <asp:DropDownList ID="ViolentFelonyIndicatorTextBox" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="L" Value="L"></asp:ListItem>
                            <asp:ListItem Text="Non-violent Felony" Value="N"></asp:ListItem>
                            <asp:ListItem Text="Violent Felony" Value="V"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                    <asp:Image ID="InfoButton2" runat="server" ImageUrl="images/information.png"  Height="16" Width="16" />
                        Attempted Violent Felony Indicator:
                    </td>
                    <td>
                        <asp:DropDownList ID="AttemptedViolentFelonyIndicatorTextBox" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="L" Value="L"></asp:ListItem>
                            <asp:ListItem Text="No violent Felony Indicator" Value="N"></asp:ListItem>
                            <asp:ListItem Text="Violent Felony Indicator" Value="V"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <%--<asp:CheckBox ID="JuniorOffenderIndicator" runat="server" Text="Junior Offender"
                            AutoPostBack="true" />--%>
                        <asp:Button ID="AddButton" runat="server" Text="Add Law" CssClass="nyptiButton" />
                        &nbsp;
                        <asp:Button ID="ClearButton" runat="server" Text="Clear" CssClass="nyptiButton" CausesValidation="false" />
                        &nbsp;
                        <asp:Button ID="CancelButton" runat="server" Text="Cancel" CssClass="nyptiButton"
                            CausesValidation="false" />
                    </td>
                </tr>
            </table>
            <br />
            <label style="color: Red;">
                Fields marked by a * are required</label>
            <br />
            <asp:Label ID="lblError" runat="server"></asp:Label>
        </center>
    </div>
</asp:Content>
