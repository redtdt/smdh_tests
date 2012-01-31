#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

Global Const $PERSONA_INDIVIDUAL = "Individual"
Global Const $PERSONA_COLECTIVA = "Colectiva"
Global Const $PERSONA_SEXO_VACIO = ""
Global Const $PERSONA_SEXO_MUJER = "Mujer"
Global Const $PERSONA_SEXO_HOMBRE = "Hombre"

Local $PersonaswTitle = "Manejo de Casos"
Local $PersonaswText = "NBPersonas"
Local $PersonasBiowText = "NBPersonasBio"

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
	UTAssert( WinWaitActive("Manejo de Casos", "Origen", 10) )
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

Func SMDH_Personas_Individual_Compose_String($nombre, $apellido)
	return $apellido & ", " & $nombre
EndFunc

Func SMDH_Personas_Colectiva_Compose_String($nombre, $sigla = "")
	Local $str = $nombre
	If ($sigla <> "") Then
		$str = $str & " (" & $sigla & ")"
	EndIf
	return $str
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
	If ($sexo == $PERSONA_SEXO_VACIO) Then
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
	If ($sexo == $PERSONA_SEXO_VACIO) Then
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx or _GUICtrlComboBoxEx_GetCurSel($hCombo) == 4294967295)
	Else
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx )
	EndIf
	UTLogEndTestOK()
EndFunc


