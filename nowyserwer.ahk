FormatTime, TimeString ,, HHmm
TimeString2 := TimeString + 10
data := ""
FileRead, data, przerwy\queuelist
Loop
	{
	data := StrReplace(data, "`r`n`r`n", "`r`n", Count)
	if Count = 0
		{
		break
		}
	}
start:
sleep 10000
Gui, Destroy
FormatTime, TimeString ,, HHmm
if ( Timestring > TimeString2)
	{
	datachanged := ""
	Loop, Read, przerwy\checkin
		{
		if InStr(data, A_LoopReadLine)
			{
			datachanged .= "" A_LoopReadLine "`n"
			}
		}
	Loop
		{
		datachanged := StrReplace(datachanged, "`r`n`r`n", "`r`n", Count)
		if Count = 0
			{
			break
			}
		}
	if (data != datachanged)
		{
		data := datachanged
		again1:
		FileDelete, przerwy\queuelist
		if (ErrorLevel != 0)
			{
			sleep 1000
			goto, again1
			}
		sleep 5000
		FileAppend,%datachanged%, przerwy\queuelist
		}
	FileDelete, przerwy\checkin
	FormatTime, TimeString ,, HHmm
	TimeString2 := TimeString + 10
	}
if FileExist("przerwy\addqueue")
	{
	FileRead, toadd, przerwy\addqueue
	If InStr(data, toadd)
		{
		again2:
		FileDelete, przerwy\addqueue
		if (ErrorLevel != 0)
			{
			sleep 1000
			goto, again2
			}
		}
	else
		{
		data .= toadd
		Loop
			{
			data := StrReplace(data, "`r`n`r`n", "`r`n", Count)
			if Count = 0
				{
				break
				}
			}
		Loop
			{
			toadd := StrReplace(toadd, "`r`n`r`n", "`r`n", Count)
			if Count = 0
				{
				break
				}
			}
		FileAppend,%toadd%, przerwy\queuelist
		sleep 10000
		again3:
		FileDelete, przerwy\addqueue
		if (ErrorLevel != 0)
			{
			sleep 1000
			goto, again3
			}
		}
	}
if FileExist("przerwy\rmqueue")
	{
	FileRead, toremove, przerwy\rmqueue
	toremove := "" toremove "`r`n"
	data := StrReplace(data, toremove)
	again4:
	FileDelete, przerwy\queuelist
		if (ErrorLevel != 0)
			{
			sleep 1000
			goto, again4
			}
	Loop
		{
		data := StrReplace(data, "`r`n`r`n", "`r`n", Count)
		if Count = 0
			{
			break
			}
		}
	sleep 5000
	FileAppend,%data%, przerwy\queuelist
	again5:
	FileDelete, przerwy\rmqueue
		if (ErrorLevel != 0)
			{
			sleep 1000
			goto, again5
			}
	}
goto, start
