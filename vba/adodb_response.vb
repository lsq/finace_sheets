Private Function GetResponseText(ByVal URL As String) As String    
  Dim http As New MSXML2.XMLHTTP60        
  http.Open "GET", URL, False    
  http.send        
  If http.Status = 200 Then
    Dim stream As New ADODB.Stream
    stream.Type = adTypeBinary
    stream.Open
    stream.Write http.ResponseBody
    stream.Position = 0
    stream.Type = adTypeText
    stream.Charset ="UTF-8"
    GetResponseText = stream.ReadText(-1)
    stream.Close
  End If
End Function