Func SMDH_Personas_Individual_Set_FechaNacimiento($nombre, $apellido, $tipo, $anio, $mes = 0, $dia = 0,	$expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	UTLogInitTest( "SMDH_Personas_Individual_Set_FechaNacimiento", $nombre & ", " & $apellido & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)

	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:15]")
	Local $idx = 0;
	If ($tipo == $FECHA_TIPO_VACIO) Then
		$idx = -1
	Else
		$idx = _GUICtrlComboBoxEx_FindStringExact($hCombo, $tipo);
		UTAssert( $idx >= 0)
	EndIf
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	ControlCommand("Manejo de Casos","personas registradas","[CLASS:ComboBox; INSTANCE:15]","SelectString",$tipo)
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_DIA and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]", "") )
		UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]", $dia) )
		If ($expect_failure_dia = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinWaitActive("Alerta", "fuera de rango", 10) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; Set a valid one to avoid problems
			UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]", "") )
			UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]", 1) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]", "") )
		UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]", $mes) )
		If ($expect_failure_mes = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinWaitActive("Alerta", "fuera de rango", 10) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; Set a valid one to avoid problems
			UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]", "") )
			UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]", 1) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO) Then
		UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]", "") )
		UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]", $anio) )
		If ($expect_failure_anio = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinExists("Alerta", "") )
			UTAssert( WinWaitActive("Alerta", "", 3) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; a veces sale 2 veces
			If( WinWaitActive("Alerta", "no es", 1) ) Then
				UTAssert( ControlClick("Alerta", "", "Aceptar") )
			EndIf
			; a veces sale 3 veces
			If( WinWaitActive("Alerta", "no es", 1) ) Then
				UTAssert( ControlClick("Alerta", "", "Aceptar") )
			EndIf
			; Set a valid one to avoid problems
			UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]", "") )
			UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]", 2000) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:88]") )
	If ($expect_failure_saving = False) Then
		UTAssert( not WinExists("Alerta", "no es") )
	Else
		UTAssert( WinWaitActive("Alerta", "no es", 1) )
		UTAssert( ControlClick("Alerta", "", "Aceptar") )
		; sale 2 veces
		UTAssert( WinWaitActive("Alerta", "no es", 1) )
		UTAssert( ControlClick("Alerta", "", "Aceptar") )
		; a veces sale 3 veces
		If( WinWaitActive("Alerta", "no es", 1) ) Then
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
		EndIf
		UTLogEndTestOK()
		return
	EndIf
	; verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:15]")
	If ($tipo == $FECHA_TIPO_VACIO) Then
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx or _GUICtrlComboBoxEx_GetCurSel($hCombo) == 4294967295)
	Else
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_DIA and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]") == $dia )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]") == $mes )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO) Then
		UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]") == $anio )
	EndIf
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_FechaCreacion($nombre, $sigla, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_FechaCreacion", $nombre & ", " & $sigla & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)

	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:15]")
	Local $idx = 0;
	If ($tipo == $FECHA_TIPO_VACIO) Then
		$idx = -1
	Else
		$idx = _GUICtrlComboBoxEx_FindStringExact($hCombo, $tipo);
		UTAssert( $idx >= 0)
	EndIf
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	ControlCommand("Manejo de Casos","personas registradas","[CLASS:ComboBox; INSTANCE:15]","SelectString",$tipo)
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_DIA and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]", "") )
		UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]", $dia) )
		If ($expect_failure_dia = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinWaitActive("Alerta", "fuera de rango", 10) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; Set a valid one to avoid problems
			UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]", "") )
			UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]", 1) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]", "") )
		UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]", $mes) )
		If ($expect_failure_mes = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinWaitActive("Alerta", "fuera de rango", 10) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; Set a valid one to avoid problems
			UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]", "") )
			UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]", 1) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO) Then
		UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]", "") )
		UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]", $anio) )
		If ($expect_failure_anio = False) Then
			UTAssert( not WinExists("Alerta", "fuera de rango") )
		Else
			UTAssert( WinExists("Alerta", "") )
			UTAssert( WinWaitActive("Alerta", "", 3) )
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
			; a veces sale 2 veces
			If( WinWaitActive("Alerta", "", 1) ) Then
				UTAssert( ControlClick("Alerta", "", "Aceptar") )
			EndIf
			; a veces sale 3 veces
			If( WinWaitActive("Alerta", "", 1) ) Then
				UTAssert( ControlClick("Alerta", "", "Aceptar") )
			EndIf
			; Set a valid one to avoid problems
			UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]", "") )
			UTAssert( ControlSend("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]", 2000) )
			UTLogEndTestOK()
			return
		EndIf
	EndIf
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:88]") )
	If ($expect_failure_saving = False) Then
		UTAssert( not WinExists("Alerta", "no es") )
	Else
		UTAssert( WinWaitActive("Alerta", "no es", 1) )
		UTAssert( ControlClick("Alerta", "", "Aceptar") )
		; sale 2 veces
		UTAssert( WinWaitActive("Alerta", "no es", 1) )
		UTAssert( ControlClick("Alerta", "", "Aceptar") )
		; a veces sale 3 veces
		If( WinWaitActive("Alerta", "no es", 1) ) Then
			UTAssert( ControlClick("Alerta", "", "Aceptar") )
		EndIf
		UTLogEndTestOK()
		return
	EndIf
	; verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:15]")
	If ($tipo == $FECHA_TIPO_VACIO) Then
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx or _GUICtrlComboBoxEx_GetCurSel($hCombo) == 4294967295)
	Else
		UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) == $idx )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_DIA and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:46]") == $dia )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO and $tipo<>$FECHA_TIPO_NO_MES) Then
		UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:47]") == $mes )
	EndIf
	If ($tipo<>$FECHA_TIPO_VACIO) Then
		UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:48]") == $anio )
	EndIf
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Get_Paises($nombre, $apellido, $only_countries = True)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Paises", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:92]") )
	UTAssert( WinWaitActive("País de origen o nacimiento", "", 5) )
	Local $hTree = ControlGetHandle("País de origen o nacimiento", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, $only_countries, True)
	UTAssert( ControlClick("País de origen o nacimiento", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Paises($nombre, $sigla, $only_countries = True)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Paises", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:92]") )
	UTAssert( WinWaitActive("País de origen o nacimiento", "", 5) )
	Local $hTree = ControlGetHandle("País de origen o nacimiento", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, $only_countries, True)
	UTAssert( ControlClick("País de origen o nacimiento", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_PaisOrigen($nombre, $apellido, $pais)
	UTLogInitTest( "SMDH_Personas_Individual_Set_PaisOrigen", $nombre & ", " & $apellido & ", " & $pais );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:92]") )
	UTAssert( WinWaitActive("País de origen o nacimiento", "", 5) )
	Local $hTree = ControlGetHandle("País de origen o nacimiento", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $pais)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("País de origen o nacimiento", "", "Seleccionar") )
	;verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Static; INSTANCE:125]") == $pais )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_PaisOrigen($nombre, $sigla, $pais)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_PaisOrigen", $nombre & ", " & $sigla & ", " & $pais );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:92]") )
	UTAssert( WinWaitActive("País de origen o nacimiento", "", 5) )
	Local $hTree = ControlGetHandle("País de origen o nacimiento", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $pais)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("País de origen o nacimiento", "", "Seleccionar") )
	;verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Static; INSTANCE:125]") == $pais )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Remove_PaisOrigen($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Remove_PaisOrigen", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:95]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Static; INSTANCE:125]") == "" )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Remove_PaisOrigen($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Remove_PaisOrigen", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:95]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Static; INSTANCE:125]") == "" )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Get_Estados($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Estados", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas", "[CLASS:ComboBox; INSTANCE:16]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Estados($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Estados", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas", "[CLASS:ComboBox; INSTANCE:16]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_Estado_Idx($nombre, $apellido, $estado_idx)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Estado_Idx", $nombre & ", " & $apellido & ", " & $estado_idx );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	If $estado_idx = 0 Then
		$idx = -1
	Else
		$idx = $estado_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:16]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:16]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Estado_Idx($nombre, $sigla, $estado_idx)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Estado_Idx", $nombre & ", " & $sigla & ", " & $estado_idx );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	If $estado_idx = 0 Then
		$idx = -1
	Else
		$idx = $estado_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:16]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:16]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Get_Municipios($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Municipios", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas", "[CLASS:ComboBox; INSTANCE:13]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Municipios($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Municipios", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas", "[CLASS:ComboBox; INSTANCE:13]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_Municipio_Idx($nombre, $apellido, $mpo_idx)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Municipio_Idx", $nombre & ", " & $apellido & ", " & $mpo_idx );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	If $mpo_idx = 0 Then
		$idx = -1
	Else
		$idx = $mpo_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:13]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	;SMDH_Personas_Individual_Select($nombre, $apellido)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:13]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Municipio_Idx($nombre, $sigla, $mpo_idx)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Municipio_Idx", $nombre & ", " & $sigla & ", " & $mpo_idx );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	If $mpo_idx = 0 Then
		$idx = -1
	Else
		$idx = $mpo_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:13]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	;SMDH_Personas_Colectiva_Select($nombre, $sigla)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:13]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Set_Localidad($nombre, $apellido, $loc)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Localidad", $nombre & ", " & $apellido & ", " & $loc );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:43]", $loc) )
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:43]") == $loc )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Localidad($nombre, $sigla, $loc)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Localidad", $nombre & ", " & $sigla & ", " & $loc );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlSetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:43]", $loc) )
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Edit; INSTANCE:43]") == $loc )
	UTLogEndTestOK()
