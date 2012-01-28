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

Func SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_DatosGenerales_Open")
	UTAssert( WinActive("Manejo de Casos", "NBCasos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR5", "primary", 1, 55, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "casos registrados", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_InformacionNarrativa_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_InformacionNarrativa_Open")
	UTAssert( WinActive("Manejo de Casos", "NBCasos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR5", "primary", 1, 176, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "narrativa", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_InformacionAdministrativa_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_InformacionAdministrativa_Open")
	UTAssert( WinActive("Manejo de Casos", "NBCasos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR5", "primary", 1, 330, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "omentarios", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Tipificaciones_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Tipificaciones_Open")
	UTAssert( WinActive("Manejo de Casos", "NBCasos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR5", "primary", 1, 460, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "afectados", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Relaciones_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Relaciones_Open")
	UTAssert( WinActive("Manejo de Casos", "NBCasos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR5", "primary", 1, 540, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "elacionado", 10) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Nuevo($caso)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Nuevo", $caso )
	UTAssert( WinActive("Manejo de Casos", "NBCasos") )
	UTAssert( ControlClick("Manejo de Casos","","Nuevo caso") )
	UTAssert( WinWaitActive("Nombre del caso", "", 10) )
	UTAssert( ControlSetText("Nombre del caso", "", "[CLASS:Edit; INSTANCE:1]", $caso) )
	UTAssert( ControlClick("Nombre del caso", "Seleccionar", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( not WinExists("Alerta", "existe un caso") )
	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:2]")
	UTAssert( _GUICtrlListBox_FindString($hList, $caso, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Select($caso)
	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:2]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $caso, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc

Func SMDH_ManejoDeCasos_Casos_Borrar($caso, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Borrar", $caso);
	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:2]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $caso, True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick("Manejo de Casos", "casos registrados", "Borrar caso") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( _GUICtrlListBox_FindString($hList, $caso, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_BusquedaRapida($search)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_BusquedaRapida");
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlSetText("Manejo de Casos", "", "[CLASS:Edit; INSTANCE:10]", $search) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_Nombre($caso, $nuevo)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_Nombre", $caso & ", " & $nuevo );
	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
	SMDH_ManejoDeCasos_Casos_Select($caso)
	UTAssert( ControlSetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:8]", $nuevo) )
	UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:17]") )
	; verify
	SMDH_ManejoDeCasos_Casos_Select($nuevo)
	UTAssert( ControlGetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:8]") == $nuevo )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_FechaInicial($caso, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_ManejoDeCasos_Casos_Set_FechaInicial", $caso & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "casos registrados","[CLASS:ComboBox; INSTANCE:2]", "[CLASS:Edit; INSTANCE:12]", "[CLASS:Edit; INSTANCE:13]","[CLASS:Edit; INSTANCE:11]", "[CLASS:Button; INSTANCE:17]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_FechaFinal($caso, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_ManejoDeCasos_Casos_Set_FechaFinal", $caso & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "casos registrados","[CLASS:ComboBox; INSTANCE:3]", "[CLASS:Edit; INSTANCE:16]", "[CLASS:Edit; INSTANCE:15]","[CLASS:Edit; INSTANCE:14]", "[CLASS:Button; INSTANCE:17]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_NumeroPersonasAfectadas($caso, $n, $expect_failure = False)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_NumeroPersonasAfectadas", $caso & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
	UTAssert( ControlSetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:9]", "") )
	UTAssert( ControlSend("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:9]", String($n)) )
	UTAssert( ControlClick("Manejo de Casos", "casos registrados", "Guardar") )
	; verify
	If ($expect_failure) Then
		UTAssert( ControlGetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:9]") <> $n )
	Else
		UTAssert( ControlGetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:9]") == $n )
	EndIf
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_ExportarCaso($caso, $val)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_ExportarCaso", $caso & ", " & $val );
	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
	If ( GUI_Is_CheckBox_Checked("Manejo de Casos", "casos registrados","[CLASS:Button; INSTANCE:18]") <> $val) Then
		UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:18]") )
		UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:17]") )
	EndIf
	UTAssert( GUI_Is_CheckBox_Checked("Manejo de Casos", "casos registrados","[CLASS:Button; INSTANCE:18]") = $val)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_ExportarRelaciones($caso, $val)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_ExportarRelaciones", $caso & ", " & $val );
	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
	If ( GUI_Is_CheckBox_Checked("Manejo de Casos", "casos registrados","[CLASS:Button; INSTANCE:29]") <> $val) Then
		UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:29]") )
		UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:17]") )
	EndIf
	UTAssert( GUI_Is_CheckBox_Checked("Manejo de Casos", "casos registrados","[CLASS:Button; INSTANCE:29]") = $val)
	UTLogEndTestOK()
EndFunc
