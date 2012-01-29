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
	UTAssert( WinWaitActive("Manejo de Casos", "NBActosPerp", 5) )
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
	UTAssert( WinWaitActive("Manejo de Casos", "Actos registrados", 5) )
	Local $hList = ControlGetHandle("Manejo de Casos", "Actos registrados", "[CLASS:ListBox; INSTANCE:7]")
	Local $str = $victima & " / " & $tipo
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Exist($victima, $tipo)
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	Local $str = $victima & " / " & $tipo
	Local $hList = ControlGetHandle("Manejo de Casos","Actos registrados","[CLASS:ListBox; INSTANCE:7]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	Return $item_idx >= 0
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


Func SMDH_ManejoDeCasos_Actos_Set_FechaInicial($victima, $tipov, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_ManejoDeCasos_Actos_Set_FechaInicial", $victima & ", " & $tipov & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "Actos registrados","[CLASS:ComboBox; INSTANCE:8]", "[CLASS:Edit; INSTANCE:34]", "[CLASS:Edit; INSTANCE:33]","[CLASS:Edit; INSTANCE:32]", "[CLASS:Button; INSTANCE:50]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_FechaFinal($victima, $tipov, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_ManejoDeCasos_Actos_Set_FechaFinal", $victima & ", " & $tipov & ", " & $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, "Manejo de Casos" , "Actos registrados","[CLASS:ComboBox; INSTANCE:9]", "[CLASS:Edit; INSTANCE:37]", "[CLASS:Edit; INSTANCE:36]","[CLASS:Edit; INSTANCE:35]", "[CLASS:Button; INSTANCE:50]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Get_CaracteristicasRelevantes($victima, $tipov)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Get_CaracteristicasRelevantes", $victima & ", " & $tipov);
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:52]") )
	UTAssert( WinWaitActive("Características relevantes", "", 5) )
	Local $hTree = ControlGetHandle("Características relevantes", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, False, True)
	UTAssert( ControlClick("Características relevantes", "", "[CLASS:Button; INSTANCE:4]") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_ManejoDeCasos_Actos_Add_CaracteristicaRelevante($victima, $tipov, $item)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Add_CaracteristicaRelevante", $victima & ", " & $tipov & ", " & $item );
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:52]") )
	UTAssert( WinWaitActive("Características relevantes", "", 5) )
	Local $hTree = ControlGetHandle("Características relevantes", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $item)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("Características relevantes", "", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Manejo de Casos", "Actos registrados") )
	;verify
	Local $hList = ControlGetHandle("Manejo de Casos", "Actos registrados","[CLASS:ListBox; INSTANCE:8]")
	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Remove_CaracteristicaRelevante($victima, $tipov, $item)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Remove_CaracteristicaRelevante", $victima & ", " & $tipov & ", " & $item);
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	Local $hList = ControlGetHandle("Manejo de Casos", "Actos registrados","[CLASS:ListBox; INSTANCE:8]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $item)>=0)
	;Local $hItem = _GUICtrlListBox_FindString($hList, $item, True)
	;UTAssert(  $hItem >= 0)
	;_GUICtrlListBox_ClickItem($hList, $hItem)
	UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:64]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( _GUICtrlListBox_FindString($hList, $item, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Get_TiposLugares($victima, $tipov)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Get_TiposLugares", $victima & ", " & $tipov);
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:53]") )
	UTAssert( WinWaitActive("Tipo de lugar", "", 5) )
	Local $hTree = ControlGetHandle("Tipo de lugar", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	$items = GetArrayFromTreeView($hTree, False, True)
	UTAssert( ControlClick("Tipo de lugar", "", "[CLASS:Button; INSTANCE:4]") )
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_TipoLugar($victima, $tipov, $item)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_TipoLugar", $victima & ", " & $tipov & ", " & $item );
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:53]") )
	UTAssert( WinWaitActive("Tipo de lugar", "", 5) )
	Local $hTree = ControlGetHandle("Tipo de lugar", "", "[CLASS:SysTreeView32; INSTANCE:1]")
	UTAssert( $hTree )
	Local $hItem = _GUICtrlTreeView_FindItem($hTree, $item)
	UTAssert( $hItem )
	_GUICtrlTreeView_EnsureVisible($hTree, $hItem)
;	_GUICtrlTreeView_Expand($hTree, $hItem)
	UTAssert( _GUICtrlTreeView_ClickItem($hTree, $hItem) )
	UTAssert( ControlClick("Tipo de lugar", "", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinWaitActive("Manejo de Casos", "Actos registrados") )
	;verify
	UTAssert( ControlGetText("Manejo de Casos", "Actos registrados", "[CLASS:Static; INSTANCE:79]") == $item )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Remove_TipoLugar($victima, $tipov)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Remove_TipoLugar", $victima & ", " & $tipov);
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:59]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( ControlGetText("Manejo de Casos", "Actos registrados", "[CLASS:Static; INSTANCE:79]") == "" )
	UTLogEndTestOK()
EndFunc

Local $EstatusVDHwTitle = "Manejo de Casos"
Local $EstatusVDHwText = "Actos registrados"
Local $EstatusVDHbAdd = "[CLASS:Button; INSTANCE:54]"
Local $EstatusVDHbRemove = "[CLASS:Button; INSTANCE:61]"
Local $EstatusVDHstatic = "[CLASS:Static; INSTANCE:82]"
Local $EstatusVDHsTitle = "Estatus de la VDH"
Local $EstatusVDHsOK = "[CLASS:Button; INSTANCE:1]"
Local $EstatusVDHsCancel = "[CLASS:Button; INSTANCE:4]"
Local $EstatusVDHtree = "[CLASS:SysTreeView32; INSTANCE:1]"

Func SMDH_ManejoDeCasos_Actos_Get_EstatusVDHs($victima, $tipov)
	return SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Get_EstatusVDHs", $victima & ", " & $tipov, $EstatusVDHwTitle, $EstatusVDHwText, $EstatusVDHbAdd, $EstatusVDHbRemove, $EstatusVDHstatic, $EstatusVDHsTitle, $EstatusVDHsOK, $EstatusVDHsCancel, $EstatusVDHtree)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_EstatusVDH($victima, $tipov, $item)
	SMDH_SetFromTreeViewList_Single("SMDH_ManejoDeCasos_Actos_Set_EstatusVDH", $victima & ", " & $tipov, $EstatusVDHwTitle, $EstatusVDHwText, $EstatusVDHbAdd, $EstatusVDHbRemove, $EstatusVDHstatic, $EstatusVDHsTitle, $EstatusVDHsOK, $EstatusVDHsCancel, $EstatusVDHtree, $item)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Remove_EstatusVDH($victima, $tipov)
	SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Remove_EstatusVDH", $victima & ", " & $tipov, $EstatusVDHwTitle, $EstatusVDHwText, $EstatusVDHbAdd, $EstatusVDHbRemove, $EstatusVDHstatic, $EstatusVDHsTitle, $EstatusVDHsOK, $EstatusVDHsCancel, $EstatusVDHtree)
EndFunc

Local $EstatusVictimawTitle = "Manejo de Casos"
Local $EstatusVictimawText = "Actos registrados"
Local $EstatusVictimabAdd = "[CLASS:Button; INSTANCE:55]"
Local $EstatusVictimabRemove = "[CLASS:Button; INSTANCE:60]"
Local $EstatusVictimastatic = "[CLASS:Static; INSTANCE:83]"
Local $EstatusVictimasTitle = "Estatus de la víctima"
Local $EstatusVictimasOK = "[CLASS:Button; INSTANCE:1]"
Local $EstatusVictimasCancel = "[CLASS:Button; INSTANCE:4]"
Local $EstatusVictimatree = "[CLASS:SysTreeView32; INSTANCE:1]"

Func SMDH_ManejoDeCasos_Actos_Get_EstatusVictimas($victima, $tipov)
	return SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Get_EstatusVictimas", $victima & ", " & $tipov, $EstatusVictimawTitle, $EstatusVictimawText, $EstatusVictimabAdd, $EstatusVictimabRemove, $EstatusVictimastatic, $EstatusVictimasTitle, $EstatusVictimasOK, $EstatusVictimasCancel, $EstatusVictimatree)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_EstatusVictima($victima, $tipov, $item)
	SMDH_SetFromTreeViewList_Single("SMDH_ManejoDeCasos_Actos_Set_EstatusVictima", $victima & ", " & $tipov, $EstatusVictimawTitle, $EstatusVictimawText, $EstatusVictimabAdd, $EstatusVictimabRemove, $EstatusVictimastatic, $EstatusVictimasTitle, $EstatusVictimasOK, $EstatusVictimasCancel, $EstatusVictimatree, $item)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Remove_EstatusVictima($victima, $tipov)
	SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Remove_EstatusVictima", $victima & ", " & $tipov, $EstatusVictimawTitle, $EstatusVictimawText, $EstatusVictimabAdd, $EstatusVictimabRemove, $EstatusVictimastatic, $EstatusVictimasTitle, $EstatusVictimasOK, $EstatusVictimasCancel, $EstatusVictimatree)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_Observaciones($victima, $tipov, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_Observaciones", $victima & ", " & $tipov & ", " & $n );
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	UTAssert( ControlSetText("Manejo de Casos", "Actos registrados", "[CLASS:Edit; INSTANCE:30]", $n) )
	UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:50]") )
	; verify
	UTAssert( ControlGetText("Manejo de Casos", "Actos registrados", "[CLASS:Edit; INSTANCE:30]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_ExportarActo($victima, $tipov, $val)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Set_ExportarActo", $victima & ", " & $tipov & ", " & $val );
	UTAssert( WinActive("Manejo de Casos", "Actos registrados") )
	If ( GUI_Is_CheckBox_Checked("Manejo de Casos", "Actos registrados","[CLASS:Button; INSTANCE:56]") <> $val) Then
		UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:56]") )
		UTAssert( ControlClick("Manejo de Casos", "Actos registrados", "[CLASS:Button; INSTANCE:50]") )
	EndIf
	UTAssert( GUI_Is_CheckBox_Checked("Manejo de Casos", "Actos registrados","[CLASS:Button; INSTANCE:56]") = $val)
	UTLogEndTestOK()
EndFunc


Func SMDH_ManejoDeCasos_Actos_Add_Perpetrador($victima, $tipov, $perpetrador)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Add_Perpetrador", $victima & ", " & $tipov & ", " & $perpetrador )
	UTAssert( WinActive("Manejo de Casos", "NBActosPerp") )
	UTAssert( ControlClick("Manejo de Casos", "NBActosPerp", "[CLASS:Button; INSTANCE:65]") )
	UTAssert( WinWaitActive("Seleccionar una persona", "", 10) )
	$a = WinList("Seleccionar una persona")
	Local $hList = ControlGetHandle("Seleccionar una persona", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $perpetrador)>=0)
	UTAssert( ControlClick("Seleccionar una persona","","[CLASS:Button; INSTANCE:7]") )
	; verify
	UTAssert( WinWaitActive("Manejo de Casos", "NBActosPerp", 5) )
	Local $hList = ControlGetHandle("Manejo de Casos", "NBActosPerp","[CLASS:ListBox; INSTANCE:10]")
	UTAssert( _GUICtrlListBox_FindString($hList, $perpetrador, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Actos_Remove_Perpetrador($victima, $tipov, $perpetrador, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Actos_Remove_Perpetrador", $victima & ", " & $tipov & ", " & $perpetrador )
	UTAssert( WinActive("Manejo de Casos", "NBActosPerp") )
	Local $hList = ControlGetHandle("Manejo de Casos", "NBActosPerp", "[CLASS:ListBox; INSTANCE:10]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $perpetrador, True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick("Manejo de Casos", "NBActosPerp", "[CLASS:Button; INSTANCE:78]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinActive("Manejo de Casos", "NBActosPerp") )
	UTAssert( _GUICtrlListBox_FindString($hList, $perpetrador, True) < 0)
	UTLogEndTestOK()
EndFunc

Local $GradoInvolucramientowTitle = "Manejo de Casos"
Local $GradoInvolucramientowText = "NBActosPerp"
Local $GradoInvolucramientobAdd = "[CLASS:Button; INSTANCE:68]"
Local $GradoInvolucramientobRemove = "[CLASS:Button; INSTANCE:75]"
Local $GradoInvolucramientostatic = "[CLASS:Static; INSTANCE:99]"
Local $GradoInvolucramientosTitle = "Grado de involucramiento"
Local $GradoInvolucramientosOK = "[CLASS:Button; INSTANCE:1]"
Local $GradoInvolucramientosCancel = "[CLASS:Button; INSTANCE:4]"
Local $GradoInvolucramientotree = "[CLASS:SysTreeView32; INSTANCE:1]"

Func SMDH_ManejoDeCasos_Actos_Get_GradosInvolucramientos($victima, $tipov, $perpetrador)
	return SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Get_GradosInvolucramientos", $victima & ", " & $tipov & ", " & $perpetrador, $GradoInvolucramientowTitle, $GradoInvolucramientowText, $GradoInvolucramientobAdd, $GradoInvolucramientobRemove, $GradoInvolucramientostatic, $GradoInvolucramientosTitle, $GradoInvolucramientosOK, $GradoInvolucramientosCancel, $GradoInvolucramientotree)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_GradoInvolucramiento($victima, $tipov, $perpetrador, $item)
	SMDH_SetFromTreeViewList_Single("SMDH_ManejoDeCasos_Actos_Set_GradoInvolucramiento", $victima & ", " & $tipov & ", " & $perpetrador, $GradoInvolucramientowTitle, $GradoInvolucramientowText, $GradoInvolucramientobAdd, $GradoInvolucramientobRemove, $GradoInvolucramientostatic, $GradoInvolucramientosTitle, $GradoInvolucramientosOK, $GradoInvolucramientosCancel, $GradoInvolucramientotree, $item)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Remove_GradoInvolucramiento($victima, $tipov, $perpetrador)
	SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Remove_GradoInvolucramiento", $victima & ", " & $tipov & ", " & $perpetrador, $GradoInvolucramientowTitle, $GradoInvolucramientowText, $GradoInvolucramientobAdd, $GradoInvolucramientobRemove, $GradoInvolucramientostatic, $GradoInvolucramientosTitle, $GradoInvolucramientosOK, $GradoInvolucramientosCancel, $GradoInvolucramientotree)
EndFunc

Local $TipoPerpetradorwTitle = "Manejo de Casos"
Local $TipoPerpetradorwText = "NBActosPerp"
Local $TipoPerpetradorbAdd = "[CLASS:Button; INSTANCE:69]"
Local $TipoPerpetradorbRemove = "[CLASS:Button; INSTANCE:74]"
Local $TipoPerpetradorstatic = "[CLASS:Static; INSTANCE:98]"
Local $TipoPerpetradorsTitle = "Tipo de perpetrador"
Local $TipoPerpetradorsOK = "[CLASS:Button; INSTANCE:1]"
Local $TipoPerpetradorsCancel = "[CLASS:Button; INSTANCE:4]"
Local $TipoPerpetradortree = "[CLASS:SysTreeView32; INSTANCE:1]"

Func SMDH_ManejoDeCasos_Actos_Get_TiposPerpetradores($victima, $tipov, $perpetrador)
	return SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Get_TiposPerpetradores", $victima & ", " & $tipov & ", " & $perpetrador, $TipoPerpetradorwTitle, $TipoPerpetradorwText, $TipoPerpetradorbAdd, $TipoPerpetradorbRemove, $TipoPerpetradorstatic, $TipoPerpetradorsTitle, $TipoPerpetradorsOK, $TipoPerpetradorsCancel, $TipoPerpetradortree)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_TipoPerpetrador($victima, $tipov, $perpetrador, $item)
	SMDH_SetFromTreeViewList_Single("SMDH_ManejoDeCasos_Actos_Set_TipoPerpetrador", $victima & ", " & $tipov & ", " & $perpetrador, $TipoPerpetradorwTitle, $TipoPerpetradorwText, $TipoPerpetradorbAdd, $TipoPerpetradorbRemove, $TipoPerpetradorstatic, $TipoPerpetradorsTitle, $TipoPerpetradorsOK, $TipoPerpetradorsCancel, $TipoPerpetradortree, $item)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Remove_TipoPerpetrador($victima, $tipov, $perpetrador)
	SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Remove_TipoPerpetrador", $victima & ", " & $tipov & ", " & $perpetrador, $TipoPerpetradorwTitle, $TipoPerpetradorwText, $TipoPerpetradorbAdd, $TipoPerpetradorbRemove, $TipoPerpetradorstatic, $TipoPerpetradorsTitle, $TipoPerpetradorsOK, $TipoPerpetradorsCancel, $TipoPerpetradortree)
EndFunc

Local $UltimoEstatuswTitle = "Manejo de Casos"
Local $UltimoEstatuswText = "NBActosPerp"
Local $UltimoEstatusbAdd = "[CLASS:Button; INSTANCE:70]"
Local $UltimoEstatusbRemove = "[CLASS:Button; INSTANCE:73]"
Local $UltimoEstatusstatic = "[CLASS:Static; INSTANCE:97]"
Local $UltimoEstatussTitle = "Último estatus de perpetrador"
Local $UltimoEstatussOK = "[CLASS:Button; INSTANCE:1]"
Local $UltimoEstatussCancel = "[CLASS:Button; INSTANCE:4]"
Local $UltimoEstatustree = "[CLASS:SysTreeView32; INSTANCE:1]"

Func SMDH_ManejoDeCasos_Actos_Get_UltimosEstatus($victima, $tipov, $perpetrador)
	return SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Get_UltimosEstatus", $victima & ", " & $tipov & ", " & $perpetrador, $UltimoEstatuswTitle, $UltimoEstatuswText, $UltimoEstatusbAdd, $UltimoEstatusbRemove, $UltimoEstatusstatic, $UltimoEstatussTitle, $UltimoEstatussOK, $UltimoEstatussCancel, $UltimoEstatustree)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Set_UltimoEstatus($victima, $tipov, $perpetrador, $item)
	SMDH_SetFromTreeViewList_Single("SMDH_ManejoDeCasos_Actos_Set_UltimoEstatus", $victima & ", " & $tipov & ", " & $perpetrador, $UltimoEstatuswTitle, $UltimoEstatuswText, $UltimoEstatusbAdd, $UltimoEstatusbRemove, $UltimoEstatusstatic, $UltimoEstatussTitle, $UltimoEstatussOK, $UltimoEstatussCancel, $UltimoEstatustree, $item)
EndFunc

Func SMDH_ManejoDeCasos_Actos_Remove_UltimoEstatus($victima, $tipov, $perpetrador)
	SMDH_GetTreeViewList("SMDH_ManejoDeCasos_Actos_Remove_UltimoEstatus", $victima & ", " & $tipov & ", " & $perpetrador, $UltimoEstatuswTitle, $UltimoEstatuswText, $UltimoEstatusbAdd, $UltimoEstatusbRemove, $UltimoEstatusstatic, $UltimoEstatussTitle, $UltimoEstatussOK, $UltimoEstatussCancel, $UltimoEstatustree)
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

