#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_casos.au3"

; 2.1.1.2.3 Que guarde correctamente el nombre si es largo

Local $base = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
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
		Local $nombre = ""
		For $i = 1 To 5 Step 1
			$nombre = $nombre & $base
			SMDH_ManejoDeCasos_Casos_Borrar($nombre, False)
		Next
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()
SMDH_ManejoDeCasos_Casos_Open()
SMDH_ManejoDeCasos_Casos_DatosGenerales_Open()
Local $nombre = ""
For $i = 1 To 5 Step 1
	$nombre = $nombre & $base
	SMDH_ManejoDeCasos_Casos_Nuevo($caso)
	SMDH_ManejoDeCasos_Casos_Set_Nombre($caso, $nombre)
	SMDH_ManejoDeCasos_Casos_Borrar($nombre)
Next
