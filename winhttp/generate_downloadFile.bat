@echo off

 rem Windows has no built-in wget or curl, so generate a VBS script to do it:
 rem -------------------------------------------------------------------------
 set DLOAD_SCRIPT=download.vbs
 echo Option Explicit                                                    >  %DLOAD_SCRIPT%
 echo Dim args, http, fileSystem, adoStream, url, target, status         >> %DLOAD_SCRIPT%
 echo.                                                                   >> %DLOAD_SCRIPT%
 echo Set args = Wscript.Arguments                                       >> %DLOAD_SCRIPT%
 echo Set http = CreateObject("WinHttp.WinHttpRequest.5.1")              >> %DLOAD_SCRIPT%
 echo url = args(0)                                                      >> %DLOAD_SCRIPT%
 echo target = args(1)                                                   >> %DLOAD_SCRIPT%
 echo WScript.Echo "Getting '" ^& target ^& "' from '" ^& url ^& "'..."  >> %DLOAD_SCRIPT%
 echo.                                                                   >> %DLOAD_SCRIPT%
 echo http.Open "GET", url, False                                        >> %DLOAD_SCRIPT%
 echo http.Send                                                          >> %DLOAD_SCRIPT%
 echo status = http.Status                                               >> %DLOAD_SCRIPT%
 echo.                                                                   >> %DLOAD_SCRIPT%
 echo If status ^<^> 200 Then                                            >> %DLOAD_SCRIPT%
 echo    WScript.Echo "FAILED to download: HTTP Status " ^& status       >> %DLOAD_SCRIPT%
 echo    WScript.Quit 1                                                  >> %DLOAD_SCRIPT%
 echo End If                                                             >> %DLOAD_SCRIPT%
 echo.                                                                   >> %DLOAD_SCRIPT%
 echo Set adoStream = CreateObject("ADODB.Stream")                       >> %DLOAD_SCRIPT%
 echo adoStream.Open                                                     >> %DLOAD_SCRIPT%
 echo adoStream.Type = 1                                                 >> %DLOAD_SCRIPT%
 echo adoStream.Write http.ResponseBody                                  >> %DLOAD_SCRIPT%
 echo adoStream.Position = 0                                             >> %DLOAD_SCRIPT%
 echo.                                                                   >> %DLOAD_SCRIPT%
 echo Set fileSystem = CreateObject("Scripting.FileSystemObject")        >> %DLOAD_SCRIPT%
 echo If fileSystem.FileExists(target) Then fileSystem.DeleteFile target >> %DLOAD_SCRIPT%
 echo adoStream.SaveToFile target                                        >> %DLOAD_SCRIPT%
 echo adoStream.Close                                                    >> %DLOAD_SCRIPT%
 echo.                                                                   >> %DLOAD_SCRIPT%
 rem -------------------------------------------------------------------------'"'