EndFunc



Func SMDH_Personas_Individual_Get_Ciudadanias($nombre, $apellido, $only_countries = True)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Ciudadanias", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:93]") )
	UTAssert( WinWaitActive("Ciudadanía o país sede", "", 5) )
	Local $hTree = ControlGetHandle("Ciudadanía o país sede", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, $only_countries, True)
	UTAssert( ControlClick("Ciudadanía o país sede", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Ciudadanias($nombre, $sigla, $only_countries = True)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Ciudadanias", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:93]") )
	UTAssert( WinWaitActive("Ciudadanía o país sede", "", 5) )
	Local $hTree = ControlGetHandle("Ciudadanía o país sede", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, $only_countries, True)
	UTAssert( ControlClick("Ciudadanía o país sede", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_Ciudadania($nombre, $apellido, $pais)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Ciudadania", $nombre & ", " & $apellido & ", " & $pais );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:93]") )
	UTAssert( WinWaitActive("Ciudadanía o país sede", "", 5) )
	Local $hTree = ControlGetHandle("Ciudadanía o país sede", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $pais)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("Ciudadanía o país sede", "", "Seleccionar") )
	;verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Static; INSTANCE:126]") == $pais )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Ciudadania($nombre, $sigla, $pais)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Ciudadania", $nombre & ", " & $sigla & ", " & $pais );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:93]") )
	UTAssert( WinWaitActive("Ciudadanía o país sede", "", 5) )
	Local $hTree = ControlGetHandle("Ciudadanía o país sede", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $pais)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("Ciudadanía o país sede", "", "Seleccionar") )
	;verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Static; INSTANCE:126]") == $pais )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Remove_Ciudadania($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Remove_Ciudadania", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:96]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Static; INSTANCE:126]") == "" )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Remove_Ciudadania($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Remove_Ciudadania", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "[CLASS:Button; INSTANCE:96]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	UTAssert( ControlGetText("Manejo de Casos", "personas registradas", "[CLASS:Static; INSTANCE:126]") == "" )
	UTLogEndTestOK()
EndFunc



Func SMDH_Personas_Individual_Get_Escolaridades($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Escolaridades", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas", "[CLASS:ComboBox; INSTANCE:14]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Escolaridades($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Escolaridades", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas", "[CLASS:ComboBox; INSTANCE:14]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_Escolaridad_Idx($nombre, $apellido, $esc_idx)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Escolaridad_Idx", $nombre & ", " & $apellido & ", " & $esc_idx );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Individual_Select($nombre, $apellido)
	If $esc_idx = 0 Then
		$idx = -1
	Else
		$idx = $esc_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:14]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Individual_Select($nombre, $apellido)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:14]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Escolaridad_Idx($nombre, $sigla, $esc_idx)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Escolaridad_Idx", $nombre & ", " & $sigla & ", " & $esc_idx );
	UTAssert( WinActive("Manejo de Casos", "personas registradas") )
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	If $esc_idx = 0 Then
		$idx = -1
	Else
		$idx = $esc_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:14]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "personas registradas", "Guardar") )
	; verify
	SMDH_Personas_Colectiva_Select($nombre, $sigla)
	$hCombo = ControlGetHandle("Manejo de Casos", "personas registradas","[CLASS:ComboBox; INSTANCE:14]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc




Func SMDH_Personas_Individual_Get_Ocupaciones($nombre, $apellido, $only_leafs = True)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Ocupaciones", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:120]") )
	UTAssert( WinWaitActive("Ocupación", "", 5) )
	Local $hTree = ControlGetHandle("Ocupación", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, $only_leafs, True)
	UTAssert( ControlClick("Ocupación", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Ocupaciones($nombre, $sigla, $only_leafs = True)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Ocupaciones", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:120]") )
	UTAssert( WinWaitActive("Ocupación", "", 5) )
	Local $hTree = ControlGetHandle("Ocupación", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, $only_leafs, True)
	UTAssert( ControlClick("Ocupación", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_Ocupacion($nombre, $apellido, $ocu)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Ocupacion", $nombre & ", " & $apellido & ", " & $ocu );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:120]") )
	UTAssert( WinWaitActive("Ocupación", "", 5) )
	Local $hTree = ControlGetHandle("Ocupación", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $ocu)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(300)
	UTAssert( ControlClick("Ocupación", "", "Seleccionar") )
	;verify
	UTAssert( ControlGetText("Manejo de Casos", "Origen", "[CLASS:Static; INSTANCE:151]") == $ocu )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Ocupacion($nombre, $sigla, $ocu)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Ocupacion", $nombre & ", " & $sigla & ", " & $ocu );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:120]") )
	UTAssert( WinWaitActive("Ocupación", "", 5) )
	Local $hTree = ControlGetHandle("Ocupación", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $ocu)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(500)
	UTAssert( ControlClick("Ocupación", "", "Seleccionar") )
	;verify
	UTAssert( ControlGetText("Manejo de Casos", "Origen", "[CLASS:Static; INSTANCE:151]") == $ocu )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Remove_Ocupacion($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Remove_Ocupacion", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:121]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( ControlGetText("Manejo de Casos", "Origen", "[CLASS:Static; INSTANCE:151]") == "" )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Remove_Ocupacion($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Remove_Ocupacion", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:121]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( ControlGetText("Manejo de Casos", "Origen", "[CLASS:Static; INSTANCE:151]") == "" )
	UTLogEndTestOK()
