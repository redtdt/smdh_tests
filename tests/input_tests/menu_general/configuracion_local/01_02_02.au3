#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_configuracion_local.au3"

; 1.2.2 Que guarde correctamente un host con caracteres especiales

Local $host = "·"
Local $host2 = "·ÈÌÛ˙¡…Õ”⁄Ò~`!@#$%^&*()_-+={}[]|\:;'<>,.?/ø°"

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

SMDH_Run()
SMDH_ConfiguracionLocal_Open()
SMDH_ConfiguracionLocal_SetServidorRemoto($host2)
SMDH_ConfiguracionLocal_Aceptar()

SMDH_Run()
SMDH_ConfiguracionLocal_Open()
SMDH_ConfiguracionLocal_IsServidorRemoto($host2)
SMDH_ConfiguracionLocal_Aceptar()

