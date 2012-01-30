#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"
#include "../../../../lib/smdh_intervenciones.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.3.3.2 Que acepte solo números en los rangos adecuados

Local $caso = "Caso de pruebas para intervenciones"
Local $quien_nombre = "Fulano"
Local $quien_apellido = "Castro"
Local $quien = SMDH_Personas_Individual_Compose_String($quien_nombre, $quien_apellido)
Local $tipo = "Acción urgente"
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
; create a caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Nuevo($caso)
SMDH_ManejoDeCasos_Casos_Select($caso)

; what we are testing

;Anios
SMDH_ManejoDeCasos_Intervenciones_Open()
SMDH_ManejoDeCasos_Intervenciones_Nuevo($caso, $quien, $tipo)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA,   -1, 1, 1, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA,    1, 1, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1000, 1, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1879, 1, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1880, 1, 1)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 1, 1)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2050, 1, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2051, 1, 1, True)
SMDH_ManejoDeCasos_Intervenciones_Borrar($caso, $quien, $tipo)

;Meses
SMDH_ManejoDeCasos_Intervenciones_Open()
SMDH_ManejoDeCasos_Intervenciones_Nuevo($caso, $quien, $tipo)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000,-1, 1, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 0, 1, False, True)
For $m = 1 To 12 Step 1
	SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, $m, 1)
Next
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000,13, 1, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA,    1, 1, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1000, 1, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1879,12, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1880, 1, 1)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 1, 1)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2050,12, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2051, 1, 1, True)
SMDH_ManejoDeCasos_Intervenciones_Borrar($caso, $quien, $tipo)

;Dias
SMDH_ManejoDeCasos_Intervenciones_Open()
SMDH_ManejoDeCasos_Intervenciones_Nuevo($caso, $quien, $tipo)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 1, -1, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 1,  0, False, False, True)
For $d = 1 To 5 Step 1
	SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 1, $d)
Next
For $d = 28 To 31 Step 1
	SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 1, $d)
Next
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 1,32, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA,    1, 1, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1000, 1, 1, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1879,12,31, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 1880, 1, 1)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2000, 1, 1)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2050,12,31, False, False, False, True)
SMDH_ManejoDeCasos_Intervenciones_Set_FechaIntervencion($caso, $quien, $tipo, $FECHA_TIPO_EXACTA, 2051, 1, 1, True)
SMDH_ManejoDeCasos_Intervenciones_Borrar($caso, $quien, $tipo)

; delete caso
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Borrar($caso)
; delete quien
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($quien_nombre, $quien_apellido)
