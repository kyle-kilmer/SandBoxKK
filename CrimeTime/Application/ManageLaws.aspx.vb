Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class ManageLaws
    Inherits System.Web.UI.Page
    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            fulllistofCrimesGrid.DataSourceID = "SqlDataSource1"
            Session("ButtonID") = 999
            Search_Run()
        End If
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        End If
    End Sub
    Protected Sub GridViewRDB(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles fulllistofCrimesGrid.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Keys As DataKey = fulllistofCrimesGrid.DataKeys(e.Row.RowIndex)
            Dim CrimeID As Integer = Keys.Value
            Dim Name As String = Keys.Values(1)
            If IsDBNull(Keys.Values(2)) Then
                Dim LawOrd As String = String.Empty
            Else
                Dim LawOrd As String = Keys.Values(2)
            End If
            Dim H As HyperLink = e.Row.Cells.Item(0).FindControl("FullText")
            H.NavigateUrl = "Addsentencinginfo.aspx?CID=" & CrimeID
            H.Text = Name
        End If
    End Sub
        
    Protected Sub Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Search.Click
        Session("search") = SearchCriteria.Text
        If SearchCriteria.Text = "" Then
            fulllistofCrimesGrid.DataSourceID = "SqlDataSource1"
        Else
            SqlDataSource2.SelectParameters.Clear()
            SqlDataSource2.SelectParameters.Add("SearchText", SearchCriteria.Text)
            fulllistofCrimesGrid.DataSourceID = "SqlDataSource2"
        End If
    End Sub

    Protected Sub Search_Run()
        Dim str As String = Session("search")
        If String.IsNullOrEmpty(str) Then
            fulllistofCrimesGrid.DataSourceID = "SqlDataSource1"
        Else
            SqlDataSource2.SelectParameters.Clear()
            SqlDataSource2.SelectParameters.Add("SearchText", str)
            fulllistofCrimesGrid.DataSourceID = "SqlDataSource2"
        End If
    End Sub

    Protected Sub AddLaw_Click(sender As Object, e As System.EventArgs) Handles AddLaw.Click
        Response.Redirect("./AddLaw.aspx")
    End Sub
End Class
