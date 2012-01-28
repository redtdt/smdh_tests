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

Func SMDH_ManejoDeCasos_Casos_Borrar($caso, $assert = True)
	UTLogInitTest( "SMDH_ManejoDeCasos_Casos_Borrar", $caso);
	UTAssert( WinActive("Manejo de Casos", "NBCasos") )
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

Func SMDH_ManejoDeCasos_BusquedaRapida($search)
	UTLogInitTest( "SMDH_ManejoDeCasos_BusquedaRapida");
	UTAssert( WinActive("Manejo de Casos") )
	UTAssert( ControlSetText("Manejo de Casos", "", "[CLASS:Edit; INSTANCE:10]", $search) )
	UTLogEndTestOK()
EndFunc

