Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Imports System.Web.UI
Partial Class UpdateParagraphs
    Inherits System.Web.UI.Page
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Public Blankitem As New ListItem
    Public Yesitem As New ListItem
    Public Noitem As New ListItem
    Public CrimeAnswerID As Integer
    Public EDITID As Integer
    Private userid As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        userid = Session("CTUserID")
        'If Session("NYPTIStaff") <> True Then
        '    Session("ButtonID") = 0
        '    Response.Redirect("./CrimeTime.aspx")
        'Else

        'End If
        Blankitem.Text = "No Value"
        Blankitem.Value = 0

        DropdownTable.Visible = False

        If Not Page.IsPostBack Then
            FillPulldowns()
            Session("ButtonID") = 999

            'Added by Aishwarya Sharma on 12/18/2014 for ticket 1750. Check request variables for initial values.
            doInitialFill()
        End If
    End Sub
    Protected Sub FillPulldowns()
        FillPreface()
        FillTransitions()
        FillStatePrison()
        FillDefiniteSentence()
        FillIntermittentImprisonment()
        FillProbation()
        FillConditionalDischarge()
        FillSplitSentence()
        FillFine()
        FillUnConditionalDischarge()
        FillRestitutionReparation()
        FillSurchargeVictimAssessmentFee()
        FillLicensePenalties()
        FillConsecutiveConcurrent()
        FillEND()
    End Sub
    Protected Sub FillPreface()
        PrefaceList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 1)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    PrefaceList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillTransitions()
        TransitionList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 2)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    TransitionList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillStatePrison()
        StatePrisonList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 3)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    StatePrisonList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillDefiniteSentence()
        DefiniteSentenceList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 4)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    DefiniteSentenceList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillIntermittentImprisonment()
        IntermittentImprisonmentList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 5)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    IntermittentImprisonmentList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillProbation()
        ProbationList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 6)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    ProbationList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillConditionalDischarge()
        ConditionalDischargeList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 7)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    ConditionalDischargeList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillSplitSentence()
        SplitSentenceList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 8)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    SplitSentenceList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillFine()
        FineList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 9)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    FineList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillUnConditionalDischarge()
        UnconditionalDischargeList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 10)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    UnconditionalDischargeList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillRestitutionReparation()
        RestitutionReparationList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 11)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    RestitutionReparationList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillSurchargeVictimAssessmentFee()
        SurchargeVictimAssessmentFeeList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 12)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    SurchargeVictimAssessmentFeeList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillLicensePenalties()
        LicensePenaltiesList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 13)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    LicensePenaltiesList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillConsecutiveConcurrent()
        ConsecutiveConcurrentList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 14)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    ConsecutiveConcurrentList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FillEND()
        ENDList.Items.Add(Blankitem)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicList", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CategoryID", 15)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Do While reader.Read
                    Dim newlistitem As New ListItem
                    newlistitem.Text = reader("TopicKey")
                    newlistitem.Value = reader("TopicID")
                    ENDList.Items.Add(newlistitem)
                Loop
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub PrefaceList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles PrefaceList.SelectedIndexChanged
        If Not (PrefaceList.SelectedValue = 0) Then
            ParagraphKey.Text = PrefaceList.SelectedItem.Text
            UParagraphs.Text = ""
            ParagraphTypeID.Value = 1
            ParagraphKeyID.Value = PrefaceList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub TransitionList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TransitionList.SelectedIndexChanged
        If Not (TransitionList.SelectedValue = 0) Then
            ParagraphKey.Text = TransitionList.SelectedItem.Text
            ParagraphTypeID.Value = 2
            ParagraphKeyID.Value = TransitionList.SelectedValue
            GetLiteral()
        End If

    End Sub

    Protected Sub StatePrisonList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles StatePrisonList.SelectedIndexChanged
        If Not (StatePrisonList.SelectedValue = 0) Then
            ParagraphKey.Text = StatePrisonList.SelectedItem.Text
            ParagraphTypeID.Value = 3
            ParagraphKeyID.Value = StatePrisonList.SelectedValue
            GetLiteral()
        End If

    End Sub

    Protected Sub DefiniteSentenceList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DefiniteSentenceList.SelectedIndexChanged
        If Not (DefiniteSentenceList.SelectedValue = 0) Then
            ParagraphKey.Text = DefiniteSentenceList.SelectedItem.Text
            ParagraphTypeID.Value = 4
            ParagraphKeyID.Value = DefiniteSentenceList.SelectedValue
            GetLiteral()
        End If

    End Sub

    Protected Sub IntermittentImprisonmentList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles IntermittentImprisonmentList.SelectedIndexChanged
        If Not (IntermittentImprisonmentList.SelectedValue = 0) Then
            ParagraphKey.Text = IntermittentImprisonmentList.SelectedItem.Text
            ParagraphTypeID.Value = 5
            ParagraphKeyID.Value = IntermittentImprisonmentList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub ProbationList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ProbationList.SelectedIndexChanged
        If Not (ProbationList.SelectedValue = 0) Then
            ParagraphKey.Text = ProbationList.SelectedItem.Text
            ParagraphTypeID.Value = 6
            ParagraphKeyID.Value = ProbationList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub ConditionalDischargeList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ConditionalDischargeList.SelectedIndexChanged
        If Not (ConditionalDischargeList.SelectedValue = 0) Then
            ParagraphKey.Text = ConditionalDischargeList.SelectedItem.Text
            ParagraphTypeID.Value = 7
            ParagraphKeyID.Value = ConditionalDischargeList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub SplitSentenceList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles SplitSentenceList.SelectedIndexChanged
        If Not (SplitSentenceList.SelectedValue = 0) Then
            ParagraphKey.Text = SplitSentenceList.SelectedItem.Text
            ParagraphTypeID.Value = 8
            ParagraphKeyID.Value = SplitSentenceList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub FineList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles FineList.SelectedIndexChanged
        If Not (FineList.SelectedValue = 0) Then
            ParagraphKey.Text = FineList.SelectedItem.Text
            ParagraphTypeID.Value = 9
            ParagraphKeyID.Value = FineList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub UnconditionalDischargeList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles UnconditionalDischargeList.SelectedIndexChanged
        If Not (UnconditionalDischargeList.SelectedValue = 0) Then
            ParagraphKey.Text = UnconditionalDischargeList.SelectedItem.Text
            ParagraphTypeID.Value = 10
            ParagraphKeyID.Value = UnconditionalDischargeList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub RestitutionReparationList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RestitutionReparationList.SelectedIndexChanged
        If Not (RestitutionReparationList.SelectedValue = 0) Then
            ParagraphKey.Text = RestitutionReparationList.SelectedItem.Text
            ParagraphTypeID.Value = 11
            ParagraphKeyID.Value = RestitutionReparationList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub SurchargeVictimAssessmentFeeList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles SurchargeVictimAssessmentFeeList.SelectedIndexChanged
        If Not (SurchargeVictimAssessmentFeeList.SelectedValue = 0) Then
            ParagraphKey.Text = SurchargeVictimAssessmentFeeList.SelectedItem.Text
            ParagraphTypeID.Value = 12
            ParagraphKeyID.Value = SurchargeVictimAssessmentFeeList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub LicensePenaltiesList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles LicensePenaltiesList.SelectedIndexChanged
        If Not (LicensePenaltiesList.SelectedValue = 0) Then
            ParagraphKey.Text = LicensePenaltiesList.SelectedItem.Text
            ParagraphTypeID.Value = 13
            ParagraphKeyID.Value = LicensePenaltiesList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub ConsecutiveConcurrentList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ConsecutiveConcurrentList.SelectedIndexChanged
        If Not (ConsecutiveConcurrentList.SelectedValue = 0) Then
            ParagraphKey.Text = ConsecutiveConcurrentList.SelectedItem.Text
            ParagraphTypeID.Value = 14
            ParagraphKeyID.Value = ConsecutiveConcurrentList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub ENDList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ENDList.SelectedIndexChanged
        If Not (ENDList.SelectedValue = 0) Then
            ParagraphKey.Text = ENDList.SelectedItem.Text
            ParagraphTypeID.Value = 15
            ParagraphKeyID.Value = ENDList.SelectedValue
            GetLiteral()
        End If
    End Sub

    Protected Sub GetLiteral()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        Select Case ParagraphTypeID.Value
            Case 1
                cmd.CommandText = "SP_GetPrefacebyID"
                cmd.Parameters.AddWithValue("@PrefaceID", ParagraphKeyID.Value)
            Case 2
                cmd.CommandText = "SP_GetTransitionbyID"
                cmd.Parameters.AddWithValue("@TransitionID", ParagraphKeyID.Value)
            Case 3
                cmd.CommandText = "SP_GetStatePrisonbyID"
                cmd.Parameters.AddWithValue("@StatePrisonID", ParagraphKeyID.Value)
            Case 4
                cmd.CommandText = "SP_GetDefiniteSentencebyID"
                cmd.Parameters.AddWithValue("@DefiniteSentenceID", ParagraphKeyID.Value)
            Case 5
                cmd.CommandText = "SP_GetIntermittentImprisonmentbyID"
                cmd.Parameters.AddWithValue("@IntermittentImprisonmentID", ParagraphKeyID.Value)
            Case 6
                cmd.CommandText = "SP_GetProbationbyID"
                cmd.Parameters.AddWithValue("@ProbationID", ParagraphKeyID.Value)
            Case 7
                cmd.CommandText = "SP_GetConditionalDischargebyID"
                cmd.Parameters.AddWithValue("@ConditionalDischargeID", ParagraphKeyID.Value)
            Case 8
                cmd.CommandText = "SP_GetSplitsentencebyID"
                cmd.Parameters.AddWithValue("@SplitsentenceID", ParagraphKeyID.Value)
            Case 9
                cmd.CommandText = "SP_GetFinebyID"
                cmd.Parameters.AddWithValue("@FineID", ParagraphKeyID.Value)
            Case 10
                cmd.CommandText = "SP_GetUnConditionalDischargebyID"
                cmd.Parameters.AddWithValue("@UnConditionalDischargeID", ParagraphKeyID.Value)
            Case 11
                cmd.CommandText = "SP_GetRestitutionReparationbyID"
                cmd.Parameters.AddWithValue("@RestitutionReparationID", ParagraphKeyID.Value)
            Case 12
                cmd.CommandText = "SP_GetSurchargeVictimAssessmentFeebyID"
                cmd.Parameters.AddWithValue("@SurchargeVictimAssessmentFeeID", ParagraphKeyID.Value)
            Case 13
                cmd.CommandText = "SP_GetLicensePenaltiesbyID"
                cmd.Parameters.AddWithValue("@LicensePenaltiesID", ParagraphKeyID.Value)
            Case 14
                cmd.CommandText = "SP_GetConsecutiveConcurrentbyID"
                cmd.Parameters.AddWithValue("@ConsecutiveConcurrentID", ParagraphKeyID.Value)
            Case 15
                cmd.CommandText = "SP_GetEndbyID"
                cmd.Parameters.AddWithValue("@EndID", ParagraphKeyID.Value)
            Case Else
                'This should never happen.
        End Select
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Par As String = ""
                Do While reader.Read
                    Par = reader("Literal")
                Loop
                UParagraphs.Text = Server.HtmlDecode(Par)
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub UpdateLiteral()
        Dim NewParagraph As String
        NewParagraph = Server.HtmlEncode(UParagraphs.Text)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        Select Case ParagraphTypeID.Value
            Case 1
                cmd.CommandText = "SP_UpdatePrefacebyID"
                cmd.Parameters.AddWithValue("@PrefaceID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 2
                cmd.CommandText = "SP_UpdateTransitionbyID"
                cmd.Parameters.AddWithValue("@TransitionID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 3
                cmd.CommandText = "SP_UpdateStatePrisonbyID"
                cmd.Parameters.AddWithValue("@StatePrisonID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 4
                cmd.CommandText = "SP_UpdateDefiniteSentencebyID"
                cmd.Parameters.AddWithValue("@DefiniteSentenceID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 5
                cmd.CommandText = "SP_UpdateIntermittentImprisonmentbyID"
                cmd.Parameters.AddWithValue("@IntermittentImprisonmentID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 6
                cmd.CommandText = "SP_UpdateProbationbyID"
                cmd.Parameters.AddWithValue("@ProbationID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 7
                cmd.CommandText = "SP_UpdateConditionalDischargebyID"
                cmd.Parameters.AddWithValue("@ConditionalDischargeID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 8
                cmd.CommandText = "SP_UpdateSplitsentencebyID"
                cmd.Parameters.AddWithValue("@SplitsentenceID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 9
                cmd.CommandText = "SP_UpdateFinebyID"
                cmd.Parameters.AddWithValue("@FineID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 10
                cmd.CommandText = "SP_UpdateUnConditionalDischargebyID"
                cmd.Parameters.AddWithValue("@UnConditionalDischargeID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 11
                cmd.CommandText = "SP_UpdateRestitutionReparationbyID"
                cmd.Parameters.AddWithValue("@RestitutionReparationID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 12
                cmd.CommandText = "SP_UpdateSurchargeVictimAssessmentFeebyID"
                cmd.Parameters.AddWithValue("@SurchargeVictimAssessmentFeeID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 13
                cmd.CommandText = "SP_UpdateLicensePenaltiesbyID"
                cmd.Parameters.AddWithValue("@LicensePenaltiesID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 14
                cmd.CommandText = "SP_UpdateConsecutiveConcurrentbyID"
                cmd.Parameters.AddWithValue("@ConsecutiveConcurrentID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case 15
                cmd.CommandText = "SP_UpdateEndbyID"
                cmd.Parameters.AddWithValue("@EndID", ParagraphKeyID.Value)
                cmd.Parameters.AddWithValue("@NewLit", NewParagraph)
            Case Else
                'This should never happen.
        End Select
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Par As String = ""
                Do While reader.Read
                    Par = reader("Literal")
                Loop
                UParagraphs.Text = Server.HtmlDecode(Par)
            End If
            Response.Redirect("./Paragraphs.aspx")
        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try

    End Sub
    Protected Sub UpdateParagraph_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles UpdateParagraph.Click
        UpdateLiteral()
    End Sub

    Protected Sub ClearParagraph_Click(sender As Object, e As System.EventArgs) Handles ClearParagraph.Click
        UParagraphs.Text = String.Empty
        'ParagraphKey.Text = String.Empty
        'ParagraphKeyID.Value = Nothing
        'ParagraphTypeID.Value = Nothing
        'ClearLists()
    End Sub

    Private Sub ClearLists()
        PrefaceList.SelectedIndex = 0
        TransitionList.SelectedIndex = 0
        StatePrisonList.SelectedIndex = 0
        DefiniteSentenceList.SelectedIndex = 0
        IntermittentImprisonmentList.SelectedIndex = 0
        ProbationList.SelectedIndex = 0
        ConditionalDischargeList.SelectedIndex = 0
        SplitSentenceList.SelectedIndex = 0
        FineList.SelectedIndex = 0
        UnconditionalDischargeList.SelectedIndex = 0
        RestitutionReparationList.SelectedIndex = 0
        SurchargeVictimAssessmentFeeList.SelectedIndex = 0
        LicensePenaltiesList.SelectedIndex = 0
        ConsecutiveConcurrentList.SelectedIndex = 0
        ENDList.SelectedIndex = 0
    End Sub

    Private Sub doInitialFill()
        If (Not Request("Category") Is Nothing) AndAlso (Not Request("key") Is Nothing) AndAlso (Not Request("ID") Is Nothing) Then
            Dim Category As Integer = Request("Category")
            Dim key As String = Request("Key")
            Dim ID As Integer = Request("ID")

            ParagraphKey.Text = key
            UParagraphs.Text = ""
            ParagraphTypeID.Value = Category
            ParagraphKeyID.Value = ID
            GetLiteral()
        Else
            Return
        End If
    End Sub

    Protected Sub CancelButton_Click(sender As Object, e As System.EventArgs) Handles CancelButton.Click
        Response.Redirect("./Paragraphs.aspx")
    End Sub
End Class
