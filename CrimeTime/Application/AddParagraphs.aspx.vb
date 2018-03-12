Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.Configuration

Partial Class AddParagraphs
    Inherits System.Web.UI.Page

    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Private UserID As Integer

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        End If

        FillCategories()
    End Sub

    Protected Sub AddButton_Click(sender As Object, e As System.EventArgs) Handles AddButton.Click

        If CategoryList.SelectedValue = -1 Then
            lblResult.Text = "A category must be selected in order to add a new paragraph"
            Return
        ElseIf String.IsNullOrEmpty(KeyTextBox.Text) Then
            lblResult.Text = "A Paragraph Key must be specified in order to add a new paragraph"
            Return
        ElseIf String.IsNullOrEmpty(ParagraphTextBox.Text.Trim) Then
            lblResult.Text = "Paragraph text cannot be empty."
            Return
        End If

        Dim NewParagraph As String
        NewParagraph = Server.HtmlEncode(ParagraphTextBox.Text)

        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_AddAnswer", con)
        cmd.Parameters.AddWithValue("@CategoryID", CategoryList.SelectedValue)
        cmd.Parameters.AddWithValue("@TopicKey", KeyTextBox.Text)
        cmd.Parameters.AddWithValue("@Literal", NewParagraph)
        cmd.CommandType = CommandType.StoredProcedure
        Try
            con.Open()
            cmd.ExecuteNonQuery()
            Response.Redirect("./Paragraphs.aspx")
        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try

    End Sub

    Protected Sub ClearButton_Click(sender As Object, e As System.EventArgs) Handles ClearButton.Click
        KeyTextBox.Text = String.Empty
        ParagraphTextBox.Text = String.Empty
    End Sub

    Private Sub FillCategories()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCategories", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("Literal")
                    newlistitem.Value = reader("CategoryID")
                    CategoryList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try

        If Not Request("Category") Is Nothing Then
            CategoryList.SelectedValue = Request("Category")
        End If

    End Sub

    Protected Sub ReturnButton_Click(sender As Object, e As System.EventArgs) Handles ReturnButton.Click
        Response.Redirect("./Paragraphs.aspx")
    End Sub
End Class
