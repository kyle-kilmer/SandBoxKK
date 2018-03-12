Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class EditFullText
    Inherits System.Web.UI.Page
    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        Else

        End If
        If Not Page.IsPostBack Then
            FillText()
        End If
    End Sub
    Protected Sub FillText()
        Dim CID As Integer
        CID = Request("LawOrd")
        If CID = 0 Then
            lblErrors.Text = "There is a problem with this page, please return to the CrimeTime Main Page and work and continue your work."
        Else
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_GetStatutoryText", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@LawOrdinal", CID)
            Dim reader As SqlDataReader
            Try
                con.Open()
                reader = cmd.ExecuteReader()

                If reader.HasRows Then
                    Dim F As String = ""
                    Do While reader.Read
                        F = reader("statute")
                    Loop
                    FullText.Text = F
                End If
            Catch Err As Exception

            Finally
                con.Close()
            End Try
        End If

    End Sub

    Protected Sub Editor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Editor.Click
        Dim X As String
        X = Request("LawOrd")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_UpdateStatutoryText", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@LawOrdinal", X)
        cmd.Parameters.AddWithValue("@Statutory", FullText.Text)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

        Catch ex As Exception

        End Try
        FillText()

    End Sub
End Class
