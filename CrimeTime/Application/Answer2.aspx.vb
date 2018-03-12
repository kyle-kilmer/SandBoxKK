﻿Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class Answer2
    Inherits System.Web.UI.Page
    Private CAID As Integer
    Private PersistantFelon As String
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CAID = Session("CAID")
        PersistantFelon = Session("PersistantFelon")
        Session("ButtonID") = 4
        If IsNothing(Session("EmailAddressID")) Then
            Response.Redirect("./default.aspx")
        End If
        If Not Page.IsPostBack Then
            FillItems()
            Reporter.NavigateUrl = "./ReportAnswer.aspx?CAID=" & CAID & "&Name=" & Server.HtmlEncode(lblOffense.Text)
            CreateCloser()
        End If

    End Sub
    Protected Sub CreateCloser()
        Dim scriptstring As String
        scriptstring = "<script language='Javascript'>"
        scriptstring &= "function CloseWindow(){"
        scriptstring &= "self.close();"
        scriptstring &= "}</script>"
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "CloseWindow", scriptstring)
    End Sub
    Protected Sub FillItems()
        FillOffense()
        GETPrefaces()
        GETTransition()
        GETStatePRISON()
        GETDEFINITESENTENCE()
        GETIntermittentImprisonment()
        GETPROBATION()
        GETCONDITIONALDISCHARGE()
        GETSplitSentence()
        GETFINE()
        GETUNCONDTIONALDISCHARGE()
        GETRESTITUTIONREPARATION()
        GETSURCHARGEVictimAssessmentFee()
        GETLicensePenalties()
        GETConSECutiveConcurrent()
        GETEnd()
        GETCASATs()
        GETSupervisedParole()
        GETINTERIMPROBATIONSUPERVISION()
        GETJudicialDiversion()
        GETShock()

        PersistantFelon = Session("PersistantFelon")
        If PersistantFelon = "True" Then
            getPersistantFelon()
        End If
    End Sub

    Protected Sub FillOffense()
        CAID = Session("CAID")
        Dim Law As String = ""
        Dim Cite As String = ""
        Dim Agecat As String = ""
        Dim FelonyLev As String = ""
        Dim FelConvictions As String = ""
        Dim Pasconvictions As String = ""
        Dim Attempt As Boolean


        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAssumptionInfo", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then

                Do While reader.Read
                    Law = reader("Name")
                    Cite = reader("Cite")
                    Agecat = CheckDBNULL(reader("Age"))
                    FelonyLev = reader("FelonyLevel")
                    FelConvictions = reader("FelConvictions")
                    Pasconvictions = reader("Pastconvictions")
                    Attempt = reader("Attempted")
                Loop
                If Attempt Then
                    lblOffense.Text = "attempted " & Law & ", in violation of Penal Law 110.00 & " & Cite & ", a " & FelonyLev
                Else
                    lblOffense.Text = Law & ", in violation of  " & Cite & ", a " & FelonyLev
                End If

                lblAge.Text = Agecat
                If FelConvictions = "" Then
                    Feloffender.Visible = False
                Else
                    lblFelonyoffender.Text = FelConvictions
                End If

            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub GETPrefaces()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 1)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Pref As String = ""
                Do While reader.Read
                    Pref &= reader("Literal")
                    Pref &= "<br /><br />"
                Loop
                Pref = Pref.Replace("''", "'")
                lblPreface.Text = Server.HtmlDecode(Pref) & "<br />"
            Else

            End If

        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETTransition()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 2)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Transition As String = ""
                Do While reader.Read
                    Transition &= reader("Literal")
                    Transition &= "<br /><br />"
                Loop
                Transition = Transition.Replace("''", "'")
                lblTransition.Text = Server.HtmlDecode(Transition) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETStatePRISON()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 3)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim StatePRISON As String = ""
                Do While reader.Read
                    StatePRISON &= reader("Literal")
                    StatePRISON &= "<br /><br />"
                Loop
                StatePRISON = StatePRISON.Replace("''", "'")
                lblStatePRISON.Text = Server.HtmlDecode(StatePRISON) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETDEFINITESENTENCE()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 4)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim DEFINITESENTENCE As String = ""
                Do While reader.Read
                    DEFINITESENTENCE &= reader("Literal")
                    DEFINITESENTENCE &= "<br /><br />"
                Loop
                DEFINITESENTENCE = DEFINITESENTENCE.Replace("''", "'")
                lblDEFINITESENTENCE.Text = Server.HtmlDecode(DEFINITESENTENCE) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETIntermittentImprisonment()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 5)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim IntermittentImprisonment As String = ""
                Do While reader.Read
                    IntermittentImprisonment &= reader("Literal")
                    IntermittentImprisonment &= "<br /><br />"
                Loop
                IntermittentImprisonment = IntermittentImprisonment.Replace("''", "'")
                lblIntermittentImprisonment.Text = Server.HtmlDecode(IntermittentImprisonment) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETPROBATION()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 6)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim PROBATION As String = ""
                Do While reader.Read
                    PROBATION &= reader("Literal")
                    PROBATION &= "<br /><br />"
                Loop
                PROBATION = PROBATION.Replace("''", "'")
                lblPROBATION.Text = Server.HtmlDecode(PROBATION) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETCONDITIONALDISCHARGE()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 7)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim CONDITIONALDISCHARGE As String = ""
                Do While reader.Read
                    CONDITIONALDISCHARGE &= reader("Literal")
                    CONDITIONALDISCHARGE &= "<br /><br />"
                Loop
                CONDITIONALDISCHARGE = CONDITIONALDISCHARGE.Replace("''", "'")
                lblCONDITIONALDISCHARGE.Text = Server.HtmlDecode(CONDITIONALDISCHARGE) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETSplitSentence()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 8)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim SplitSentence As String = ""
                Do While reader.Read
                    SplitSentence &= reader("Literal")
                    SplitSentence &= "<br /><br />"
                Loop
                SplitSentence = SplitSentence.Replace("''", "'")
                lblSplitSentence.Text = Server.HtmlDecode(SplitSentence) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETFINE()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 9)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim FINE As String = ""
                Do While reader.Read
                    FINE &= reader("Literal")
                    FINE &= "<br /><br />"
                Loop
                FINE = FINE.Replace("''", "'")
                lblFINE.Text = Server.HtmlDecode(FINE) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETUNCONDTIONALDISCHARGE()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 10)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim UNCONDTIONALDISCHARGE As String = ""
                Do While reader.Read
                    UNCONDTIONALDISCHARGE &= reader("Literal")
                    UNCONDTIONALDISCHARGE &= "<br /><br />"
                Loop
                UNCONDTIONALDISCHARGE = UNCONDTIONALDISCHARGE.Replace("''", "'")
                lblUNCONDTIONALDISCHARGE.Text = Server.HtmlDecode(UNCONDTIONALDISCHARGE) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETRESTITUTIONREPARATION()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 11)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim RESTITUTIONREPARATION As String = ""
                Do While reader.Read
                    RESTITUTIONREPARATION &= reader("Literal")
                    RESTITUTIONREPARATION &= "<br /><br />"
                Loop
                RESTITUTIONREPARATION = RESTITUTIONREPARATION.Replace("''", "'")
                lblRESTITUTIONREPARATION.Text = Server.HtmlDecode(RESTITUTIONREPARATION) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETSURCHARGEVictimAssessmentFee()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 12)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim SURCHARGEVictimAssessmentFee As String = ""
                Do While reader.Read
                    SURCHARGEVictimAssessmentFee &= reader("Literal")
                    SURCHARGEVictimAssessmentFee &= "<br /><br />"
                Loop
                SURCHARGEVictimAssessmentFee = SURCHARGEVictimAssessmentFee.Replace("''", "'")
                lblSURCHARGEVictimAssessmentFee.Text = Server.HtmlDecode(SURCHARGEVictimAssessmentFee) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETLicensePenalties()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 13)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim LicensePenalties As String = ""
                Do While reader.Read
                    LicensePenalties &= reader("Literal")
                    LicensePenalties &= "<br /><br />"
                Loop
                LicensePenalties = LicensePenalties.Replace("''", "'")
                lblLicensePenalties.Text = Server.HtmlDecode(LicensePenalties) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETConSECutiveConcurrent()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 14)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim ConSECutiveConcurrent As String = ""
                Do While reader.Read
                    ConSECutiveConcurrent &= reader("Literal")
                    ConSECutiveConcurrent &= "<br /><br />"
                Loop
                ConSECutiveConcurrent = ConSECutiveConcurrent.Replace("''", "'")
                lblConSECutiveConcurrent.Text = Server.HtmlDecode(ConSECutiveConcurrent) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETEnd()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 15)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim End1 As String = ""
                Do While reader.Read
                    End1 &= reader("Literal")
                    End1 &= "<br /><br />"
                Loop
                End1 = End1.Replace("''", "'")
                lblEnd.Text = Server.HtmlDecode(End1) & "<br />"
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub GETCASATs()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 16)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim CASAT As String = ""
                Do While reader.Read
                    CASAT &= reader("Literal")
                    CASAT &= "<br /><br />"
                Loop
                CASAT = CASAT.Replace("''", "'")
                lblCASAT.Text = Server.HtmlDecode(CASAT) & "<br />"
            Else

            End If

        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETSupervisedParole()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 17)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim SupervisedParole As String = ""
                Do While reader.Read
                    SupervisedParole &= reader("Literal")
                    SupervisedParole &= "<br /><br />"
                Loop
                SupervisedParole = SupervisedParole.Replace("''", "'")
                lblSupervisedParole.Text = Server.HtmlDecode(SupervisedParole) & "<br />"
            Else

            End If

        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETShock()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 19)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Shock As String = ""
                Do While reader.Read
                    Shock &= reader("Literal")
                    Shock &= "<br /><br />"
                Loop
                Shock = Shock.Replace("''", "'")
                lblShock.Text = Server.HtmlDecode(Shock) & "<br />"
            Else

            End If

        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETJudicialDiversion()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 18)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim JudicialDiversion As String = ""
                Do While reader.Read
                    JudicialDiversion &= reader("Literal")
                    JudicialDiversion &= "<br /><br />"
                Loop
                JudicialDiversion = JudicialDiversion.Replace("''", "'")
                lblJudicialDiversion.Text = Server.HtmlDecode(JudicialDiversion) & "<br />"
            Else

            End If

        Catch Err As Exception
            Alert.Show("Error in Judicial Diversion")
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub GETINTERIMPROBATIONSUPERVISION()
        CAID = Session("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        cmd.Parameters.AddWithValue("@CategoryID", 20)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim INTERIMPROBATIONSUPERVISION As String = ""
                Do While reader.Read
                    INTERIMPROBATIONSUPERVISION &= reader("Literal")
                    INTERIMPROBATIONSUPERVISION &= "<br /><br />"
                Loop
                INTERIMPROBATIONSUPERVISION = INTERIMPROBATIONSUPERVISION.Replace("''", "'")
                lblINTERIMPROBATIONSUPERVISION.Text = Server.HtmlDecode(INTERIMPROBATIONSUPERVISION) & "<br />"
            Else

            End If

        Catch Err As Exception
            Alert.Show("Error in INTERIMPROBATIONSUPERVISION")
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub getPersistantFelon()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetSpecialQuestionResponses", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@SpecialQuestion", "Persistant Felon")
        Dim reader As SqlDataReader

        Dim Answer As New ArrayList
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim ID As Integer = 0
                Dim Keyname As String = ""

                Do While reader.Read
                    Dim Keys As New ListItem
                    ID = reader("ParagraphsID")
                    Keyname = reader("ParagraphKey")
                    Keys.Text = Keyname
                    Keys.Value = ID
                    Answer.Add(Keys)
                Loop

            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
        If Answer.Count > 0 Then
            Dim Y As Integer
            Do While Y < Answer.Count
                Dim X As New ListItem
                X = Answer(Y)
                Y = Y + 1
                Select Case X.Value
                    Case 1
                        FindPrefacebyKey(X.Text)
                    Case 2
                        FindTransitionbyKey(X.Text)
                    Case 3
                        FindStatePrisonbyKey(X.Text)
                    Case 4
                        FindDefinitesentencebyKey(X.Text)
                    Case 5
                        FindIntermittentImprisonmentbyKey(X.Text)
                    Case 6
                        FindProbationbyKey(X.Text)
                    Case 7
                        FindConditionalDischargebyKey(X.Text)
                    Case 8
                        FindSplitsentencebyKey(X.Text)
                    Case 9
                        FindFinebyKey(X.Text)
                    Case 10
                        FindUnconditionalDischargebyKey(X.Text)
                    Case 11
                        FindRestitutionReparationbyKey(X.Text)
                    Case 12
                        FindSurchargeVictimAssessmentFeebyKey(X.Text)
                    Case 13
                        FindLicensepenaltiesbyKey(X.Text)
                    Case 14
                        FindConsecutiveConcurrentbyKey(X.Text)
                    Case 15
                        FindEndbyKey(X.Text)
                    Case Else
                        'THis should never happen.
                End Select
            Loop
        End If
    End Sub



    Protected Sub FindPrefacebyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Pref As String = ""
                Do While reader.Read
                    Pref &= reader("Literal")
                    Pref &= "<br />"
                Loop
                Pref = Pref.Replace("''", "'")
                lblPreface.Text &= Server.HtmlDecode(Pref)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindTransitionbyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim Transition As String = ""
                Do While reader.Read
                    Transition &= reader("Literal")
                    Transition &= "<br />"
                Loop
                Transition = Transition.Replace("''", "'")
                lblTransition.Text &= Server.HtmlDecode(Transition)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindStatePrisonbyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim StatePRISON As String = ""
                Do While reader.Read
                    StatePRISON &= reader("Literal")
                    StatePRISON &= "<br />"
                Loop
                StatePRISON = StatePRISON.Replace("''", "'")
                lblStatePRISON.Text &= Server.HtmlDecode(StatePRISON)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindDefinitesentencebyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim DEFINITESENTENCE As String = ""
                Do While reader.Read
                    DEFINITESENTENCE &= reader("Literal")
                    DEFINITESENTENCE &= "<br />"
                Loop
                DEFINITESENTENCE = DEFINITESENTENCE.Replace("''", "'")
                lblDEFINITESENTENCE.Text &= Server.HtmlDecode(DEFINITESENTENCE)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindIntermittentImprisonmentbyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim IntermittentImprisonment As String = ""
                Do While reader.Read
                    IntermittentImprisonment &= reader("Literal")
                    IntermittentImprisonment &= "<br />"
                Loop
                IntermittentImprisonment = IntermittentImprisonment.Replace("''", "'")
                lblIntermittentImprisonment.Text &= Server.HtmlDecode(IntermittentImprisonment)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindProbationbyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim PROBATION As String = ""
                Do While reader.Read
                    PROBATION &= reader("Literal")
                    PROBATION &= "<br />"
                Loop
                PROBATION = PROBATION.Replace("''", "'")
                lblPROBATION.Text &= Server.HtmlDecode(PROBATION)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindConditionalDischargebyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim CONDITIONALDISCHARGE As String = ""
                Do While reader.Read
                    CONDITIONALDISCHARGE &= reader("Literal")
                    CONDITIONALDISCHARGE &= "<br />"
                Loop
                CONDITIONALDISCHARGE = CONDITIONALDISCHARGE.Replace("''", "'")
                lblCONDITIONALDISCHARGE.Text &= Server.HtmlDecode(CONDITIONALDISCHARGE)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindSplitsentencebyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim SplitSentence As String = ""
                Do While reader.Read
                    SplitSentence &= reader("Literal")
                    SplitSentence &= "<br />"
                Loop
                SplitSentence = SplitSentence.Replace("''", "'")
                lblSplitSentence.Text &= Server.HtmlDecode(SplitSentence)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindFinebyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim FINE As String = ""
                Do While reader.Read
                    FINE &= reader("Literal")
                    FINE &= "<br />"
                Loop
                FINE = FINE.Replace("''", "'")
                lblFINE.Text &= Server.HtmlDecode(FINE)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindUnconditionalDischargebyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim UNCONDTIONALDISCHARGE As String = ""
                Do While reader.Read
                    UNCONDTIONALDISCHARGE &= reader("Literal")
                    UNCONDTIONALDISCHARGE &= "<br />"
                Loop
                UNCONDTIONALDISCHARGE = UNCONDTIONALDISCHARGE.Replace("''", "'")
                lblUNCONDTIONALDISCHARGE.Text &= Server.HtmlDecode(UNCONDTIONALDISCHARGE)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindRestitutionReparationbyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim RESTITUTIONREPARATION As String = ""
                Do While reader.Read
                    RESTITUTIONREPARATION &= reader("Literal")
                    RESTITUTIONREPARATION &= "<br />"
                Loop
                RESTITUTIONREPARATION = RESTITUTIONREPARATION.Replace("''", "'")
                lblRESTITUTIONREPARATION.Text &= Server.HtmlDecode(RESTITUTIONREPARATION)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindSurchargeVictimAssessmentFeebyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim SURCHARGEVictimAssessmentFee As String = ""
                Do While reader.Read
                    SURCHARGEVictimAssessmentFee &= reader("Literal")
                    SURCHARGEVictimAssessmentFee &= "<br />"
                Loop
                SURCHARGEVictimAssessmentFee = SURCHARGEVictimAssessmentFee.Replace("''", "'")
                lblSURCHARGEVictimAssessmentFee.Text &= Server.HtmlDecode(SURCHARGEVictimAssessmentFee)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindLicensepenaltiesbyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim LicensePenalties As String = ""
                Do While reader.Read
                    LicensePenalties &= reader("Literal")
                    LicensePenalties &= "<br />"
                Loop
                LicensePenalties = LicensePenalties.Replace("''", "'")
                lblLicensePenalties.Text &= Server.HtmlDecode(LicensePenalties)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindConsecutiveConcurrentbyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim ConSECutiveConcurrent As String = ""
                Do While reader.Read
                    ConSECutiveConcurrent &= reader("Literal")
                    ConSECutiveConcurrent &= "<br />"
                Loop
                ConSECutiveConcurrent = ConSECutiveConcurrent.Replace("''", "'")
                lblConSECutiveConcurrent.Text &= Server.HtmlDecode(ConSECutiveConcurrent)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub FindEndbyKey(ByRef ParagraphKey As String)
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetTopicByKey", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@TopicKey", ParagraphKey)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                Dim End1 As String = ""
                Do While reader.Read
                    End1 &= reader("Literal")
                    End1 &= "<br />"
                Loop
                End1 = End1.Replace("''", "'")
                lblEnd.Text &= Server.HtmlDecode(End1)
            Else

            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub Back1_Click(sender As Object, e As System.EventArgs) Handles Back1.Click
        Response.Redirect("./Qualifiers.aspx")
    End Sub
    Protected Sub Back2_Click(sender As Object, e As System.EventArgs) Handles Back2.Click
        Response.Redirect("./Qualifiers.aspx")
    End Sub
    Protected Sub SearchReturn1_Click(sender As Object, e As System.EventArgs) Handles SearchReturn1.Click
        Response.Redirect("./CrimeTime.aspx")
    End Sub
    Protected Sub SearchReturn2_Click(sender As Object, e As System.EventArgs) Handles SearchReturn2.Click
        Response.Redirect("./CrimeTime.aspx")
    End Sub

    Private Function CheckDBNULL(p1 As Object) As String
        If IsDBNull(p1) Then
            Return String.Empty
        Else
            Return p1
        End If
    End Function

End Class
