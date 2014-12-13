'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Sirgold's AWESOME RegExp to match dirty links
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Set RegularExpressionObject = CreateObject("VBScript.RegExp") 
With RegularExpressionObject
 .Pattern = "\b(https?|ftp|file)://[-A-Z0-9+&@#/%?=~_|!:,.;]*[-A-Z0-9+&@#/%=~_|]"
 .IgnoreCase = True
 .Global = True
End With

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Read from file
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
If WScript.Arguments.Count = 0 Then
  WScript.Echo "Missing source file to parse. Aborting." & vbCrLf & vbCrLf & "Drop the file to parse on the script from Windows. Sirgold RULES!"
  Wscript.Quit
End If

strFileToParse = WScript.Arguments(0)

Const ForReading = 1
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strFileToParse, ForReading)

strContents = objFile.ReadAll
objFile.Close

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Extract matches
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Set objMatches = RegularExpressionObject.Execute(strContents)

For Each objMatch in objMatches
  strLinks = strLinks & objMatch.value & vbCrLf
Next

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Process Results
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
If strLinks = "" Then
  WScript.Echo "No Links Found..."
  WScript.Quit
End If

Const ForWriting = 2
strCurDate = Year(now) & Month(now) & Day(now) & Hour(now) & Minute(now) & Second(now) 'Add timestamp to the filename to prevent overwriting
strFileWrite = "links-.txt"
objFSO.CreateTextFile(strFileWrite)
Set objFile = objFSO.OpenTextFile(strFileWrite, ForWriting)
objFile.WriteLine strLinks
objFile.Close
'WScript.Echo "Sirgold RULES, done! Check: " & strFileWrite