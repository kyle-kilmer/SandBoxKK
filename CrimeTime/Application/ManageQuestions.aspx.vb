Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class ManageQuestions
    Inherits System.Web.UI.Page
    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillGrid()
            Session("ButtonID") = 999
        End If
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        Else

        End If
    End Sub
    Protected Sub FillGrid()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetQuestionList", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                QuestionsGrid.DataSource = reader
                QuestionsGrid.DataBind()
            End If
        Catch Err As Exception
            ErrorLabel.Text = Err.Message
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GridViewRDB(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles QuestionsGrid.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Dim Keys As DataKey = QuestionsGrid.DataKeys(e.Row.RowIndex)
            'Dim QuestionID As Integer = Keys.Value
            'Dim B As Button = e.Row.Cells(0).FindControl("EditButton")
            'B.CommandArgument = QuestionID
        End If
    End Sub
    Protected Sub Gridview1_rowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs) Handles QuestionsGrid.RowCommand

        Dim rowIndex As Integer = Integer.Parse(e.CommandArgument.ToString())
        Dim Keys As DataKey = QuestionsGrid.DataKeys(rowIndex)
        Dim QuestionID As Integer = Keys.Value

        If e.CommandName = "EditQuestion" Then
            HiddenQuestionID.Value = QuestionID
            FillQuestion(QuestionID)
        ElseIf e.CommandName = "DeleteQuestion" Then
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_CheckQuestionInUse", con)
            cmd.CommandType = CommandType.StoredProcedure
            Dim reader As SqlDataReader
            cmd.Parameters.AddWithValue("@QuestionID", QuestionID)
            Try
                con.Open()
                reader = cmd.ExecuteReader()
                If reader.HasRows Then
                    reader.Read()
                    Dim str As String = reader("QuestionID").ToString.Trim
                    If String.IsNullOrEmpty(str) Then
                        Dim con2 As New SqlConnection(connectionString)
                        Dim cmd2 As New SqlCommand("SP_DeleteQuestion", con2)
                        cmd2.CommandType = CommandType.StoredProcedure
                        cmd2.Parameters.AddWithValue("@QuestionID", QuestionID)
                        con2.Open()
                        cmd2.ExecuteNonQuery()
                        con2.Close()
                        ErrorLabel.Text = "The Question has been deleted"
                    Else
                        ErrorLabel.Text = "This Question is in use and cannot be deleted."
                    End If

                    Exit Try
                Else
                    Dim con2 As New SqlConnection(connectionString)
                    Dim cmd2 As New SqlCommand("SP_DeleteQuestion", con2)
                    cmd2.CommandType = CommandType.StoredProcedure
                    cmd2.Parameters.AddWithValue("@QuestionID", QuestionID)
                    con2.Open()
                    cmd2.ExecuteNonQuery()
                    con2.Close()
                    ErrorLabel.Text = "The Question has been deleted"
                End If
            Catch ex As Exception
                ErrorLabel.Text = ex.Message
            Finally
                con.Close()
            End Try
        End If
        FillGrid()
    End Sub
    Protected Sub FillQuestion(ByVal QID As Integer)

        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetQuestion", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QuestionID", QID)
        Dim reader As SqlDataReader
        Dim Question As String = ""
        Try
            con.Open()
            reader = cmd.ExecuteReader()
            If reader.HasRows Then
                Do While reader.Read
                    Question = reader("Literal")
                Loop
                QuestionText.Text = Question
                UpdateQuestion.Visible = True
                AddQuestion.Visible = False
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub AddQuestion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles AddQuestion.Click
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_InsertQuestiontoList", con)
        cmd.CommandType = CommandType.StoredProcedure
        If String.IsNullOrEmpty(QuestionText.Text) Then
            ErrorLabel.Text = "Please input a Question"
            Exit Sub
        End If
        cmd.Parameters.AddWithValue("@Question", QuestionText.Text)
        Dim reader As SqlDataReader
        Dim Question As String = ""
        Try
            con.Open()
            reader = cmd.ExecuteReader()
            ClearItems()
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub ClearItems()
        QuestionText.Text = ""
        UpdateQuestion.Visible = False
        FillGrid()
        AddQuestion.Visible = True
        HiddenQuestionID.Value = Nothing
    End Sub

    Protected Sub UpdateQuestion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles UpdateQuestion.Click
        Dim QuestionString As String
        QuestionString = QuestionText.Text

        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_UpdateQuestioninList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QuestionID", HiddenQuestionID.Value)
        cmd.Parameters.AddWithValue("@Question", QuestionString)
        Dim reader As SqlDataReader
        Dim Question As String = ""
        Try
            con.Open()
            reader = cmd.ExecuteReader()
            ClearItems()
        Catch Err As Exception
            ErrorLabel.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub ClearFields_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ClearFields.Click
        ClearItems()
    End Sub

    Protected Sub ReturntoCT_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ReturntoCT.Click
        Response.Redirect("./Addsentencinginfo.aspx?CID=" & Request("CID").ToString.Trim)
    End Sub

End Class
