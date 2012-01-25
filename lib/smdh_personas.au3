#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

Global Const $PERSONA_INDIVIDUAL = "Individual"
Global Const $PERSONA_COLECTIVA = "Colectiva"
Global Const $PERSONA_SEXO_MUJER = "Mujer"
Global Const $PERSONA_SEXO_HOMBRE = "Hombre"
Global Const $PERSONA_SEXO_EMPTY = ""

Func SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Personas_DatosGenerales_Open")
	UTAssert( WinActive("Manejo de Casos", "NBPersonas") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR17", "primary", 1, 58, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "personas registradas", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Personas_Detalles_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Personas_Detalles_Open")
	UTAssert( WinActive("Manejo de Casos", "NBPersonas") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR17", "primary", 1, 138, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "habla", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Personas_InformacionAdministrativa_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Personas_InformacionAdministrativa_Open")
	UTAssert( WinActive("Manejo de Casos", "NBPersonas") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR17", "primary", 1, 250, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "bservaciones", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Personas_DatosBiograficos_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Personas_DatosBiograficos_Open")
	UTAssert( WinActive("Manejo de Casos", "NBPersonas") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR17", "primary", 1, 390, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "ato biogr", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Nueva($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Nueva", $nombre & ", " & $apellido )
	UTAssert( WinActive("Manejo de Casos", "NBPersonas") )
	UTAssert( ControlClick("Manejo de Casos","","Nueva persona") )
	UTAssert( WinWaitActive("Datos de una persona", "", 10) )
	UTAssert( ControlSetText("Datos de una persona", "", "[CLASS:Edit; INSTANCE:2]", $nombre) )
	UTAssert( ControlSetText("Datos de una persona", "", "[CLASS:Edit; INSTANCE:1]", $apellido) )
	UTAssert( ControlClick("Datos de una persona", "", $PERSONA_INDIVIDUAL) )
	UTAssert( ControlClick("Datos de una persona", "", "Seleccionar") )
	UTAssert( not WinExists("Alerta", "existe una persona") )
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:13]")
	Local $str = $apellido & ", " & $nombre
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Nueva($nombre, $sigla = "")
	UTLogInitTest( "SMDH_Personas_Colectiva_Nueva", $nombre & ", " & $sigla )
	UTAssert( WinActive("Manejo de Casos", "NBPersonas") )
	UTAssert( ControlClick("Manejo de Casos","","Nueva persona") )
	UTAssert( WinWaitActive("Datos de una persona", "", 10) )
	UTAssert( ControlSetText("Datos de una persona", "", "[CLASS:Edit; INSTANCE:1]", $nombre) )
	UTAssert( ControlSetText("Datos de una persona", "", "[CLASS:Edit; INSTANCE:2]", $sigla) )
	UTAssert( ControlClick("Datos de una persona", "", $PERSONA_COLECTIVA) )
	UTAssert( ControlClick("Datos de una persona", "", "Seleccionar") )
	UTAssert( not WinExists("Alerta", "existe una persona") )
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:13]")
	Local $str = $nombre
	If ($sigla <> "") Then
		$str = $str & " (" & $sigla & ")"
	EndIf
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Borrar($nombre, $apellido, $assert = True)
	UTLogInitTest( "SMDH_Personas_Individual_Borrar", $nombre & ", " & $apellido );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:13]")
	Local $str = $apellido & ", " & $nombre
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Borrar persona") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Borrar($nombre, $sigla = "", $assert = True)
	UTLogInitTest( "SMDH_Personas_Colectiva_Borrar", $nombre & ", " & $sigla );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:13]")
	Local $str = $nombre
	If ($sigla <> "") Then
		$str = $str & " (" & $sigla & ")"
	EndIf
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Borrar persona") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:13]")
	Local $str = $apellido & ", " & $nombre
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc

Func SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:13]")
	Local $str = $nombre
	If ($sigla <> "") Then
		$str = $str & " (" & $sigla & ")"
	EndIf
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc

Func SMDH_Personas_Individual_Set_OtroNombre($nombre, $apellido, $otro)
	UTLogInitTest( "SMDH_Personas_Individual_Set_OtroNombre", $nombre & ", " & $apellido & ", " & $otro );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:45]", $otro) )
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:45]") == $otro )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_OtroNombre($nombre, $sigla, $otro)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_OtroNombre", $nombre & ", " & $sigla & ", " & $otro );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:45]", $otro) )
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:45]") == $otro )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Set_Sexo($nombre, $apellido, $sexo)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Sexo", $nombre & ", " & $apellido & ", " & $sexo );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)

	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:12]")
	Local $idx = 0;
	If ($sexo == $PERSONA_SEXO_EMPTY) Then
		$idx = -1
	Else
		$idx = _GUICtrlComboBoxEx_FindStringExact($hCombo, $sexo);
		UTAssert( $idx >= 0)
	EndIf
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:12]")
	If ($sexo == $PERSONA_SEXO_EMPTY) Then
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx or _GUICtrlComboBoxEx_GetCurSel($hCombo) == 4294967295)
	Else
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx )
	EndIf
	UTLogEndTestOK()
EndFunc

