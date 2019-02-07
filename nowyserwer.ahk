FormatTime, TimeString ,, yyMM
if ( TimeString != "1901") and ( TimeString != "1902")
	{
	MsgBox, Wesja nieaktualna.
	ExitApp
	}
data := ""
FileRead, data, przerwyV2\queuelist
data := variableclearenter(data)
start:
sleep 10000
Gui, Destroy
if FileExist("przerwyV2\addqueue")
	{
	toadd := ""
	FileRead, toadd, przerwyV2\addqueue
	If InStr(data, toadd)
		{
		toadd := ""
		}
	data .= toadd
	data := variableclearenter(data)
	queuelistrewrite(data)
	FileDelete, przerwyV2\addqueue
	Sleep 5000
	}
if FileExist("przerwyV2\rmqueue")
	{
	toremove := ""
	FileRead, toremove, przerwyV2\rmqueue
	toremove := variableclearenter(toremove)
	data := StrReplace(data, toremove)
	data := variableclearenter(data)
	queuelistrewrite(data)
	FileDelete, przerwyV2\rmqueue
	Sleep 5000
	}
goto, start
queuelistrewrite(variable)
	{
	variableclearenter(variable)
	FileDelete, przerwyV2\queuelist
	Sleep 3000
	FileDelete, przerwyV2\queuelist
	Sleep 3000
	FileAppend,%variable%, przerwyV2\queuelist
	sleep 7000
	return
	}
variableclearenter(variable)
	{
	Loop
		{
		variable := StrReplace(variable, "`r`n`r`n", "`r`n", Count)
		if Count = 0
			{
			break
			}
		}
	return variable
	}