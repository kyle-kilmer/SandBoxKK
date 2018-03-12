Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data

Partial Class AddParagraphToMultiple
    Inherits System.Web.UI.Page

    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Private ParagraphID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UserID = Session("CTUserID")
        ParagraphID = Request("ParagraphID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        End If
        If Not Page.IsPostBack Then
            PopulateParagraphText()
            PopulateLaws()
        End If

    End Sub

    Protected Sub PopulateParagraphText()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetParagraph", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ParagraphID", ParagraphID)
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                reader.Read()
                Paragraph.Text = reader("ParagraphText")
            End If
        Catch ex As Exception

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub PopulateLaws()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetCrimeList", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                gvLawUsed.DataSource = reader
                gvLawUsed.DataBind()
            End If
        Catch ex As Exception

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub gvPermutations_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "EditSentence" Then
            Response.Redirect("./ChooseParagraphs.aspx?CAID=" & e.CommandArgument)
        End If

    End Sub

    Protected Sub gvLawUsed_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvLawUsed.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim CrimesID As Integer = gvLawUsed.DataKeys(e.Row.RowIndex).Value
            Dim gv As GridView = TryCast(e.Row.FindControl("gvPermutations"), GridView)
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_GetCrimeAnswerListByCrimeID", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CRIMEID", CrimesID)
            cmd.Parameters.AddWithValue("@CRIMEANSWERID", 0)
            Dim reader As SqlDataReader
            Try
                con.Open()
                reader = cmd.ExecuteReader()

                If reader.HasRows Then
                    gv.DataSource = reader
                    gv.DataBind()
                End If
            Catch ex As Exception
            Finally
                con.Close()
            End Try
        End If
    End Sub



    Protected Sub btnAddToPermutations_Click(sender As Object, e As EventArgs) Handles btnAddToPermutations.Click
        Dim totalProcessed As Integer = 0
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_AddParagraphToPermutation", con)
        cmd.CommandType = CommandType.StoredProcedure

        For Each gvRow As GridViewRow In gvLawUsed.Rows
            Dim gv As GridView = TryCast(gvRow.FindControl("gvPermutations"), GridView)
            For Each gvPRow As GridViewRow In gv.Rows
                If gvPRow.RowType = DataControlRowType.DataRow Then
                    Dim chkSel As CheckBox = DirectCast(gvPRow.FindControl("chkSelect"), CheckBox)
                    If chkSel.Checked Then
                        totalProcessed += 1
                        Dim Keys As DataKey = gv.DataKeys(gvPRow.RowIndex)
                        Dim PermutationID As Integer = Keys(0)
                        cmd.Parameters.AddWithValue("@ParagraphID", ParagraphID)
                        cmd.Parameters.AddWithValue("@PermutationID", PermutationID)
                        Try
                            con.Open()
                            cmd.ExecuteNonQuery()
                        Catch ex As Exception
                        Finally
                            con.Close()
                            cmd.Parameters.Clear()
                        End Try
                    End If
                End If
            Next
        Next

        lblResult.Text = "Paragraph added to " & totalProcessed.ToString & " Permutations"

    End Sub

    Protected Sub btnFilter_Click(sender As Object, e As EventArgs) Handles btnFilter.Click
        If lbFilterSelect.SelectedValue = "" Then
            PopulateLaws()
        Else
            Dim dt As New DataTable
            dt.Columns.Add("Class")
            dt.Columns.Add("Category")
            For Each li As ListItem In lbFilterSelect.Items
                If li.Selected Then
                    Dim dr As DataRow
                    dr = dt.NewRow
                    If li.Value.Length > 1 Then
                        dr.Item("Class") = li.Value.Substring(0, 1)
                        dr.Item("Category") = li.Value.Substring(1, 1)
                    Else
                        dr.Item("Class") = String.Empty
                        dr.Item("Category") = li.Value.Substring(0, 1)
                    End If
                    dt.Rows.Add(dr)
                End If
            Next


            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_GetLawsByClassAndCategory", con)

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.Add("@ClassAndCategory", SqlDbType.Structured).Value = dt

            Dim reader As SqlDataReader
            Try
                con.Open()
                reader = cmd.ExecuteReader()

                If reader.HasRows Then
                    gvLawUsed.DataSource = reader
                    gvLawUsed.DataBind()
                End If
            Catch ex As Exception
            Finally
                con.Close()
            End Try
        End If
    End Sub
End Class
