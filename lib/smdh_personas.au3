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
Global Const $FECHA_TIPO_VACIO = ""
Global Const $FECHA_TIPO_EXACTA = "Fecha exacta"
Global Const $FECHA_TIPO_APROX = "Fecha aproximada"
Global Const $FECHA_TIPO_NO_DIA = "Se desconoce el día"
Global Const $FECHA_TIPO_NO_MES = "Se desconoce el día y el mes"

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
