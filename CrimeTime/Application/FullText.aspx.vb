Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class FullText
    Inherits System.Web.UI.Page
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillText2()
        End If
    End Sub
    Protected Sub FillText2()
        Dim CID As Integer
        CID = Request("CID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeFullText", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim F As String = ""
                Dim X As String = ""
                Do While reader.Read
                    F = reader("statute")
                    X = reader("full_law_description")
                Loop
                FullText1.Text = F
                CrimeName.Text = X
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub

End Class
