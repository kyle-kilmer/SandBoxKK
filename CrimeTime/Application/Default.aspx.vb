Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Imports System.Web.UI
Imports System.Security.Cryptography.X509Certificates
Imports System.Net
Imports System.Net.Security

Partial Class _Default
    Inherits System.Web.UI.Page
    Private ButtonIdentifier As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Private Function ValidateCert(ByVal sender As Object, ByVal cert As X509Certificate, ByVal chain As X509Chain, ByVal err As SslPolicyErrors) As Boolean
        ValidateCert = True
    End Function
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then


            Session("FromSSO") = False
            
            If (Not (Request("t") Is Nothing)) Then

                If ConfigurationManager.AppSettings("BypassCertificateCheck") = True Then
                    ServicePointManager.ServerCertificateValidationCallback = New RemoteCertificateValidationCallback(AddressOf ValidateCert)
                End If

                Dim sso As SSO.InternalClient

                sso = New SSO.InternalClient()
                sso.ClientCredentials.UserName.UserName = ConfigurationManager.AppSettings("ServerToServer.Username")
                sso.ClientCredentials.UserName.Password = ConfigurationManager.AppSettings("ServerToServer.Password")

                Dim token As SSO.Token
                Dim ServiceId As Integer = Integer.Parse(ConfigurationManager.AppSettings("ServiceID"))

                token = sso.LoginTokenClaim(Request("t"), ServiceId)

                ' Session("UserId") = token.Account.UserID
                ' Session("User") = token.Account.Email
                EmailInfo.Text = token.Account.Email
                EmailInfo.Visible = False
                EmailLabel.Visible = False

                ' set the session variable which will be used to display or hide the SSO dashboard and SSO logout links
                Session("FromSSO") = True
                If EmailInfo.Text.ToLower.Contains("@nypti.org") Then
                    Session("NYPTIStaff") = True
                End If
                Session("EmailAddressID") = EmailInfo.Text
            End If
            'To bypass login security for Admin pages for testing uncomment the following line
            'Session("NYPTIStaff") = True
        End If
    End Sub

    Protected Sub AcceptDisclaimer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles AcceptDisclaimer.Click
        InputEmailToDB()
        Session("ButtonID") = 0
        Session("EmailAddressID") = EmailInfo.Text
        Response.Redirect("./CrimeTime.aspx")
    End Sub
    Protected Sub InputEmailToDB()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_InsertEmails", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Email", EmailInfo.Text)
        cmd.Parameters.AddWithValue("@EMailDate", Now)

        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then

                Do While reader.Read
                    Session("EmailAddressID") = reader("EmailAddressID")
                Loop

            Else
                Session("EmailAddressID") = 0
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
End Class
