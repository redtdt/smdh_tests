#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

Func SMDH_ManejoDeCasos_Actos_InformacionGeneral_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_InformacionGeneral_Open")
	UTAssert( WinActive("Manejo de Casos", "NBActos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR12", "primary", 1, 64, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "Actos registrados", 5) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Perpetradores_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Perpetradores_Open")
	UTAssert( WinActive("Manejo de Casos", "NBActos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR12", "primary", 1, 180, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "Perpetradores", 5) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Normatividad_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Normatividad_Open")
	UTAssert( WinActive("Manejo de Casos", "NBActos") )
	UTAssert( ControlClick("Manejo de Casos","","wxWindowClassNR12", "primary", 1, 270, 14) )
	UTAssert( WinWaitActive("Manejo de Casos", "normatividad", 5) )
	UTLogEndTestOK()
EndFunc



Func SMDH_ManejoDeCasos_Actos_Nuevo_Victima_Select($victima)
	UTAssert( WinActive("Nuevo acto", "") )
	UTAssert( ControlClick("Nuevo acto","","[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Seleccionar una persona", "", 10) )
	Local $hList = ControlGetHandle("Seleccionar una persona", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $victima)>=0)
	UTAssert( ControlClick("Seleccionar una persona","","[CLASS:Button; INSTANCE:7]") )
EndFunc

Func SMDH_ManejoDeCasos_Actos_Nuevo_Tipo_Select($tipo)
	UTAssert( WinActive("Nuevo acto", "") )
	UTAssert( ControlClick("Nuevo acto","","[CLASS:Button; INSTANCE:2]") )
	UTAssert( WinWaitActive("Tipo de acto", "", 10) )
	Local $hTree = ControlGetHandle("Tipo de acto", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $tipo)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("Tipo de acto","","[CLASS:Button; INSTANCE:1]") )
EndFunc

Func SMDH_ManejoDeCasos_Actos_Nuevo($victima, $tipo)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Nuevo", $victima & ", " & $tipo )
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	; select victima
	UTAssert( ControlClick("Manejo de Casos","","[CLASS:Button; INSTANCE:49]") )
	UTAssert( WinWaitActive("Nuevo acto", "", 10) )
	SMDH_ManejoDeCasos_Actos_Nuevo_Victima_Select($victima)
	; verify victima chosen
	UTAssert( WinWaitActive("Nuevo acto", ""), 5 )
	UTAssert( ControlGetText("Nuevo acto", "", "[CLASS:Static; INSTANCE:2]") == $victima )
	; select tipo
	SMDH_ManejoDeCasos_Actos_Nuevo_Tipo_Select($tipo)
	; verify tipo chosen
	UTAssert( WinWaitActive("Nuevo acto", "") )
	UTAssert( ControlGetText("Nuevo acto", "", "[CLASS:Static; INSTANCE:4]") == $tipo )
	; ok
	UTAssert( ControlClick("Nuevo acto", "", "[CLASS:Button; INSTANCE:3]") )
	; verify
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	Local $hList = ControlGetHandle("Manejo de Casos", "Actos registrados", "[CLASS:ListBox; INSTANCE:7]")
	Local $str = $victima & " / " & $tipo
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) >= 0)
	UTLogEndTestOK()
EndFunc


