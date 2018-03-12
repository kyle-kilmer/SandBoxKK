Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Imports System.Web.UI
Partial Class Administration
    Inherits System.Web.UI.Page
    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("ButtonID") = 4
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        End If
    End Sub
    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender
        Dim VN As HiddenField
        VN = Master.FindControl("VersionNumber")
        Versioninfo.Value = VN.Value
        Dim DU As HiddenField
        DU = Master.FindControl("DateUpdated")
        Dateinfo.Value = DU.Value
        CTVersion.Text = Versioninfo.Value
        LastUpdate.Text = Dateinfo.Value
    End Sub



    Protected Sub AddLaws_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles AddLaws.Click
        Response.Redirect("./ManageLaws.aspx")
    End Sub

    Protected Sub MakenewVersionNumber_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles MakenewVersionNumber.Click
        If Page.IsValid Then
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_InsertCrimeTimeUpdateInfo", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@VersionNumber", NewVersion.Text)
            cmd.Parameters.AddWithValue("@UpdateDate", Now)
            Dim reader As SqlDataReader
            Try
                con.Open()
                reader = cmd.ExecuteReader
                If reader.HasRows Then
                    Do While reader.Read

                    Loop

                End If
            Catch Err As Exception
            Finally
                con.Close()
            End Try
            GetVersionInfo()
        End If
    End Sub
    Protected Sub GetVersionInfo()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeTimeUpdateInfo", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader
            If reader.HasRows Then
                Dim Version As String = ""
                Dim UpdateDate As DateTime
                Do While reader.Read
                    Version = reader("CrimeVersion")
                    UpdateDate = reader("CrimeUpdateDate")
                Loop
                CTVersion.Text = Version
                LastUpdate.Text = UpdateDate
            End If
        Catch Err As Exception
            con.Close()
        End Try
        Dim VN As HiddenField
        VN = Master.FindControl("VersionNumber")
        VN.Value = CTVersion.Text
        Dim DU As HiddenField
        DU = Master.FindControl("DateUpdated")
        DU.Value = LastUpdate.Text
    End Sub
    Protected Sub NewVersionCustomValidator_servervalidate(ByVal sender As Object, ByVal e As ServerValidateEventArgs) Handles NewVersionCustomValidator.ServerValidate
        Try
            Dim X As Double
            X = CType(NewVersion.Text, Double)
            Dim Y As Double
            Y = CType(Versioninfo.Value, Double)
            If X > Y Then
                e.IsValid = True
            Else
                e.IsValid = False
            End If
        Catch ex As Exception
            e.IsValid = False
        End Try
    End Sub

    'Protected Sub EditParagraphs_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles EditParagraphs.Click
    '    Response.Redirect("./UpdateParagraphs.aspx")
    'End Sub

    Protected Sub RunReports_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles RunReports.Click
        Response.Redirect("./Reports.aspx")
    End Sub
End Class
