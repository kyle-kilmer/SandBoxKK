Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Partial Class ChooseParagraphs
    Inherits System.Web.UI.Page
    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Public CrimeAnswerID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        End If
        CrimeAnswerID = Request("CAID")
        FillQualifiers()
        If Not Page.IsPostBack Then
            PreviewWrapper.Visible = True
            Session("ButtonID") = 999

        End If
        FillCrimeName()
        FillParagraphList()
        'Checking for copied permutations
        If (Not Session("CopiedParagraphIDs") Is Nothing) AndAlso (Not String.IsNullOrEmpty(Session("CopiedParagraphIDs").ToString)) Then
            btnPaste.Enabled = True
        End If
    End Sub

    Protected Sub FillParagraphList()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetParagraphAndCategory", con)
        cmd.Parameters.AddWithValue("CrimeAnswerID", CrimeAnswerID)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then

                Dim currentCount As Integer = lbParagraphKeys.Items.Count
                Do While reader.Read
                    If currentCount = 0 Then
                        Dim newlistitem As New ListItem
                        newlistitem.Text = reader("ParagraphKey")
                        newlistitem.Value = reader("ParagraphID")
                        Dim str As String = reader("ParagraphText")
                        str = Regex.Replace(str, "<.*?>", String.Empty)
                        str = Regex.Replace(str, "[\u0080-\uFFFF\r\n]", String.Empty)
                        str = Regex.Replace(str, "[\'\""]", String.Empty)

                        newlistitem.Attributes.Add("onmouseover", "this.title='" & str & "'")
                        newlistitem.Attributes.Add("optGroup", reader("Category"))

                        If CBool(reader("Selected")) Then
                            newlistitem.Selected = True
                        End If
                        lbParagraphKeys.Items.Add(newlistitem)
                    Else
                        Dim str As String = reader("ParagraphText")
                        str = Regex.Replace(str, "<.*?>", String.Empty)
                        str = Regex.Replace(str, "[\u0080-\uFFFF\r\n]", String.Empty)
                        str = Regex.Replace(str, "[\'\""]", String.Empty)
                        lbParagraphKeys.Items.FindByValue(reader("ParagraphID")).Attributes.Add("onmouseover", "this.title='" & str & "'")
                        lbParagraphKeys.Items.FindByValue(reader("ParagraphID")).Attributes.Add("optGroup", reader("Category"))

                    End If
                Loop
            End If

        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        DeleteParagraphs()
        AddParagraphs()
        Dim CID As Integer
        CID = Request("CID")
        Response.Redirect("./Addsentencinginfo.aspx?CID=" & CID)
    End Sub

    Protected Sub AddParagraphs()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_AddParagraphToPermutation", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@PermutationID", CrimeAnswerID)
        For Each i As Integer In lbParagraphKeys.GetSelectedIndices()
            cmd.Parameters.AddWithValue("@ParagraphID", lbParagraphKeys.Items(i).Value)
            Dim reader As SqlDataReader
            Try
                con.Open()
                reader = cmd.ExecuteReader()
            Catch Err As Exception
                lblError.Text = Err.Message
            Finally
                con.Close()
            End Try
            cmd.Parameters.RemoveAt("@ParagraphID")
        Next
    End Sub

    Protected Sub FillQualifiers()
        Dim sb As New StringBuilder
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetPermutationParameters", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CrimeAnswerID)

        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()
            If reader.HasRows Then
                reader.Read()
                sb.Append("Attempt - ")
                If CType(reader("Attempted"), Boolean) Then
                    sb.Append("Yes;")
                Else
                    sb.Append("No;")
                End If

                sb.Append(" Age - ")

                If IsDBNull(reader("Age")) Then
                    sb.Append("No category;")
                Else
                    sb.Append(reader("Age") & ";")
                End If
                sb.Append(" Past Convictions - " & reader("PastConvictions") & ";")

                sb.Append(" Felony Category - " & reader("FelonyCategory") & ";")

                sb.Append(" QuestionResponse - ")
                If IsDBNull(reader("QuestionsResponse")) Then
                    sb.Append(";")
                ElseIf CType(reader("QuestionsResponse"), Boolean) Then
                    sb.Append("Yes;")
                Else
                    sb.Append("No;")
                End If
            End If

        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try

        Qualifiers.Text = sb.ToString
    End Sub


    Protected Sub DeleteParagraphs()

        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_RemoveParagraphsfromCrime", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CrimeAnswerID)

        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()


        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try
    End Sub

    Private Sub FillCrimeName()
        Dim CID As Integer = Request("CID")
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeName", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CRIMEID", CID)
        cmd.Parameters.AddWithValue("@CrimeAnswerID", CrimeAnswerID)
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
                    title = reader("title")
                    section = reader("section")
                    subsection = reader("subsection")
                Loop
            End If
            CrimeName.Text = title & " " & section & " " & subsection & " - " & CName
        Catch Err As Exception
            lblError.Text = Err.Message
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub btnCopy_Click(sender As Object, e As System.EventArgs) Handles btnCopy.Click
        Dim SelectedParagraphIDs As String = String.Empty
        For Each i As ListItem In lbParagraphKeys.Items
            If i.Selected Then
                SelectedParagraphIDs = SelectedParagraphIDs + i.Value + ","
            End If
        Next
        SelectedParagraphIDs = Regex.Replace(SelectedParagraphIDs, ",$", "")
        Session("CopiedParagraphIDs") = SelectedParagraphIDs
    End Sub

End Class