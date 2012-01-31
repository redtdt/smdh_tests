#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"
#include "../../../../lib/smdh_fuentes.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.4.2.6.1 Que guarde correctamente

Local $caso = "Caso de pruebas para fuentes"
Local $fuente = "FuenteDocumental"
Local $nombresitio = "Nombre del sitio de una fuente documental"

Func TearDown()
	SMDH_Terminate_No_Asserts()

	If (@exitCode <> 0) Then
		SMDH_Run()
		SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
		SMDH_ManejoDeCasos_Open()
		SMDH_ManejoDeCasos_Casos_Open()
		SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
		If (SMDH_ManejoDeCasos_Casos_Exist($caso)) Then
			SMDH_ManejoDeCasos_Casos_Select($caso)

			SMDH_ManejoDeCasos_Fuentes_Open()
			SMDH_ManejoDeCasos_Fuentes_Documental_Open()
			SMDH_ManejoDeCasos_Fuentes_Documental_Borrar($caso, $fuente, False)

			; delete caso
			SMDH_ManejoDeCasos_Casos_Open()
			SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
			SMDH_ManejoDeCasos_Casos_Borrar($caso, False)
		EndIf
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()

; create a caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Nuevo($caso)
SMDH_ManejoDeCasos_Casos_Select($caso)

; what we are testing
SMDH_ManejoDeCasos_Fuentes_Open()
SMDH_ManejoDeCasos_Fuentes_Documental_Open()
SMDH_ManejoDeCasos_Fuentes_Documental_Nueva($caso, $fuente)
SMDH_ManejoDeCasos_Fuentes_Set_NombreSitio($caso, $fuente, $nombresitio)
SMDH_ManejoDeCasos_Fuentes_Documental_Borrar($caso, $fuente)

; delete caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Borrar($caso)
