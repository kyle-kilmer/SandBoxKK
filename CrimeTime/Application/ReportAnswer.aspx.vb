Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class ReportAnswer
    Inherits System.Web.UI.Page
    Private CAID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Dim AgeCat As String = ""
    Dim FelConvictions As String = ""
    Dim PastConvictions As String = ""
    Dim Question As String = ""
    Dim QuestionResponse As String = ""
    Dim Attempt As Boolean
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Session("EmailAddressID")) Then
            Response.Redirect("./default.aspx")
        End If
        If Not Page.IsPostBack Then
            sbm_button.Enabled = True
        End If

    End Sub


    Protected Sub sbm_button_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles sbm_button.Click
        CAID = Request("CAID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetAnswerDetails", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CAID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then

                Do While reader.Read
                    AgeCat = reader("AgeCat")
                    FelConvictions = reader("FelonyCon")
                    PastConvictions = reader("PastCon")
                    Question = reader("Question")
                    If Question <> "" Then
                        QuestionResponse = reader("QuestionsResponse")
                    End If
                    Attempt = reader("Attempted")
                Loop
            End If
        Catch Err As Exception
            lblError.Text = Err.ToString
        Finally
            con.Close()
        End Try
        SendEmail()
    End Sub
    Protected Sub SendEmail()
        Dim emailTo As String = WebConfigurationManager.AppSettings("EmailTo")
        Dim emailFrom As String = WebConfigurationManager.AppSettings("EmailFrom")

        Dim mailMessage As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()

        mailMessage.From = New System.Net.Mail.MailAddress(emailFrom)
        'Another option is the "from" attirbute in the <smtp> element in the web.config.

        'Set additinal addresses
        mailMessage.To.Add(New System.Net.Mail.MailAddress(emailTo))

        'Set additional options
        mailMessage.Priority = Net.Mail.MailPriority.High
        'Text/HTML
        mailMessage.IsBodyHtml = True

        'Set the subjet and body text
        mailMessage.Subject = "Problem report for: " & Server.HtmlDecode(Request("Name"))
        mailMessage.Body = "<b>Law: </b>" & Server.HtmlDecode(Request("Name"))
        mailMessage.Body = mailMessage.Body & "<br /><b>Reporting Email Address: </b>" & Session("EmailAddressID")
        mailMessage.Body = mailMessage.Body & "<br /><b>Permutation Details: </b>"
        mailMessage.Body = mailMessage.Body & "<br /><b>&nbsp;&nbsp;&nbsp;Attempted: </b>" & IIf(Attempt, "Yes", "No")
        mailMessage.Body = mailMessage.Body & "<br /><b>&nbsp;&nbsp;&nbsp;Age: </b>" & AgeCat
        If Question <> "" Then
            mailMessage.Body = mailMessage.Body & "<br /><b>&nbsp;&nbsp;&nbsp;Qualifying Question: </b>" & Question
            mailMessage.Body = mailMessage.Body & "<br /><b>&nbsp;&nbsp;&nbsp;Question Response: </b>" & IIf(QuestionResponse, "Yes", "No")
        End If
        If PastConvictions <> "" Then
            mailMessage.Body = mailMessage.Body & "<br /><b>&nbsp;&nbsp;&nbsp;Past Convictions: </b>" & PastConvictions
        End If
        If FelConvictions <> "" Then
            mailMessage.Body = mailMessage.Body & "<br /><b>&nbsp;&nbsp;&nbsp;Felony Sentencing Category: </b>" & FelConvictions
        End If
        mailMessage.Body = mailMessage.Body & "<br /><b>Issue Reported: </b>" & ReportReason.Text

        'Create an instance of the SmtpClient class for sending the email
        Dim smtpClient As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient()

        Try
            smtpClient.Send(mailMessage)
            sbm_button.Enabled = False
            Thanks.Text = "Thank you for reporting this issue"
        Catch Err As Exception
            lblError.Text = Err.ToString
        End Try
    End Sub
End Class
