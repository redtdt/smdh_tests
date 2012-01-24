#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GuiButton.au3>
#include <GuiListBox.au3>
#include <GuiComboBox.au3>
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