EndFunc





Func SMDH_Personas_Individual_Get_Idiomas($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Idiomas", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:115]") )
	UTAssert( WinWaitActive("Idioma", "", 5) )
	Local $hTree = ControlGetHandle("Idioma", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, True, True)
	UTAssert( ControlClick("Idioma", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Idiomas($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Idiomas", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:115]") )
	UTAssert( WinWaitActive("Idioma", "", 5) )
	Local $hTree = ControlGetHandle("Idioma", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, True, True)
	UTAssert( ControlClick("Idioma", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Add_Idioma($nombre, $apellido, $idioma)
	UTLogInitTest( "SMDH_Personas_Individual_Add_Idioma", $nombre & ", " & $apellido & ", " & $idioma );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:115]") )
	UTAssert( WinWaitActive("Idioma", "", 5) )
	Local $hTree = ControlGetHandle("Idioma", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $idioma)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(300)
	UTAssert( ControlClick("Idioma", "", "Seleccionar") )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:15]")
	UTAssert( _GUICtrlListBox_FindString($hList, $idioma, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Add_Idioma($nombre, $sigla, $idioma)
	UTLogInitTest( "SMDH_Personas_Colectiva_Add_Idioma", $nombre & ", " & $sigla & ", " & $idioma );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:115]") )
	UTAssert( WinWaitActive("Idioma", "", 5) )
	Local $hTree = ControlGetHandle("Idioma", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $idioma)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(500)
	UTAssert( ControlClick("Idioma", "", "Seleccionar") )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:15]")
	UTAssert( _GUICtrlListBox_FindString($hList, $idioma, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Remove_Idioma($nombre, $apellido, $idioma)
	UTLogInitTest( "SMDH_Personas_Individual_Remove_Idioma", $nombre & ", " & $apellido & ", " & $idioma);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:15]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $idioma)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $idioma, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:122]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $idioma, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Remove_Idioma($nombre, $sigla, $idioma)
	UTLogInitTest( "SMDH_Personas_Colectiva_Remove_Idioma", $nombre & ", " & $sigla & ", " & $idioma);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:15]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $idioma)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $idioma, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:122]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $idioma, True) < 0)
	UTLogEndTestOK()
EndFunc




Func SMDH_Personas_Set_HablaEspaniol($nombre, $apellido, $val)
	UTLogInitTest( "SMDH_Personas_Set_HablaEspaniol", $nombre & ", " & $apellido & ", " & $val );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	If ( GUI_Is_CheckBox_Checked("Manejo de Casos", "Origen","[CLASS:Button; INSTANCE:117]") <> $val) Then
		UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:117]") )
		UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	EndIf
	UTAssert( GUI_Is_CheckBox_Checked("Manejo de Casos", "Origen","[CLASS:Button; INSTANCE:117]") = $val)
	UTLogEndTestOK()
EndFunc





