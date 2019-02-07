FormatTime, TimeString ,, HHmm
TimeString2 := TimeString + 1
data := ""
FileRead, data, przerwy\queuelist
data := variableclearenter(data)
start:
sleep 10000
Gui, Destroy
FormatTime, TimeString ,, HHmm
if ( Timestring > TimeString2)
	{
	FileRead, datachanged, przerwy\queuelist
	datachanged := variableclearenter(datachanged)
	sleep 2000
	if (data != datachanged)
		{
		data := variableclearenter(data)
		queuelistrewrite(data)
		goto, start
		}
	FileRead, checkin, przerwy\checkin
	checkin := variableclearenter(checkin)
	datachanged := ""
	Loop, Read, przerwy\queuelist
		{
		if InStr(checkin, A_LoopReadLine)
			{
			datachanged .= "" A_LoopReadLine "`n"
			}
		}
	datachanged := variableclearenter(datachanged)
	data := variableclearenter(data)
	if (data != datachanged)
		{
		data := datachanged
		queuelistrewrite(datachanged)
		}
	againcheckin:
	FileDelete, przerwy\checkin
	if (ErrorLevel != 0)
	{
	sleep 1000
	goto, againcheckin
	}
	FormatTime, TimeString ,, HHmm
	TimeString2 := TimeString + 2
	}
if FileExist("przerwy\addqueue")
	{
	toadd := ""
	FileRead, toadd, przerwy\addqueue
	If InStr(data, toadd)
		{
		toadd := ""
		}
	data .= toadd
	data := variableclearenter(data)
	queuelistrewrite(data)
	again:
	FileDelete, przerwy\addqueue
	if (ErrorLevel != 0)
		{
		sleep 1000
		goto, again
		}
	}
if FileExist("przerwy\rmqueue")
	{
	toremove := ""
	FileRead, toremove, przerwy\rmqueue
	toremove := variableclearenter(toremove)
	data := StrReplace(data, toremove)
	data := variableclearenter(data)
	queuelistrewrite(data)
	again5:
	FileDelete, przerwy\rmqueue
		if (ErrorLevel != 0)
			{
			sleep 1000
			goto, again5
			}
	}
goto, start
queuelistrewrite(data)
	{
	variableclearenter(data)
	deleteagain:
	FileDelete, przerwy\queuelist
	if (ErrorLevel != 0)
			{
			sleep 1000
			goto, deleteagain
			}
	FileAppend,%data%, przerwy\queuelist
	sleep 5000
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