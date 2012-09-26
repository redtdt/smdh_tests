#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../lib/smdh_utils.au3"

SMDH_Run()
SMDH_TerminateOnExit()

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()
SMDH_ManejoDeCasos_CreateCaso("CASO bug 0002")
SMDH_ManejoDeCasos_BusquedaRapida("0002")
Sleep(1000)
UTAssert( ControlClick("Manejo de Casos", "", "[CLASS:Button; INSTANCE:17]") )
Sleep(1000)
; Texto de la busqueda rapida no debiera limpiarse
UTAssert( ControlClick("Manejo de Casos", "", "[CLASS:Button; INSTANCE:17]") )
UTAssert( ControlGetText("Manejo de Casos", "", "[CLASS:Edit; INSTANCE:10]") == "0002" )

