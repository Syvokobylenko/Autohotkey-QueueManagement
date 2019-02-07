FormatTime, TimeString ,, yyMM
if ( TimeString != "1901") and ( TimeString != "1902")
	{
	MsgBox, Wesja nieaktualna.
	ExitApp
	}
start:
FileRead, iloscprzerwfile, przerwyV2\liczbaprzerw
Gui, Destroy
GuiClose:
count := 0
list := []
inqueue := False
Loop, Read, przerwyV2\queuelist
	{
	count += 1
	list[count] := A_LoopReadLine
	}
if (count > 35)
	{
	MsgBox, Za dużo osób w kolejce, nie usuwaj osób powyżej 35. Może wystapić błąd. Proszę o ostrożność.
	}
FileRead, data, przerwyV2\queuelist
Gui, Destroy
Gui, Add, Button,, Zmien_Ilosc_Przerw
Gui, Add, Text,,Usuń z kolejki:
count2 := 0
count3 := count
Loop
	{
	if (count3 = 0)
		{
		break
		}
	count2 += 1
	Gui, Add, Button,, Usun%count2%
	count3 -= 1
	}
Gui, Add, Text,ym, Przerw:%iloscprzerwfile%
Gui, Add, Text,, Kolejka:
count2 := 0
count3 := count
Loop
	{
	if (count3 = 0)
		{
		break
		}
	count2 += 1
	Gui, Add, Text,, % list[count2]
	count3 -= 1
	}
Gui, Show,, Kolejka na przerwy.
return
ButtonZmien_Ilosc_Przerw:
Gui, Destroy
FileRead, iloscprzerwfile, przerwyV2\liczbaprzerw
InputBox, iloscprzerw, Podaj Ilość przerw:,Podaj Ilość przerw:,,350,150,,,,, %iloscprzerwfile%
Gui, Destroy
Gui, Add, Text,, Przetwarzanie. Nie wyłączaj programu!
Gui, Show,, Przetwarzanie.
FileDelete, przerwyV2\liczbaprzerw
Sleep 3000
FileDelete, przerwyV2\liczbaprzerw
Sleep 3000
FileAppend,%iloscprzerw%, przerwyV2\liczbaprzerw
sleep 7000
goto, start
ButtonUsun1:
UsunZkolejki(list[1])
goto, start
ButtonUsun2:
UsunZkolejki(list[2])
goto, start
ButtonUsun3:
UsunZkolejki(list[3])
goto, start
ButtonUsun4:
UsunZkolejki(list[4])
goto, start
ButtonUsun5:
UsunZkolejki(list[5])
goto, start
ButtonUsun6:
UsunZkolejki(list[6])
goto, start
ButtonUsun7:
UsunZkolejki(list[7])
goto, start
ButtonUsun8:
UsunZkolejki(list[8])
goto, start
ButtonUsun9:
UsunZkolejki(list[9])
goto, start
ButtonUsun10:
UsunZkolejki(list[10])
goto, start
ButtonUsun11:
UsunZkolejki(list[11])
goto, start
ButtonUsun12:
UsunZkolejki(list[12])
goto, start
ButtonUsun13:
UsunZkolejki(list[13])
goto, start
ButtonUsun14:
UsunZkolejki(list[14])
goto, start
ButtonUsun15:
UsunZkolejki(list[15])
goto, start
ButtonUsun16:
UsunZkolejki(list[16])
goto, start
ButtonUsun17:
UsunZkolejki(list[17])
goto, start
ButtonUsun18:
UsunZkolejki(list[18])
goto, start
ButtonUsun19:
UsunZkolejki(list[19])
goto, start
ButtonUsun20:
UsunZkolejki(list[20])
goto, start
ButtonUsun21:
UsunZkolejki(list[21])
goto, start
ButtonUsun22:
UsunZkolejki(list[22])
goto, start
ButtonUsun23:
UsunZkolejki(list[23])
goto, start
ButtonUsun24:
UsunZkolejki(list[24])
goto, start
ButtonUsun25:
UsunZkolejki(list[25])
goto, start
ButtonUsun26:
UsunZkolejki(list[26])
goto, start
ButtonUsun27:
UsunZkolejki(list[27])
goto, start
ButtonUsun28:
UsunZkolejki(list[28])
goto, start
ButtonUsun29:
UsunZkolejki(list[29])
goto, start
ButtonUsun30:
UsunZkolejki(list[30])
goto, start
ButtonUsun31:
UsunZkolejki(list[31])
goto, start
ButtonUsun32:
UsunZkolejki(list[32])
goto, start
ButtonUsun33:
UsunZkolejki(list[33])
goto, start
ButtonUsun34:
UsunZkolejki(list[34])
goto, start
ButtonUsun35:
UsunZkolejki(list[35])
goto, start

UsunZkolejki(variable)
	{
	Koniec_Przerwy:
	Gui, Destroy
	Gui, Add, Text,, Oczekiwanie na serwer. Nie wyłączaj programu!
	Gui, Show,, Przetwarzanie.
	if !FileExist("przerwyV2\rmqueue") and !FileExist("przerwyV2\addqueue")
		{
		FileAppend,%variable%, przerwyV2\rmqueue
		goto, aftertask
		}
	goto, Koniec_Przerwy
	aftertask:
	sleep 5000
	if !FileExist("przerwyV2\rmqueue") and !FileExist("przerwyV2\addqueue")
		{
		return
		}
	goto, aftertask
	}