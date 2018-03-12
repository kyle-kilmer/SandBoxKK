Imports System.Web
Imports System.Text
Imports System.Web.UI

'/ <summary> 
'/ A JavaScript alert 
'/ </summary> 
Public Class Confirm

    '/ <summary> 
    '/ Shows a client-side JavaScript alert in the browser. 
    '/ </summary> 
    '/ <param name="message">The message to appear in the alert.</param> 
    Public Shared Sub Show(ByVal message As String)
        ' Cleans the message to allow single quotation marks 
        Dim cleanMessage As String = message.Replace("'", "\'")
        Dim script As String = "<script type='text/javascript'>confirm('" + cleanMessage + "');</script>"

        ' Gets the executing web page 
        Dim page As Page = HttpContext.Current.CurrentHandler

        ' Checks if the handler is a Page and that the script isn't allready on the Page 
        If Not page Is Nothing And Not page.ClientScript.IsClientScriptBlockRegistered("confirm") Then
            page.ClientScript.RegisterClientScriptBlock(GetType(Confirm), "confirm", script)
        End If
    End Sub
    Public Shared Sub RegisterConfirmJavascriptButton(ByVal control As Button, ByVal Message As String)

        Dim attributes As System.Web.UI.AttributeCollection = control.Attributes()

        If Not attributes Is Nothing Then
            Dim cleanMessage As String = Message.Replace("'", "\'")
            attributes.Add("OnClick", "return confirm('" + cleanMessage + "');")

        End If

    End Sub
End Class