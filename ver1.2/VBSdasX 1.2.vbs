' English version / AI Neural Core V2.0
On Error Resume Next
Set fs = CreateObject("Scripting.FileSystemObject")
Set args = WScript.Arguments

' Фикс ошибки: проверка наличия аргумента
If args.Count = 0 Then
    WScript.Echo "[AI]: System Standby. Please provide a query."
    WScript.Quit
End If

question = LCase(args(0))
brainFile = "data ∕/brain.db"
found = False

' Имитация анализа данных
WScript.Sleep 1000 

If fs.FileExists(brainFile) Then
    Set f = fs.OpenTextFile(brainFile, 1)
    Do Until f.AtEndOfStream
        line = f.ReadLine
        If InStr(line, "|") > 0 Then
            parts = Split(line, "|")
            If InStr(question, LCase(parts(0))) > 0 Then
                WScript.Echo "[AI]: " & parts(1)
                found = True
                Exit Do
            End If
        End If
    Loop
    f.Close
End If

' Режим обучения, если ответ не найден
If Not found Then
    WScript.Echo "[AI]: Unknown query. Teach me."
    WScript.StdOut.Write "Enter response for '" & question & "': "
    newAnswer = WScript.StdIn.ReadLine
    
    If newAnswer <> "" Then
        Set f = fs.OpenTextFile(brainFile, 8, True) ' 8 = Append mode
        f.WriteLine(question & "|" & newAnswer)
        f.Close
        WScript.Echo "[SYSTEM]: Neural database updated."
    End If
End If