Func SMDH_Personas_Individual_Get_Lenguas($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Lenguas", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:114]") )
	UTAssert( WinWaitActive("Lengua indígena", "", 5) )
	Local $hTree = ControlGetHandle("Lengua indígena", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, True, True)
	UTAssert( ControlClick("Lengua indígena", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Lenguas($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Lenguas", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:114]") )
	UTAssert( WinWaitActive("Lengua indígena", "", 5) )
	Local $hTree = ControlGetHandle("Lengua indígena", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, True, True)
	UTAssert( ControlClick("Lengua indígena", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Add_Lengua($nombre, $apellido, $Lengua)
	UTLogInitTest( "SMDH_Personas_Individual_Add_Lengua", $nombre & ", " & $apellido & ", " & $Lengua );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:114]") )
	UTAssert( WinWaitActive("Lengua indígena", "", 5) )
	Local $hTree = ControlGetHandle("Lengua indígena", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $Lengua)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(300)
	UTAssert( ControlClick("Lengua indígena", "", "Seleccionar") )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:16]")
	UTAssert( _GUICtrlListBox_FindString($hList, $Lengua, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Add_Lengua($nombre, $sigla, $Lengua)
	UTLogInitTest( "SMDH_Personas_Colectiva_Add_Lengua", $nombre & ", " & $sigla & ", " & $Lengua );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:114]") )
	UTAssert( WinWaitActive("Lengua indígena", "", 5) )
	Local $hTree = ControlGetHandle("Lengua indígena", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $Lengua)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(500)
	UTAssert( ControlClick("Lengua indígena", "", "Seleccionar") )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:16]")
	UTAssert( _GUICtrlListBox_FindString($hList, $Lengua, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Remove_Lengua($nombre, $apellido, $Lengua)
	UTLogInitTest( "SMDH_Personas_Individual_Remove_Lengua", $nombre & ", " & $apellido & ", " & $Lengua);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:16]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $Lengua)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $Lengua, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:123]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $Lengua, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Remove_Lengua($nombre, $sigla, $Lengua)
	UTLogInitTest( "SMDH_Personas_Colectiva_Remove_Lengua", $nombre & ", " & $sigla & ", " & $Lengua);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:16]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $Lengua)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $Lengua, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:123]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $Lengua, True) < 0)
	UTLogEndTestOK()
EndFunc




Func SMDH_Personas_Individual_Get_Etnias($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Etnias", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:113]") )
	UTAssert( WinWaitActive("Origen etnico", "", 5) )
	Local $hTree = ControlGetHandle("Origen etnico", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, True, True)
	UTAssert( ControlClick("Origen etnico", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Etnias($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Etnias", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:113]") )
	UTAssert( WinWaitActive("Origen etnico", "", 5) )
	Local $hTree = ControlGetHandle("Origen etnico", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, True, True)
	UTAssert( ControlClick("Origen etnico", "", "Cancelar") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Add_Etnia($nombre, $apellido, $Etnia)
	UTLogInitTest( "SMDH_Personas_Individual_Add_Etnia", $nombre & ", " & $apellido & ", " & $Etnia );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:113]") )
	UTAssert( WinWaitActive("Origen etnico", "", 5) )
	Local $hTree = ControlGetHandle("Origen etnico", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $Etnia)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(300)
	UTAssert( ControlClick("Origen etnico", "", "Seleccionar") )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:17]")
	UTAssert( _GUICtrlListBox_FindString($hList, $Etnia, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Add_Etnia($nombre, $sigla, $Etnia)
	UTLogInitTest( "SMDH_Personas_Colectiva_Add_Etnia", $nombre & ", " & $sigla & ", " & $Etnia );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:113]") )
	UTAssert( WinWaitActive("Origen etnico", "", 5) )
	Local $hTree = ControlGetHandle("Origen etnico", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $Etnia)
	UTAssert( $hItem )
	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(500)
	UTAssert( ControlClick("Origen etnico", "", "Seleccionar") )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:17]")
	UTAssert( _GUICtrlListBox_FindString($hList, $Etnia, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Remove_Etnia($nombre, $apellido, $Etnia)
	UTLogInitTest( "SMDH_Personas_Individual_Remove_Etnia", $nombre & ", " & $apellido & ", " & $Etnia);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:17]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $Etnia)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $Etnia, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:124]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $Etnia, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Remove_Etnia($nombre, $sigla, $Etnia)
	UTLogInitTest( "SMDH_Personas_Colectiva_Remove_Etnia", $nombre & ", " & $sigla & ", " & $Etnia);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hList = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ListBox; INSTANCE:17]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $Etnia)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $Etnia, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "Origen", "[CLASS:Button; INSTANCE:124]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $Etnia, True) < 0)
	UTLogEndTestOK()
EndFunc






Func SMDH_Personas_Individual_Get_Religiones($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Religiones", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen", "[CLASS:ComboBox; INSTANCE:19]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Religiones($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Religiones", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen", "[CLASS:ComboBox; INSTANCE:19]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_Religion_Idx($nombre, $apellido, $Religion_idx)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Religion_Idx", $nombre & ", " & $apellido & ", " & $Religion_idx );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	If $Religion_idx = 0 Then
		$idx = -1
	Else
		$idx = $Religion_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:19]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	; verify
	$hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:19]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Religion_Idx($nombre, $sigla, $Religion_idx)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Religion_Idx", $nombre & ", " & $sigla & ", " & $Religion_idx );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	If $Religion_idx = 0 Then
		$idx = -1
	Else
		$idx = $Religion_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:19]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	; verify
	$hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:19]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc





