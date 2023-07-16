url = "https://httpbin.org/get"

Set xmlHttp = CreateObject("WinHTTP.WinHTTPRequest.5.1")
xmlHttp.Open "GET", url, false
'xmlHttp.SetRequestHeader "Accetp", "application/json"
xmlHttp.SetRequestHeader "Accetp", "text/html"
xmlHttp.SetRequestHeader "lsq", "haha!"
xmlHttp.Send
intStatus = xmlhttp.Status
sResponse = xmlHttp.ResponseText

If intStatus = 200 Then
  WScript.Echo " " & intStatus & " A OK " +myURL
Else
  WScript.Echo "OOPS" +myURL
End If
WScript.Echo sResponse
