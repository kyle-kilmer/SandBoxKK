Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.Profile
Imports System.Web.Security
Imports System.Data
Imports System.Web.UI
Partial Class CrimeTimeHistory
    Inherits System.Web.UI.Page
    Private ButtonIdentifier As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("ButtonID") = 4
    End Sub

    Protected Sub ReturnDisclaimer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ReturnDisclaimer.Click
        Response.Redirect("./Default.aspx")
    End Sub
End Class
