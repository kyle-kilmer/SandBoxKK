Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Imports System.Web.UI
Partial Class NYPTICrimeTime
    Inherits System.Web.UI.MasterPage
    Private ButtonID As Integer
    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GetVersionInfo()
            lblCopyRightYear.Text = Now.Year
            lblCopyRightYear2.Text = Now.Year
        End If
        If HttpContext.Current.Request.Url.AbsolutePath.Contains("default.aspx") Then
            HelpLink.Visible = False
        ElseIf HttpContext.Current.Request.Url.AbsolutePath.Contains("Default.aspx") Then
            HelpLink.Visible = False
        Else
            HelpLink.Visible = True
        End If



    End Sub

    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender
        ' check if the user came from SSO, if so display the SSO dashboard and logout links

        'for testing
        '  Session("FromSSO") = True
        ' Session("CTUserID") = 999
        'Session("FromSSO") = True
        'Session("NYPTIStaff") = True
        If Session("FromSSO") = True Then
            
            LogoutLink.Visible = True
            DashboardLink.Visible = True
            ' AdminLink.Visible = False




        End If

        UserID = Session("CTUserID")

        If Session("NYPTIStaff") = True Then
            AdminLink.Visible = True
            LogoutLink.Visible = True
            DashboardLink.Visible = True
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
                Dim UpdateDate As Date
                Do While reader.Read
                    Version = reader("CrimeVersion")
                    UpdateDate = reader("CrimeUpdateDate")
                Loop
                VersionNumber.Value = Version
                DateUpdated.Value = UpdateDate
                'UpdatedDate.Text = UpdateDate.Date
            End If
        Catch Err As Exception
        Finally
            con.Close()
        End Try
    End Sub



    Protected Sub AdminLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles AdminLink.ServerClick

        Response.Redirect("./Administration.aspx")
    End Sub

    Protected Sub DashboardLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles DashboardLink.ServerClick
        Response.Redirect(ConfigurationManager.AppSettings("ReturnURL"))
    End Sub

    Protected Sub LogoutLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LogoutLink.ServerClick
        Session.Abandon()
        Response.Redirect(ConfigurationManager.AppSettings("LogoutURL"))
    End Sub

    Protected Sub HelpLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles HelpLink.ServerClick
        Session("ButtonID") = 99
        Response.Redirect("./CrimeTimeHelp.aspx")
    End Sub

    Protected Sub HomeLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles HomeLink.ServerClick

        Dim path As String = Request.Url.AbsolutePath
        If IsNothing(Session("EmailAddressID")) Then
            Response.Redirect("./Default.aspx")
        Else
            Response.Redirect("./CrimeTime.aspx")
        End If
    End Sub
End Class

