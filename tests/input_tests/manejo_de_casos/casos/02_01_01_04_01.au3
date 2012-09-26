#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"

; 2.1.1.4.1 Que guarde correctamente el nombre

Local $caso = "Caso de pruebas"
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
		SMDH_ManejoDeCasos_Casos_Borrar($caso, False)
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Nuevo($caso)
SMDH_ManejoDeCasos_Casos_Set_FechaFinal($caso, $FECHA_TIPO_VACIO, $anio, $mes, $dia)
SMDH_ManejoDeCasos_Casos_Set_FechaFinal($caso, $FECHA_TIPO_EXACTA, $anio, $mes, $dia)
SMDH_ManejoDeCasos_Casos_Set_FechaFinal($caso, $FECHA_TIPO_APROX, $anio, $mes, $dia)
SMDH_ManejoDeCasos_Casos_Set_FechaFinal($caso, $FECHA_TIPO_NO_DIA, $anio, $mes, $dia)
SMDH_ManejoDeCasos_Casos_Set_FechaFinal($caso, $FECHA_TIPO_NO_MES, $anio, $mes, $dia)
SMDH_ManejoDeCasos_Casos_Borrar($caso)
