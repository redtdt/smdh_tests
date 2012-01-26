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