'https://www.mrexcel.com/board/threads/vba-create-text-file-in-utf-8-rather-then-ansi.1204545/
Option Explicit

Sub test()

  Dim oStreamUTF8 As Object
  Dim oStreamUTF8NoBOM As Object
  Dim data As String
  Dim ArrFileTxt() As String
  Dim i As Long
  Dim j As Long
  Dim t As Long
  Dim found As Boolean

  Set oStreamUTF8 = CreateObject("ADODB.Stream")

  With oStreamUTF8
    .Charset = "UTF-8"
    .Type = 2 'adTypeText
    .Open
    .LoadFromFile "F:\Abe Files\My Downloads\Codes\UNIRECEIPTS.TXT"
    data = .ReadText
    .Close
  End With

  ArrFileTxt = Split(data, vbCrLf)

  found = False
  For i = 50000 To UBound(ArrFileTxt)
    If InStr(ArrFileTxt(i), "/2022") Then
      Debug.Print "True"
      i = i - 15
      j = i
      found = True
      Exit For
    End If
  Next

  If found Then
    With oStreamUTF8
      .Charset = "UTF-8"
      .Type = 2 'adTypeText
      .Open
      For t = j To UBound(ArrFileTxt)
        .WriteText Trim(ArrFileTxt(t)) & vbCrLf
      Next
      .Position = 3 'skip byte order mark
    End With
    Set oStreamUTF8NoBOM = CreateObject("ADODB.Stream")
    With oStreamUTF8NoBOM
      .Type = 1 'adTypeBinary
      .Open
      oStreamUTF8.CopyTo oStreamUTF8NoBOM
      .SaveToFile "F:\Abe Files\My Downloads\Codes\UNIRECEIPTSNEW.TXT", 2 'adSaveCreateOverWrite
    End With
    oStreamUTF8.Close
    oStreamUTF8NoBOM.Close
  End If

End Sub
