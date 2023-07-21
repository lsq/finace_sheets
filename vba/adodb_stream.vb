'https://blog.csdn.net/jessezappy/article/details/106324532
https://blog.csdn.net/chuhe163/article/details/103549144?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-103549144-blog-96280537.235%5Ev38%5Epc_relevant_sort_base2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-103549144-blog-96280537.235%5Ev38%5Epc_relevant_sort_base2&utm_relevant_index=5
'先前说到， 想用 ADODB.Stream 实现GB2312和UTF8编码转换 未果， 找了下， 找到个文章： 《利用ADO STREAM实现GB2312和UTF8编码转换》，
'试了下，在VB和VBA都没问题，但是在 ASP 和 VBS 下面就不成了，原因就是我一直纠结的，adoStream.Write bytes 失败！
'于是又专门找了一下 VBS 下 Byte 数组的定义方法（https://www.jb51.net/article/33247.htm），将上面的《利用ADO STREAM实现GB2312和UTF8编码转换》 代码改造了一下，终于实现了 VBS 和 ASP 下可用的 ADODB.Stream GB2312 和 UTF8 编码转换
'ps: GB2312 转 UTF-8 得到的是一个 Variant 数组，因为用于 Base64 或 MD5 编码时不需要 UTF-8 的标识头“&HEFBBBF”因此输出的数组改造删除了头三字节 &HEFBBBF , 而且原文代码中得到的是一个 Byte 数组，
'不能直接用于 base64 和 MD5 编码，也即：ustr(0) 报错，必须使用 ascb(midb(ustr,i+1,1)) 才能得到可直接操作的数组，参见: e(19) 。 UTF-8 转 GB2312 得到的则是 unicode 字符串
'- ------------------------------------------- -
'  函数说明：GB2312转换为UTF8 去除 头部三字节
'- ------------------------------------------- -
Public Function GB2312ToUTF8(strIn)
  Dim adoStream, ustr, i, outarr()
  Set adoStream = CreateObject("ADODB.Stream")
  adoStream.Charset = "utf-8"
  adoStream.Type = 2 'adTypeText
  adoStream.Open
  adoStream.WriteText strIn
  adoStream.Position = 0
  adoStream.Type = 1 'adTypeBinary
  'msgbox adoStream.size    
  ustr = adoStream.Read()
  'redim Preserve ustr(adoStream.size-1)
  adoStream.Close
  'WScript.Echo VarType(ustr), TypeName(ustr),"ustr"
  'msgbox ascb(midb(ustr,3,1))
  ReDim outarr(UBound(ustr) - 3)
  For i = 3 To UBound(ustr)
    outarr(i - 3) = ascb(midb(ustr,i+1,1))
  Next
  GB2312ToUTF8 = outarr
  'WScript.Echo VarType(outarr), TypeName(outarr)
  set adoStream=nothing
End Function

public function Varr2hexstr(a)  '-------转换 Variant 数组为十六进制字符串
  dim i,S
  For i = 0 To UBound(a)
    S=S & Right("00" & Hex(a(i)), 2)
  Next
  Varr2hexstr=S
End Function

public function HexStr2ByteArr(S) '-------转换十六进制字符串为 Bytes 数组（真,可写入ADODB.Stream.Write）
  Dim xmldoc, node, bytes
  Set xmldoc = CreateObject("Msxml2.DOMDocument") 
  Set node = xmldoc.CreateElement("binary") 
  node.DataType = "bin.hex" 
  'demon.tw 的十六进制值为 
  '64 65 6D 6F 6E 2E 74 77
  'node.Text = "64656D6F6E2E7477"
  node.Text = S
  bytes = node.NodeTypedValue 
  'WScript.Echo VarType(bytes), TypeName(bytes),"bytes"
  set xmldoc=nothing
  set node=nothing	
  HexStr2ByteArr=bytes
End Function

'- ------------------------------------------- -
'  函数说明：UTF8转换为GB2312 As String
'- ------------------------------------------- -
Public Function UTF8ToGB2312(varIn)
  Dim adoStream, bytes, S

  S = "EFBBBF" & Varr2hexstr(varIn)
  bytes = HexStr2ByteArr(s)

  Set adoStream = CreateObject("ADODB.Stream")
  adoStream.Charset = "utf-8"
  adoStream.Type = 1 'adTypeBinary
  adoStream.Open
  adoStream.Write bytes
  adoStream.Position = 0
  adoStream.Type = 2 'adTypeText
  UTF8ToGB2312 = adoStream.ReadText()
  adoStream.Close

  set adoStream=nothing

End Function

Function Bytes2BSTR(vin) 
  Bytes2BSTR = Bytes2Str(vin,"utf-8") 
End FunctionFunction Bytes2Str(vin,charset) 
Dim ms,strRet 
Set ms = Server.CreateObject("ADODB.Stream") '建立流对象
ms.Type = 1 ' Binary 
ms.Open 
ms.Write vin '把vin写入流对象中
ms.Position = 0 '设置流对象的起始位置是0 以设置Charset属性
ms.Type = 2 'Text 
ms.Charset = charset '设置流对象的编码方式为charset 
strRet = ms.ReadText 
'取字符流
ms.close '关闭流对象
Set ms = nothing 
Bytes2Str = strRet 
End Function 
Function Str2Bytes(str,charset) 
  Dim ms,strRet 
  Set ms = CreateObject("ADODB.Stream") '建立流对象
  ms.Type = 2 ' Text 
  ms.Charset = charset '设置流对象的编码方式为charset
  ms.Open 
  ms.WriteText str '把str写入流对象中
  ms.Position = 0 '设置流对象的起始位置是0 以设置Charset属性
  ms.Type = 1 'Binary 
  vout = ms.Read(ms.Size) '取字符流
  ms.close '关闭流对象
  Set ms = nothing 
  Str2Bytes = vout 
End Function

Dim a, d, e
a = "123中文，？αabc"
e = GB2312ToUTF8(a)
msgbox e(19)
d = UTF8ToGB2312(e)    
msgbox d
' 注意： chrB，ascB ，CByte 在 VBS 和 ASP 中都无法得到 8209 Bytes() 的真字节数组。
