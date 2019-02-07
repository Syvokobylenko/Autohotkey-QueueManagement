FormatTime, TimeString ,, yyMM
if ( TimeString != "1901")
	{
	MsgBox, Wesja nieaktualna.
	ExitApp
	}
login := ""
FileRead, loginfile, login.ini
MsgBox, Witaj w Aplikacji przerwy! Autor - Maksym Syvokobylenko. Kod źródłowy jest własnością Maksyma Syvokobylenko. Poprawki naniosła Patrycja Florkowska! Aplikacja udostępniona do użytkowania przez CompanyNameHidden
Gui, Destroy
InputBox, login, Podaj Swój Login do SoftwareNameHidden (imie.nazwisko):, Podaj Swój Login do SoftwareNameHidden (imie.nazwisko):,,350,100,,,,, %loginfile%
if ErrorLevel
	{
	MsgBox Błąd Loginu - Aplikacja jest wyłączana.
	ExitApp
	}
if (login = "")
	{
	MsgBox Błąd Loginu - Aplikacja jest wyłączana.
	ExitApp
	}
if (login != loginfile)
	{
	FileDelete, login.ini
	sleep 2000
	FileAppend,%login%, login.ini
	}
loginline := "" login "`n"
start:
GuiClose:
if !FileExist("przerwy\queuelist")
	{
	sleep 5000
	goto, start
	}
if (action = "koniec")
	{
	goto, ButtonKoniec_Przerwy
	}
if (action = "dodaj")
	{
	goto, ButtonDodaj_do_kolejki
	}
if (action = "aftertask")
	{
	goto, aftertask
	}
action := ""
Gui, Destroy
count = 1
list := ""
inqueue := False
Loop, Read, przerwy\queuelist
	{
	list := A_LoopReadLine
	If (list = login)
		{
		inqueue := True
		break
		}
	count += 1
	}
FileRead, quantity, przerwy\liczbaprzerw
If inqueue
	{
	if (count > quantity)
		{
		checkin := ""
		Gui, Destroy
		Gui, Add, Text,, Jesteś %count%. w kolejce.
		Gui, Add, Text,, Ilość osób na przerwie: %quantity%.
		Gui, Add, Button, default, Usun_z_Kolejki
		Gui, Show, Minimize , Zapisano na przerwę.
		FileRead, checkin, przerwy\checkin
		If not InStr(checkin, login)
			{
			FileAppend,%loginline%, przerwy\checkin
			}
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
		FileRead, checkin, przerwy\checkin
		If not InStr(checkin, login)
			{
			FileAppend,%loginline%, przerwy\checkin
			}
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
	Gui, Destroy
	display := count - 1 
	Gui, Add, Text,, Nie jesteś w kolejce. Ilość osób w kolejce: %display%
	Gui, Add, Text,, Ilość osób na przerwie: %quantity%.
	Gui, Add, Button, default, Dodaj_do_kolejki
	Gui, Show, Minimize , Nie jesteś w kolejce.
	sleep 30000
	goto, start
	}
sleep, 214748364
ButtonKoniec_Przerwy:
ButtonUsun_z_Kolejki:
Gui, Destroy
action := "koniec"
Gui, Add, Text,, Oczekiwanie na serwer. Nie wyłączaj programu!
Gui, Show, Minimize , Przetwarzanie.
if !FileExist("przerwy\rmqueue") and !FileExist("przerwy\addqueue")
	{
	FileAppend,%loginline%, przerwy\rmqueue
	goto, aftertask
	}
sleep 20000
goto, ButtonKoniec_Przerwy
ButtonDodaj_do_kolejki:
Gui, Destroy
action := "dodaj"
Gui, Add, Text,, Oczekiwanie na serwer. Nie wyłączaj programu!
Gui, Show, Minimize , Przetwarzanie.
if !FileExist("przerwy\rmqueue") and !FileExist("przerwy\addqueue")
	{
	FileAppend,%loginline%, przerwy\addqueue
	goto, aftertask
	}
sleep 20000
goto, ButtonDodaj_do_kolejki
aftertask:
action := "aftertask"
if !FileExist("przerwy\rmqueue") and !FileExist("przerwy\addqueue")
	{
	action := ""
	goto, start
	}
FileRead, checkin, przerwy\checkin
If not InStr(checkin, login)
	{
	FileAppend,%loginline%, przerwy\checkin
	}
sleep 10000
goto, aftertask