#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"

SMDH_Run()
SMDH_TerminateOnExit()
SMDH_ConfiguracionLocal_Open()
SMDH_ConfiguracionLocal_SetServidorLocal()
SMDH_ConfiguracionLocal_Aceptar()
OnAutoItExitUnregister("SMDH_Terminate")

SMDH_Run()
SMDH_TerminateOnExit()
SMDH_ConfiguracionLocal_Open()
SMDH_ConfiguracionLocal_IsServidorLocal()
SMDH_ConfiguracionLocal_Aceptar()
OnAutoItExitUnregister("SMDH_Terminate")
