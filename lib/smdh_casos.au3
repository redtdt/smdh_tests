#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

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

Func SMDH_ManejoDeCasos_Casos_Exist($caso)
	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
	Local $hList = ControlGetHandle("Manejo de Casos","","[CLASS:ListBox; INSTANCE:2]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $caso, True)
	Return $item_idx >= 0
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

Func SMDH_ManejoDeCasos_Casos_Set_DescripcionNarrativa($caso, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_DescripcionNarrativa", $caso& ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "narrativa") )
	UTAssert( ControlSetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:17]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "narrativa", "[CLASS:Button; INSTANCE:38]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:17]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_ResumenDescripcion($caso, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_ResumenDescripcion", $caso& ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "narrativa") )
	UTAssert( ControlSetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:18]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "narrativa", "[CLASS:Button; INSTANCE:38]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:18]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_Observaciones($caso, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_Observaciones", $caso& ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "narrativa") )
	UTAssert( ControlSetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:19]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "narrativa", "[CLASS:Button; INSTANCE:38]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:19]") == $n )
	UTLogEndTestOK()
EndFunc

; Administrativa
Func SMDH_ManejoDeCasos_Casos_Set_FechaRecepcion($caso, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_ManejoDeCasos_Casos_Set_FechaRecepcion", $caso & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "omentarios","[CLASS:ComboBox; INSTANCE:7]", "[CLASS:Edit; INSTANCE:27]", "[CLASS:Edit; INSTANCE:26]","[CLASS:Edit; INSTANCE:25]", "[CLASS:Button; INSTANCE:41]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_ProyectoLocal($caso, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_ProyectoLocal", $caso & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "omentarios") )
	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:20]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:20]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_ProyectoConjunto($caso, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_ProyectoLocal", $caso & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "omentarios") )
	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:21]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:21]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Administrativa_Set_Comentarios($caso, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Administrativa_Set_Comentarios", $caso & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "omentarios") )
	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:23]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:23]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Get_EstatusCasos($caso)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Get_EstatusCasos", $caso);
	UTAssert( WinActive("Manejo de Casos", "omentarios") )
	Local $hCombo = ControlGetHandle("Manejo de Casos", "omentarios", "[CLASS:ComboBox; INSTANCE:6]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_EstatusCaso_Idx($caso, $estatuscaso_idx)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_EstatusCaso_Idx", $caso & ", " & $estatuscaso_idx );
	UTAssert( WinActive("Manejo de Casos", "omentarios") )
	If $estatuscaso_idx = 0 Then
		$idx = -1
	Else
		$idx = $estatuscaso_idx
	EndIf
	Local $hCombo = ControlGetHandle("Manejo de Casos", "omentarios","[CLASS:ComboBox; INSTANCE:6]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
	; verify
	$hCombo = ControlGetHandle("Manejo de Casos", "omentarios","[CLASS:ComboBox; INSTANCE:6]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_Archivos($caso, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_Archivos", $caso & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "omentarios") )
	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:24]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:24]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Get_DerechosAfectados($caso)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Get_DerechosAfectados", $caso);
	UTAssert( WinActive("Manejo de Casos", "afectados") )
	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:33]") )
	UTAssert( WinWaitActive("Derecho afectado", "", 5) )
	Local $hTree = ControlGetHandle("Derecho afectado", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, False, True)
	UTAssert( ControlClick("Derecho afectado", "", "[CLASS:Button; INSTANCE:4]") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_ManejoDeCasos_Casos_Add_DerechoAfectado($caso, $item)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Add_DerechoAfectado", $caso & ", " & $item );
	UTAssert( WinActive("Manejo de Casos", "afectados") )
	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:33]") )
	UTAssert( WinWaitActive("Derecho afectado", "", 5) )
	Local $hTree = ControlGetHandle("Derecho afectado", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $item)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;	_GUICtrlTreeView_Expand($hTree, $hItem)
;	MsgBox(0, "","" )
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("Derecho afectado", "", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Manejo de Casos", "afectados", 10) )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "afectados","[CLASS:ListBox; INSTANCE:5]")
	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Remove_DerechoAfectado($caso, $item)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Remove_DerechoAfectado", $caso & ", " & $item);
	UTAssert( WinActive("Manejo de Casos", "afectados") )
	Local $hList = ControlGetHandle("Manejo de Casos", "afectados","[CLASS:ListBox; INSTANCE:5]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $item)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $item, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:36]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Get_Temas($caso)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Get_Temas", $caso);
	UTAssert( WinActive("Manejo de Casos", "afectados") )
	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:34]") )
	UTAssert( WinWaitActive("Temas", "", 5) )
	Local $hTree = ControlGetHandle("Temas", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, False, True)
	UTAssert( ControlClick("Temas", "", "[CLASS:Button; INSTANCE:4]") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_ManejoDeCasos_Casos_Add_Tema($caso, $item)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Add_Tema", $caso & ", " & $item );
	UTAssert( WinActive("Manejo de Casos", "afectados") )
	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:34]") )
	UTAssert( WinWaitActive("Temas", "", 5) )
	Local $hTree = ControlGetHandle("Temas", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $item)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;	_GUICtrlTreeView_Expand($hTree, $hItem)
