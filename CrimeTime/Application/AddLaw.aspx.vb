Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.Configuration

Partial Class AddLaw
    Inherits System.Web.UI.Page

    Dim UserID As Integer
    Dim CID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        End If

        Dim edit As String = Request("edit")
        CID = Request("CID")

        FillDropdowns() 'Filling all dropdowns with values

        'Filling info button tooltips
        InfoButton1.ToolTip = "Laws that are violent by nature, such as Murder 2nd, but are not included in section 70.02 because the legislature was not addressing the sentencing provisions for them. These are flagged as ""L,"" meaning that they are ""like"" other violent felonies but not included in the legal definition of violent."
        InfoButton2.ToolTip = "Laws that are violent by nature, such as Murder 2nd, but are not included in section 70.02 because the legislature was not addressing the sentencing provisions for them. These are flagged as ""L,"" meaning that they are ""like"" other violent felonies but not included in the legal definition of violent."

        If Not String.IsNullOrEmpty(edit) AndAlso CID > 0 AndAlso Not Page.IsPostBack Then
            AddButton.Text = "Update Law"
            getLawDetails()
        End If

        AddScripts()
    End Sub

    Protected Sub FillDropdowns()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("GetCategory", con)
        Dim cmd2 As New SqlCommand("GetClass", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd2.CommandType = CommandType.StoredProcedure
        Try
            con.Open()
            'Filling category dropdowns
            Dim reader As SqlDataReader = cmd.ExecuteReader
            If reader.HasRows Then
                Do While (reader.Read)
                    Dim item As New ListItem
                    Dim item2 As New ListItem
                    item.Text = reader("literal")
                    item.Value = reader("short")
                    item2.Text = reader("literal")
                    item2.Value = reader("short")
                    AttemptedLawCategoryTextBox.Items.Add(item)
                    LawCategoryTextBox.Items.Add(item2)
                Loop
            End If
            reader.Close()

            'Filling class dropdowns
            Dim reader2 As SqlDataReader = cmd2.ExecuteReader
            If reader2.HasRows Then
                Do While (reader2.Read)
                    Dim item As New ListItem
                    Dim item2 As New ListItem
                    item.Text = reader2("literal")
                    item.Value = reader2("short")
                    item2.Text = reader2("literal")
                    item2.Value = reader2("short")
                    AttemptedClassTextBox.Items.Add(item)
                    ClassTextBox.Items.Add(item2)
                Loop
            End If
        Catch ex As Exception
            lblError.Text = ex.Message
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub CancelButton_Click(sender As Object, e As System.EventArgs) Handles CancelButton.Click
        If CID = 0 Then
            Response.Redirect("./ManageLaws.aspx")
        Else
            Response.Redirect("./Addsentencinginfo.aspx?CID=" & CID)
        End If
    End Sub

    Protected Sub ClearButton_Click(sender As Object, e As System.EventArgs) Handles ClearButton.Click
        LawOrdinalTextBox.Text = String.Empty
        DescriptionTextBox.Text = String.Empty
        TitleTextBox.SelectedIndex = 0
        SectionTextBox.Text = String.Empty
        SubsectionTextBox.Text = String.Empty
        ClassTextBox.SelectedIndex = 0
        LawCategoryTextBox.SelectedIndex = 0
        EffectiveDateTextBox.Text = String.Empty
        RepealDateTextBox.Text = String.Empty
        AttemptedLawCategoryTextBox.SelectedIndex = 0
        AttemptedClassTextBox.SelectedIndex = 0
        ViolentFelonyIndicatorTextBox.SelectedIndex = 0
        AttemptedViolentFelonyIndicatorTextBox.SelectedIndex = 0
    End Sub

    Protected Sub AddButton_Click(sender As Object, e As System.EventArgs) Handles AddButton.Click
        If AddButton.Text = "Update Law" Then
            doUpdate()
        Else
            doAdd()
        End If
    End Sub

    Private Sub doAdd()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_AddLaw", con)
        cmd.CommandType = CommandType.StoredProcedure
        Try
            con.Open()

            Dim ed, rd As Object

            If String.IsNullOrEmpty(EffectiveDateTextBox.Text.Trim) Then
                ed = DBNull.Value
            Else
                ed = Date.Parse(EffectiveDateTextBox.Text)
            End If

            If String.IsNullOrEmpty(RepealDateTextBox.Text.Trim) Then
                rd = DBNull.Value
            Else
                rd = Date.Parse(RepealDateTextBox.Text)
            End If


            If String.IsNullOrEmpty(LawOrdinalTextBox.Text.Trim) Then
                cmd.Parameters.AddWithValue("@LawOrdinal", DBNull.Value)
            Else
                cmd.Parameters.AddWithValue("@LawOrdinal", Integer.Parse(LawOrdinalTextBox.Text.Trim))
            End If

            cmd.Parameters.AddWithValue("@FullLawDescription", DescriptionTextBox.Text.Trim)
            cmd.Parameters.AddWithValue("@Title", TitleTextBox.Text.Trim)
            cmd.Parameters.AddWithValue("@Section", SectionTextBox.Text.Trim)
            cmd.Parameters.AddWithValue("@Subsection", SubsectionTextBox.Text.Trim)
            cmd.Parameters.AddWithValue("@EffectiveDate", ed)
            cmd.Parameters.AddWithValue("@RepealDate", rd)
            cmd.Parameters.AddWithValue("@Class", ClassTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@NYSLawCategory", LawCategoryTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@AttemptedNYSLawCategory", AttemptedLawCategoryTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@AttemptedClass", AttemptedClassTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@VFIndicator", ViolentFelonyIndicatorTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@AttemptedVFIndicator", AttemptedViolentFelonyIndicatorTextBox.SelectedValue)

            cmd.ExecuteNonQuery()

            CancelButton_Click(Nothing, Nothing)
        Catch ex As Exception
            lblError.Text = ex.Message
        Finally
            con.Close()
        End Try
    End Sub

    Private Sub doUpdate()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_UpdateLaw", con)
        cmd.CommandType = CommandType.StoredProcedure
        Try
            con.Open()

            Dim ed, rd As Object

            If String.IsNullOrEmpty(EffectiveDateTextBox.Text.Trim) Then
                ed = DBNull.Value
            Else
                ed = Date.Parse(EffectiveDateTextBox.Text)
            End If

            If String.IsNullOrEmpty(RepealDateTextBox.Text.Trim) Then
                rd = DBNull.Value
            Else
                rd = Date.Parse(RepealDateTextBox.Text)
            End If

            cmd.Parameters.AddWithValue("@CID", CID)

            If String.IsNullOrEmpty(LawOrdinalTextBox.Text.Trim) Then
                cmd.Parameters.AddWithValue("@LawOrdinal", DBNull.Value)
            Else
                cmd.Parameters.AddWithValue("@LawOrdinal", Integer.Parse(LawOrdinalTextBox.Text.Trim))
            End If

            cmd.Parameters.AddWithValue("@FullLawDescription", DescriptionTextBox.Text.Trim)
            cmd.Parameters.AddWithValue("@Title", TitleTextBox.Text.Trim)
            cmd.Parameters.AddWithValue("@Section", SectionTextBox.Text.Trim)
            cmd.Parameters.AddWithValue("@Subsection", SubsectionTextBox.Text.Trim)
            cmd.Parameters.AddWithValue("@EffectiveDate", ed)
            cmd.Parameters.AddWithValue("@RepealDate", rd)
            cmd.Parameters.AddWithValue("@Class", ClassTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@NYSLawCategory", LawCategoryTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@AttemptedNYSLawCategory", AttemptedLawCategoryTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@AttemptedClass", AttemptedClassTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@VFIndicator", ViolentFelonyIndicatorTextBox.SelectedValue)
            cmd.Parameters.AddWithValue("@AttemptedVFIndicator", AttemptedViolentFelonyIndicatorTextBox.SelectedValue)

            cmd.ExecuteNonQuery()

            CancelButton_Click(Nothing, Nothing)
        Catch ex As Exception
            lblError.Text = ex.Message
        Finally
            con.Close()
        End Try
    End Sub

    Private Sub getLawDetails()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetLawDetails", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            cmd.Parameters.AddWithValue("@CID", CID)
            reader = cmd.ExecuteReader

            While reader.Read
                LawOrdinalTextBox.Text = CheckDBNULL(reader("law_ordinal"))
                DescriptionTextBox.Text = CheckDBNULL(reader("full_law_description"))
                TitleTextBox.Text = CheckDBNULL(reader("title"))
                SectionTextBox.Text = CheckDBNULL(reader("section"))
                SubsectionTextBox.Text = CheckDBNULL(reader("subsection"))
                EffectiveDateTextBox.Text = CheckDBNULL(reader("effective_date"))
                RepealDateTextBox.Text = CheckDBNULL(reader("repeal_date"))

                ClassTextBox.SelectedValue = CheckDBNULL(reader("class")).Trim
                LawCategoryTextBox.SelectedValue = CheckDBNULL(reader("nys_law_category")).Trim
                AttemptedLawCategoryTextBox.SelectedValue = CheckDBNULL(reader("attempted_nys_law_category")).Trim
                AttemptedClassTextBox.SelectedValue = CheckDBNULL(reader("attempted_class")).Trim

                ViolentFelonyIndicatorTextBox.SelectedValue = CheckDBNULL(reader("vf_indicator"))
                AttemptedViolentFelonyIndicatorTextBox.SelectedValue = CheckDBNULL(reader("attempted_vf_indicator"))
            End While

        Catch ex As Exception
            lblError.Text = ex.Message
        Finally
            con.Close()
        End Try
    End Sub

    Private Function CheckDBNULL(p1 As Object) As String
        If IsDBNull(p1) Then
            Return String.Empty
        Else
            Return p1
        End If
    End Function

    Private Sub AddScripts()

        Dim sb As New StringBuilder

        sb.AppendLine("<script type=""text/javascript"">")
        sb.AppendLine("$(function () {")
        sb.AppendLine("$(""#" & EffectiveDateTextBox.ClientID & """).datepicker();")
        sb.AppendLine("$(""#" & RepealDateTextBox.ClientID & """).datepicker();")
        sb.AppendLine("});")
        sb.AppendLine("</script>")

        Page.ClientScript.RegisterStartupScript(Me.GetType, "DatePickerScript", sb.ToString)
    End Sub

End Class
