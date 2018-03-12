<%@ WebHandler Language="VB" Class="GetParagraphs" %>

Imports System
Imports System.Web
Imports System.Web.Configuration
Imports System.Data.SqlClient
Imports System.Data

Public Class GetParagraphs : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim paragraphs As String = String.Empty
        
        If Not context.Request.QueryString("IDs") = "null" Then
            Dim ParagraphIDs As String() = context.Request.QueryString("IDs").Split(",")
       
            Dim dt As New DataTable
            dt.Columns.Add("ID")
            For Each i As Integer In ParagraphIDs
                dt.Rows.Add(i)
            Next
            Dim connectionString As String = WebConfigurationManager.ConnectionStrings("CTConnection").ConnectionString
            Dim con As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SP_GetParagraphByIDs", con)
               
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.Add("@ParagraphIDs", SqlDbType.Structured).Value = dt
        
            Dim reader As SqlDataReader
            Try
                con.Open()
                reader = cmd.ExecuteReader()

                If reader.HasRows Then
                    Do While reader.Read
                        paragraphs = paragraphs + reader("ParagraphText") + "<br/>" + "<br/>"
                    Loop
                End If
        

            Catch ex As Exception

            Finally
                con.Close()
            End Try

        End If
        context.Response.ContentType = "text\html"
        context.Response.Write(paragraphs)
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class