Func SMDH_Personas_Individual_Get_EstadosCiviles($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_EstadosCiviles", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen", "[CLASS:ComboBox; INSTANCE:20]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_EstadosCiviles($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_EstadosCiviles", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen", "[CLASS:ComboBox; INSTANCE:20]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_EstadoCivil_Idx($nombre, $apellido, $EstadoCivil_idx)
	UTLogInitTest( "SMDH_Personas_Individual_Set_EstadoCivil_Idx", $nombre & ", " & $apellido & ", " & $EstadoCivil_idx );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	If $EstadoCivil_idx = 0 Then
		$idx = -1
	Else
		$idx = $EstadoCivil_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:20]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	; verify
	$hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:20]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_EstadoCivil_Idx($nombre, $sigla, $EstadoCivil_idx)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_EstadoCivil_Idx", $nombre & ", " & $sigla & ", " & $EstadoCivil_idx );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	If $EstadoCivil_idx = 0 Then
		$idx = -1
	Else
		$idx = $EstadoCivil_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:20]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	; verify
	$hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:20]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc




Func SMDH_Personas_Individual_Set_NumeroDependientes($nombre, $apellido, $n, $expect_failure = False)
	UTLogInitTest( "SMDH_Personas_Individual_Set_NumeroDependientes", $nombre & ", " & $apellido & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlSetText("Manejo de Casos", "Origen", "[CLASS:Edit; INSTANCE:51]", "") )
	UTAssert( ControlSend("Manejo de Casos", "Origen", "[CLASS:Edit; INSTANCE:51]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	; verify
	If ($expect_failure) Then
		UTAssert( ControlGetText("Manejo de Casos", "Origen", "[CLASS:Edit; INSTANCE:51]") <> $n )
	Else
		UTAssert( ControlGetText("Manejo de Casos", "Origen", "[CLASS:Edit; INSTANCE:51]") == $n )
	EndIf
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_NumeroPersonas($nombre, $sigla, $n, $expect_failure = False)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_NumeroPersonas", $nombre & ", " & $sigla & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	UTAssert( ControlSetText("Manejo de Casos", "Origen", "[CLASS:Edit; INSTANCE:51]", "") )
	UTAssert( ControlSend("Manejo de Casos", "Origen", "[CLASS:Edit; INSTANCE:51]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	; verify
	If ($expect_failure) Then
		UTAssert( ControlGetText("Manejo de Casos", "Origen", "[CLASS:Edit; INSTANCE:51]") <> $n )
	Else
		UTAssert( ControlGetText("Manejo de Casos", "Origen", "[CLASS:Edit; INSTANCE:51]") == $n )
	EndIf
	UTLogEndTestOK()
EndFunc




Func SMDH_Personas_Individual_Get_Monitoreos($nombre, $apellido)
	UTLogInitTest( "SMDH_Personas_Individual_Get_Monitoreos", $nombre & ", " & $apellido);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen", "[CLASS:ComboBox; INSTANCE:21]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Colectiva_Get_Monitoreos($nombre, $sigla)
	UTLogInitTest( "SMDH_Personas_Colectiva_Get_Monitoreos", $nombre & ", " & $sigla);
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen", "[CLASS:ComboBox; INSTANCE:21]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_Personas_Individual_Set_Monitoreo_Idx($nombre, $apellido, $Monitoreo_idx)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Monitoreo_Idx", $nombre & ", " & $apellido & ", " & $Monitoreo_idx );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	If $Monitoreo_idx = 0 Then
		$idx = -1
	Else
		$idx = $Monitoreo_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:21]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	; verify
	$hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:21]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Monitoreo_Idx($nombre, $sigla, $Monitoreo_idx)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Monitoreo_Idx", $nombre & ", " & $sigla & ", " & $Monitoreo_idx );
	UTAssert( WinActive("Manejo de Casos", "Origen") )
	If $Monitoreo_idx = 0 Then
		$idx = -1
	Else
		$idx = $Monitoreo_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:21]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "Origen", "Guardar") )
	; verify
	$hCombo = ControlGetHandle("Manejo de Casos", "Origen","[CLASS:ComboBox; INSTANCE:21]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc




Func SMDH_Personas_Individual_Set_Observaciones($nombre, $apellido, $n)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Observaciones", $nombre & ", " & $apellido & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:52]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:52]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Observaciones($nombre, $sigla, $n)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Observaciones", $nombre & ", " & $sigla & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:52]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:52]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Set_Comentarios($nombre, $apellido, $n)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Comentarios", $nombre & ", " & $apellido & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:53]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:53]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Comentarios($nombre, $sigla, $n)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Comentarios", $nombre & ", " & $sigla & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:53]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:53]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Set_Archivos($nombre, $apellido, $n)
	UTLogInitTest( "SMDH_Personas_Individual_Set_Archivos", $nombre & ", " & $apellido & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:54]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:54]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_Archivos($nombre, $sigla, $n)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_Archivos", $nombre & ", " & $sigla & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:54]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:54]") == $n )
	UTLogEndTestOK()
EndFunc



