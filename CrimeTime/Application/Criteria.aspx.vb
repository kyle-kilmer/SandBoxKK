
Partial Class Criteria
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Session("ButtonID") = 4
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
End Class
