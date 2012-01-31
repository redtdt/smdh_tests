#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GuiButton.au3>
#include <GuiListBox.au3>
#include <GuiComboBox.au3>
#include <GuiComboBoxEx.au3>
#include <GuiTreeView.au3>
#include <Array.au3>
#include "unit_test.au3"

Global Const $FECHA_TIPO_VACIO = ""
Global Const $FECHA_TIPO_EXACTA = "Fecha exacta"
Global Const $FECHA_TIPO_APROX = "Fecha aproximada"
Global Const $FECHA_TIPO_NO_DIA = "Se desconoce el día"
Global Const $FECHA_TIPO_NO_MES = "Se desconoce el día y el mes"

Func GUI_Is_CheckBox_Checked($title, $text, $controlID)
	Local $hCheck = ControlGetHandle($title, $text, $controlID)
	UTAssert( $hCheck <> "" )
	Local $checked = _GUICtrlButton_GetCheck($hCheck)
	If ( $checked = $GUI_CHECKED ) Then
		return True
	EndIf
	return False
EndFunc

Func _ArrayAddCreate(ByRef $avArray, $sValue)
    If IsArray($avArray) Then
        ReDim $avArray[UBound($avArray) + 1]
        $avArray[UBound($avArray) - 1] = $sValue
        SetError(0)
        Return 1
    ElseIf Not IsArray($avArray) Then
        Dim $avArray[1]
        $avArray[0] = $sValue
        Return 2
    Else
        SetError(1)
        Return 0
    EndIf
EndFunc   ;==>_ArrayAddCreate


Func GetArrayFromTreeView($hTree, $only_leafs = True, $skip_root = False)
	Dim $items
	Local $hCur = _GUICtrlTreeView_GetFirstItem($hTree)
	While ($hCur <> 0)
		If ($only_leafs and _GUICtrlTreeView_GetFirstChild($hTree, $hCur)=0) Then ; leaf
			_ArrayAddCreate($items, _GUICtrlTreeView_GetText($hTree, $hCur))
		Else
			If ($skip_root and _GUICtrlTreeView_IsFirstItem($hTree, $hCur)) Then
			Else
				_ArrayAddCreate($items, _GUICtrlTreeView_GetText($hTree, $hCur))
			EndIf
		EndIf
		$hCur = _GUICtrlTreeView_GetNext($hTree, $hCur)
	WEnd
	return $items
EndFunc

Func GetArrayFromComboBox($hCombo)
	Dim $items
	Local $tmp = _GUICtrlComboBoxEx_GetListArray($hCombo)
	For $x = 1 To $tmp[0]
		_ArrayAddCreate($items, $tmp[$x])
    Next
	return $items
EndFunc