Func SMDH_Personas_Individual_Set_FechaRecepcion($nombre, $apellido, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_Personas_Individual_Set_FechaRecepcion", $nombre & ", " & $apellido & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "bservaciones","[CLASS:ComboBox; INSTANCE:22]", "[CLASS:Edit; INSTANCE:60]", "[CLASS:Edit; INSTANCE:59]","[CLASS:Edit; INSTANCE:58]", "[CLASS:Button; INSTANCE:127]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_Personas_Colectiva_Set_FechaRecepcion($nombre, $apellido, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_Personas_Colectiva_Set_FechaRecepcion", $nombre & ", " & $apellido & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "bservaciones","[CLASS:ComboBox; INSTANCE:22]", "[CLASS:Edit; INSTANCE:60]", "[CLASS:Edit; INSTANCE:59]","[CLASS:Edit; INSTANCE:58]", "[CLASS:Button; INSTANCE:127]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_Personas_Individual_Set_ProyectoLocal($nombre, $apellido, $n)
	UTLogInitTest( "SMDH_Personas_Individual_Set_ProyectoLocal", $nombre & ", " & $apellido & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:57]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:57]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_ProyectoLocal($nombre, $sigla, $n)
	UTLogInitTest( "SMDH_Personas_Individual_Set_ProyectoLocal", $nombre & ", " & $sigla & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:57]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:57]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_Set_ProyectoConjunto($nombre, $apellido, $n)
	UTLogInitTest( "SMDH_Personas_Individual_Set_ProyectoConjunto", $nombre & ", " & $apellido & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:56]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:56]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Colectiva_Set_ProyectoConjunto($nombre, $sigla, $n)
	UTLogInitTest( "SMDH_Personas_Colectiva_Set_ProyectoConjunto", $nombre & ", " & $sigla & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "bservaciones") )
	UTAssert( ControlSetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:56]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "bservaciones", "[CLASS:Button; INSTANCE:127]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "bservaciones", "[CLASS:Edit; INSTANCE:56]") == $n )
	UTLogEndTestOK()
EndFunc

; Datos Biograficos

Func SMDH_Personas_Individual_DatoBiografico_Simple_Add($nombre, $apellido, $id)
	UTLogInitTest( "SMDH_Personas_Individual_DatoBiografico_Simple_Add", $nombre & ", " & $apellido & ", " & $id );
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	UTAssert( ControlClick($PersonaswTitle, $PersonasBiowText, "[CLASS:Button; INSTANCE:128]") )
	UTAssert( WinWaitActive("Dato biográfico", "", 10) )
	UTAssert( ControlClick("Dato biográfico", "", "[CLASS:Button; INSTANCE:6]") )
	UTAssert( ControlSetText("Dato biográfico", "", "[CLASS:Edit; INSTANCE:1]", $id) )
	UTAssert( ControlClick("Dato biográfico", "", "[CLASS:Button; INSTANCE:2]") )
	;verify
	UTAssert( WinWaitActive($PersonaswTitle, $PersonasBiowText, 5) )
 	Local $hList = ControlGetHandle($PersonaswTitle, $PersonasBiowText,"[CLASS:ListBox; INSTANCE:19]")
 	UTAssert( _GUICtrlListBox_FindString($hList, $id, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Relacionado_Add($nombre, $apellido, $tipo, $persona)
	UTLogInitTest( "SMDH_Personas_Individual_DatoBiografico_Relacionado_Add", $nombre & ", " & $apellido & ", " & $tipo & ", " & $persona );
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	UTAssert( ControlClick($PersonaswTitle, $PersonasBiowText, "[CLASS:Button; INSTANCE:128]") )
	UTAssert( WinWaitActive("Dato biográfico", "", 10) )
	UTAssert( ControlClick("Dato biográfico", "", "[CLASS:Button; INSTANCE:7]") )
	; select tipo
	Local $hTree = ControlGetHandle("Dato biográfico", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $tipo)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem, "primary", True, 2 ) )
	; select persona
	Local $hList = ControlGetHandle("Dato biográfico", "","[CLASS:ListBox; INSTANCE:1]")
	Local $hItem = _GUICtrlListBox_SelectString($hList, $persona)
	UTAssert($hItem>=0)
	_GUICtrlListBox_ClickItem($hList, $hItem, "primary", True, 2 )
	;verify
	UTAssert( ControlClick("Dato biográfico","","[CLASS:Button; INSTANCE:2]") )
	UTAssert( WinWaitActive($PersonaswTitle, $PersonasBiowText, 5) )
 	Local $hList = ControlGetHandle($PersonaswTitle, $PersonasBiowText,"[CLASS:ListBox; INSTANCE:19]")
	Local $str = $persona & " [" & $tipo & "]"
 	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) >= 0)
	UTLogEndTestOK()
EndFunc


