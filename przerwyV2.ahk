FormatTime, TimeString ,, yyMM
if ( TimeString != "1901")
	{
	MsgBox, Wesja nieaktualna.
	ExitApp
	}
MsgBox, Witaj w Aplikacji przerwy! Autor - Maksym Syvokobylenko. Kod źródłowy jest własnością Maksyma Syvokobylenko. Aplikacja udostępniona do użytkowania przez CompanyNameHidden
Gui, Destroy
login := ""
Gui, Add, Text,, Podaj Swój Login do SoftwareNameHidden (imie.nazwisko):
Gui, Add, Edit, vlogin w135 ym,
Gui, Show, , Logowanie
KeyWait, enter, D
KeyWait, enter
Gui, Submit
start:
busy := ""
GuiClose:
Gui, Destroy
if (login = "")
	{
	MsgBox Błąd Loginu - Aplikacja jest wyłączana.
	ExitApp
	}
destroy = 0
number = 1
list := ""
inqueue := False
Loop, Read, przerwy\listaprzerw
	{
	list := A_LoopReadLine
	If (list = login)
		{
		inqueue := True
		break
		}
	number += 1
	}
Loop, Read, przerwy\liczbaprzerw
	{
	quantity := A_LoopReadLine
	}
If inqueue
	{
	if (number > quantity)
		{
		Gui, Destroy
		Gui, Add, Text,, Pozycja w kolejce: %number%.
		Gui, Add, Text,, Ilość przerw: %quantity%.
		Gui, Show, Minimize , Zapisano na przerwę.
		checkin := ""
		Loop, Read, przerwy\checkin
			{
			checkin .= "" A_LoopReadLine "`n"
			}
		If not InStr(checkin, login)
			{
			FileAppend,%login%, przerwy\checkin
			}
		checkin := ""
		sleep 30000
		goto, start
		}
	else
		{
		Gui, Destroy
		Gui, Add, Text,, Zaakceptuj swoją przerwę (inaczej ją stracisz)!
		Gui, Add, Button, default, Akceptuję
		Gui, Show,, Masz 3 minuty!
		sleep 180000
		Gui, Destroy
		goto, ButtonKoniec_Przerwy
		ButtonAkceptuję:
		Gui, Destroy
		Gui, Add, Text,, Zakończ połączenie i kliknij:
		Gui, Add, Button, default, Wychodze_na_przerwę
		Gui, Show,, Rozpocznij przerwę
		Akceptacja:
		checkin := ""
		Loop, Read, przerwy\checkin
			{
			checkin .= "" A_LoopReadLine "`n"
			}
		If not InStr(checkin, login)
			{
			FileAppend,%login%, przerwy\checkin
			}
		checkin := ""
		sleep 30000
		goto, Akceptacja
		ButtonWychodze_na_przerwę:
		Gui, Destroy
		Gui, Add, Text,, Możesz wyjść na przerwę.
		Gui, Add, Button, default, Koniec_Przerwy
		Gui, Show,, Przerwa!
		goto, Akceptacja
		}
	}
Else
	{
	busy := ""
	Loop, Read, przerwy\busy
		{
		busy := A_LoopReadLine
		}
	if (busy != "")
		{
		sleep 5000
		goto, start
		}
	Gui, Destroy
	Gui, Add, Text,, Nie jesteś w kolejce. Ilość osób: %number%.
	Gui, Add, Text,, Ilość przerw: %quantity% .
	Gui, Add, Button, default, Dodaj_do_kolejki
	Gui, Show, , Nie jesteś w kolejce.
	sleep, 214748364
	}
sleep, 214748364
ButtonKoniec_Przerwy:
Gui, Destroy
FormatTime, TimeString ,, HHmm
TimeString2 := TimeString + 2
checkin3:
busy := ""
Loop, Read, przerwy\busy
	{
	busy := A_LoopReadLine
	}
if (busy = "")
	{
	FileAppend,%login%, przerwy\busy
	sleep 5000
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
	goto checkin3
	}
number := 1
list := ""
inqueue := True
Loop, Read, przerwy\listaprzerw
	{
	list := A_LoopReadLine
	If (list = login)
		{
		break
		}
	number += 1
	}
destroy := number
ButtonDodaj_do_kolejki:
Gui, Destroy
FormatTime, TimeString ,, HHmm
TimeString2 := TimeString + 2
checkin4:
busy := ""
Loop, Read, przerwy\busy
	{
	busy := A_LoopReadLine
	}
if (busy = "")
	{
	FileAppend,%login%, przerwy\busy
	sleep 5000
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
	goto checkin4
	}
data := ""
Loop, Read, przerwy\listaprzerw
	{
	if (destroy != 1)
		{
		data .= "" A_LoopReadLine "`n"
		}
	destroy -= 1
	}
destroy = 0
FileDelete, przerwy\listaprzerw
sleep 5000
if inqueue
	{
	FileAppend,%data%, przerwy\listaprzerw
	}
else
	{
	FileAppend,%data%%login%, przerwy\listaprzerw
	}
FileDelete, przerwy\busy
goto, start
