#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"

; 2.5.4.4 Que guarde correctamente si es corto

Local $caso = "Caso de pruebas"
Local $caso_rel = "Relacionado Caso de pruebas"
Local $comentarios= "o"

Func TearDown()
	SMDH_Terminate_No_Asserts()

	If (@exitCode <> 0) Then
		SMDH_Run()
		SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
		SMDH_ManejoDeCasos_Open()
		SMDH_ManejoDeCasos_Casos_Open()
		SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
		SMDH_ManejoDeCasos_Casos_Borrar($caso, False)
		SMDH_ManejoDeCasos_Casos_Borrar($caso_rel, False)
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
SMDH_ManejoDeCasos_Casos_Nuevo($caso_rel)
SMDH_ManejoDeCasos_Casos_Select($caso)

SMDH_ManejoDeCasos_Casos_Relaciones_Open()
Local $items = SMDH_ManejoDeCasos_Casos_Get_TiposRelaciones($caso)
SMDH_ManejoDeCasos_Casos_Add_Relacion($caso, $caso_rel, $items[0])
SMDH_ManejoDeCasos_Casos_Set_Relacion_Comentarios($caso, $caso_rel, $comentarios)
SMDH_ManejoDeCasos_Casos_Remove_Relacion($caso, $caso_rel)
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
SMDH_ManejoDeCasos_Casos_Borrar($caso)
SMDH_ManejoDeCasos_Casos_Borrar($caso_rel)

