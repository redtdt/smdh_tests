#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_configuracion_local.au3"

; 1.2.1 Que guarde correctamente un host largo
; prueba con host de 100, 200, 300, 400 y 500

Local $base = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"

Func TearDown()
	SMDH_Terminate_No_Asserts()
	; Be sure to leave a local server
	SMDH_Run()
	SMDH_ConfiguracionLocal_Open()
	SMDH_ConfiguracionLocal_SetServidorLocal()
	SMDH_ConfiguracionLocal_Aceptar()

	SMDH_Run()
	SMDH_ConfiguracionLocal_Open()
	SMDH_ConfiguracionLocal_IsServidorLocal()
	SMDH_ConfiguracionLocal_Aceptar()
EndFunc

OnAutoItExitRegister("TearDown")

Local $host = ""
For $i = 1 To 5 Step 1
	$host = $host & $base
	SMDH_Run()
	SMDH_ConfiguracionLocal_Open()
	SMDH_ConfiguracionLocal_SetServidorRemoto($host)
	SMDH_ConfiguracionLocal_Aceptar()

	SMDH_Run()
	SMDH_ConfiguracionLocal_Open()
	SMDH_ConfiguracionLocal_IsServidorRemoto($host)
	SMDH_ConfiguracionLocal_Aceptar()
Next

