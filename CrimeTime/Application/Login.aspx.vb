Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class Login
    Inherits System.Web.UI.Page
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Admin") = 0
        Session("CTUserID") = 0
        Me.Login1.Focus()
    End Sub
    Protected Sub Login1_Authenticate(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.AuthenticateEventArgs) Handles Login1.Authenticate
        If (Logintest()) Then
            Session("ButtonID") = 3
            Response.Redirect("./Administration.aspx")
        Else
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        End If
    End Sub

    Public Function Logintest() As Boolean
        ' Define the ADO.NET objects.
        Dim Status As Integer
        Dim UserIPAddress As String

        UserIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
        If UserIPAddress = "" Then
            UserIPAddress = Request.ServerVariables("REMOTE_ADDR")
        End If

        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_VerifyUser", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@User", Login1.UserName)
        cmd.Parameters.AddWithValue("@Password", Login1.Password)
        cmd.Parameters.AddWithValue("@IP", UserIPAddress)

        Dim reader As SqlDataReader

        ' Try to open database and read information.
        Try
            con.Open()
            reader = cmd.ExecuteReader()
            Do While reader.Read()
                Session("CTUserID") = reader("UserId")
                Session("User") = Login1.UserName
                Status = reader("StatusCode")
            Loop
            Select Case Status
                Case 0
                    Session("CTUserID") = 0
                    Login1.FailureText = "That Username/password combination is incorrect."
                    Return False
                Case 1
                    Return True
            End Select
            reader.Close()

        Catch Err As Exception

        Finally
            con.Close()
        End Try
        Return False
    End Function


            
End Class
