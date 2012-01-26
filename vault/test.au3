#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GuiListBox.au3>
#include <unittest.au3>
; Run SMDH
ConsoleWrite( "[TEST:RUN_SMDH] " );
UTAssert( Run("C:\smdh2\bin\smdh.exe", "c:\smdh2")>0 )
UTAssert( WinWaitActive("Menú general", "", 5) )
ConsoleWrite( "OK" & @CRLF )

; Login as admin
ConsoleWrite( "[TEST:LOGIN_ADMIN] " );
UTAssert( ControlSetText("Menú general", "", "[CLASS:Edit; INSTANCE:1]", "admin") )
UTAssert( ControlSetText("Menú general", "", "[CLASS:Edit; INSTANCE:2]", "gfh325gm") )
UTAssert( ControlClick("Menú general", "", "[CLASS:Button; INSTANCE:5]") )
UTAssert( WinWaitActive("Menú general", "Administración de usuari@s", 5) )
ConsoleWrite( "OK" & @CRLF )

; Create usuario001 with password password001
ConsoleWrite( "[TEST:CREATE_USER] " );
UTAssert( ControlClick("Menú general", "Administración de usuari@s", "[CLASS:Button; INSTANCE:6]") )
UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
UTAssert( ControlClick("Usuarias y usuarios", "Nuev@ usuari@", "[CLASS:Button; INSTANCE:1]") )
UTAssert( WinWaitActive("Nombre de la persona", "", 5) )
UTAssert( ControlSetText("Nombre de la persona", "", "[CLASS:Edit; INSTANCE:1]", "usuario001") )
UTAssert( ControlClick("Nombre de la persona", "Seleccionar", "[CLASS:Button; INSTANCE:1]") )
UTAssert( WinWaitActive("Contraseña", "", 5) )
UTAssert( ControlSetText("Contraseña", "", "[CLASS:Edit; INSTANCE:1]", "password001") )
UTAssert( ControlClick("Contraseña", "Seleccionar", "[CLASS:Button; INSTANCE:1]") )
UTAssert( WinWaitActive("Usuarias y usuarios", "", 5) )
Local $hUserList = ControlGetHandle("Usuarias y usuarios","","[CLASS:ListBox; INSTANCE:1]")
UTAssert( _GUICtrlListBox_FindString($hUserList, "usuario001", True) >= 0)
ConsoleWrite( "OK" & @CRLF )

_GUICtrlListBox_ClickItem($hUserList, 0, "left", False, 2)

UTAssert( Winclose("Menú general", "") )

; recorrer combobox
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:12]")
	Local $hCnt = _GUICtrlComboBox_GetCount($hCombo);
	For $i =0 To $hCnt Step 1
		Local $str
		_GUICtrlComboBoxEx_GetItemText($hCombo, $i, $str)
		MsgBox(0, $i, "A" & $str & "A")
	Next

; recorrer tree
	Local $hTree = ControlGetHandle("País de origen o nacimiento", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hCur = _GUICtrlTreeView_GetFirstItem($hTree)
	While ($hCur <> 0)
		If (_GUICtrlTreeView_GetFirstChild($hTree, $hCur)=0) Then ; leaf
			MsgBox(0, _GUICtrlTreeView_GetText($hTree, $hCur), _GUICtrlTreeView_GetChildCount($hTree, $hCur))
		EndIf
		$hCur = _GUICtrlTreeView_GetNext($hTree, $hCur)
	WEnd