;	MsgBox(0, "","" )
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("Temas", "", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Manejo de Casos", "afectados", 10) )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "afectados","[CLASS:ListBox; INSTANCE:4]")
	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Remove_Tema($caso, $item)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Remove_Tema", $caso & ", " & $item);
	UTAssert( WinActive("Manejo de Casos", "afectados") )
	Local $hList = ControlGetHandle("Manejo de Casos", "afectados","[CLASS:ListBox; INSTANCE:4]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $item)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $item, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:37]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) < 0)
	UTLogEndTestOK()
EndFunc

; Relaciones
Func SMDH_ManejoDeCasos_Casos_Get_TiposRelaciones($caso)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Get_TiposRelaciones", $caso);
	UTAssert( WinActive("Manejo de Casos", "elacionado") )
	UTAssert( ControlClick("Manejo de Casos", "elacionado", "[CLASS:Button; INSTANCE:42]") )
	UTAssert( WinWaitActive("Seleccionar caso", "", 5) )
	UTAssert( ControlClick("Seleccionar caso", "", "[CLASS:Button; INSTANCE:3]") )
	UTAssert( WinWaitActive("Tipo de relacion", "", 5) )
	Local $hTree = ControlGetHandle("Tipo de relacion", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, False, True)
	UTAssert( ControlClick("Tipo de relacion", "", "[CLASS:Button; INSTANCE:4]") )
	UTAssert( WinWaitActive("Seleccionar caso", "", 5) )
	UTAssert( ControlClick("Seleccionar caso", "", "[CLASS:Button; INSTANCE:2]") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_ManejoDeCasos_Casos_Add_Relacion($caso, $caso_rel, $tipo)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Add_Relacion", $caso & ", " & $caso_rel & ", " & $tipo );
	UTAssert( WinActive("Manejo de Casos", "elacionado") )
	UTAssert( ControlClick("Manejo de Casos", "elacionado", "[CLASS:Button; INSTANCE:42]") )
	UTAssert( WinWaitActive("Seleccionar caso", "", 5) )
	; now select the caso
	Local $hList = ControlGetHandle("Seleccionar caso", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $caso_rel)>=0)
	; now, select the tipo
	UTAssert( ControlClick("Seleccionar caso", "", "[CLASS:Button; INSTANCE:3]") )
	UTAssert( WinWaitActive("Tipo de relacion", "", 5) )
	Local $hTree = ControlGetHandle("Tipo de relacion", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $tipo)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
	Sleep(300)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	Sleep(300)
	UTAssert( ControlClick("Tipo de relacion", "", "[CLASS:Button; INSTANCE:1]") )
	Sleep(500)
	; weird, there are 2 windows with same title, look for the one visible
	Local  $a = WinList("Seleccionar caso", "")
	For $i = 1 To $a[0][0]
		If BitAND(WinGetState($a[$i][1]), 2) Then
			UTAssert( WinActivate($a[$i][1]) )
			Sleep(500)
			UTAssert( WinActive($a[$i][1]) )
		EndIf
	Next
	UTAssert( ControlClick("Seleccionar caso", "", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Manejo de Casos", "elacionado", 5) )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "elacionado","[CLASS:ListBox; INSTANCE:6]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $caso_rel, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlGetText("Manejo de Casos", "elacionado", "[CLASS:Static; INSTANCE:62]") == $tipo )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Remove_Relacion($caso, $caso_rel, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Remove_Relacion", $caso & ", " & $caso_rel);
	UTAssert( WinActive("Manejo de Casos", "elacionado") )
	Local $hList = ControlGetHandle("Manejo de Casos", "elacionado","[CLASS:ListBox; INSTANCE:6]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $caso_rel, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick("Manejo de Casos", "elacionado", "[CLASS:Button; INSTANCE:47]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $caso_rel, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_Relacion_Observaciones($caso, $caso_rel, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_Relacion_Observaciones", $caso & ", " & $caso_rel & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "elacionado") )
	Local $hList = ControlGetHandle("Manejo de Casos", "elacionado","[CLASS:ListBox; INSTANCE:6]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $caso_rel, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:29]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:46]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:29]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Casos_Set_Relacion_Comentarios($caso, $caso_rel, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Set_Relacion_Comentarios", $caso & ", " & $caso_rel & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "elacionado") )
	Local $hList = ControlGetHandle("Manejo de Casos", "elacionado","[CLASS:ListBox; INSTANCE:6]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $caso_rel, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:28]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:46]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:28]") == $n )
	UTLogEndTestOK()
EndFunc

