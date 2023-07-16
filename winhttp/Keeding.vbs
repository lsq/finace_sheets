'@charset="UTF-8"
Option Explicit                                                    
Dim args, http, fileSystem, adoStream, url, target, status , body 
Set args = Wscript.Arguments                                       
Set http = CreateObject("WinHttp.WinHttpRequest.5.1")              
'url = args(0)                                                      
url =  "https://maxeye.test.ik3cloud.com/Kingdee.BOS.WebApi.ServicesStub.AuthService.ValidateUser.common.kdsvc"
body = "{""parameters"":[""20201201132949924"", ""刘军晓"",""lsq!#1213MAXEYE"",2052]}"
'target = args(1)          
target = "k3cloud.html"                                             
'WScript.Echo "Getting '" & target & "' from '" & url & "'..."  
WScript.Echo "Getting Start Post ...."
                                                                   
http.Open "POST", url, False    
http.SetRequestHeader "Content-Type", "application/json;charset=UTF-8"    
http.SetRequestHeader "Accept", "*/*"  
http.Option(6) = True                              
http.Send body                                                         
status = http.Status                                               
                                                                   
If status <> 200 Then                                            
   WScript.Echo "FAILED to download: HTTP Status " & status       
   'WScript.Quit 1
Else
   WScript.Echo status
End If                                                             
       
WScript.Echo http.GetAllResponseHeaders	  
WScript.Echo "--------------------"
'WScript.Echo http.GetResponseHeader 
Set adoStream = CreateObject("ADODB.Stream")                       
adoStream.Open                                                     
adoStream.Type = 1                                                 
adoStream.Write http.ResponseBody                                  
adoStream.Position = 0                                             
                                                                   
Set fileSystem = CreateObject("Scripting.FileSystemObject")        
If fileSystem.FileExists(target) Then fileSystem.DeleteFile target 
adoStream.SaveToFile target                                        
adoStream.Close                                                    
WScript.Echo "文件已保存！"                                                             
