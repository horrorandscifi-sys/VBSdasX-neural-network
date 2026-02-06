' English version / AI Neural Core V3.0 + Logger
On Error Resume Next
Set fs = CreateObject("Scripting.FileSystemObject")
Set args = WScript.Arguments

' Пути к файлам
brainFile = "data ∕/brain.db"
logFile = "data ∕/English version ∕ user_queries.log"

If args.Count = 0 Then
    WScript.Echo "[AI]: Standby mode. No input detected."
    WScript.Quit
End If

question = args(0)
found = False

' --- LOGGING SYSTEM ---
Set fLog = fs.OpenTextFile(logFile, 8, True)
fLog.WriteLine "[" & Now & "] USER: " & question
' ----------------------

WScript.Sleep 800 ' Имитация раздумий

If fs.FileExists(brainFile) Then
    Set f = fs.OpenTextFile(brainFile, 1)
    Do Until f.AtEndOfStream
        line = f.ReadLine
        If InStr(line, "|") > 0 Then
            parts = Split(line, "|")
            If InStr(LCase(question), LCase(parts(0))) > 0 Then
                response = parts(1)
                WScript.Echo "[AI]: " & response
                fLog.WriteLine "[" & Now & "] AI: " & response
                found = True
                Exit Do
            End If
        End If
    Loop
    f.Close
End If

If Not found Then
    WScript.Echo "[AI]: Data not found. Initiating learning mode..."
    WScript.StdOut.Write "Suggest a response: "
    newAnswer = WScript.StdIn.ReadLine
    
    If newAnswer <> "" Then
        Set f = fs.OpenTextFile(brainFile, 8, True)
        f.WriteLine LCase(question) & "|" & newAnswer
        f.Close
        WScript.Echo "[SYSTEM]: Neural link updated."
        fLog.WriteLine "[" & Now & "] SYSTEM: Learned new response."
    End If
End If

fLog.WriteLine "---------------------------------------"
fLog.Close
