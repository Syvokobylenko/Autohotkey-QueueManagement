FormatTime, TimeString ,, yyMM
if ( TimeString != "1901") and ( TimeString != "1902")
	{
	MsgBox, Wesja nieaktualna.
	ExitApp
	}
MsgBox, Witaj w Aplikacji przerwy! Autor - Maksym Syvokobylenko. Kod źródłowy jest własnością Maksyma Syvokobylenko. Aplikacja udostępniona do użytkowania przez CompanyNameHidden Główny alfa tester - Patrycja Florkowska! 
MsgBox, 
(
1.Podajemy login, a następnie wciskamy ok.
2.Po kilku sekundach powinno wyskoczyć okienko informujące o statusie.
3.Jeśli nie jesteśmy na przerwie, możemy się zapisać klikając dodaj do kolejki.
4.Po dodaniu do kolejki czekamy na zapisanie. Status można sprawdzić klikając H na pasku.
5.W momencie przyznania przerwy wyskoczy nam powiadomienie które należy zaakceptować w ciągu 3ch minut.
6.Po zaakceptowaniu kończymy połączenie i wychodzimy na przerwę.
7.Po powrocie z przerwy wciskamy koniec przerwy. Czekamy na zapisanie.
8.W razie błędów otwieramy aplikację jeszcze raz i klikamy tak na pojawiające się okienko (single instance).
Instrukcja autorstwa Klaudii Szymoniak.
)
login := ""
if FileExist("login.ini")
	{
	FileRead, login, login.ini
	goto, startlogin
	}
Gui, Destroy
InputBox, login, Podaj Swój Login do SoftwareNameHidden (imie.nazwisko):, Podaj Swój Login do SoftwareNameHidden (imie.nazwisko):,,350,150,,,,, %loginfile%
if ErrorLevel
	{
	MsgBox Błąd Loginu - Aplikacja jest wyłączana.
	ExitApp
	}
sleep 2000
FileAppend,%login%, login.ini
startlogin:
if (login = "")
	{
	MsgBox Błąd Loginu - Aplikacja jest wyłączana.
	ExitApp
	}
loginline := "" login "`n"
start:
GuiClose:
if !FileExist("przerwyV2\queuelist")
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
Loop, Read, przerwyV2\queuelist
	{
	list := A_LoopReadLine
	If (list = login)
		{
		inqueue := True
		break
		}
	count += 1
	}
FileRead, data, przerwyV2\queuelist
FileRead, quantity, przerwyV2\liczbaprzerw
If inqueue
	{
	if (count > quantity)
		{
		checkin := ""
		Gui, Destroy
		Gui, Add, Text,, Jesteś %count%. w kolejce.
		Gui, Add, Text,, Ilość osób na przerwie: %quantity%.
		Gui, Add, Text,ym, Kolejka:
		Gui, Add, Text,,%data%
		Gui, Add, Button, default, Usun_z_Kolejki
		Gui, Show, Minimize , Zapisano na przerwę.
		sleep 30000
		goto, start
		}
	else
		{
		ButtonAkceptuję:
		Gui, Destroy
		Gui, Add, Text,, Otrzymujesz przerwę po powrocie wciśnij:
		Gui, Add, Button, default, Koniec_Przerwy
		Gui, Show,, Możesz wyjść na przerwę.
		sleep 90000
		goto, ButtonAkceptuję
		}
	}
Else
	{
	Gui, Destroy
	display := count - 1 
	Gui, Add, Text,, Nie jesteś w kolejce. Ilość osób w kolejce: %display%
	Gui, Add, Text,, Ilość osób na przerwie: %quantity%.
	Gui, Add, Text,ym, Kolejka:
	Gui, Add, Text,,%data%
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
if !FileExist("przerwyV2\rmqueue") and !FileExist("przerwyV2\addqueue")
	{
	FileAppend,%loginline%, przerwyV2\rmqueue
	goto, aftertask
	}
sleep 20000
goto, ButtonKoniec_Przerwy
ButtonDodaj_do_kolejki:
Gui, Destroy
action := "dodaj"
Gui, Add, Text,, Oczekiwanie na serwer. Nie wyłączaj programu!
Gui, Show, Minimize , Przetwarzanie.
if !FileExist("przerwyV2\rmqueue") and !FileExist("przerwyV2\addqueue")
	{
	FileAppend,%loginline%, przerwyV2\addqueue
	goto, aftertask
	}
sleep 20000
goto, ButtonDodaj_do_kolejki
aftertask:
action := "aftertask"
if !FileExist("przerwyV2\rmqueue") and !FileExist("przerwyV2\addqueue")
	{
	action := ""
	goto, start
	}
sleep 10000
goto, aftertask