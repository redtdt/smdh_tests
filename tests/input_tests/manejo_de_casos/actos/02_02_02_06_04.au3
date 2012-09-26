#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"
#include "../../../../lib/smdh_actos.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.2.2.6.4 Que guarde correctamente si es corto

Local $caso = "Caso de pruebas para actos"
Local $derechos = "Derechos de los pueblos"
Local $victima_nombre = "Fulana"
Local $victima_apellido = "Figueroa"
Local $victima = SMDH_Personas_Individual_Compose_String($victima_nombre, $victima_apellido)
Local $perpetrador_nombre = "Perpetrador"
Local $perpetrador_apellido = "Lopez"
Local $perpetrador = SMDH_Personas_Individual_Compose_String($perpetrador_nombre, $perpetrador_apellido)
Local $violacion = "Violaciones al derecho de los pueblos indígenas a la tierra y territorio"
Local $observaciones = "a"

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

			SMDH_ManejoDeCasos_Actos_Open()
			If (SMDH_ManejoDeCasos_Actos_Exist($victima, $violacion)) Then
				SMDH_ManejoDeCasos_Actos_Select($victima, $violacion)

				SMDH_ManejoDeCasos_Actos_Open()
				SMDH_ManejoDeCasos_Actos_Perpetradores_Open()
				SMDH_ManejoDeCasos_Actos_Remove_Perpetrador($victima, $violacion, $perpetrador, False)

				SMDH_ManejoDeCasos_Actos_Open()
				SMDH_ManejoDeCasos_Actos_InformacionGeneral_Open()
				SMDH_ManejoDeCasos_Actos_Borrar($victima, $violacion, False)
			EndIf
			; delete caso
			SMDH_ManejoDeCasos_Casos_Open()
			SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
			SMDH_ManejoDeCasos_Casos_Borrar($caso, False)
		EndIf
		; delete victima
		SMDH_ManejoDeCasos_Personas_Open()
		SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
		SMDH_Personas_Individual_Borrar($victima_nombre, $victima_apellido, False)
		; delete perpetrador
		SMDH_ManejoDeCasos_Personas_Open()
		SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
		SMDH_Personas_Individual_Borrar($perpetrador_nombre, $perpetrador_apellido, False)
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()

; create a persona victima
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Nueva($victima_nombre, $victima_apellido)
; create a persona perpetrador
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Nueva($perpetrador_nombre, $perpetrador_apellido)
; create a caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Nuevo($caso)
SMDH_ManejoDeCasos_Casos_Select($caso)
; add derechos afectados
SMDH_ManejoDeCasos_Casos_Tipificaciones_Open()
SMDH_ManejoDeCasos_Casos_Add_DerechoAfectado($caso, $derechos)
; add acto
SMDH_ManejoDeCasos_Actos_Open()
SMDH_ManejoDeCasos_Actos_InformacionGeneral_Open()
SMDH_ManejoDeCasos_Actos_Nuevo($victima, $violacion)

; what we are testing
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_Select($caso)
SMDH_ManejoDeCasos_Actos_Open()
SMDH_ManejoDeCasos_Actos_Select($victima, $violacion)
SMDH_ManejoDeCasos_Actos_Perpetradores_Open()
SMDH_ManejoDeCasos_Actos_Add_Perpetrador($victima, $violacion, $perpetrador)

SMDH_ManejoDeCasos_Actos_Set_Perpetrador_Observaciones($victima, $violacion, $perpetrador, $observaciones)
SMDH_ManejoDeCasos_Actos_Remove_Perpetrador($victima, $violacion, $perpetrador)

;delete acto
SMDH_ManejoDeCasos_Actos_Open()
SMDH_ManejoDeCasos_Actos_InformacionGeneral_Open()
SMDH_ManejoDeCasos_Actos_Borrar($victima, $violacion)
; delete caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Borrar($caso)
; delete victima
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($victima_nombre, $victima_apellido)
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($perpetrador_nombre, $perpetrador_apellido)
