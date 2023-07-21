Sub ExportModule()

    Dim wbExport As Workbook
    Dim wbImport As Workbook
    Dim mdlModule As VBComponent   

    '要导出的模块所在的工作簿
    Set wbExport =Workbooks("VBAProgram52.xlsm")
    '要导入模块的工作簿
    Set wbImport =Workbooks("ExportToWorkbook.xlsm")
    '遍历代码模块
    For Each mdlModule In wbExport.VBProject.VBComponents
        '本代码所在的模块除外
        If mdlModule.Name <>"ExportModule" Then
            '将模块导出到临时文件夹中
            mdlModule.Export("C:\temp\" & mdlModule.Name & ".bas")
            '再将临时文件夹中的模块导入到指定工作簿
           wbImport.VBProject.VBComponents.Import ("C:\temp\" &mdlModule.Name & ".bas")
        End If
    Next mdlModule

    MsgBox "所有模块导出成功!"
End Sub