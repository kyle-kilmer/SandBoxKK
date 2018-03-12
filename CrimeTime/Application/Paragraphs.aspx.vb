Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data

Partial Class Paragraph
    Inherits System.Web.UI.Page

    Private UserID As Integer
    Private connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
    Dim pCategoryID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UserID = Session("CTUserID")
        If Session("NYPTIStaff") <> True Then
            Session("ButtonID") = 0
            Response.Redirect("./CrimeTime.aspx")
        End If
        If Not Page.IsPostBack Then
            PopulateParagraphCategories()
            'FillPulldowns()
        End If
    End Sub
    Protected Sub PopulateParagraphCategories()
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand("SP_GetParagraphCategories", con)
        cmd.CommandType = CommandType.StoredProcedure
        Dim reader As SqlDataReader
        Try
            con.Open()
            reader = cmd.ExecuteReader()

            If reader.HasRows Then
                ParagraphCategories.DataSource = reader
                ParagraphCategories.DataBind()
            End If
        Catch Err As Exception

        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub ParagraphCategories_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles ParagraphCategories.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            pCategoryID = ParagraphCategories.DataKeys(e.Row.RowIndex).Value
            Dim gv As GridView = TryCast(e.Row.FindControl("gvParagraphs"), GridView)
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_GetParagraphList", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CategoryID", pCategoryID)
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


    Protected Sub OnGridRDB(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.Header Then
            Dim H As HyperLink = e.Row.Cells.Item(0).FindControl("AddNew")
            H.NavigateUrl = "./AddParagraphs.aspx?Category=" & pCategoryID
        ElseIf e.Row.RowType = DataControlRowType.DataRow Then
            'Getting data key value
            Dim grid As GridView = TryCast(sender, GridView)
            Dim Keys As DataKey = grid.DataKeys(e.Row.RowIndex)
            Dim ParagraphID As Integer = Keys("ParagraphID")
            Dim literal As String = Keys("Literal")
            Dim categoryID As Integer = Keys("CategoryID")

            'Translating HTML tags
            Dim L As Label = e.Row.Cells.Item(2).FindControl("ParaLabel")
            L.Text = Server.HtmlDecode(literal.Trim)

            'Setting navigation URL for paragraph edit page
            Dim H As HyperLink = e.Row.Cells.Item(0).FindControl("EditSentence")
            H.NavigateUrl = "./UpdateParagraphs.aspx?Category=" & categoryID & "&key=" & e.Row.Cells(2).Text & "&ID=" & ParagraphID

            Dim H2 As HyperLink = e.Row.Cells.Item(2).FindControl("WhereUsed")
            H2.NavigateUrl = "./ParagraphUsage.aspx?ParagraphID=" & ParagraphID

            Dim H3 As HyperLink = e.Row.Cells.Item(2).FindControl("AddToMultiple")
            H3.NavigateUrl = "./AddParagraphToMultiple.aspx?ParagraphID=" & ParagraphID
        End If
    End Sub



    Protected Sub OnRowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)

        If e.CommandName = "DeleteParagraph" Then
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_DeleteParagraph", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@AnswerID", e.CommandArgument.ToString())
            Try
                con.Open()
                cmd.ExecuteNonQuery()
                lblResult.Text = "The paragraph has been deleted"
            Catch ex As Exception
                lblResult.Text = ex.StackTrace
            Finally
                con.Close()
            End Try
        End If


    End Sub


End Class