Func SMDH_Personas_Individual_DatoBiografico_Simple_Exists($nombre, $apellido, $id)
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	Local $str = $id
	Local $hList = ControlGetHandle($PersonaswTitle, $PersonasBiowText, "[CLASS:ListBox; INSTANCE:19]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	Return $item_idx >= 0
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Simple_Select($nombre, $apellido, $id)
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	Local $str = $id
	Local $hList = ControlGetHandle($PersonaswTitle, $PersonasBiowText, "[CLASS:ListBox; INSTANCE:19]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Simple_Borrar($nombre, $apellido, $id, $assert = True)
	UTLogInitTest( "SMDH_Personas_Individual_DatoBiografico_Borrar", $nombre & ", " & $apellido & ", " & $id)
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	Local $str = $id
	Local $hList = ControlGetHandle($PersonaswTitle, $PersonasBiowText, "[CLASS:ListBox; INSTANCE:19]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str,  True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick($PersonaswTitle, $PersonasBiowText, "[CLASS:Button; INSTANCE:134]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Relacionado_Borrar($nombre, $apellido, $tipo, $persona, $assert = True)
	UTLogInitTest( "SMDH_Personas_Individual_DatoBiografico_Borrar", $nombre & ", " & $apellido & ", " & $tipo & ", " & $persona)
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	Local $str = $persona & " [" & $tipo & "]"
	Local $hList = ControlGetHandle($PersonaswTitle, $PersonasBiowText, "[CLASS:ListBox; INSTANCE:19]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str,  True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick($PersonaswTitle, $PersonasBiowText, "[CLASS:Button; INSTANCE:134]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Set_FechaInicial($nombre, $apellido, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_Personas_Individual_DatoBiografico_Set_FechaInicial", $nombre & ", " & $apellido & ", " &  $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, $PersonaswTitle , $PersonasBiowText,"[CLASS:ComboBox; INSTANCE:24]", "[CLASS:Edit; INSTANCE:68]", "[CLASS:Edit; INSTANCE:67]","[CLASS:Edit; INSTANCE:66]", "[CLASS:Button; INSTANCE:129]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Set_FechaFinal($nombre, $apellido, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_Personas_Individual_DatoBiografico_Set_FechaFinal", $nombre & ", " & $apellido & ", " &  $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, $PersonaswTitle , $PersonasBiowText,"[CLASS:ComboBox; INSTANCE:23]", "[CLASS:Edit; INSTANCE:71]", "[CLASS:Edit; INSTANCE:70]","[CLASS:Edit; INSTANCE:69]", "[CLASS:Button; INSTANCE:129]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia", $nombre & ", " & $apellido & ", " &  $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, $PersonaswTitle , $PersonasBiowText,"[CLASS:ComboBox; INSTANCE:25]", "[CLASS:Edit; INSTANCE:74]", "[CLASS:Edit; INSTANCE:73]","[CLASS:Edit; INSTANCE:72]", "[CLASS:Button; INSTANCE:129]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Set_Observaciones($nombre, $apellido, $n)
	UTLogInitTest( "SMDH_Personas_Individual_DatoBiografico_Set_Observaciones", $nombre & ", " & $apellido & ", " & $n );
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	UTAssert( ControlSetText($PersonaswTitle, $PersonasBiowText, "[CLASS:Edit; INSTANCE:61]", $n) )
	UTAssert( ControlClick($PersonaswTitle, $PersonasBiowText, "[CLASS:Button; INSTANCE:129]") )
	; verify
	UTAssert( ControlGetText($PersonaswTitle, $PersonasBiowText, "[CLASS:Edit; INSTANCE:61]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Set_Comentarios($nombre, $apellido, $n)
	UTLogInitTest( "SMDH_Personas_Individual_DatoBiografico_Set_Comentarios", $nombre & ", " & $apellido & ", " & $n );
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	UTAssert( ControlSetText($PersonaswTitle, $PersonasBiowText, "[CLASS:Edit; INSTANCE:62]", $n) )
	UTAssert( ControlClick($PersonaswTitle, $PersonasBiowText, "[CLASS:Button; INSTANCE:129]") )
	; verify
	UTAssert( ControlGetText($PersonaswTitle, $PersonasBiowText, "[CLASS:Edit; INSTANCE:62]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_Personas_Individual_DatoBiografico_Set_ExportarDatoBiografico($nombre, $apellido, $val)
	UTLogInitTest( "SMDH_Personas_Individual_DatoBiografico_Set_ExportarDatoBiografico", $nombre & ", " & $apellido & ", " & $val );
	UTAssert( WinActive($PersonaswTitle, $PersonasBiowText) )
	If ( GUI_Is_CheckBox_Checked($PersonaswTitle, $PersonasBiowText,"[CLASS:Button; INSTANCE:130]") <> $val) Then
		UTAssert( ControlClick($PersonaswTitle, $PersonasBiowText, "[CLASS:Button; INSTANCE:130]") )
		UTAssert( ControlClick($PersonaswTitle, $PersonasBiowText, "[CLASS:Button; INSTANCE:129]") )
	EndIf
	UTAssert( GUI_Is_CheckBox_Checked($PersonaswTitle, $PersonasBiowText,"[CLASS:Button; INSTANCE:130]") = $val)
	UTLogEndTestOK()
EndFunc