Func SMDH_ManejoDeCasos_Actos_Select($victima, $tipo)
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	Local $str = $victima & " / " & $tipo
	Local $hList = ControlGetHandle("Manejo de Casos", "Actos registrados", "[CLASS:ListBox; INSTANCE:7]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc


Func SMDH_ManejoDeCasos_Actos_Borrar($victima, $tipo, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Borrar", $victima & ", " & $tipo);
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	Local $str = $victima & " / " & $tipo
	Local $hList = ControlGetHandle("Manejo de Casos", "Actos registrados", "[CLASS:ListBox; INSTANCE:7]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:63]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_BusquedaRapida($search)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_BusquedaRapida");
;~ 	UTAssert( WinActive("Manejo de Casos") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "", "[CLASS:Edit; INSTANCE:10]", $search) )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_Nombre($acto, $nuevo)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_Nombre", $acto & ", " & $nuevo );
;~ 	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
;~ 	SMDH_ManejoDeCasos_Actos_Select($acto)
;~ 	UTAssert( ControlSetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:8]", $nuevo) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:17]") )
;~ 	; verify
;~ 	SMDH_ManejoDeCasos_Actos_Select($nuevo)
;~ 	UTAssert( ControlGetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:8]") == $nuevo )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_FechaInicial($acto, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
;~ 	SMDH_SetFecha("SMDH_ManejoDeCasos_Actos_Set_FechaInicial", $acto & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "casos registrados","[CLASS:ComboBox; INSTANCE:2]", "[CLASS:Edit; INSTANCE:12]", "[CLASS:Edit; INSTANCE:13]","[CLASS:Edit; INSTANCE:11]", "[CLASS:Button; INSTANCE:17]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_FechaFinal($acto, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
;~ 	SMDH_SetFecha("SMDH_ManejoDeCasos_Actos_Set_FechaFinal", $acto & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "casos registrados","[CLASS:ComboBox; INSTANCE:3]", "[CLASS:Edit; INSTANCE:16]", "[CLASS:Edit; INSTANCE:15]","[CLASS:Edit; INSTANCE:14]", "[CLASS:Button; INSTANCE:17]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_NumeroPersonasAfectadas($acto, $n, $expect_failure = False)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_NumeroPersonasAfectadas", $acto & ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:9]", "") )
;~ 	UTAssert( ControlSend("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:9]", String($n)) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "casos registrados", "Guardar") )
;~ 	; verify
;~ 	If ($expect_failure) Then
;~ 		UTAssert( ControlGetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:9]") <> $n )
;~ 	Else
;~ 		UTAssert( ControlGetText("Manejo de Casos", "casos registrados", "[CLASS:Edit; INSTANCE:9]") == $n )
;~ 	EndIf
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_ExportarCaso($acto, $val)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_ExportarCaso", $acto & ", " & $val );
;~ 	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
;~ 	If ( GUI_Is_CheckBox_Checked("Manejo de Casos", "casos registrados","[CLASS:Button; INSTANCE:18]") <> $val) Then
;~ 		UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:18]") )
;~ 		UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:17]") )
;~ 	EndIf
;~ 	UTAssert( GUI_Is_CheckBox_Checked("Manejo de Casos", "casos registrados","[CLASS:Button; INSTANCE:18]") = $val)
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_ExportarRelaciones($acto, $val)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_ExportarRelaciones", $acto & ", " & $val );
;~ 	UTAssert( WinActive("Manejo de Casos", "casos registrados") )
;~ 	If ( GUI_Is_CheckBox_Checked("Manejo de Casos", "casos registrados","[CLASS:Button; INSTANCE:29]") <> $val) Then
;~ 		UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:29]") )
;~ 		UTAssert( ControlClick("Manejo de Casos", "casos registrados", "[CLASS:Button; INSTANCE:17]") )
;~ 	EndIf
;~ 	UTAssert( GUI_Is_CheckBox_Checked("Manejo de Casos", "casos registrados","[CLASS:Button; INSTANCE:29]") = $val)
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_DescripcionNarrativa($acto, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_DescripcionNarrativa", $acto& ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "narrativa") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:17]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "narrativa", "[CLASS:Button; INSTANCE:38]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:17]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_ResumenDescripcion($acto, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_ResumenDescripcion", $acto& ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "narrativa") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:18]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "narrativa", "[CLASS:Button; INSTANCE:38]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:18]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_Observaciones($acto, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_Observaciones", $acto& ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "narrativa") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:19]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "narrativa", "[CLASS:Button; INSTANCE:38]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "narrativa", "[CLASS:Edit; INSTANCE:19]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ ; Administrativa
;~ Func SMDH_ManejoDeCasos_Actos_Set_FechaRecepcion($acto, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
;~ 	SMDH_SetFecha("SMDH_ManejoDeCasos_Actos_Set_FechaRecepcion", $acto & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "omentarios","[CLASS:ComboBox; INSTANCE:7]", "[CLASS:Edit; INSTANCE:27]", "[CLASS:Edit; INSTANCE:26]","[CLASS:Edit; INSTANCE:25]", "[CLASS:Button; INSTANCE:41]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_ProyectoLocal($acto, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_ProyectoLocal", $acto & ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "omentarios") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:20]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:20]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_ProyectoConjunto($acto, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_ProyectoLocal", $acto & ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "omentarios") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:21]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:21]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Administrativa_Set_Comentarios($acto, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Administrativa_Set_Comentarios", $acto & ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "omentarios") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:23]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:23]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Get_EstatusCasos($acto)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Get_EstatusCasos", $acto);
;~ 	UTAssert( WinActive("Manejo de Casos", "omentarios") )
;~ 	Local $hCombo = ControlGetHandle("Manejo de Casos", "omentarios", "[CLASS:ComboBox; INSTANCE:6]")
;~ 	UTAssert( $hCombo )
;~ 	Local $items = GetArrayFromComboBox($hCombo)
;~ 	UTLogEndTestOK()
;~ 	return $items
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_EstatusCaso_Idx($acto, $estatuscaso_idx)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_EstatusCaso_Idx", $acto & ", " & $estatuscaso_idx );
;~ 	UTAssert( WinActive("Manejo de Casos", "omentarios") )
;~ 	If $estatuscaso_idx = 0 Then
;~ 		$idx = -1
;~ 	Else
;~ 		$idx = $estatuscaso_idx
;~ 	EndIf
;~ 	Local $hCombo = ControlGetHandle("Manejo de Casos", "omentarios","[CLASS:ComboBox; INSTANCE:6]")
;~ 	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
;~ 	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
;~ 	; verify
;~ 	$hCombo = ControlGetHandle("Manejo de Casos", "omentarios","[CLASS:ComboBox; INSTANCE:6]")
;~ 	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_Archivos($acto, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_Archivos", $acto & ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "omentarios") )
;~ 	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:24]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:41]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:24]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Get_DerechosAfectados($acto)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Get_DerechosAfectados", $acto);
;~ 	UTAssert( WinActive("Manejo de Casos", "afectados") )
;~ 	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:33]") )
;~ 	UTAssert( WinWaitActive("Derecho afectado", "", 5) )
;~ 	Local $hTree = ControlGetHandle("Derecho afectado", "", "[CLASS:SysTreeView32; INSTANCE:1]")
;~ 	UTAssert( $hTree )
;~ 	$items = GetArrayFromTreeView($hTree, False, True)
;~ 	UTAssert( ControlClick("Derecho afectado", "", "[CLASS:Button; INSTANCE:4]") )
;~ 	UTLogEndTestOK()
;~ 	return $items
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Add_DerechoAfectado($acto, $item)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Add_DerechoAfectado", $acto & ", " & $item );
;~ 	UTAssert( WinActive("Manejo de Casos", "afectados") )
;~ 	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:33]") )
;~ 	UTAssert( WinWaitActive("Derecho afectado", "", 5) )
;~ 	Local $hTree = ControlGetHandle("Derecho afectado", "", "[CLASS:SysTreeView32; INSTANCE:1]")
;~ 	UTAssert( $hTree )
;~ 	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $item)
;~ 	UTAssert( $hItem )
;~ 	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;~ ;	_GUICtrlTreeView_Expand($hTree, $hItem)
;~ ;	MsgBox(0, "","" )
;~ 	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
;~ 	UTAssert( ControlClick("Derecho afectado", "", "[CLASS:Button; INSTANCE:1]") )
;~ 	UTAssert( WinWaitActive("Manejo de Casos", "afectados") )
;~ 	;verify
;~ 	Local $hList = ControlGetHandle("Manejo de Casos", "afectados","[CLASS:ListBox; INSTANCE:5]")
;~ 	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) >= 0)
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Remove_DerechoAfectado($acto, $item)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Remove_DerechoAfectado", $acto & ", " & $item);
;~ 	UTAssert( WinActive("Manejo de Casos", "afectados") )
;~ 	Local $hList = ControlGetHandle("Manejo de Casos", "afectados","[CLASS:ListBox; INSTANCE:5]")
;~ 	UTAssert(_GUICtrlListBox_SelectString($hList, $item)>=0)
;~ 	;Local $hItem = _GUICtrlListBox_FindString($hList, $item, True)
;~ 	;UTAssert(  $hItem >= 0)
;~ 	;_GUICtrlListBox_ClickItem($hList, $hItem)
;~ 	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:36]") )
;~ 	UTAssert( WinWaitActive("Alerta", "", 5) )
;~ 	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
;~ 	;verify
;~ 	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) < 0)
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Get_Temas($acto)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Get_Temas", $acto);
;~ 	UTAssert( WinActive("Manejo de Casos", "afectados") )
;~ 	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:34]") )
;~ 	UTAssert( WinWaitActive("Temas", "", 5) )
;~ 	Local $hTree = ControlGetHandle("Temas", "", "[CLASS:SysTreeView32; INSTANCE:1]")
;~ 	UTAssert( $hTree )
;~ 	$items = GetArrayFromTreeView($hTree, False, True)
;~ 	UTAssert( ControlClick("Temas", "", "[CLASS:Button; INSTANCE:4]") )
;~ 	UTLogEndTestOK()
;~ 	return $items
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Add_Tema($acto, $item)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Add_Tema", $acto & ", " & $item );
;~ 	UTAssert( WinActive("Manejo de Casos", "afectados") )
;~ 	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:34]") )
;~ 	UTAssert( WinWaitActive("Temas", "", 5) )
;~ 	Local $hTree = ControlGetHandle("Temas", "", "[CLASS:SysTreeView32; INSTANCE:1]")
;~ 	UTAssert( $hTree )
;~ 	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $item)
;~ 	UTAssert( $hItem )
;~ 	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;~ ;	_GUICtrlTreeView_Expand($hTree, $hItem)
;~ ;	MsgBox(0, "","" )
;~ 	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
;~ 	UTAssert( ControlClick("Temas", "", "[CLASS:Button; INSTANCE:1]") )
;~ 	UTAssert( WinWaitActive("Manejo de Casos", "afectados") )
;~ 	;verify
;~ 	Local $hList = ControlGetHandle("Manejo de Casos", "afectados","[CLASS:ListBox; INSTANCE:4]")
;~ 	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) >= 0)
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Remove_Tema($acto, $item)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Remove_Tema", $acto & ", " & $item);
;~ 	UTAssert( WinActive("Manejo de Casos", "afectados") )
;~ 	Local $hList = ControlGetHandle("Manejo de Casos", "afectados","[CLASS:ListBox; INSTANCE:4]")
;~ 	UTAssert(_GUICtrlListBox_SelectString($hList, $item)>=0)
;~ 	;Local $hItem = _GUICtrlListBox_FindString($hList, $item, True)
;~ 	;UTAssert(  $hItem >= 0)
;~ 	;_GUICtrlListBox_ClickItem($hList, $hItem)
;~ 	UTAssert( ControlClick("Manejo de Casos", "afectados", "[CLASS:Button; INSTANCE:37]") )
;~ 	UTAssert( WinWaitActive("Alerta", "", 5) )
;~ 	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
;~ 	;verify
;~ 	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) < 0)
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ ; Relaciones
;~ Func SMDH_ManejoDeCasos_Actos_Get_TiposRelaciones($acto)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Get_TiposRelaciones", $acto);
;~ 	UTAssert( WinActive("Manejo de Casos", "elacionado") )
;~ 	UTAssert( ControlClick("Manejo de Casos", "elacionado", "[CLASS:Button; INSTANCE:42]") )
;~ 	UTAssert( WinWaitActive("Seleccionar caso", "", 5) )
;~ 	UTAssert( ControlClick("Seleccionar caso", "", "[CLASS:Button; INSTANCE:3]") )
;~ 	UTAssert( WinWaitActive("Tipo de relacion", "", 5) )
;~ 	Local $hTree = ControlGetHandle("Tipo de relacion", "", "[CLASS:SysTreeView32; INSTANCE:1]")
;~ 	UTAssert( $hTree )
;~ 	$items = GetArrayFromTreeView($hTree, False, True)
;~ 	UTAssert( ControlClick("Tipo de relacion", "", "[CLASS:Button; INSTANCE:4]") )
;~ 	UTAssert( WinWaitActive("Seleccionar caso", "", 5) )
;~ 	UTAssert( ControlClick("Seleccionar caso", "", "[CLASS:Button; INSTANCE:2]") )
;~ 	UTLogEndTestOK()
;~ 	return $items
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Add_Relacion($acto, $acto_rel, $tipo)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Add_Relacion", $acto & ", " & $acto_rel & ", " & $tipo );
;~ 	UTAssert( WinActive("Manejo de Casos", "elacionado") )
;~ 	UTAssert( ControlClick("Manejo de Casos", "elacionado", "[CLASS:Button; INSTANCE:42]") )
;~ 	UTAssert( WinWaitActive("Seleccionar caso", "", 5) )
;~ 	; now select the caso
;~ 	Local $hList = ControlGetHandle("Seleccionar caso", "","[CLASS:ListBox; INSTANCE:1]")
;~ 	UTAssert(_GUICtrlListBox_SelectString($hList, $acto_rel)>=0)
;~ 	; now, select the tipo
;~ 	UTAssert( ControlClick("Seleccionar caso", "", "[CLASS:Button; INSTANCE:3]") )
;~ 	UTAssert( WinWaitActive("Tipo de relacion", "", 5) )
;~ 	Local $hTree = ControlGetHandle("Tipo de relacion", "", "[CLASS:SysTreeView32; INSTANCE:1]")
;~ 	UTAssert( $hTree )
;~ 	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $tipo)
;~ 	UTAssert( $hItem )
;~ 	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;~ 	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
;~ 	UTAssert( ControlClick("Tipo de relacion", "", "[CLASS:Button; INSTANCE:1]") )
;~ 	; weird, there are 2 windows with same title, look for the one visible
;~ 	Local  $a = WinList("Seleccionar caso", "")
;~ 	For $i = 1 To $a[0][0]
;~ 		If BitAND(WinGetState($a[$i][1]), 2) Then
;~ 			UTAssert( WinActivate($a[$i][1]) )
;~ 			Sleep(500)
;~ 			UTAssert( WinActive($a[$i][1]) )
;~ 		EndIf
;~ 	Next
;~ 	UTAssert( ControlClick("Seleccionar caso", "", "[CLASS:Button; INSTANCE:1]") )
;~ 	UTAssert( WinWaitActive("Manejo de Casos", "elacionado", 5) )
;~ 	;verify
;~ 	Local $hList = ControlGetHandle("Manejo de Casos", "elacionado","[CLASS:ListBox; INSTANCE:6]")
;~ 	Local $item_idx = _GUICtrlListBox_FindString($hList, $acto_rel, True)
;~ 	UTAssert( $item_idx >= 0)
;~ 	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
;~ 	UTAssert( ControlGetText("Manejo de Casos", "elacionado", "[CLASS:Static; INSTANCE:62]") == $tipo )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Remove_Relacion($acto, $acto_rel, $assert = True)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Remove_Relacion", $acto & ", " & $acto_rel);
;~ 	UTAssert( WinActive("Manejo de Casos", "elacionado") )
;~ 	Local $hList = ControlGetHandle("Manejo de Casos", "elacionado","[CLASS:ListBox; INSTANCE:6]")
;~ 	Local $item_idx = _GUICtrlListBox_FindString($hList, $acto_rel, True)
;~ 	UTAssert( $item_idx >= 0)
;~ 	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
;~ 	UTAssert( ControlClick("Manejo de Casos", "elacionado", "[CLASS:Button; INSTANCE:47]") )
;~ 	UTAssert( WinWaitActive("Alerta", "", 5) )
;~ 	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
;~ 	;verify
;~ 	UTAssert( _GUICtrlListBox_FindString($hList, $acto_rel, True) < 0)
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_Relacion_Observaciones($acto, $acto_rel, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_Relacion_Observaciones", $acto & ", " & $acto_rel & ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "elacionado") )
;~ 	Local $hList = ControlGetHandle("Manejo de Casos", "elacionado","[CLASS:ListBox; INSTANCE:6]")
;~ 	Local $item_idx = _GUICtrlListBox_FindString($hList, $acto_rel, True)
;~ 	UTAssert( $item_idx >= 0)
;~ 	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
;~ 	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:29]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:46]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:29]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

;~ Func SMDH_ManejoDeCasos_Actos_Set_Relacion_Comentarios($acto, $acto_rel, $n)
;~ 	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_Relacion_Comentarios", $acto & ", " & $acto_rel & ", " & $n );
;~ 	UTAssert( WinActive("Manejo de Casos", "elacionado") )
;~ 	Local $hList = ControlGetHandle("Manejo de Casos", "elacionado","[CLASS:ListBox; INSTANCE:6]")
;~ 	Local $item_idx = _GUICtrlListBox_FindString($hList, $acto_rel, True)
;~ 	UTAssert( $item_idx >= 0)
;~ 	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
;~ 	UTAssert( ControlSetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:28]", $n) )
;~ 	UTAssert( ControlClick("Manejo de Casos", "omentarios", "[CLASS:Button; INSTANCE:46]") )
;~ 	; verify
;~ 	UTAssert( ControlGetText("Manejo de Casos", "omentarios", "[CLASS:Edit; INSTANCE:28]") == $n )
;~ 	UTLogEndTestOK()
;~ EndFunc

