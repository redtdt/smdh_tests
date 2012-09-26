#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.5.1.1.1.2 Que guarde correctamente el nombre con caracteres especiales

Local $nombre1 = "Fernand@!#"
Local $apellido1 = "Perez"

Local $nombre2 = "Juan ·ÈÌÛ˙¡…Õ”⁄Ò~`!@#$%^&*()_-+={}[]|\:;'<>,.?/ø°"
Local $apellido2 = "Perez"

Local $colectiva1 = "Red Tod@s"
Local $sigla1 = "redtdt"

Local $colectiva2 = "Red ·ÈÌÛ˙¡…Õ”⁄Ò~`!@#$%^&*()_-+={}[]|\:;'<>,.?/ø°"
Local $sigla2 = "redtdt"

Func TearDown()
	SMDH_Terminate_No_Asserts()

	If (@exitCode <> 0) Then
		SMDH_Run()
		SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
		SMDH_ManejoDeCasos_Open()
		SMDH_ManejoDeCasos_Personas_Open()
		SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
		SMDH_Personas_Individual_Borrar($nombre1, $apellido1, False)
		SMDH_Personas_Individual_Borrar($nombre2, $apellido2, False)
		SMDH_Personas_Colectiva_Borrar($colectiva1, $sigla1, False)
		SMDH_Personas_Colectiva_Borrar($colectiva2, $sigla2, False)
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Nueva($nombre1, $apellido1)
SMDH_Personas_Individual_Borrar($nombre1, $apellido1)
SMDH_Personas_Individual_Nueva($nombre2, $apellido2)
SMDH_Personas_Individual_Borrar($nombre2, $apellido2)
SMDH_Personas_Colectiva_Nueva($colectiva1, $sigla1)
SMDH_Personas_Colectiva_Borrar($colectiva1, $sigla1)
SMDH_Personas_Colectiva_Nueva($colectiva2, $sigla2)
SMDH_Personas_Colectiva_Borrar($colectiva2, $sigla2)
