<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="CrimeTime.aspx.vb" Inherits="CrimeTime" Title="NYPTI CrimeTime Online" %>

<asp:Content ID="Head1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {

            $("#offenseTextWrapper").dialog({
                autoOpen: false,
                // width: 400,
                // height: 200,
                modal: true,
                show: "blind",
                hide: "blind",
                buttons: {
                    Ok: function () {
                        $(this).dialog("close");
                    }
                }
            });

            //          use this if you want the offense text to show up in a fancy popup
            //            $(".offenseTextLink").click(function (event) {
            //                event.preventDefault();
            //                var link = $(this).attr('href');

            //                $("#offenseTextDiv").load(link, function () {
            //                    $("#offenseTextWrapper").dialog("open");
            //                });
            //            });

            var windowsize = $(window).width();
            CheckSize(windowsize);
        });

        $(window).resize(function () {
            var windowsize = $(window).width();
            CheckSize(windowsize);
        });

        function CheckSize(windowsize) {
            if (windowsize > 520) {
                $(".ctGrid td:nth-child(3),th:nth-child(3)").show();
                //  $(".ctGrid td:nth-child(4),th:nth-child(4)").show();
            }
            else {
                $(".ctGrid td:nth-child(3),th:nth-child(3)").hide();
                //$(".ctGrid td:nth-child(4),th:nth-child(4)").hide();

                //since the hide above will also select the pagination 3rd and 4th value we need to put them back
                $(".ctGrid td:nth-child(3):contains('3')").show();
                //$(".ctGrid td:nth-child(4):contains('4')").show();
            }
        };
    </script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="ActiveTab" runat="server" />
    <div id="navigatorlist" runat="server" class="navigatorlist center">
        <asp:LinkButton ID="HomeLink" CausesValidation="false" class="lawFilterTab" runat="server">All Laws</asp:LinkButton>
        <asp:LinkButton ID="PenalLawsLink" CausesValidation="false" class="lawFilterTab"
            runat="server">PL</asp:LinkButton>
        <asp:LinkButton ID="VTLLawsLink" CausesValidation="false" class="lawFilterTab" runat="server">VTL</asp:LinkButton>
        <asp:LinkButton ID="CorrLawsLink" CausesValidation="false" class="lawFilterTab" runat="server">Corr. L.</asp:LinkButton>
    </div>
    <br />
    <div id="SearchDiv" class="msgDiv ui-corner-all center centered shadow">
        <asp:Panel ID="SearchPanel" runat="server" DefaultButton="Searcher" BorderStyle="None">
            <div style="font-weight: bold; font-size: large;">
                Search Criteria:
            </div>
            <div style="font-size: medium;">
                (please input the cite number or phrase i.e. 255.17 or 'assault')
            </div>
            <asp:TextBox ID="SearchCriteria" runat="server" Style="margin: 8px;" class="searchBox"></asp:TextBox>
            <br />
            <asp:Button ID="Searcher" runat="server" Text="Search For Crime" class="nyptiButton"
                Style="padding: 5px;" />
            <br />
        </asp:Panel>
    </div>
    <br />
    <%--    <div id="offenseTextWrapper" title="Full Offense Text">
          <div id="offenseTextDiv"></div>
    </div>--%>
    <div class="disclaimerDiv center centered ui-corner-all" style="font-weight: bold;">
        Click the name of the Offense to determine sentencing options
    </div>
    <div>
        <asp:GridView ID="CrimeTimeGrid" DataSourceID="SqlDataSource1" AllowSorting="true"
            runat="server" AutoGenerateColumns="False" Style="border: 2px #336699 solid;"
            class="ui-corner-all center ctGrid" CellPadding="4" EmptyDataText="No Crimes Available"
            DataKeyNames="CrimesID,Name,repeal_date,Cite,Literal, title, section" ForeColor="#333333"
            GridLines="None" AllowPaging="True" PageSize="40" PagerSettings-Position="TopAndBottom">
            <PagerSettings Position="TopAndBottom"></PagerSettings>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        Cite
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="FullText" runat="server" HeaderStyle-Width="100"
                            ReadOnly="true" DataField="Cite" class="offenseTextLink" SortExpression="Cite"
                            ToolTip="View Statutory Text" Target="_blank"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                    <ItemTemplate>
                        <asp:Button ID="SelectCrime" ToolTip="Click to Calculate Sentence" runat="server"
                            class="nyptiButton center" Style="width: 90%; white-space: normal;"></asp:Button>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Level" ReadOnly="true" DataField="Level" HeaderStyle-Width="90"
                    SortExpression="Level" />
            </Columns>
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#336699" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
    </div>
    <div>
        <asp:Label ID="lblerrors" runat="server"></asp:Label>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SP_GetCrimeList"
        ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" SelectCommand="SP_GetCrimeListPLONLY"
        ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" SelectCommand="SP_GetCrimeListVTLONLY"
        ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" SelectCommand="SP_GetCrimeListCORONLY"
        ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure" />
    <asp:SqlDataSource ID="SqlDataSource5" runat="server" SelectCommand="SP_GetCrimeTIMEListSearched"
        ConnectionString="<%$ ConnectionStrings:CTConnection %>" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
</asp:Content>