Func SMDH_SetFecha($test, $prefix, $window, $text, $comboId, $anioId, $mesId, $diaId, $saveId, $tipo, $anio, $mes = 0, $dia = 0,	$expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	UTLogInitTest( $test, $prefix & ", " & $window & ", " & $text & ", " & $comboId & ", " & $anioId & ", " & $mesId & ", " & $diaId & ", " & $saveId & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia);
	UTAssert( WinActive($window, $text) )
	Local $hCombo = ControlGetHandle($window, $text,$comboId)
	Local $idx = 0;
	If ($tipo == $FECHA_TIPO_VACIO) Then
		$idx = -1
	Else
		$idx = _GUICtrlComboBoxEx_FindStringExact($hCombo, $tipo);
		UTAssert( $idx >= 0)
	EndIf
;	_GUICtrlComboBoxEx_ShowDropDown($hCombo, True)
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	ControlCommand($window,$text,$comboId,"SelectString",$tipo)
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_DIA and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlSetText($window, $text, $diaId, "") )
		UTAssert( ControlSend($window, $text, $diaId, $dia) )
		If ($expect_failure_dia = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinWaitActive("Alerta", "fuera de rango", 10) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; Set a valid one to avoid problems
			UTAssert( ControlSetText($window, $text, $diaId, "") )
			UTAssert( ControlSend($window, $text, $diaId, 1) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlSetText($window, $text, $mesId, "") )
		UTAssert( ControlSend($window, $text, $mesId, $mes) )
		If ($expect_failure_mes = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinWaitActive("Alerta", "fuera de rango", 10) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; Set a valid one to avoid problems
			UTAssert( ControlSetText($window, $text, $mesId, "") )
			UTAssert( ControlSend($window, $text, $mesId, 1) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO) Then
		UTAssert( ControlSetText($window, $text, $anioId, "") )
		UTAssert( ControlSend($window, $text, $anioId, $anio) )
		If ($expect_failure_anio = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinExists("Alerta", "") )
			UTAssert( WinWaitActive("Alerta", "", 5) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; a veces sale 2 veces
			If( WinWaitActive("Alerta", "no es", 5) ) Then
				UTAssert( ControlClick("Alerta", "", "Aceptar") )
			EndIf
			; a veces sale 3 veces
			If( WinWaitActive("Alerta", "no es", 5) ) Then
				UTAssert( ControlClick("Alerta", "", "Aceptar") )
			EndIf
			; Set a valid one to avoid problems
			UTAssert( ControlSetText($window, $text, $anioId, "") )
			UTAssert( ControlSend($window, $text, $anioId, 2000) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	UTAssert( ControlClick($window, $text, $saveId) )
	If ($expect_failure_saving = False) Then
		UTAssert( not WinExists("Alerta", "no es") )
	Else
		UTAssert( WinWaitActive("Alerta", "no es", 5) )
		UTAssert( ControlClick("Alerta", "", "Aceptar") )
		; sale 2 veces
		If( WinWaitActive("Alerta", "no es", 5) ) Then
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
		EndIf
		; a veces sale 3 veces
		If( WinWaitActive("Alerta", "no es", 5) ) Then
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
		EndIf
		UTLogEndTestOK()
		return
	EndIf
	; verify
	$hCombo = ControlGetHandle($window, $text,$comboId)
	If ($tipo == $FECHA_TIPO_VACIO) Then
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx or _GUICtrlComboBoxEx_GetCurSel($hCombo) == 4294967295)
	Else
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_DIA and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlGetText($window, $text, $diaId) == $dia )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlGetText($window, $text, $mesId) == $mes )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO) Then
		UTAssert( ControlGetText($window, $text, $anioId) == $anio )
	EndIf
	UTLogEndTestOK()
EndFunc

; To retrieve list of items from subwindows like Tipo de Lugar
Func SMDH_GetTreeViewList_Single($test, $prefix, $window, $text, $addId, $removeId, $staticId, $subwindow, $subOk, $subCancel, $tree)
	UTLogInitTest( $test, $prefix & ", " & $window & ", " & $text & ", " & $addId & ", " & $removeId & ", " & $staticId & ", " & $subwindow & ", " & $subOk & ", " & $subCancel & ", " & $tree)
	UTAssert( WinActive($window, $text) )
	UTAssert( ControlClick($window, $text, $addId) )
	UTAssert( WinWaitActive($subwindow, "", 5) )
	Local $hTree = ControlGetHandle($subwindow, "", $tree)
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, False, True)
	UTAssert( ControlClick($subwindow, "", $subCancel) )
	UTLogEndTestOK()
	return $items
EndFunc

; To select an item from a list of items from subwindows like Tipo de Lugar
Func SMDH_SetFromTreeViewList_Single($test, $prefix, $window, $text, $addId, $removeId, $staticId, $subwindow, $subOk, $subCancel, $tree, $item)
	UTLogInitTest( $test, $prefix & ", " & $window & ", " & $text & ", " & $addId & ", " & $removeId & ", " & $staticId & ", " & $subwindow & ", " & $subOk & ", " & $subCancel & ", " & $tree & ", " & $item)
	UTAssert( WinActive($window, $text) )
	UTAssert( ControlClick($window, $text, $addId) )
	UTAssert( WinWaitActive($subwindow, "", 5) )
	Local $hTree = ControlGetHandle($subwindow, "", $tree)
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $item)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick($subwindow, "", $subOk) )
	UTAssert( WinWaitActive($window, $text, 10) )
	;verify
	UTAssert( ControlGetText($window, $text, $staticId) == $item )
	UTLogEndTestOK()
