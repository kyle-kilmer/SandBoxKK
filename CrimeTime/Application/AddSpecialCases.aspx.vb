Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class AddSpecialCases
    Inherits System.Web.UI.Page
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Private Userid As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Userid = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        Else

        End If
        If Not Page.IsPostBack Then
            AddSpecial.Visible = True
            Update.Visible = False
            SpecialPopup.Text = ""
            PopUpReason.Text = ""
            FillGrid()
        End If
    End Sub
    Protected Sub FillGrid()
        SpecialPopupGridview.DataSourceID = "SqlDataSource1"

    End Sub
    Protected Sub GridViewRDB(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles SpecialPopupGridview.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Keys As DataKey = SpecialPopupGridview.DataKeys(e.Row.RowIndex)
            Dim SID As Integer = Keys.Value
            Dim Ebutton As Button = e.Row.Cells(2).FindControl("EDITOR")
            Ebutton.CommandArgument = SID
        End If
    End Sub
    Protected Sub Gridview1_rowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs) Handles SpecialPopupGridview.RowCommand
        If e.CommandName = "EditPopup" Then
            FillTextBox(e.CommandArgument)
            AddSpecial.Visible = False
            Update.Visible = True
        End If
    End Sub
    Protected Sub FillTextBox(ByRef SID As Integer)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetSpecialPopupsBYID", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@SID", SID)
 
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim SpecialLit As String = ""
                Dim RLit As String = ""
                Do While reader.Read
                    SpecialLit = Server.HtmlDecode(reader("Literal"))
                    RLit = Server.HtmlDecode(reader("Reason"))
                Loop
                SpecialPopup.Text = SpecialLit
                PopUpReason.Text = RLit
                SpecialID.Value = SID
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub AddSpecial_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles AddSpecial.Click
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_ADDSpecialPopups", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Literal", Server.HtmlEncode(SpecialPopup.Text))
        cmd.Parameters.AddWithValue("@Reason", Server.HtmlEncode(PopUpReason.Text))

        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim SpecialLit As String = ""
                Do While reader.Read

                Loop

            End If
            Clearitems()
        Catch ex As Exception

        End Try

        FillGrid()
    End Sub
    Protected Sub Clearitems()
        SpecialPopup.Text = ""
        PopUpReason.Text = ""
        AddSpecial.Visible = True
        Update.Visible = False
    End Sub
    Protected Sub Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Update.Click
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_UpdateSpecialPopups", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@SID", SpecialID.Value)
        cmd.Parameters.AddWithValue("@Literal", Server.HtmlEncode(SpecialPopup.Text))
        cmd.Parameters.AddWithValue("@Reason", Server.HtmlEncode(PopUpReason.Text))

        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim SpecialLit As String = ""
                Do While reader.Read

                Loop

            End If
            Clearitems()
        Catch ex As Exception

        End Try
        FillGrid()
    End Sub
End Class
