Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class Addsentencinginfo
    Inherits System.Web.UI.Page
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Private Blankitem As New ListItem
    Private yesitem As New ListItem
    Private noitem As New ListItem
    Private CID As Integer
    Private CAID As Integer
    Private Userid As Integer
    Private MitigatingShort As String = String.Empty


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Userid = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        Else

        End If
        Blankitem.Value = 0
        Blankitem.Text = ""
        yesitem.Value = True
        yesitem.Text = "Yes"
        noitem.Text = "No"
        noitem.Value = False
        CID = Request("CID")
        If CID = 0 Then
            CAID = Request("CAID")
        End If

        If Not Page.IsPostBack Then
            SqlDataSource1.SelectParameters.Clear()
            SqlDataSource1.SelectParameters.Add("CRIMEID", CID)
            SqlDataSource1.SelectParameters.Add("CRIMEANSWERID", CAID)
            Session("ButtonID") = 999
            FillDropdowns()
            CrimeAnswerGridview.DataSourceID = "SqlDataSource1"
            FillQualifyingQuestion(CID)
            FillMitigatingFactorLabel(CID)
            FillCrimeName()
        End If

        'Checking to see if paste button should be enabled or not.
        If Not Session("SentenceCopy") Is Nothing Then
            PasteButton.Enabled = True
        End If


    End Sub
    Protected Sub FillDropdowns()
        FillAttempt()
        FillAge()
        FillFelonyConvictions()
        FillPastConvictions()
        FillQuestions()
        FillQuestionResponses()
        FillMitigating()
    End Sub
    Protected Sub FillCrimeName()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeName", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CRIMEID", CID)
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        Dim Viewable As Boolean
        Dim title As String = String.Empty
        Dim section As String = String.Empty
        Dim subsection As String = String.Empty
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()
            Dim CName As String = ""
            If reader.HasRows Then

                Do While reader.Read
                    CName = reader("full_law_description")
                    CID = reader("CrimesID")
                    Viewable = reader("Viewable")
                    title = reader("title")
                    section = reader("section")
                    subsection = reader("subsection")
                Loop
            End If
            CrimeName.Text = title & " " & section & " " & subsection & " - " & CName
            ViewState("CID") = CID
            If Viewable Then
                chkViewStatus.Checked = True
            End If

        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillAttempt()
        Attempted.Items.Add(Blankitem)
        Attempted.Items.Add(noitem)
        Attempted.Items.Add(yesitem)

    End Sub
    Protected Sub FillAge()
        AgeCat.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAgeList", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("Literal")
                    newlistitem.Value = reader("AgeCategoryID")
                    AgeCat.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillPastConvictions()
        PastCon.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetPastConvictionsList", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("Literal")
                    newlistitem.Value = reader("PastConvictionsID")
                    PastCon.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillFelonyConvictions()
        FelCat.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetFelonyCategoryList", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("Literal")
                    newlistitem.Value = reader("FelonyConvictionsID")
                    FelCat.Items.Add(newlistitem)
                Loop
            End If

        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillQuestions()
        Dim noitem As New ListItem
        noitem.Text = "No Question"
        noitem.Value = 0
        Questions.Items.Add(noitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetQuestionList", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    Dim str As String = reader("Literal")
                    newlistitem.Text = str.Trim
                    newlistitem.Value = reader("QuestionsID")
                    'newlistitem.Attributes.Add("onmouseover", "this.title='" & reader("Literal").ToString.Trim & "'")
                    Questions.Items.Add(newlistitem)
                Loop
            End If

        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillQuestionResponses()
        QuestionResponses.Items.Add(Blankitem)
        QuestionResponses.Items.Add(yesitem)
        QuestionResponses.Items.Add(noitem)
    End Sub
    Protected Sub FillMitigating()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetMitigatingQuestionList", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader

        Dim noItem As New ListItem
        noItem.Text = "No Mitigating Factor"
        noItem.Value = 0
        Mitigating.Items.Add(noItem)

        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("Literal")
                    newlistitem.Value = reader("MitigatingFactorQuestionsID")
                    Mitigating.Items.Add(newlistitem)
                Loop
            End If

        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub AddPermutation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles AddPermutation.Click
        CID = ViewState("CID")


        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_AddCrimeAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimesID", CID)
        cmd.Parameters.AddWithValue("@Attempt", Attempted.SelectedValue)
        cmd.Parameters.AddWithValue("@AgeCat", AgeCat.SelectedValue)
        If FelCat.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@FelonyCon", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@FelonyCon", FelCat.SelectedValue)
        End If
        If PastCon.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@PastConv", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@PastConv", PastCon.SelectedValue)
        End If
        If Questions.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@QuestionID", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@QuestionID", Questions.SelectedValue)
        End If

        If QuestionResponses.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@QuestionResponse", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@QuestionResponse", QuestionResponses.SelectedValue)
        End If
        If Mitigating.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@Mitigating", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@Mitigating", Mitigating.SelectedValue)
        End If



        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then

                Do While reader.Read
                    CAID = reader("AnswerID")
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
            Response.Redirect("ChooseParagraphs.aspx?CAID=" & CAID & "&EDITID=0&CID=" & CID & "&Attempt=" & Attempted.SelectedValue _
                & "&AgeCat=" & AgeCat.SelectedValue & "&PastConv=" & PastCon.SelectedValue & "&FelonyCat=" & FelCat.SelectedValue & "&QR=" & QuestionResponses.SelectedValue)
        End Try
    End Sub

    Protected Sub CrimeAnswerGridview_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles CrimeAnswerGridview.RowCommand
        Dim rowIndex As Integer = Integer.Parse(e.CommandArgument.ToString())
        Dim Keys As DataKey = CrimeAnswerGridview.DataKeys(rowIndex)
        Dim CrimeAnswerID As Integer = Keys.Value

        If e.CommandName = "DeleteSentence" Then
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_DeleteSentence", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CrimeAnswerID", CrimeAnswerID)
            cmd.Parameters.AddWithValue("@CID", CID)

            Try
                con.Open()
                cmd.ExecuteNonQuery()
                CrimeAnswerGridview.DataBind()
                FillQualifyingQuestion(CID)

            Catch err As Exception
                lblError.Text = err.Message
            Finally
                con.Close()
            End Try
        ElseIf e.CommandName = "EditSentence" Then
            Dim age As String = CrimeAnswerGridview.Rows(rowIndex).Cells.Item(4).Text()
            Dim qr As String = CrimeAnswerGridview.Rows(rowIndex).Cells.Item(3).Text
            Dim attempt As String = CrimeAnswerGridview.Rows(rowIndex).Cells.Item(2).Text

            If attempt = "Yes" Then
                attempt = "True"
            ElseIf attempt = "No" Then
                attempt = "False"
            End If

            If qr = "Yes" Then
                qr = "True"
            ElseIf qr = "No" Then
                qr = "False"
            End If

            If age.Trim = String.Empty OrElse age.Trim = "No Category" Then
                age = String.Empty
            End If

            Dim NavigateUrl As String = "./ChooseParagraphs.aspx?CAID=" & CrimeAnswerID 
            Response.Redirect(NavigateUrl)
        End If
    End Sub

    Protected Sub GridViewRDB(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles CrimeAnswerGridview.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Dim Keys As DataKey = CrimeAnswerGridview.DataKeys(e.Row.RowIndex)
            'Dim CrimeAnswerID As Integer = Keys.Value
            'Dim age As String = e.Row.Cells.Item(3).Text

            'If age = "&nbsp;" OrElse age = String.Empty OrElse age = " " Then
            '    age = String.Empty
            'End If

            'Dim H As HyperLink = e.Row.Cells.Item(6).FindControl("EditSentence")
            'H.NavigateUrl = "ChooseParagraphs.aspx?CAID=" & CrimeAnswerID & "&EDITID=1&CID=" & CID & "&Attempt=" & e.Row.Cells.Item(0).Text _
            '    & "&AgeCat=" & age & "&PastConv=" & e.Row.Cells.Item(4).Text & "&FelonyCat=" & e.Row.Cells.Item(5).Text & "&QR=" & e.Row.Cells.Item(6).Text


            'Changing true/false in Question Response to yes/no
            If e.Row.Cells.Item(3).Text.Trim.ToLower = "true" Then
                e.Row.Cells.Item(3).Text = "Yes"
            ElseIf e.Row.Cells.Item(3).Text.Trim.ToLower = "false" Then
                e.Row.Cells.Item(3).Text = "No"
            End If

            'Changing true/false in Attempt to yes/no
            If e.Row.Cells.Item(2).Text.Trim.ToLower = "true" Then
                e.Row.Cells.Item(2).Text = "Yes"
            ElseIf e.Row.Cells.Item(2).Text.Trim.ToLower = "false" Then
                e.Row.Cells.Item(2).Text = "No"
            End If
        End If
    End Sub


    Protected Sub EditLawButton_Click(sender As Object, e As System.EventArgs) Handles EditLawButton.Click
        Response.Redirect("./AddLaw.aspx?edit=1&CID=" & CID)
    End Sub

    Protected Sub AddQuestions_Click(sender As Object, e As System.EventArgs) Handles AddQuestions.Click
        Response.Redirect("./ManageQuestions.aspx?CID=" & CID)
    End Sub

    Protected Sub FillQualifyingQuestion(ByVal CRIMEID As Integer)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeQuestion", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CRIMEID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    lblQuestion.Text = reader("Literal")
                Loop

                Questions.SelectedIndex = -1
                'Selecting the question from radio list.
                For Each item As ListItem In Questions.Items
                    If item.Text.Trim = lblQuestion.Text.Trim Then
                        item.Selected = True
                    End If
                Next
            Else
                lblQuestion.Text = "No Question currently selected"
                Questions.SelectedIndex = 0
            End If
        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try
    End Sub


    Protected Sub CopyButton_Click(sender As Object, e As System.EventArgs) Handles CopyButton.Click
        Session("SentenceCopy") = CID
        If Not PasteButton.Enabled Then
            PasteButton.Enabled = True
        End If
    End Sub

    Protected Sub PasteButton_Click(sender As Object, e As System.EventArgs) Handles PasteButton.Click
        Dim oldcid As Integer = Session("SentenceCopy")
        'Session("SentenceCopy") = String.Empty

        'Extracting sentencing info from database to be copied.
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeAnswerListByCrimeID", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", oldcid)
        cmd.Parameters.AddWithValue("@CRIMEANSWERID", 0)


        'Copying mitigating factor info
        Dim con0 As New SqlConnection(connectionString)
        Dim cmd0 As New SqlCommand("SP_GetMitigatingFactor", con0)
        Dim reader0 As SqlDataReader
        cmd0.CommandType = CommandType.StoredProcedure
        cmd0.Parameters.AddWithValue("@CRIMEID", oldcid)
        Try
            con0.Open()
            reader0 = cmd0.ExecuteReader()

            If reader0.HasRows Then
                Do While reader0.Read
                    lblMitigating.Text = reader0("Literal")
                    MitigatingShort = reader0("short")
                Loop
            End If
            'Selecting correct value from radio button list.
            For Each item As ListItem In Mitigating.Items
                If item.Text.Trim = lblMitigating.Text.Trim Then
                    Mitigating.SelectedIndex = -1
                    item.Selected = True
                End If
            Next
        Catch ex As Exception
            lblError.Text = ex.Message
        Finally
            con0.Close()
        End Try


        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim caid As String = reader("CrimeAnswerID").ToString.Trim
                    Dim question As String = reader("Question").ToString.Trim
                    Dim attempt As String = reader("Attempted").ToString.Trim
                    Dim qr As String = reader("QuestionsResponse").ToString.Trim
                    Dim age As String = reader("AgeCat").ToString.Trim
                    Dim pastconv As String = reader("PastConCat").ToString.Trim
                    Dim felonycat As String = reader("FelonyCat").ToString.Trim

                    'Clear all list selections
                    Questions.SelectedIndex = -1
                    Attempted.SelectedIndex = -1
                    QuestionResponses.SelectedIndex = -1
                    AgeCat.SelectedIndex = -1
                    PastCon.SelectedIndex = -1
                    FelCat.SelectedIndex = -1

                    'Getting value for questions list
                    If String.IsNullOrEmpty(question) Then
                        Questions.SelectedIndex = 0
                    Else
                        For Each item As ListItem In Questions.Items
                            If item.Text = question Then
                                item.Selected = True
                            End If
                        Next
                    End If

                    'Getting value for attempted list
                    If String.IsNullOrEmpty(attempt) Then
                        Attempted.SelectedIndex = 0
                    Else
                        For Each item As ListItem In Attempted.Items
                            If item.Value = attempt Then
                                item.Selected = True
                            End If
                        Next
                    End If

                    'Getting value for question response list
                    If String.IsNullOrEmpty(qr) Then
                        QuestionResponses.SelectedIndex = 0
                    Else
                        For Each item As ListItem In QuestionResponses.Items
                            If item.Value = qr Then
                                item.Selected = True
                            End If
                        Next
                    End If

                    'Getting value for Age Category list
                    If String.IsNullOrEmpty(age) Then
                        AgeCat.SelectedIndex = 0
                    Else
                        For Each item As ListItem In AgeCat.Items
                            If item.Text = age Then
                                item.Selected = True
                            End If
                        Next
                    End If

                    'Getting value for Past felony convictions list
                    If String.IsNullOrEmpty(pastconv) Then
                        PastCon.SelectedIndex = 0
                    Else
                        For Each item As ListItem In PastCon.Items
                            If item.Text = pastconv Then
                                item.Selected = True
                            End If
                        Next
                    End If

                    'Getting value for Felony Sentencing Category list
                    If String.IsNullOrEmpty(felonycat) Then
                        FelCat.SelectedIndex = 0
                    Else
                        For Each item As ListItem In FelCat.Items
                            If item.Text = felonycat Then
                                item.Selected = True
                            End If
                        Next
                    End If

                    'Adding all records to current case
                    AddEachSentence()

                    'Adding paragraphs from old sentence to new sentence
                    'Get new CrimeAnswerID
                    Dim caid2 As String = String.Empty
                    Dim con2 As New SqlConnection(connectionString)
                    Dim cmd2 As New SqlCommand("SP_GetCrimeAnswerListByCrimeID", con2)
                    cmd2.CommandType = CommandType.StoredProcedure
                    cmd2.Parameters.AddWithValue("@CrimeID", CID)
                    cmd2.Parameters.AddWithValue("@CRIMEANSWERID", 0)

                    Dim reader2 As SqlDataReader
                    con2.Open()
                    reader2 = cmd2.ExecuteReader

                    If reader2.HasRows Then
                        Do While reader2.Read
                            caid2 = reader2("CrimeAnswerID").ToString.Trim
                        Loop
                    End If
                    con2.Close()

                    'Get old paragraph links
                    Dim con3 As New SqlConnection(connectionString)
                    Dim cmd3 As New SqlCommand("SP_GetParaLinks", con3)
                    cmd3.CommandType = CommandType.StoredProcedure
                    cmd3.Parameters.AddWithValue("@CrimeAnswerID", caid)
                    Dim reader3 As SqlDataReader
                    con3.Open()
                    reader3 = cmd3.ExecuteReader

                    If reader3.HasRows Then
                        Do While reader3.Read
                            'Copying old paragraph links to new Crime Answer
                            Dim con4 As New SqlConnection(connectionString)
                            Dim cmd4 As New SqlCommand("SP_AddParagraphToPermutation", con4)
                            cmd4.CommandType = CommandType.StoredProcedure
                            cmd4.Parameters.AddWithValue("@PermutationID", caid2)
                            cmd4.Parameters.AddWithValue("@ParagraphID", reader3("AnswerID"))
                            con4.Open()
                            cmd4.ExecuteNonQuery()
                            con4.Close()
                            'End Copy
                        Loop
                    End If
                    con3.Close()
                Loop
            End If

        Catch ex As Exception
            lblError.Text = ex.Message
        Finally
            con.Close()
        End Try

        'Reloading page
        Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri)
    End Sub

    Protected Sub AddEachSentence()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_AddCrimeAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimesID", CID)
        cmd.Parameters.AddWithValue("@Attempt", Attempted.SelectedValue)

        If AgeCat.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@AgeCat", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@AgeCat", AgeCat.SelectedValue)
        End If

        If FelCat.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@FelonyCon", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@FelonyCon", FelCat.SelectedValue)
        End If
        If PastCon.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@PastConv", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@PastConv", PastCon.SelectedValue)
        End If
        If Questions.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@QuestionID", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@QuestionID", Questions.SelectedValue)
        End If

        If QuestionResponses.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@QuestionResponse", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@QuestionResponse", QuestionResponses.SelectedValue)
        End If
        If Mitigating.SelectedValue = "0" Then
            cmd.Parameters.AddWithValue("@Mitigating", DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@Mitigating", Mitigating.SelectedValue)
        End If

        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then

                Do While reader.Read
                    CAID = reader("AnswerID")
                Loop
            End If
        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub ChangeQuestion_Click(sender As Object, e As System.EventArgs) Handles ChangeQuestion.Click
        If CrimeAnswerGridview.Rows.Count = 0 Then
            lblError.Text = "Please insert atleast one sentence before trying to update this information."
            Exit Sub
        End If

        UpdateQuestion()
        UpdateMitigating()
    End Sub

    Protected Sub UpdateQuestion()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_UpdateCrimeQuestion", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CID)

        Dim item As ListItem

        For Each i As ListItem In Questions.Items
            If i.Selected Then
                item = i
                Exit For
            End If
        Next

        If Not item Is Nothing Then
            If item.Value = "0" Then
                cmd.Parameters.AddWithValue("@QuestionID", DBNull.Value)
            Else
                cmd.Parameters.AddWithValue("@QuestionID", item.Value)
            End If
        Else
            lblError.Text = "No Value is selected to update Qualifying Question."
            Exit Sub
        End If

        Try
            con.Open()
            cmd.ExecuteNonQuery()
        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try

        FillQualifyingQuestion(CID)
    End Sub

    Protected Sub UpdateMitigating()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_UpdateMitigating", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CID)

        Dim item As New ListItem

        For Each i As ListItem In Mitigating.Items
            If i.Selected Then
                item = i
                Exit For
            End If
        Next

        If Not item Is Nothing Then
            If item.Value = "0" Then
                cmd.Parameters.AddWithValue("@FactorID", DBNull.Value)
            Else
                cmd.Parameters.AddWithValue("@FactorID", item.Value)
            End If
        Else
            lblError.Text = "No Value is selected to update Mitigating factor."
            Exit Sub
        End If

        Try
            con.Open()
            cmd.ExecuteNonQuery()
        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try

        FillMitigatingFactorLabel(CID)
    End Sub

    Private Sub FillMitigatingFactorLabel(ByVal CRIMEID As Integer)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetMitigatingFactor", con)
        Dim reader As SqlDataReader
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CRIMEID", CID)
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    lblMitigating.Text = reader("Literal")
                    MitigatingShort = reader("short")
                Loop
            Else
                lblMitigating.Text = "No Mitigating Factor"
            End If

            'Selecting correct value from radio button list.
            For Each item As ListItem In Mitigating.Items
                If item.Text.Trim = lblMitigating.Text.Trim Then
                    Mitigating.SelectedIndex = -1
                    item.Selected = True
                End If
            Next

        Catch ex As Exception
            lblError.Text = ex.Message
        Finally
            con.Close()
        End Try
    End Sub

    <System.Web.Services.WebMethod()> Public Shared Sub changeViewStatus(ByVal CID As String)
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("CTConnection").ConnectionString)
        Dim cmd As New SqlCommand("SP_MakeViewable", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimesID", CID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then

                Do While reader.Read
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
End Class