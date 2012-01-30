#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

Local $FuenteswTitle = "Manejo de Casos"
Local $FuenteswText = "NBFuente"
Local $FuentesDocumentalwText = "NBFuenteDocumental"

Func SMDH_ManejoDeCasos_Fuentes_Personal_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Personal_Open")
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlClick($FuenteswTitle,"","wxWindowClassNR23", "primary", 1, 56, 14) )
	UTAssert( WinWaitActive($FuenteswTitle, "NBFuentePersonal", 5) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Documental_Open()
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Documental_Open")
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlClick($FuenteswTitle,"","wxWindowClassNR23", "primary", 1, 164, 14) )
	UTAssert( WinWaitActive($FuenteswTitle, "NBFuenteDocumental", 5) )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Personal_Nueva($caso, $persona)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Personal_Nueva", $caso & ", " & $persona )
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlClick($FuenteswTitle, $FuenteswText,"[CLASS:Button; INSTANCE:136]") )
	UTAssert( WinWaitActive("Seleccionar una persona", "", 10) )
	Local $hList = ControlGetHandle("Seleccionar una persona", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $persona)>=0)
	UTAssert( ControlClick("Seleccionar una persona","","[CLASS:Button; INSTANCE:7]") )
	; verify
	UTAssert( WinWaitActive($FuenteswTitle, $FuenteswText, ""), 5 )
	Local $hList = ControlGetHandle($FuenteswTitle, $FuenteswText,"[CLASS:ListBox; INSTANCE:20]")
	UTAssert( _GUICtrlListBox_FindString($hList, $persona, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Personal_Exists($caso, $persona)
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	Local $str = $persona
	Local $hList = ControlGetHandle($FuenteswTitle, $FuenteswText, "[CLASS:ListBox; INSTANCE:20]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	Return $item_idx >= 0
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Personal_Select($caso, $persona)
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	Local $str = $persona
	Local $hList = ControlGetHandle($FuenteswTitle, $FuenteswText, "[CLASS:ListBox; INSTANCE:20]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Personal_Borrar($caso, $persona, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Personal_Borrar", $caso & ", " & $persona);
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	Local $str = $persona
	Local $hList = ControlGetHandle($FuenteswTitle, $FuenteswText, "[CLASS:ListBox; INSTANCE:20]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str,  True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick($FuenteswTitle, $FuenteswText, "[CLASS:Button; INSTANCE:147]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_Sobre_Quien($caso, $persona, $sobre)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Set_Sobre_Quien", $caso & ", " & $persona & ", " & $sobre );
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlClick($FuenteswTitle,$FuenteswText,"[CLASS:Button; INSTANCE:139]") )
	UTAssert( WinWaitActive("Seleccionar una persona", "", 10) )
	Local $hList = ControlGetHandle("Seleccionar una persona", "","[CLASS:ListBox; INSTANCE:1]")
	UTAssert(_GUICtrlListBox_SelectString($hList, $sobre)>=0)
	UTAssert( ControlClick("Seleccionar una persona","","[CLASS:Button; INSTANCE:7]") )
	;verify
	UTAssert( WinWaitActive($FuenteswTitle,$FuenteswText, ""), 5 )
	UTAssert( ControlGetText($FuenteswTitle,$FuenteswText, "[CLASS:Static; INSTANCE:193]") == $sobre )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Remove_Sobre_Quien($caso, $persona)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Remove_Sobre_Quien", $caso & ", " & $persona );
	UTAssert( WinActive($FuenteswTitle, $FuenteswText ) )
	UTAssert( ControlClick($FuenteswTitle, $FuenteswText, "[CLASS:Button; INSTANCE:145]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	;verify
	UTAssert( ControlGetText($FuenteswTitle, $FuenteswText, "[CLASS:Static; INSTANCE:193]") == "" )
	UTLogEndTestOK()
EndFunc

Local $ConexionwTitle = $FuenteswTitle
Local $ConexionwText = $FuenteswText
Local $ConexionbAdd = "[CLASS:Button; INSTANCE:140]"
Local $ConexionbRemove = "[CLASS:Button; INSTANCE:144]"
Local $Conexionstatic = "[CLASS:Static; INSTANCE:194]"
Local $ConexionsTitle = "Conexión de la fuente con la información"
Local $ConexionsOK = "[CLASS:Button; INSTANCE:1]"
Local $ConexionsCancel = "[CLASS:Button; INSTANCE:4]"
Local $Conexiontree = "[CLASS:SysTreeView32; INSTANCE:1]"

Func SMDH_ManejoDeCasos_Fuentes_Get_Conexiones($caso, $persona)
	return SMDH_GetTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Get_Conexiones", $caso & ", " & $persona, $ConexionwTitle, $ConexionwText, $ConexionbAdd, $ConexionbRemove, $Conexionstatic, $ConexionsTitle, $ConexionsOK, $ConexionsCancel, $Conexiontree)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_Conexion($caso, $persona, $item)
	SMDH_SetFromTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Set_Conexion", $caso & ", " & $persona, $ConexionwTitle, $ConexionwText, $ConexionbAdd, $ConexionbRemove, $Conexionstatic, $ConexionsTitle, $ConexionsOK, $ConexionsCancel, $Conexiontree, $item)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Remove_Conexion($caso, $persona)
	SMDH_RemoveFromTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Remove_Conexion", $caso & ", " & $persona, $ConexionwTitle, $ConexionwText, $ConexionbAdd, $ConexionbRemove, $Conexionstatic, $ConexionsTitle, $ConexionsOK, $ConexionsCancel, $Conexiontree)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_FechaInformacion($caso, $persona, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_ManejoDeCasos_Fuentes_Set_FechaInformacion", $caso & ", " & $persona & ", " &  $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, $FuenteswTitle , $FuenteswText,"[CLASS:ComboBox; INSTANCE:26]", "[CLASS:Edit; INSTANCE:79]", "[CLASS:Edit; INSTANCE:78]","[CLASS:Edit; INSTANCE:77]", "[CLASS:Button; INSTANCE:141]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Get_Idiomas($caso, $persona)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Get_Idiomas", $caso & ", " & $persona);
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	Local $hCombo = ControlGetHandle($FuenteswTitle, $FuenteswText, "[CLASS:ComboBox; INSTANCE:27]")
	UTAssert( $hCombo )
	Local $items = GetArrayFromComboBox($hCombo)
	UTLogEndTestOK()
	return $items
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_Idioma_Idx($caso, $persona, $Idioma_idx)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Set_Idioma_Idx", $caso & ", " & $persona & ", " & $Idioma_idx );
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	If $Idioma_idx = 0 Then
		$idx = -1
	Else
		$idx = $Idioma_idx
	EndIf
	Local $hCombo = ControlGetHandle($FuenteswTitle, $FuenteswText,"[CLASS:ComboBox; INSTANCE:27]")
	UTAssert( _GUICtrlComboBoxEx_SetCurSel($hCombo, $idx))
	UTAssert( ControlClick($FuenteswTitle, $FuenteswText, "Guardar") )
	; verify
	$hCombo = ControlGetHandle($FuenteswTitle, $FuenteswText,"[CLASS:ComboBox; INSTANCE:27]")
	UTAssert( _GUICtrlComboBoxEx_GetCurSel($hCombo) = $idx)
	UTLogEndTestOK()
EndFunc

Local $LenguaIndigenawTitle = $FuenteswTitle
Local $LenguaIndigenawText = $FuenteswText
Local $LenguaIndigenabAdd = "[CLASS:Button; INSTANCE:148]"
Local $LenguaIndigenabRemove = "[CLASS:Button; INSTANCE:149]"
Local $LenguaIndigenastatic = "[CLASS:Static; INSTANCE:197]"
Local $LenguaIndigenasTitle = "Lengua indígena"
Local $LenguaIndigenasOK = "[CLASS:Button; INSTANCE:1]"
Local $LenguaIndigenasCancel = "[CLASS:Button; INSTANCE:4]"
Local $LenguaIndigenatree = "[CLASS:SysTreeView32; INSTANCE:1]"

Func SMDH_ManejoDeCasos_Fuentes_Get_LenguasIndigenas($caso, $persona)
	return SMDH_GetTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Get_LenguasIndigenas", $caso & ", " & $persona, $LenguaIndigenawTitle, $LenguaIndigenawText, $LenguaIndigenabAdd, $LenguaIndigenabRemove, $LenguaIndigenastatic, $LenguaIndigenasTitle, $LenguaIndigenasOK, $LenguaIndigenasCancel, $LenguaIndigenatree)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_LenguaIndigena($caso, $persona, $item)
	SMDH_SetFromTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Set_LenguaIndigena", $caso & ", " & $persona, $LenguaIndigenawTitle, $LenguaIndigenawText, $LenguaIndigenabAdd, $LenguaIndigenabRemove, $LenguaIndigenastatic, $LenguaIndigenasTitle, $LenguaIndigenasOK, $LenguaIndigenasCancel, $LenguaIndigenatree, $item)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Remove_LenguaIndigena($caso, $persona)
	SMDH_RemoveFromTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Remove_LenguaIndigena", $caso & ", " & $persona, $LenguaIndigenawTitle, $LenguaIndigenawText, $LenguaIndigenabAdd, $LenguaIndigenabRemove, $LenguaIndigenastatic, $LenguaIndigenasTitle, $LenguaIndigenasOK, $LenguaIndigenasCancel, $LenguaIndigenatree)
EndFunc

Local $ConfiabilidadwTitle = $FuenteswTitle
Local $ConfiabilidadwText = $FuenteswText
Local $ConfiabilidadbAdd = "[CLASS:Button; INSTANCE:150]"
Local $ConfiabilidadbRemove = "[CLASS:Button; INSTANCE:151]"
Local $Confiabilidadstatic = "[CLASS:Static; INSTANCE:198]"
Local $ConfiabilidadsTitle = "Confiabilidad"
Local $ConfiabilidadsOK = "[CLASS:Button; INSTANCE:1]"
Local $ConfiabilidadsCancel = "[CLASS:Button; INSTANCE:4]"
Local $Confiabilidadtree = "[CLASS:SysTreeView32; INSTANCE:1]"

Func SMDH_ManejoDeCasos_Fuentes_Get_Confiabilidades($caso, $persona)
	return SMDH_GetTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Get_Confiabilidades", $caso & ", " & $persona, $ConfiabilidadwTitle, $ConfiabilidadwText, $ConfiabilidadbAdd, $ConfiabilidadbRemove, $Confiabilidadstatic, $ConfiabilidadsTitle, $ConfiabilidadsOK, $ConfiabilidadsCancel, $Confiabilidadtree)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_Confiabilidad($caso, $persona, $item)
	SMDH_SetFromTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Set_Confiabilidad", $caso & ", " & $persona, $ConfiabilidadwTitle, $ConfiabilidadwText, $ConfiabilidadbAdd, $ConfiabilidadbRemove, $Confiabilidadstatic, $ConfiabilidadsTitle, $ConfiabilidadsOK, $ConfiabilidadsCancel, $Confiabilidadtree, $item)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Remove_Confiabilidad($caso, $persona)
	SMDH_RemoveFromTreeViewList_Single("SMDH_ManejoDeCasos_Fuentes_Remove_Confiabilidad", $caso & ", " & $persona, $ConfiabilidadwTitle, $ConfiabilidadwText, $ConfiabilidadbAdd, $ConfiabilidadbRemove, $Confiabilidadstatic, $ConfiabilidadsTitle, $ConfiabilidadsOK, $ConfiabilidadsCancel, $Confiabilidadtree)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_Observaciones($caso, $persona, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Set_Observaciones", $caso & ", " & $persona & ", " & $n );
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlSetText($FuenteswTitle, $FuenteswText, "[CLASS:Edit; INSTANCE:75]", $n) )
	UTAssert( ControlClick($FuenteswTitle, $FuenteswText, "[CLASS:Button; INSTANCE:141]") )
	; verify
	UTAssert( ControlGetText($FuenteswTitle, $FuenteswText, "[CLASS:Edit; INSTANCE:75]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_Comentarios($caso, $persona, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Set_Comentarios", $caso & ", " & $persona & ", " & $n );
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	UTAssert( ControlSetText($FuenteswTitle, $FuenteswText, "[CLASS:Edit; INSTANCE:76]", $n) )
	UTAssert( ControlClick($FuenteswTitle, $FuenteswText, "[CLASS:Button; INSTANCE:141]") )
	; verify
	UTAssert( ControlGetText($FuenteswTitle, $FuenteswText, "[CLASS:Edit; INSTANCE:76]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_ExportarFuentePersonal($caso, $persona, $val)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Set_ExportarFuentePersonal", $caso & ", " & $persona & ", " & $val );
	UTAssert( WinActive($FuenteswTitle, $FuenteswText) )
	If ( GUI_Is_CheckBox_Checked($FuenteswTitle, $FuenteswText,"[CLASS:Button; INSTANCE:137]") <> $val) Then
		UTAssert( ControlClick($FuenteswTitle, $FuenteswText, "[CLASS:Button; INSTANCE:137]") )
		UTAssert( ControlClick($FuenteswTitle, $FuenteswText, "[CLASS:Button; INSTANCE:141]") )
	EndIf
	UTAssert( GUI_Is_CheckBox_Checked($FuenteswTitle, $FuenteswText,"[CLASS:Button; INSTANCE:137]") = $val)
	UTLogEndTestOK()
EndFunc

; Fuentes Documentales

Func SMDH_ManejoDeCasos_Fuentes_Documental_Nueva($caso, $id)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Documental_Nueva", $caso & ", " & $id )
	UTAssert( WinActive($FuenteswTitle, $FuentesDocumentalwText) )
	UTAssert( ControlClick($FuenteswTitle, $FuentesDocumentalwText,"[CLASS:Button; INSTANCE:152]") )
	UTAssert( WinWaitActive("Identificación", "", 10) )
	UTAssert( ControlSetText("Identificación", "", "[CLASS:Edit; INSTANCE:1]", $id) )
	UTAssert( ControlClick("Identificación","","[CLASS:Button; INSTANCE:1]") )
	; verify
	UTAssert( WinWaitActive($FuenteswTitle, $FuentesDocumentalwText, ""), 5 )
	Local $hList = ControlGetHandle($FuenteswTitle, $FuentesDocumentalwText,"[CLASS:ListBox; INSTANCE:21]")
	UTAssert( _GUICtrlListBox_FindString($hList, $id, True) >= 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Documental_Exists($caso, $id)
	UTAssert( WinActive($FuenteswTitle, $FuentesDocumentalwText) )
	Local $str = $id
	Local $hList = ControlGetHandle($FuenteswTitle, $FuentesDocumentalwText, "[CLASS:ListBox; INSTANCE:21]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	Return $item_idx >= 0
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Documental_Select($caso, $id)
	UTAssert( WinActive($FuenteswTitle, $FuentesDocumentalwText) )
	Local $str = $id
	Local $hList = ControlGetHandle($FuenteswTitle, $FuentesDocumentalwText, "[CLASS:ListBox; INSTANCE:21]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str, True)
	UTAssert( $item_idx >= 0)
	_GUICtrlListBox_ClickItem($hList, $item_idx, "left", False, 2)
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Documental_Borrar($caso, $id, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Documental_Borrar", $caso & ", " & $id )
	UTAssert( WinActive($FuenteswTitle, $FuentesDocumentalwText) )
	Local $str = $id
	Local $hList = ControlGetHandle($FuenteswTitle, $FuentesDocumentalwText, "[CLASS:ListBox; INSTANCE:21]")
	Local $item_idx = _GUICtrlListBox_FindString($hList, $str,  True)
	If ($assert) Then
		UTAssert( $item_idx >= 0)
	ElseIf ($item_idx < 0) Then
		UTLogEndTestOK()
		Return
	EndIf
	_GUICtrlListBox_ClickItem($hList, $item_idx, "primary", False, 2)
	UTAssert( ControlClick($FuenteswTitle, $FuentesDocumentalwText, "[CLASS:Button; INSTANCE:162]") )
	UTAssert( WinWaitActive("Alerta", "", 5) )
	UTAssert( ControlClick("Alerta", "Yes", "[CLASS:Button; INSTANCE:1]") )
	UTAssert( WinActive($FuenteswTitle, $FuentesDocumentalwText) )
	UTAssert( _GUICtrlListBox_FindString($hList, $str, True) < 0)
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_DatosFuente($caso, $id, $n)
	UTLogInitTest( "SMDH_ManejoDeCasos_Fuentes_Set_DatosFuente", $caso & ", " & $id & ", " & $n );
	UTAssert( WinActive($FuenteswTitle, $FuentesDocumentalwText) )
	UTAssert( ControlSetText($FuenteswTitle, $FuentesDocumentalwText, "[CLASS:Edit; INSTANCE:81]", $n) )
	UTAssert( ControlClick($FuenteswTitle, $FuentesDocumentalwText, "[CLASS:Button; INSTANCE:153]") )
	; verify
	UTAssert( ControlGetText($FuenteswTitle, $FuentesDocumentalwText, "[CLASS:Edit; INSTANCE:81]") == $n )
	UTLogEndTestOK()
EndFunc

Func SMDH_ManejoDeCasos_Fuentes_Set_FechaFuente($caso, $id, $tipo, $anio, $mes = 0, $dia = 0, $expect_failure_anio = False, $expect_failure_mes= False, $expect_failure_dia = False, $expect_failure_saving = False)
	SMDH_SetFecha("SMDH_ManejoDeCasos_Fuentes_Set_FechaFuente", $caso & ", " & $id & ", " &  $tipo  & ", " & $anio  & ", " & $mes & ", " & $dia, $FuenteswTitle , $FuentesDocumentalwText,"[CLASS:ComboBox; INSTANCE:28]", "[CLASS:Edit; INSTANCE:91]", "[CLASS:Edit; INSTANCE:90]","[CLASS:Edit; INSTANCE:89]", "[CLASS:Button; INSTANCE:153]", $tipo, $anio, $mes, $dia, $expect_failure_anio, $expect_failure_mes, $expect_failure_dia, $expect_failure_saving)
EndFunc

