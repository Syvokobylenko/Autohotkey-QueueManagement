FormatTime, TimeString ,, yyMM
if ( TimeString != "1901")
	{
	MsgBox, Wesja nieaktualna.
	ExitApp
	}
start:
checkin := ""
data := ""
Loop, Read, przerwy\checkin
	{
	checkin .= "" A_LoopReadLine "`n"
	}
Loop, Read, przerwy\listaprzerw
	{
	if InStr(checkin, A_LoopReadLine)
		{
		datachanged .= "" A_LoopReadLine "`n"
		}
	}
Loop, Read, przerwy\listaprzerw
	{
	data .= "" A_LoopReadLine "`n"
	}
if (data != datachanged)
	{
	FormatTime, TimeString ,, HHmm
	TimeString2 := TimeString + 2
	checkin1:
	busy := ""
	Loop, Read, przerwy\busy
		{
		busy := A_LoopReadLine
		}
	if (busy = "")
		{
		FileAppend,%login%, przerwy\busy
		sleep 2000
		Loop, Read, przerwy\busy
			{
			busy := A_LoopReadLine
			}
		}
	if (busy != login)
		{
		FormatTime, TimeString ,, HHmm
		if ( Timestring > TimeString2)
			{
			FileDelete, przerwy\busy
			TimeString2 := TimeString + 2
			}
		sleep 15000
		goto checkin1
		}
	FileDelete, przerwy\listaprzerw
	FileAppend,%data%, przerwy\listaprzerw
	FileDelete, przerwy\checkin
	}
sleep 5000
FileDelete, przerwy\busy
sleep 6000000
goto, start
sleep, 214748364
