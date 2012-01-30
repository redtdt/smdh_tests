#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"
#include "../../../../lib/smdh_fuentes.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.4.1.8.1 Que guarde correctamente

Local $caso = "Caso de pruebas para fuentes"
Local $fuente_nombre = "Cesar"
Local $fuente_apellido = "Sanchez"
Local $fuente = SMDH_Personas_Individual_Compose_String($fuente_nombre, $fuente_apellido)

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
			SMDH_ManejoDeCasos_Fuentes_Personal_Open()
			SMDH_ManejoDeCasos_Fuentes_Personal_Borrar($caso, $fuente, False)

			; delete caso
			SMDH_ManejoDeCasos_Casos_Open()
			SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
			SMDH_ManejoDeCasos_Casos_Borrar($caso, False)
		EndIf
		; delete sobre
		SMDH_ManejoDeCasos_Personas_Open()
		SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
		SMDH_Personas_Individual_Borrar($fuente_nombre, $fuente_apellido, False)
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()

; create a persona fuente
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Nueva($fuente_nombre, $fuente_apellido)
; create a caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Nuevo($caso)
SMDH_ManejoDeCasos_Casos_Select($caso)

; what we are testing
SMDH_ManejoDeCasos_Fuentes_Open()
SMDH_ManejoDeCasos_Fuentes_Personal_Open()
SMDH_ManejoDeCasos_Fuentes_Personal_Nueva($caso, $fuente)
Local $items = SMDH_ManejoDeCasos_Fuentes_Get_Confiabilidades($caso, $fuente)
For $i = 0 To UBound($items) - 1
	SMDH_ManejoDeCasos_Fuentes_Set_Confiabilidad($caso, $fuente, $items[$i])
	SMDH_ManejoDeCasos_Fuentes_Remove_Confiabilidad($caso, $fuente)
Next
SMDH_ManejoDeCasos_Fuentes_Personal_Borrar($caso, $fuente)

; delete caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Borrar($caso)
; delete fuente
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($fuente_nombre, $fuente_apellido)
