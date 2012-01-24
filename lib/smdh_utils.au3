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

Global Const $ADMIN = "Admin"
Global Const $SIN_RESTRICCIONES = "Sin restricciones"
Global Const $CAPTURA_CONSULTA_REPORTES = "Captura, consulta y reportes"
Global Const $REPORTES_CONSULTA= "Reportes y consulta"
Global Const $SOLO_LECTURA = "Solo lectura"
Global Const $SIN_ACCESO = "Sin acceso"

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

Func SMDH_TerminateOnExit()
	OnAutoItExitRegister("SMDH_Terminate")
EndFunc

Func SMDH_Terminate()
	UTLogInitTest( "SMDH_Terminate" );
	UTAssert( ProcessClose($smdh_pid) )
	UTLogEndTestOK()
EndFunc

; Login as admin
Func SMDH_Login($user, $passwd, $level)
	UTLogInitTest( "SMDH_Login", $user & ", " & $passwd & ", " & $level);
	UTAssert( WinActive("Menú general") )
	UTAssert( ControlSend("Menú general", "", "[CLASS:Edit; INSTANCE:1]", $user) )
	UTAssert( ControlSend("Menú general", "", "[CLASS:Edit; INSTANCE:2]", $passwd) )
	UTAssert( ControlClick("Menú general", "", "[CLASS:Button; INSTANCE:5]") )
	If ($level == $ADMIN) Then
		UTAssert( WinWaitActive("Menú general", "Administración de usuari@s", 5) )
	ElseIf ($level == $SIN_RESTRICCIONES) Then
		UTAssert( WinWaitActive("Menú general", "Manejo de Casos.", 5) ) ; TODO: Check
	ElseIf ($level == $CAPTURA_CONSULTA_REPORTES) Then
		UTAssert( WinWaitActive("Menú general", "Manejo de Casos.", 5) ) ; TODO: Check
	ElseIf ($level == $REPORTES_CONSULTA) Then
		UTAssert( WinWaitActive("Menú general", "Manejo de Casos.", 5) ) ; TODO: Check
	ElseIf ($level == $SOLO_LECTURA) Then
		UTAssert( WinWaitActive("Menú general", "Manejo de Casos.", 5) ) ; TODO: Check
	ElseIf ($level == $SIN_ACCESO) Then
		UTAssert( WinWaitActive("Menú general", "Manejo de Casos.", 5) ) ; TODO: Check
	EndIf
	UTLogEndTestOK()
EndFunc

; Create user
Func SMDH_UserCreate($user, $passwd)
	UTLogInitTest( "SMDH_UserCreate", $user & ", " & $passwd );
	UTAssert( WinActive("Menú general") )
	UTAssert( ControlClick("Menú general", "Administración de usuari@s", "[CLASS:Button; INSTANCE:6]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	UTAssert( ControlClick("Usuarias y usuarios", "Nuev@ usuari@", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Nombre de la persona", "", 5) )
	UTAssert( ControlSend("Nombre de la persona", "", "[CLASS:Edit; INSTANCE:1]", $user) )
	UTAssert( ControlClick("Nombre de la persona", "Seleccionar", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Contraseña", "", 5) )
	UTAssert( ControlSend("Contraseña", "", "[CLASS:Edit; INSTANCE:1]", $passwd) )
	UTAssert( ControlClick("Contraseña", "Seleccionar", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	Local $hUserList = ControlGetHandle("Usuarias y usuarios","","[CLASS:ListBox; INSTANCE:1]")
	UTAssert( _GUICtrlListBox_FindString($hUserList, $user, True) >= 0)
	UTAssert( Winclose("Usuarias y usuarios", "") )
	Sleep(1000);
	UTLogEndTestOK()
EndFunc

; Delete user
Func SMDH_UserDelete($user)
	UTLogInitTest( "SMDH_UserDelete", $user );
	UTAssert( WinActive("Menú general") )
	UTAssert( ControlClick("Menú general", "Administración de usuari@s", "[CLASS:Button; INSTANCE:6]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	Local $hUserList = ControlGetHandle("Usuarias y usuarios","","[CLASS:ListBox; INSTANCE:1]")
	Local $user_idx = _GUICtrlListBox_FindString($hUserList, $user, True)
	UTAssert( $user_idx >= 0)
	_GUICtrlListBox_ClickItem($hUserList, $user_idx, "left", False, 2)
	UTAssert( ControlClick("Usuarias y usuarios", "Baja de usuari@", "[CLASS:Button; INSTANCE:2]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( _GUICtrlListBox_FindString($hUserList, $user, True) < 0)
	UTAssert( Winclose("Usuarias y usuarios", "") )
	Sleep(1000);
	UTLogEndTestOK()
EndFunc

; Create user
Func SMDH_UserSetAccessLevel($user, $level)
	UTLogInitTest( "SMDH_UserSetAccessLevel", $user & ", " & $level );
	UTAssert( WinActive("Menú general") )
	UTAssert( ControlClick("Menú general", "Administración de usuari@s", "[CLASS:Button; INSTANCE:6]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	Local $hUserList = ControlGetHandle("Usuarias y usuarios","","[CLASS:ListBox; INSTANCE:1]")
	Local $user_idx = _GUICtrlListBox_FindString($hUserList, $user, True)
	UTAssert( $user_idx >= 0)
	_GUICtrlListBox_ClickItem($hUserList, $user_idx, "left", False, 2)
	Local $hLevelCombo = ControlGetHandle("Usuarias y usuarios","","[CLASS:ComboBox; INSTANCE:1]")
	Local $level_idx = _GUICtrlComboBox_FindStringExact($hLevelCombo, $level);
	UTAssert( $level_idx >= 0)
	UTAssert( _GUICtrlComboBox_SetCurSel($hLevelCombo, $level_idx)>=0 )
	ControlCommand("Usuarias y usuarios","Cambiar nivel de acceso","ComboBox1","SelectString",$level)
	UTAssert( ControlClick("Usuarias y usuarios", "Cerrar", "[CLASS:Button; INSTANCE:3]") )
	Sleep(1000);
	UTLogEndTestOK()
EndFunc

; Create user
Func SMDH_UserCheckAccessLevel($user, $level)
	UTLogInitTest( "SMDH_UserCheckAccessLevel", $user & ", " & $level );
	UTAssert( WinActive("Menú general") )
	UTAssert( ControlClick("Menú general", "Administración de usuari@s", "[CLASS:Button; INSTANCE:6]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	Local $hUserList = ControlGetHandle("Usuarias y usuarios","","[CLASS:ListBox; INSTANCE:1]")
	Local $user_idx = _GUICtrlListBox_FindString($hUserList, $user, True)
	UTAssert( $user_idx >= 0)
	_GUICtrlListBox_ClickItem($hUserList, $user_idx, "left", False, 2)
	Local $hLevelCombo = ControlGetHandle("Usuarias y usuarios","","[CLASS:ComboBox; INSTANCE:1]")
	Local $level_idx = _GUICtrlComboBox_GetCurSel($hLevelCombo)
	UTAssert( $level_idx >= 0)
	Local $level_str
	UTAssert( _GUICtrlComboBox_GetLBText($hLevelCombo, $level_idx, $level_str) >=0 )
	UTAssert( ControlClick("Usuarias y usuarios", "Cerrar", "[CLASS:Button; INSTANCE:3]") )
	Sleep(1000);
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Open");
	UTAssert( WinActive("Menú general") )
	UTAssert( ControlClick("Menú general", "Manejo de Casos.", "[CLASS:Button; INSTANCE:1]") )
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

