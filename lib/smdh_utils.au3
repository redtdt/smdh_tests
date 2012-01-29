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
	UTAssert( WinWaitActive("Menú general", "", 30) )
	UTLogEndTestOK()
	Return $smdh_pid
EndFunc

Func SMDH_Close()
	UTLogInitTest( "SMDH_Close" );
	UTAssert( Winclose("Menú general", "") )
	UTLogEndTestOK()
EndFunc

Func SMDH_Close_NoAssert()
	Winclose("Menú general", "")
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
	UTAssert( WinActive("Menú general") )
	UTAssert( ControlClick("Menú general", "Manejo de Casos.", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Manejo de Casos", "", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Open")
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR2", "primary", 1, 26, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "casos registrados", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Open")
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR2", "primary", 1, 74, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "NBActos", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Intervenciones_Open")
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR2", "primary", 1, 144, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "Tipo de intervenci", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Open")
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR2", "primary", 1, 222, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "fuente personal", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Personas_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Personas_Open")
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR2", "primary", 1, 283, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "NBPersonas", 10) )
	UTLogEndTestOK()
EndFunc

