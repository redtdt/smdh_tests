#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <SendMessage.au3>
#include <WindowsConstants.au3>
#include "unit_test.au3"
#include "smdh_gui_utils.au3"

Global $smdh_pid

; Run SMDH
Func SMDH_Run($dir = "C:\smdh2")
	UTLogInitTest( "SMDH_Run", $dir );
	$smdh_pid = Run($dir & "\bin\smdh.exe", $dir)
	UTAssert( $smdh_pid > 0 )
	UTAssert( WinWaitActive("Men� general", "", 30) )
	UTLogEndTestOK()
	Return $smdh_pid
EndFunc

Func SMDH_Close()
	UTLogInitTest( "SMDH_Close" );
	UTAssert( Winclose("Men� general", "") )
	UTLogEndTestOK()
EndFunc

Func SMDH_Close_NoAssert()
	Winclose("Men� general", "")
EndFunc

Func SMDH_TerminateOnExit()
	OnAutoItExitRegister("SMDH_Terminate")
EndFunc

Func SMDH_Terminate()
	UTLogInitTest( "SMDH_Terminate" );
	UTAssert( ProcessClose($smdh_pid) )
	UTLogEndTestOK()
EndFunc

Func SMDH_Terminate_No_Asserts()
	ProcessClose($smdh_pid)
EndFunc

Func SMDH_ManejoDeCasos_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Open");
	UTAssert( WinActive("Men� general") )
	UTAssert( ControlClick("Men� general", "Manejo de Casos.", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Manejo de Casos", "", 5) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_CreateCaso($caso_name)
	UTLogInitTest( "SMDH_ManejoDeCasos_CreateCaso");
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlClick("Manejo de Casos", "", "Nuevo caso") )
	UTAssert( WinWaitActive("Nombre del caso", "", 5) )
	UTAssert( ControlSend("Nombre del caso", "", "[CLASS:Edit; INSTANCE:1]", $caso_name) )
	UTAssert( ControlClick("Nombre del caso", "Seleccionar", "[CLASS:Button; INSTANCE:1]") )
	Sleep(2000)
	Local $hCasosList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:2]")
	UTAssert( _GUICtrlListBox_FindString($hCasosList, $caso_name, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_DeleteCaso($caso_name)
	UTLogInitTest( "SMDH_ManejoDeCasos_DeleteCaso");
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_BusquedaRapida($search)
	UTLogInitTest( "SMDH_ManejoDeCasos_BusquedaRapida");
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlSend("Manejo de Casos", "", "[CLASS:Edit; INSTANCE:10]", $search) )
	UTLogEndTestOK()
EndFunc

