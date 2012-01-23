#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../lib/smdh_utils.au3"

SMDH_Run()
SMDH_TerminateOnExit()

SMDH_Login("admin", "gfh325gm", $ADMIN)

SMDH_UserCreate("userdefaultaccesstest", "password001")
SMDH_UserCheckAccessLevel("userdefaultaccesstest", $CAPTURA_CONSULTA_REPORTES)
SMDH_UserDelete("userdefaultaccesstest")

SMDH_UserCreate("usernorestrictionstest", "passwdnorestrictions")
SMDH_UserSetAccessLevel("usernorestrictionstest", $SIN_RESTRICCIONES)
SMDH_UserCheckAccessLevel("usernorestrictionstest", $SIN_RESTRICCIONES)
SMDH_UserDelete("usernorestrictionstest")

SMDH_UserCreate("usercapturetest", "passwdcapture")
SMDH_UserSetAccessLevel("usercapturetest", $CAPTURA_CONSULTA_REPORTES)
SMDH_UserCheckAccessLevel("usercapturetest", $CAPTURA_CONSULTA_REPORTES)
SMDH_UserDelete("usercapturetest")

SMDH_UserCreate("userreportstest", "passwdreports")
SMDH_UserSetAccessLevel("userreportstest", $REPORTES_CONSULTA)
SMDH_UserCheckAccessLevel("userreportstest", $REPORTES_CONSULTA)
SMDH_UserDelete("userreportstest")

SMDH_UserCreate("userreadonlytest", "passwdreadonly")
SMDH_UserSetAccessLevel("userreadonlytest", $SOLO_LECTURA)
SMDH_UserCheckAccessLevel("userreadonlytest", $SOLO_LECTURA)
SMDH_UserDelete("userreadonlytest")

SMDH_UserCreate("usernoaccesstest", "passwdnoaccess")
SMDH_UserSetAccessLevel("usernoaccesstest", $SIN_ACCESO)
SMDH_UserCheckAccessLevel("usernoaccesstest", $SIN_ACCESO)
SMDH_UserDelete("usernoaccesstest")

; Probar los accesos de los usuarios

;SMDH_Close()
