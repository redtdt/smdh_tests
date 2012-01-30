#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

Local $FuenteswTitle = "Manejo de Casos"
Local $FuenteswText = "NBFuente"

Func SMDH_ManejoDeCasos_Fuentes_Personal_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Personal_Open")
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlClick($FuenteswTitle,"","wxWindowClassNR23", "primary", 1, 56, 14) )
	UTAssert( WinWaitActive($FuenteswTitle, "NBFuentePersonal", 5) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Documental_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Documental_Open")
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlClick($FuenteswTitle,"","wxWindowClassNR23", "primary", 1, 164, 14) )
	UTAssert( WinWaitActive($FuenteswTitle, "NBFuenteDocumental", 5) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Personal_Nueva($caso, $persona)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Personal_Nueva", $caso & ", " & $persona )
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlClick($FuenteswTitle, $FuenteswText,"[CLASS:Button; INSTANCE:136]") )
	UTAssert( WinWaitActive("Seleccionar una persona", "", 10) )
	Local $hList = ControlGetHandle("Seleccionar una persona", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $persona)>=0)
	UTAssert( ControlClick("Seleccionar una persona","","[CLASS:Button; INSTANCE:7]") )
	; verify
	UTAssert( WinWaitActive($FuenteswTitle, $FuenteswText, ""), 5 )
	Local $hList = ControlGetHandle($FuenteswTitle, $FuenteswText,"[CLASS:ListBox; INSTANCE:20]")
	UTAssert( _GUICtrlListBox_FindString($hList, $persona, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Personal_Exists($caso, $persona)
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	Local $str = $persona
	Local $hList = ControlGetHandle($FuenteswTitle, $FuenteswText, "[CLASS:ListBox; INSTANCE:20]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	Return $item_idx >= 0
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Personal_Select($caso, $persona)
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	Local $str = $persona
	Local $hList = ControlGetHandle($FuenteswTitle, $FuenteswText, "[CLASS:ListBox; INSTANCE:20]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Personal_Borrar($caso, $persona, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Personal_Borrar", $caso & ", " & $persona);
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	Local $str = $persona
	Local $hList = ControlGetHandle($FuenteswTitle, $FuenteswText, "[CLASS:ListBox; INSTANCE:20]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str,  True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick($FuenteswTitle, $FuenteswText, "[CLASS:Button; INSTANCE:147]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc
