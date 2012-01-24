#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

Func SMDH_ConfiguracionLocal_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Open");
	UTAssert( WinActive("Menú general") )
	UTAssert( ControlClick("Menú general", "", "Configuración local") )
	UTAssert( WinWaitActive("Opciones", "", 5) )
	Sleep(1000)
	UTLogEndTestOK()
EndFunc

Func SMDH_ConfiguracionLocal_SetServidorLocal()
	UTLogInitTest( "SMDH_ConfiguracionLocal_SetServidorLocal");
	UTAssert( WinActive("Opciones") )
	If ( not GUI_Is_CheckBox_Checked("Opciones","","[CLASS:Button; INSTANCE:4]") ) Then
		UTAssert( ControlClick("Opciones", "", "[CLASS:Button; INSTANCE:4]") )
	EndIf
	UTLogEndTestOK()
EndFunc

Func SMDH_ConfiguracionLocal_SetServidorRemoto($server)
	UTLogInitTest( "SMDH_ConfiguracionLocal_SetServidorRemoto", $server);
	UTAssert( WinActive("Opciones") )
	; uncheck the box
	If ( GUI_Is_CheckBox_Checked("Opciones","","[CLASS:Button; INSTANCE:4]") ) Then
		UTAssert( ControlClick("Opciones", "", "[CLASS:Button; INSTANCE:4]") )
	EndIf
	UTAssert( ControlSetText("Opciones","","[CLASS:Edit; INSTANCE:1]", "") )
	UTAssert( ControlSend("Opciones", "", "[CLASS:Edit; INSTANCE:1]", $server) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ConfiguracionLocal_IsServidorLocal()
	UTLogInitTest( "SMDH_ConfiguracionLocal_IsServidorLocal");
	UTAssert( WinActive("Opciones") )
	UTAssert( GUI_Is_CheckBox_Checked("Opciones","","[CLASS:Button; INSTANCE:4]") )
	UTLogEndTestOK()
EndFunc

Func SMDH_ConfiguracionLocal_IsServidorRemoto($server)
	UTLogInitTest( "SMDH_ConfiguracionLocal_IsServidorRemoto", $server);
	UTAssert( WinActive("Opciones") )
	UTAssert( not GUI_Is_CheckBox_Checked("Opciones","","[CLASS:Button; INSTANCE:4]") )
	UTAssert( ControlGetText("Opciones","","[CLASS:Edit; INSTANCE:1]") == $server )
	UTLogEndTestOK()
EndFunc

Func SMDH_ConfiguracionLocal_Aceptar()
	UTLogInitTest( "SMDH_ConfiguracionLocal_Aceptar");
	Sleep(1000)
	UTAssert( WinActive("Opciones") )
	UTAssert( ControlClick("Opciones", "", "Aceptar") )
	UTAssert( WinWaitActive("Alerta", "", 10) )
	UTAssert( ControlClick("Alerta", "", "Aceptar") )
	UTLogEndTestOK()
EndFunc
