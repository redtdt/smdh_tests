#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "smdh_gui_utils.au3"

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

