Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class Qualifiers
    Inherits System.Web.UI.Page
    Private CRIMEID As Integer
    Private QuestionID As Integer
    Private Blankitem As New ListItem
    Private yesitem As New ListItem
    Private noitem As New ListItem
    Private PersistantFelonValue As Boolean
    Private Returner2 As Integer = 0
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Session("EmailAddressID")) Then
            Response.Redirect("./default.aspx")
        End If
        CRIMEID = Session("CRIMEID")
        Blankitem.Value = 0
        Blankitem.Text = ""
        yesitem.Value = True
        yesitem.Text = "Yes"
        noitem.Text = "No"
        noitem.Value = False
        Session("ButtonID") = 999
        Returner2 = Session("R")
        If Not Page.IsPostBack Then
            FillCrimeName()
            PersistantFelonValue = False
            Returner2 = -1
            Session("R") = Returner2
            If VerifyAttempt() Then
                FillAttempt()
                AttemptedQuestion.Visible = True
                
            Else
                AttemptedQuestion.Visible = False
                CRIMEID = Session("CRIMEID")
                FillQuestion(CRIMEID)
            End If
        Else
            Returner2 = Returner2 - 1
            Session("R") = Returner2
        End If
        Dim R As String
        R = "history.go(" & Returner2 & ")"
        Returner.Attributes.Add("onclick", R)
    End Sub
    Protected Sub FillCrimeName()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeFullText", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CRIMEID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Crime As String = ""
                Do While reader.Read
                    Crime = reader("full_law_description")
                Loop
                CrimeName.Text = Crime
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
    Protected Sub FillQuestion(ByVal CRIMEID As Integer)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeQuestion", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CRIMEID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                QualifierQuestion.Visible = True
                Do While reader.Read
                    QuestionID = reader("QuestionsID")
                    lblQQuestion.Text = reader("Literal")
                Loop
                FindQuestionResponses()
            Else
                QualifierQuestion.Visible = False
                FindAgeOptions(CRIMEID)
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try

    End Sub
    Protected Sub FindQuestionResponses()
        QuestionResponses.Items.Clear()
        QuestionResponses.Items.Add(Blankitem)
        QuestionResponses.Items.Add(yesitem)
        QuestionResponses.Items.Add(noitem)

    End Sub

    Protected Sub FindAgeOptions(ByVal CrimeID As Integer)
        AgeCat.Visible = True
        AgeCat.Items.Clear()
        AgeCat.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAgeOptionsForCrime", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CrimeID)
        cmd.Parameters.AddWithValue("@QuestionResponseID", QuestionResponses.SelectedValue)
        cmd.Parameters.AddWithValue("@Attempted", Attempted.SelectedValue)

        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim ageopt As New ListItem
                    ageopt.Text = reader("Literal")
                    ageopt.Value = reader("AgeCategoryID")
                    If ageopt.Value > 0 Then
                        AgeCat.Items.Add(ageopt)
                    End If

                Loop

                If AgeCat.Items.Count > 1 Then
                    AgeCategory.Visible = True
                Else
                    AgeCategory.Visible = False
                End If
            Else
                AgeCategory.Visible = False
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try

    End Sub
    Protected Sub FindFelonysentencingcategory(ByVal CRIMEID As Integer)
        FelCat.Items.Clear()
        FelCat.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetFelonyOptionsForCrime", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CRIMEID)
        cmd.Parameters.AddWithValue("@PastID", PastCon.SelectedValue)
        cmd.Parameters.AddWithValue("@AgeID", AgeCat.SelectedValue)
        cmd.Parameters.AddWithValue("@Attempted", Attempted.SelectedValue)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                FelonyCat.Visible = True
                Do While reader.Read
                    Dim Felopt As New ListItem
                    Felopt.Value = reader("FelonyConvictions")
                    Felopt.Text = reader("Literal")
                    FelCat.Items.Add(Felopt)
                Loop
            Else
                FelonyCat.Visible = False
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindPastConvictionOptions(ByVal CRIMEID As Integer)
        PastCon.Items.Clear()
        PastCon.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetPastConvictionOptionsForCrime", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CRIMEID)
        cmd.Parameters.AddWithValue("@AgeCatID", AgeCat.SelectedValue)
        cmd.Parameters.AddWithValue("@QuestionResponseID", QuestionResponses.SelectedValue)
        cmd.Parameters.AddWithValue("@Attempted", Attempted.SelectedValue)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                PastConvictions.Visible = True
                Do While reader.Read
                    Dim Pastopt As New ListItem
                    Pastopt.Value = reader("PastConvictionsID")
                    Pastopt.Text = reader("Literal")
                    PastCon.Items.Add(Pastopt)
                Loop
            Else
                PastConvictions.Visible = False
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindMitigatingQuestions(ByRef CrimeID As Integer)
        lstMitigating.Items.Clear()
        lstMitigating.Items.Add(Blankitem)
        lstMitigating.Items.Add(yesitem)
        lstMitigating.Items.Add(noitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetMitigatingQuestionForCrime", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CrimeID)
        cmd.Parameters.AddWithValue("@AgeCatID", AgeCat.SelectedValue)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Mitigating.Visible = True
                Dim Mit As String = ""
                Do While reader.Read
                    Mit = reader("Literal")
                Loop
                lblMitigating.Text = Mit
            Else
                Mitigating.Visible = False
                FindPastConvictionOptions(CrimeID)
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub AgeCat_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles AgeCat.SelectedIndexChanged
        FindMitigatingQuestions(CRIMEID)
    End Sub


    Protected Sub PastCon_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles PastCon.SelectedIndexChanged
        If PastCon.SelectedValue = 3 Then
            PersistantFelonValue = True
        Else
            PersistantFelonValue = False
        End If
        Session("PersistantFelonValue") = PersistantFelonValue
        FindFelonysentencingcategory(CRIMEID)
    End Sub

    Protected Sub QuestionResponses_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles QuestionResponses.SelectedIndexChanged
        FindAgeOptions(CRIMEID)
    End Sub

    Protected Sub FillPersistant()
        Persistant.Items.Clear()
        Persistant.Items.Add(Blankitem)
        Persistant.Items.Add(noitem)
        Persistant.Items.Add(yesitem)
    End Sub

    Protected Sub GetAnswerKey()

        Dim Qresponse As String = ""
        Dim CAID As Integer = 0

        CRIMEID = Session("CRIMEID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeAnswerID", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CRIMEID)
        cmd.Parameters.AddWithValue("@AgeCat", AgeCat.SelectedValue)
        cmd.Parameters.AddWithValue("@FelConvictions", FelCat.SelectedValue)
        cmd.Parameters.AddWithValue("@PastConvictions", PastCon.SelectedValue)
        cmd.Parameters.AddWithValue("@ResponseID", QuestionResponses.SelectedValue)
        cmd.Parameters.AddWithValue("@Attempt", Attempted.selectedvalue)

        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    CAID = reader("CrimeAnswerID")
                Loop

            Else

            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try

        If CAID = 0 Then
            lblerrors.Text = "Please answer all the questions"
        Else
            Session("CAID") = CAID
            Session("PersistantFelon") = Persistant.SelectedValue
            Response.Redirect("./Answer2.aspx")
            'Response.Write("<script>")
            'Response.Write("response.redi('./Answer2.aspx')")
            'Response.Write("</script>")
        End If

    End Sub

    Protected Sub sbm_button_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles sbm_button.Click
        GetAnswerKey()
    End Sub

    Protected Sub Attempted_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Attempted.SelectedIndexChanged
        CRIMEID = Session("CRIMEID")
        lblerrors.Text = ""
        If Attempted.SelectedValue = "0" Then

        Else
            'If VerifyAttempt() Then
            FillQuestion(CRIMEID)
            'Else
            'lblerrors.Text = "This crime is not attemptable"
            'End If

        End If

    End Sub
    Protected Function VerifyAttempt() As Boolean
        CRIMEID = Session("CRIMEID")
        Dim A As Boolean
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeAttemptPossibility", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeID", CRIMEID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim X As Boolean = False
                Do While reader.Read
                    X = reader("Attempted")
                    If X = True Then
                        A = True
                    End If
                Loop

            Else

            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
        Return A

    End Function
    Protected Sub FelCat_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles FelCat.SelectedIndexChanged
        PersistantFelonValue = Session("PersistantFelonValue")
        If FelCat.SelectedValue = 7 Then
            PersistantFelonValue = False
        End If

        If PersistantFelonValue = True Then
            PersistantFelon.Visible = True
            FillPersistant()
        Else
            PersistantFelon.Visible = False
        End If
    End Sub

    Protected Sub lstMitigating_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstMitigating.SelectedIndexChanged
        If lstMitigating.SelectedValue = True Then
            FindPastConvictionOptions(CRIMEID)
        Else
            lblerrors.Text = "Please Select a different Age Category"
        End If
    End Sub


End Class
