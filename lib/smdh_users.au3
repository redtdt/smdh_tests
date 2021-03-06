#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <SendMessage.au3>
#include <WindowsConstants.au3>
#include "unit_test.au3"
#include "smdh_gui_utils.au3"

Global Const $ADMIN = "Admin"
Global Const $SIN_RESTRICCIONES = "Sin restricciones"
Global Const $CAPTURA_CONSULTA_REPORTES = "Captura, consulta y reportes"
Global Const $REPORTES_CONSULTA= "Reportes y consulta"
Global Const $SOLO_LECTURA = "Solo lectura"
Global Const $SIN_ACCESO = "Sin acceso"
Global Const $DEFAULT_ACCESS = "Captura, consulta y reportes"

; Login as admin
Func SMDH_Login($user, $passwd, $level)
	UTLogInitTest( "SMDH_Login", $user & ", " & $passwd & ", " & $level);
	UTAssert( WinActive("Men� general") )
	UTAssert( ControlSetText("Men� general", "", "[CLASS:Edit; INSTANCE:1]", $user) )
	UTAssert( ControlSetText("Men� general", "", "[CLASS:Edit; INSTANCE:2]", $passwd) )
	UTAssert( ControlClick("Men� general", "", "[CLASS:Button; INSTANCE:5]") )
	If ($level == $ADMIN) Then
		UTAssert( WinWaitActive("Men� general", "Administraci�n de usuari@s", 20) )
	ElseIf ($level == $SIN_RESTRICCIONES) Then
		UTAssert( WinWaitActive("Men� general", "Manejo de Casos.", 10) ) ; TODO: Check
	ElseIf ($level == $CAPTURA_CONSULTA_REPORTES) Then
		UTAssert( WinWaitActive("Men� general", "Manejo de Casos.", 10) ) ; TODO: Check
	ElseIf ($level == $REPORTES_CONSULTA) Then
		UTAssert( WinWaitActive("Men� general", "Manejo de Casos.", 10) ) ; TODO: Check
	ElseIf ($level == $SOLO_LECTURA) Then
		UTAssert( WinWaitActive("Men� general", "Manejo de Casos.", 10) ) ; TODO: Check
	ElseIf ($level == $SIN_ACCESO) Then
		UTAssert( WinWaitActive("Men� general", "Manejo de Casos.", 10) ) ; TODO: Check
	EndIf
	UTLogEndTestOK()
EndFunc

; Create user
Func SMDH_UserCreate($user, $passwd)
	UTLogInitTest( "SMDH_UserCreate", $user & ", " & $passwd );
	UTAssert( WinActive("Men� general") )
	UTAssert( ControlClick("Men� general", "Administraci�n de usuari@s", "[CLASS:Button; INSTANCE:6]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	UTAssert( ControlClick("Usuarias y usuarios", "Nuev@ usuari@", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Nombre de la persona", "", 5) )
	UTAssert( ControlSetText("Nombre de la persona", "", "[CLASS:Edit; INSTANCE:1]", $user) )
	UTAssert( ControlClick("Nombre de la persona", "Seleccionar", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Contrase�a", "", 5) )
	UTAssert( ControlSetText("Contrase�a", "", "[CLASS:Edit; INSTANCE:1]", $passwd) )
	UTAssert( ControlClick("Contrase�a", "Seleccionar", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	Local $hUserList = ControlGetHandle("Usuarias y usuarios","","[CLASS:ListBox; INSTANCE:1]")
	UTAssert( _GUICtrlListBox_FindString($hUserList, $user, True) >= 0)
	UTAssert( Winclose("Usuarias y usuarios", "") )
	Sleep(1000);
	UTLogEndTestOK()
EndFunc

; User Exists
Func SMDH_UserExists($user)
	UTAssert( WinActive("Men� general") )
	UTAssert( ControlClick("Men� general", "Administraci�n de usuari@s", "[CLASS:Button; INSTANCE:6]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	Local $hUserList = ControlGetHandle("Usuarias y usuarios","","[CLASS:ListBox; INSTANCE:1]")
	Local $user_idx = _GUICtrlListBox_FindString($hUserList, $user, True)
	UTAssert( ControlClick("Usuarias y usuarios", "Cerrar", "[CLASS:Button; INSTANCE:3]") )
	Sleep(1000);
	return ( $user_idx >= 0 )
EndFunc

; Delete user
Func SMDH_UserDelete($user, $assert = True)
	UTLogInitTest( "SMDH_UserDelete", $user & ", " & $assert );
	UTAssert( WinActive("Men� general") )
	UTAssert( ControlClick("Men� general", "Administraci�n de usuari@s", "[CLASS:Button; INSTANCE:6]") )
	UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
	Local $hUserList = ControlGetHandle("Usuarias y usuarios","","[CLASS:ListBox; INSTANCE:1]")
	Local $user_idx = _GUICtrlListBox_FindString($hUserList, $user, True)
	If ($assert) Then
		UTAssert( $user_idx >= 0)
	ElseIf ($user_idx < 0) Then
		UTAssert( Winclose("Usuarias y usuarios", "") )
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hUserList, $user_idx, "left", False, 2)
	UTAssert( ControlClick("Usuarias y usuarios", "Baja de usuari@", "[CLASS:Button; INSTANCE:2]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( _GUICtrlListBox_FindString($hUserList, $user, True) < 0)
	UTAssert( Winclose("Usuarias y usuarios", "") )
	Sleep(1000);
	UTLogEndTestOK()
EndFunc

; Create user
Func SMDH_UserSetAccessLevel($user, $level)
	UTLogInitTest( "SMDH_UserSetAccessLevel", $user & ", " & $level );
	UTAssert( WinActive("Men� general") )
	UTAssert( ControlClick("Men� general", "Administraci�n de usuari@s", "[CLASS:Button; INSTANCE:6]") )
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
	UTAssert( WinActive("Men� general") )
	UTAssert( ControlClick("Men� general", "Administraci�n de usuari@s", "[CLASS:Button; INSTANCE:6]") )
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

Func SMDH_User_Has_AccessLevel($user, $level)
	UTAssert( WinActive("Men� general") )
	UTAssert( ControlClick("Men� general", "Administraci�n de usuari@s", "[CLASS:Button; INSTANCE:6]") )
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
	return ($level_str == $level)
EndFunc
