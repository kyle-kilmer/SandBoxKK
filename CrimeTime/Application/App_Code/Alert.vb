﻿Imports System.Web
Imports System.Text
Imports System.Web.UI

'/ <summary> 
'/ A JavaScript alert 
'/ </summary> 
Public Class Alert

    '/ <summary> 
    '/ Shows a client-side JavaScript alert in the browser. 
    '/ </summary> 
    '/ <param name="message">The message to appear in the alert.</param> 
    Public Shared Sub Show(ByVal message As String)
        ' Cleans the message to allow single quotation marks 
        Dim cleanMessage As String = message.Replace("'", "\'")
        Dim script As String = "<script type='text/javascript'>alert('" + cleanMessage + "');</script>"

        ' Gets the executing web page 
        Dim page As Page = HttpContext.Current.CurrentHandler

        ' Checks if the handler is a Page and that the script isn't allready on the Page 
        If Not page Is Nothing And Not page.ClientScript.IsClientScriptBlockRegistered("alert") Then
            page.ClientScript.RegisterClientScriptBlock(GetType(Alert), "alert", script)
        End If
    End Sub
End Class
