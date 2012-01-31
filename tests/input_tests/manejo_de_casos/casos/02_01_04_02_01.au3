#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"

; 2.4.2.1 Que guarde correctamente la selección (probar todas las opciones)

Local $caso = "Caso de pruebas"

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
SMDH_ManejoDeCasos_Casos_Select($caso)

SMDH_ManejoDeCasos_Casos_Tipificaciones_Open()
Local $items = SMDH_ManejoDeCasos_Casos_Get_Temas($caso)
;For $i = 0 To UBound($items) - 1
;	SMDH_ManejoDeCasos_Casos_Add_DerechoAfectado($caso, $items[$i])
;	SMDH_ManejoDeCasos_Casos_Remove_DerechoAfectado($caso, $items[$i])
;Next
For $i = 0 To UBound($items) - 1
	SMDH_ManejoDeCasos_Casos_Add_Tema($caso, $items[$i])
Next
For $i = 0 To UBound($items) - 1
	SMDH_ManejoDeCasos_Casos_Remove_Tema($caso, $items[$i])
Next
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Borrar($caso)

