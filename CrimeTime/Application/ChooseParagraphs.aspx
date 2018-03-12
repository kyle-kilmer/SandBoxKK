<%@ Page Language="VB" MasterPageFile="~/NYPTICrimeTime.master" AutoEventWireup="false"
    CodeFile="ChooseParagraphs.aspx.vb" Inherits="ChooseParagraphs" Title="NYPTI CrimeTime - Paragraph Chooser" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function get(name) {
            if (name = (new RegExp('[?&]' + encodeURIComponent(name) + '=([^&]*)')).exec(location.search))
                return decodeURIComponent(name[1]);
        };
        $(document).ready(function () {
            // Javascript code to do category headers is from js/jquery.multi-select.js
         
            setupOptGroups($(".categorised"));
            setupMultiSelect();
            // Populate Preview pane on page load
            ProcessSelected();
        });
        function setupOptGroups(select) {
            var optGroups = new Array();
            var i = 0;

            $(select).find("[optGroup]").each(function (index, domEle) {
                var optGroup = $(this).attr("optGroup");
                if ($.inArray(optGroup, optGroups) == -1) optGroups[i++] = optGroup;
            });

            for (i = 0; i < optGroups.length; i++) {
                $("option[optGroup='" + optGroups[i] + "']").wrapAll("<optgroup label='" + optGroups[i] + "'>");
            }
        }
        function setupMultiSelect() {
            $('.categorised').multiSelect({
                afterSelect: function (values) {
                    ProcessSelected();
                },
                afterDeselect: function (values) {
                    ProcessSelected();
                }
            });
        }
        //Add Selected Paragraphs to the preview pane
        function ProcessSelected() {
            var a = $('.categorised').val();
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    $('.AnswerPreview').html(xmlhttp.responseText);
                    //alert("here you go:: " + xmlhttp.responseText)
                }
            }
            xmlhttp.open("GET", "Getparagraphs.ashx?IDs=" + a, true);
            xmlhttp.send();
        };
        function PasteParagraphs() {

            var currentIDs = $('.categorised').val() || [];
            var CopiedParagraphIDs = '<%= Session("CopiedParagraphIDs")%>';
            if (CopiedParagraphIDs.length > 0) {
                var IDs = CopiedParagraphIDs.split(",")
                var newIDs = currentIDs.concat(IDs);
                $('.categorised').val(newIDs);
            }
            //re-run the setup routines to display selection information from copied IDs
            setupMultiSelect();
            ProcessSelected();
            return false;
        };
    </script>
    <br />
    <asp:Panel ID="ContentWrapper" runat="server">
        <div>
            <h3>
                <asp:Label ID="CrimeName" runat="server"></asp:Label></h3>
        </div>
        <div>
            <asp:Label ID="lblResult" runat="server"></asp:Label>
        </div>
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="nyptiButton" />
        <button onclick="window.open('./Paragraphs.aspx?CID=' + get('CID'), '_blank'); return false" class="nyptiButton">
            Paragraphs</button>
        <%--<asp:Button ID="btnParagraphs" OnClientClick="" runat="server" />--%>
        <asp:Button ID="btnCopy" runat="server" Text="Copy All Paragraphs" CssClass="nyptiButton" />
        <asp:Button ID="btnPaste" runat="server" Text="Paste Paragraphs" Enabled="false"
            CssClass="nyptiButton" OnClientClick="PasteParagraphs(); return false;" CausesValidation="false" />
        <br />
        <div style="background-color: #507CD1; color: White;">
            <asp:Label ID="Qualifiers" runat="server"></asp:Label>
        </div>
        <br />

        <!-- ColumnWrapper Starts -->
        <div id="ColumnWrapper" style="width: 100%; overflow: hidden;">
            <asp:Panel ID="SelectionPanel" runat="server">
                <div id="SelectionWrapper" style="width: 30%; float: left;">
                    <asp:ListBox ID="lbParagraphKeys" runat="server" SelectionMode="Multiple" Rows="20" class="categorised" />
                </div>
                <!-- Answer Preview Wrapper Starts -->
                <div id="PreviewWrapper" runat="server" style="width: 65%; float: left; padding-left: 20px; height: 600px; overflow: auto;">
                    <h3 class="centered">Answer Preview</h3>
                    <br />
                    <div class="AnswerPreview"></div>
                </div>
                <!-- Answer Preview Wrapper Ends -->
            </asp:Panel>
        </div>
        <!-- ColumnWrapper Ends -->
        <br />
        <asp:Literal ID="AnswerKey" runat="server"></asp:Literal>
    </asp:Panel>
    <asp:Label ID="lblError" runat="server"></asp:Label>
</asp:Content>
