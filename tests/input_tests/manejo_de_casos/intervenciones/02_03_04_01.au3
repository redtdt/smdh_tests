#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"
#include "../../../../lib/smdh_intervenciones.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.3.4.1 Que guarde correctamente

Local $caso = "Caso de pruebas para intervenciones"
Local $quien_nombre = "Fulano"
Local $quien_apellido = "Castro"
Local $quien = SMDH_Personas_Individual_Compose_String($quien_nombre, $quien_apellido)
Local $sobre_quien_nombre = "Sutano"
Local $sobre_quien_apellido = "Lopez"
Local $sobre_quien = SMDH_Personas_Individual_Compose_String($sobre_quien_nombre, $sobre_quien_apellido)
Local $tipo = "Acci�n urgente"
Local $anio = 2010
Local $mes = 11
Local $dia = 20

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

			SMDH_ManejoDeCasos_Intervenciones_Open()
			SMDH_ManejoDeCasos_Intervenciones_Borrar($caso, $quien, $tipo, False)

			; delete caso
			SMDH_ManejoDeCasos_Casos_Open()
			SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
			SMDH_ManejoDeCasos_Casos_Borrar($caso, False)
		EndIf
		; delete quien
		SMDH_ManejoDeCasos_Personas_Open()
		SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
		SMDH_Personas_Individual_Borrar($quien_nombre, $quien_apellido, False)
		SMDH_Personas_Individual_Borrar($sobre_quien_nombre, $sobre_quien_apellido, False)
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()

; create a persona quien
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Nueva($quien_nombre, $quien_apellido)
SMDH_Personas_Individual_Nueva($sobre_quien_nombre, $sobre_quien_apellido)
; create a caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Nuevo($caso)
SMDH_ManejoDeCasos_Casos_Select($caso)

; what we are testing
SMDH_ManejoDeCasos_Intervenciones_Open()
SMDH_ManejoDeCasos_Intervenciones_Nuevo($caso, $quien, $tipo)
SMDH_ManejoDeCasos_Intervenciones_Select($caso, $quien, $tipo)
SMDH_ManejoDeCasos_Intervenciones_Set_Sobre_Quien($caso, $quien, $tipo, $sobre_quien)
SMDH_ManejoDeCasos_Intervenciones_Remove_Sobre_Quien($caso, $quien, $tipo)
SMDH_ManejoDeCasos_Intervenciones_Borrar($caso, $quien, $tipo)

; delete caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Borrar($caso)
; delete quien
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($quien_nombre, $quien_apellido)
SMDH_Personas_Individual_Borrar($sobre_quien_nombre, $sobre_quien_apellido)