EndFunc

Func SMDH_RemoveFromTreeViewList_Single($test, $prefix, $window, $text, $addId, $removeId, $staticId, $subwindow, $subOk, $subCancel, $tree)
	UTLogInitTest( $test, $prefix & ", " & $window & ", " & $text & ", " & $addId & ", " & $removeId & ", " & $staticId & ", " & $subwindow & ", " & $subOk & ", " & $subCancel & ", " & $tree)
	UTAssert( WinActive($window, $text) )
	UTAssert( ControlClick($window, $text, $removeId) )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( ControlGetText($window, $text, $staticId) == "" )
	UTLogEndTestOK()
EndFunc





; To retrieve list of items from subwindows like Tipo de Lugar
Func SMDH_GetTreeViewList_Multi($test, $prefix, $window, $text, $addId, $removeId, $listId, $subwindow, $subOk, $subCancel, $tree)
	UTLogInitTest( $test, $prefix & ", " & $window & ", " & $text & ", " & $addId & ", " & $removeId & ", " & $listId & ", " & $subwindow & ", " & $subOk & ", " & $subCancel & ", " & $tree)
	UTAssert( WinActive($window, $text) )
	UTAssert( ControlClick($window, $text, $addId) )
	UTAssert( WinWaitActive($subwindow, "", 5) )
	Local $hTree = ControlGetHandle($subwindow, "", $tree)
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, False, True)
	UTAssert( ControlClick($subwindow, "", $subCancel) )
	UTLogEndTestOK()
	return $items
EndFunc

; To select an item from a list of items from subwindows like Tipo de Lugar
Func SMDH_AddFromTreeViewList_Multi($test, $prefix, $window, $text, $addId, $removeId, $listId, $subwindow, $subOk, $subCancel, $tree, $item)
	UTLogInitTest( $test, $prefix & ", " & $window & ", " & $text & ", " & $addId & ", " & $removeId & ", " & $listId & ", " & $subwindow & ", " & $subOk & ", " & $subCancel & ", " & $tree & ", " & $item)
	UTAssert( WinActive($window, $text) )
	UTAssert( ControlClick($window, $text, $addId) )
	UTAssert( WinWaitActive($subwindow, "", 5) )
	Local $hTree = ControlGetHandle($subwindow, "", $tree)
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $item)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick($subwindow, "", $subOk) )
	UTAssert( WinWaitActive($window, $text, 10) )
	;verify
	Local $hList = ControlGetHandle($window, $text, $listId)
	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_RemoveFromTreeViewList_Multi($test, $prefix, $window, $text, $addId, $removeId, $listId, $subwindow, $subOk, $subCancel, $tree, $item)
	UTLogInitTest( $test, $prefix & ", " & $window & ", " & $text & ", " & $addId & ", " & $removeId & ", " & $listId & ", " & $subwindow & ", " & $subOk & ", " & $subCancel & ", " & $tree & ", " & $item)
	UTAssert( WinActive($window, $text) )
	Local $hList = ControlGetHandle($window, $text, $listId)
	UTAssert(_GUICtrlListBox_SelectString($hList, $item)>=0)
	Local $hItem = _GUICtrlListBox_FindString($hList, $item, True)
	UTAssert(  $hItem >= 0)
	_GUICtrlListBox_ClickItem($hList, $hItem, "primary", True, 2)
	UTAssert( ControlClick($window, $text, $removeId) )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( WinWaitActive($window, $text, 10) )
	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) < 0)
	UTLogEndTestOK()
EndFunc
