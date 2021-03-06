#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"
#include "../../../../lib/smdh_actos.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.2.3.3.1 Que guarde correctamente la selecci�n (probar todas las opciones)

Local $caso = "Caso de pruebas para actos"
Local $derechos = "Derechos de los pueblos"
Local $victima_nombre = "Fulana"
Local $victima_apellido = "Figueroa"
Local $victima = SMDH_Personas_Individual_Compose_String($victima_nombre, $victima_apellido)
Local $violacion = "Violaciones al derecho de los pueblos ind�genas a la tierra y territorio"

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
SMDH_ManejoDeCasos_Actos_Normatividad_Open()

Local $items = SMDH_ManejoDeCasos_Actos_Get_InstrumentosInternacionales($victima, $violacion)
For $i = 0 To UBound($items) - 1
	SMDH_ManejoDeCasos_Actos_Set_InstrumentoInternacional($victima, $violacion, $items[$i])
	SMDH_ManejoDeCasos_Actos_Remove_InstrumentoInternacional($victima, $violacion, $items[$i])
Next
For $i = 0 To 15;UBound($items) - 1
	SMDH_ManejoDeCasos_Actos_Set_InstrumentoInternacional($victima, $violacion, $items[$i])
Next
For $i = 0 To 15;UBound($items) - 1
	SMDH_ManejoDeCasos_Actos_Remove_InstrumentoInternacional($victima, $violacion, $items[$i])
Next

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
