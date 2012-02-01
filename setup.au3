#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../lib/smdh_utils.au3"
#include "../lib/smdh_users.au3"

SMDH_Run()
SMDH_TerminateOnExit()

SMDH_Login("admin", "gfh325gm", $ADMIN)

SMDH_UserCreate("userdefaultaccess", "passworddefaultaccess")
SMDH_UserCheckAccessLevel("userdefaultaccess", $CAPTURA_CONSULTA_REPORTES)

SMDH_UserCreate("usernorestrictions", "passwdnorestrictions")
SMDH_UserSetAccessLevel("usernorestrictions", $SIN_RESTRICCIONES)
SMDH_UserCheckAccessLevel("usernorestrictions", $SIN_RESTRICCIONES)

SMDH_UserCreate("usercapture", "passwdcapture")
SMDH_UserSetAccessLevel("usercapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_UserCheckAccessLevel("usercapture", $CAPTURA_CONSULTA_REPORTES)

SMDH_UserCreate("userreports", "passwdreports")
SMDH_UserSetAccessLevel("userreports", $REPORTES_CONSULTA)
SMDH_UserCheckAccessLevel("userreports", $REPORTES_CONSULTA)

SMDH_UserCreate("userreadonly", "passwdreadonly")
SMDH_UserSetAccessLevel("userreadonly", $SOLO_LECTURA)
SMDH_UserCheckAccessLevel("userreadonly", $SOLO_LECTURA)

SMDH_UserCreate("usernoaccess", "passwdnoaccess")
SMDH_UserSetAccessLevel("usernoaccess", $SIN_ACCESO)
SMDH_UserCheckAccessLevel("usernoaccess", $SIN_ACCESO)

; Probar los accesos de los usuarios

;SMDH_Close()
