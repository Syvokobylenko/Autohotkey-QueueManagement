FormatTime, TimeString ,, yyMM
if ( TimeString != "1901")
	{
	MsgBox, Wesja nieaktualna.
	ExitApp
	}
data := ""
start:
count = 1
count2 = 1
Loop, Read, przerwy\listaprzerw
	{
	count2 += 1
	}
count2 -= 3
Loop, Read, przerwy\listaprzerw
	{
	if (count > 6) and (count < count2)
		{
		datanew .= "" A_LoopReadLine "`n"
		}
	count += 1
	}
if (data != datanew)
	{
	Gui, Destroy
	Gui, Add, Text,, Było:
	Gui, Add, Text,, %data%
	Gui, Add, Text,ym, Jest:
	Gui, Add, Text,, %datanew%
	Gui, Show, Minimize , Zapisano na przerwę.
	}
data := datanew
sleep 10000
goto, start
