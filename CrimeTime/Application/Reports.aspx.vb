Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Imports System.Web.UI
Partial Class Reports
    Inherits System.Web.UI.Page
    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Session("ButtonID") = 999
        End If
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        Else

        End If
    End Sub

    Protected Sub UniqueUsers_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles UniqueUsers.Click
        Dim Sdate As Date
        Dim Edate As Date

        If StartDate.Text = "" Then
            Sdate = "1/1/2008"
        Else
            Sdate = StartDate.Text
        End If
        If EndDate.Text = "" Then
            Edate = Now.Date
        Else
            Edate = EndDate.Text
        End If


        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("EMailStartDate", Sdate)
        SqlDataSource1.SelectParameters.Add("EMailEnddate", Edate)
        UniqueUGridView.DataSourceID = "SqlDataSource1"
        UniqueU.Visible = True
        TotalU.Visible = False
        Issues.Visible = False
    End Sub

    Protected Sub TotalUsers_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles TotalUsers.Click
        UniqueU.Visible = False
        Issues.Visible = False
        Dim Sdate As Date
        Dim Edate As Date

        If StartDate.Text = "" Then
            Sdate = "1/1/08"
        Else
            Sdate = StartDate.Text
        End If
        If EndDate.Text = "" Then
            Edate = Now.AddDays(1)
        Else
            Edate = EndDate.Text
        End If
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetEmailTotalUsedByDate", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@EMailStartDate", Sdate)
        cmd.Parameters.AddWithValue("@EMailEndDate", Edate)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Total As Integer
                Do While reader.Read
                    Total = reader("total")
                Loop
                TotalU.Visible = True
                LitTotalUsers.Text = "There were " & Total & " total users accessing CrimeTime between " & Sdate.Date & " and " & Edate.Date & "."
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub CrimeAnswerIssues_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CrimeAnswerIssues.Click
        IssueGridView.DataSourceID = "SqlDataSource2"
        UniqueU.Visible = False
        TotalU.Visible = False
        Issues.Visible = True
    End Sub
    Protected Sub GridViewRDB(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles IssueGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Keys As DataKey = IssueGridView.DataKeys(e.Row.RowIndex)
            Dim AnswerID As Integer = Keys.Value
            Dim Attempt As Boolean = Keys.Values(1)
            Dim QID As Integer = Keys.Values(2)
            Dim QResponse As Boolean = Keys.Values(3)
            Dim DFIxed As Date = Keys.Values(4)
            Dim Fix As Boolean = Keys.Values(5)
            Dim Q As Literal = e.Row.Cells(4).FindControl("Question")
            Dim QR As Literal = e.Row.Cells(5).FindControl("QuestionResponse")
            Dim FixItButton As Button = e.Row.Cells(7).FindControl("Fixit")
            FixItButton.CommandArgument = AnswerID
            If QID = 0 Then
                Q.Text = "No Question"
                QR.Text = ""
            Else
                Q.Text = QID
                QR.Text = QResponse
            End If

            Dim FD As Literal = e.Row.Cells(6).FindControl("DFixed")

            If Fix = True Then
                FD.Text = DFIxed
            Else
                FD.Text = "Not Fixed"
            End If
        End If


    End Sub
    Protected Sub Gridview1_rowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs) Handles IssueGridView.RowCommand
        If e.CommandName = "FixtheIssue" Then
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_MarkIssueAsFixed", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@IssueID", e.CommandArgument)
            cmd.Parameters.AddWithValue("@FixDate", Now)
            Dim reader As SqlDataReader
            Try
                con.Open()
                reader = cmd.ExecuteReader()

            Catch ex As Exception

            End Try
            IssueGridView.DataSourceID = "SqlDataSource2"
        End If
    End Sub
End Class
