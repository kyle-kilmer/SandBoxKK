Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Imports System.Web.UI

Partial Class CrimeTime
    Inherits System.Web.UI.Page
    Private ButtonIdentifier As Integer
    Private CrimeName As String
    Private RepealDate As Date
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Session("EmailAddressID")) Then
            Response.Redirect("./default.aspx")
        End If
        If Not Page.IsPostBack Then
            HomeLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab ui-state-active")
            CrimeTimeGrid.DataSourceID = "SqlDataSource1"
        End If
    End Sub
    Protected Sub Home_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles HomeLink.Click
        SearchCriteria.Text = ""
        HomeLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab ui-state-active")
        PenalLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        VTLLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        CorrLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        CrimeTimeGrid.DataSourceID = "SqlDataSource1"
    End Sub

    Protected Sub PenalLawsLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles PenalLawsLink.Click
        SearchCriteria.Text = ""
        HomeLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        PenalLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab ui-state-active")
        VTLLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        CorrLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        CrimeTimeGrid.DataSourceID = "SqlDataSource2"
    End Sub

    Protected Sub VTLLaws_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles VTLLawsLink.Click
        SearchCriteria.Text = ""
        HomeLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        PenalLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        VTLLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab ui-state-active")
        CorrLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        CrimeTimeGrid.DataSourceID = "SqlDataSource3"
    End Sub

    Protected Sub CorrLaws_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CorrLawsLink.Click
        SearchCriteria.Text = ""
        HomeLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        PenalLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        VTLLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        CorrLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab ui-state-active")
        CrimeTimeGrid.DataSourceID = "SqlDataSource4"
    End Sub

    Protected Sub GridViewRDB(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles CrimeTimeGrid.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Keys As DataKey = CrimeTimeGrid.DataKeys(e.Row.RowIndex)
            Dim CrimeID As Integer = Keys.Value
            Dim Name As String = Keys.Values(1)
            Dim Repeal As String = Keys.Values(2).ToString
            Dim CrimeCite As String = Keys.Values(3)
            Dim SpecialLit As String = Keys.Values(4).ToString
            Dim Title As String = Keys.Values(5).ToString
            Dim Section As String = Keys.Values(6).ToString

            Dim S As Button = e.Row.Cells(2).FindControl("SelectCrime")
            S.CommandArgument = CrimeID
            S.CommandName = "SelectThisCrime"
            S.Text = Name
            If Not String.IsNullOrEmpty(Repeal.Trim) Then
                Dim rDate As Date = CDate(Repeal).Date
                If rDate <= Today.Date Then
                    Dim Message As String
                    Message = CrimeCite & " " & Name & ", was repealed " & CDate(Repeal).Date & ". Did the Defendant commit the crime prior to that date?"
                    S.Attributes.Add("onclick", "javascript:return confirm('" & Message & "'); ")
                End If
            Else
                If Not (SpecialLit = Nothing) Then
                    Dim Message As String
                    Message = Server.HtmlEncode(SpecialLit)
                    S.Attributes.Add("onclick", "javascript:return alert('" & Message & "'); ")
                    S.CommandArgument = 0
                End If
            End If

            Dim H As HyperLink = e.Row.Cells.Item(0).FindControl("FullText")
            H.Text = CrimeCite.ToString
            If Title = "PL" Then
                H.NavigateUrl = "http://statutes.nypti.org/LAWSSEAF.cgi?QUERYTYPE=LAWS+&QUERYDATA=$$PEN" & Section.TrimStart("0") & "$$@TXPEN0" & Section.TrimStart("0") & "&LIST=LAW+&BROWSER=EXPLORER+&TOKEN=33275813+&TARGET=VIEW"
            ElseIf Title = "COR" Then
                H.NavigateUrl = "http://statutes.nypti.org/LAWSSEAF.cgi?QUERYTYPE=LAWS+&QUERYDATA=$$COR" & Section.TrimStart("0") & "$$@TXCOR0" & Section.TrimStart("0") & "&LIST=LAW+&BROWSER=EXPLORER+&TOKEN=33275813+&TARGET=VIEW"
            ElseIf Title = "VTL" Then
                H.NavigateUrl = "http://statutes.nypti.org/LAWSSEAF.cgi?QUERYTYPE=LAWS+&QUERYDATA=$$VAT" & Section.TrimStart("0") & "$$@TXVAT0" & Section.TrimStart("0") & "&LIST=LAW+&BROWSER=EXPLORER+&TOKEN=33275813+&TARGET=VIEW"
            End If
            'H.NavigateUrl = "./FullText.aspx?CID=" & CrimeID

        End If

    End Sub


    Protected Sub Gridview1_rowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs) Handles CrimeTimeGrid.RowCommand
        If e.CommandName = "SelectThisCrime" Then
            If e.CommandArgument = 0 Then
            Else
                GetAnswers(e.CommandArgument)
            End If
        End If

    End Sub
    
    Protected Sub GetAnswers(ByVal CrimeID As Integer)
        Session("CRIMEID") = CrimeID
        Response.Redirect("./Qualifiers.aspx")

    End Sub

    Protected Sub Searcher_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Searcher.Click
        HomeLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        PenalLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        VTLLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")
        CorrLawsLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab")

        If SearchCriteria.Text = "" Then
            CrimeTimeGrid.DataSourceID = "SqlDataSource1"
        Else
            HomeLink.Attributes.Add("class", "ui-state-default ui-corner-top lawFilterTab ui-state-active")
            SqlDataSource5.SelectParameters.Clear()
            SqlDataSource5.SelectParameters.Add("SearchText", SearchCriteria.Text)
            CrimeTimeGrid.DataSourceID = "SqlDataSource5"
        End If

    End Sub

End Class