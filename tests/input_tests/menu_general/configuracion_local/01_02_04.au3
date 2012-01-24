#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_configuracion_local.au3"

; 1.2.1 Que guarde correctamente un host pequeño

Local $host = "1"

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

SMDH_Run()
SMDH_ConfiguracionLocal_Open()
SMDH_ConfiguracionLocal_SetServidorRemoto($host)
SMDH_ConfiguracionLocal_Aceptar()

SMDH_Run()
SMDH_ConfiguracionLocal_Open()
SMDH_ConfiguracionLocal_IsServidorRemoto($host)
SMDH_ConfiguracionLocal_Aceptar()

