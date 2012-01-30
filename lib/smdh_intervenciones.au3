#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

Local $IntervencioneswTitle = "Manejo de Casos"
Local $IntervencioneswText = "NBIntervenciones"

Func SMDH_ManejoDeCasos_Intervenciones_Nuevo_Quien_Select($victima)
	UTAssert( WinActive("Agregar intervención", "") )
	UTAssert( ControlClick("Agregar intervención","","[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Seleccionar una persona", "", 10) )
	Local $hList = ControlGetHandle("Seleccionar una persona", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $victima)>=0)
	UTAssert( ControlClick("Seleccionar una persona","","[CLASS:Button; INSTANCE:7]") )
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Nuevo_Tipo_Select($tipo)
	UTAssert( WinActive("Agregar intervención", "") )
	UTAssert( ControlClick("Agregar intervención","","[CLASS:Button; INSTANCE:2]") )
	UTAssert( WinWaitActive("Tipo de intervención", "", 10) )
	Local $hTree = ControlGetHandle("Tipo de intervención", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $tipo)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("Tipo de intervención","","[CLASS:Button; INSTANCE:1]") )
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Nuevo($caso, $quien, $tipo)
	UTLogInitTest( "SMDH_ManejoDeCasos_Intervenciones_Nuevo", $caso & ", " & $quien & ", " & $tipo )
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText) )
	; select victima
	UTAssert( ControlClick($IntervencioneswTitle,$IntervencioneswText,"[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Agregar intervención", "", 10) )
	SMDH_ManejoDeCasos_Intervenciones_Nuevo_Quien_Select($quien)
	; verify victima chosen
	UTAssert( WinWaitActive("Agregar intervención", ""), 5 )
	UTAssert( ControlGetText("Agregar intervención", "", "[CLASS:Static; INSTANCE:3]") == $quien )
	; select tipo
	SMDH_ManejoDeCasos_Intervenciones_Nuevo_Tipo_Select($tipo)
	; verify tipo chosen
	UTAssert( WinWaitActive("Agregar intervención", "") )
	UTAssert( ControlGetText("Agregar intervención", "", "[CLASS:Static; INSTANCE:4]") == $tipo )
	; ok
	Local  $a = WinList("Agregar intervención", "")
	For $i = 1 To $a[0][0]
		If BitAND(WinGetState($a[$i][1]), 2) Then
			UTAssert( WinActivate($a[$i][1]) )
			Sleep(500)
			UTAssert( WinActive($a[$i][1]) )
		EndIf
	Next
	UTAssert( ControlClick("Agregar intervención", "", "[CLASS:Button; INSTANCE:3]") )
	; verify
	UTAssert( WinWaitActive($IntervencioneswTitle, $IntervencioneswText, 5) )
	Local $hList = ControlGetHandle($IntervencioneswTitle, $IntervencioneswText, "[CLASS:ListBox; INSTANCE:1]")
	Local $str = $tipo  & "/" & $quien
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Exist($victima, $tipo)
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText) )
	Local $str = $victima & " / " & $tipo
	Local $hList = ControlGetHandle($IntervencioneswTitle,"Actos registrados","[CLASS:ListBox; INSTANCE:7]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	Return $item_idx >= 0
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Select($caso, $quien, $tipo)
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText) )
	Local $str = $tipo & "/" & $quien
	Local $hList = ControlGetHandle($IntervencioneswTitle, $IntervencioneswText, "[CLASS:ListBox; INSTANCE:1]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc


Func SMDH_ManejoDeCasos_Intervenciones_Borrar($caso, $quien, $tipo, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Intervenciones_Borrar", $caso & ", " & $quien & ", " & $tipo);
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText) )
	Local $str = $tipo & "/" & $quien
	Local $hList = ControlGetHandle($IntervencioneswTitle, $IntervencioneswText, "[CLASS:ListBox; INSTANCE:1]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick($IntervencioneswTitle, $IntervencioneswText, "[CLASS:Button; INSTANCE:14]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText) )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipoi, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion", $caso & ", " & $quien & ", " & $tipoi & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, $IntervencioneswTitle , $IntervencioneswText,"[CLASS:ComboBox; INSTANCE:1]", "[CLASS:Edit; INSTANCE:7]", "[CLASS:Edit; INSTANCE:6]","[CLASS:Edit; INSTANCE:5]", "[CLASS:Button; INSTANCE:4]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Set_Sobre_Quien($caso, $quien, $tipoi, $persona)
	UTLogInitTest( "SMDH_ManejoDeCasos_Intervenciones_Set_Sobre_Quien", $caso & ", " & $quien & ", " & $tipoi & ", " & $persona );
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText) )
	UTAssert( ControlClick($IntervencioneswTitle,$IntervencioneswText,"[CLASS:Button; INSTANCE:5]") )
	UTAssert( WinWaitActive("Seleccionar una persona", "", 10) )
	Local $hList = ControlGetHandle("Seleccionar una persona", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $persona)>=0)
	UTAssert( ControlClick("Seleccionar una persona","","[CLASS:Button; INSTANCE:7]") )
	;verify
	UTAssert( WinWaitActive($IntervencioneswTitle,$IntervencioneswText, ""), 5 )
	UTAssert( ControlGetText($IntervencioneswTitle,$IntervencioneswText, "[CLASS:Static; INSTANCE:7]") == $persona )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Remove_Sobre_Quien($caso, $quien, $tipoi)
	UTLogInitTest( "SMDH_ManejoDeCasos_Intervenciones_Remove_Sobre_Quien", $caso & ", " & $quien & ", " & $tipoi );
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText ) )
	UTAssert( ControlClick($IntervencioneswTitle, $IntervencioneswText, "[CLASS:Button; INSTANCE:9]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( ControlGetText($IntervencioneswTitle, $IntervencioneswText, "[CLASS:Static; INSTANCE:7]") == "" )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Set_A_Quien($caso, $quien, $tipoi, $persona)
	UTLogInitTest( "SMDH_ManejoDeCasos_Intervenciones_Set_A_Quien", $caso & ", " & $quien & ", " & $tipoi & ", " & $persona );
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText) )
	UTAssert( ControlClick($IntervencioneswTitle,$IntervencioneswText,"[CLASS:Button; INSTANCE:3]") )
	UTAssert( WinWaitActive("Seleccionar una persona", "", 10) )
	Local $hList = ControlGetHandle("Seleccionar una persona", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $persona)>=0)
	UTAssert( ControlClick("Seleccionar una persona","","[CLASS:Button; INSTANCE:7]") )
	;verify
	UTAssert( WinWaitActive($IntervencioneswTitle,$IntervencioneswText, ""), 5 )
	UTAssert( ControlGetText($IntervencioneswTitle,$IntervencioneswText, "[CLASS:Static; INSTANCE:4]") == $persona )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Intervenciones_Remove_A_Quien($caso, $quien, $tipoi)
	UTLogInitTest( "SMDH_ManejoDeCasos_Intervenciones_Remove_A_Quien", $caso & ", " & $quien & ", " & $tipoi );
	UTAssert( WinActive($IntervencioneswTitle, $IntervencioneswText ) )
	UTAssert( ControlClick($IntervencioneswTitle, $IntervencioneswText, "[CLASS:Button; INSTANCE:10]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( ControlGetText($IntervencioneswTitle, $IntervencioneswText, "[CLASS:Static; INSTANCE:4]") == "" )
	UTLogEndTestOK()
EndFunc
