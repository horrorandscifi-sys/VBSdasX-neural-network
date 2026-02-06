' English version / AI Neural Core
Set fs = CreateObject("Scripting.FileSystemObject")
Set args = WScript.Arguments
question = LCase(args(0))

' Имитация "нейронного процесса"
WScript.Sleep 1500 

brainFile = "data ∕/brain.db"
found = False

If fs.FileExists(brainFile) Then
    Set f = fs.OpenTextFile(brainFile, 1)
    Do Until f.AtEndOfStream
        line = f.ReadLine
        parts = Split(line, "|")
        If InStr(question, parts(0)) > 0 Then
            WScript.Echo "[AI]: " & parts(1)
            found = True
            Exit Do
        End If
    Loop
    f.Close
End If

If Not found Then
    WScript.Echo "[AI]: My neural network is still learning. Request data for: " & question
End If
