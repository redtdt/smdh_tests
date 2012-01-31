#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.5.3.6.4 Que guarde correctamente si es corto

Local $nombre = "Juan"
Local $apellido = "Perez"
Local $proyecto = "1"

Local $colectiva = "Organismo Colectivo"
Local $sigla = "redtdt"
Local $c_proyecto = "a"

Func TearDown()
	SMDH_Terminate_No_Asserts()

	If (@exitCode <> 0) Then
		SMDH_Run()
		SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
		SMDH_ManejoDeCasos_Open()
		SMDH_ManejoDeCasos_Personas_Open()
		SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
		SMDH_Personas_Individual_Borrar($nombre, $apellido, False)
		SMDH_Personas_Colectiva_Borrar($colectiva, $sigla, False)
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()
SMDH_ManejoDeCasos_Personas_Open()

SMDH_Personas_Individual_Nueva($nombre, $apellido)
SMDH_Personas_Individual_Select($nombre, $apellido)
SMDH_ManejoDeCasos_Personas_InformacionAdministrativa_Open()
SMDH_Personas_Individual_Set_ProyectoConjunto($nombre, $apellido, $proyecto)
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($nombre, $apellido)

SMDH_Personas_Colectiva_Nueva($colectiva, $sigla)
SMDH_Personas_Colectiva_Select($colectiva, $sigla)
SMDH_ManejoDeCasos_Personas_InformacionAdministrativa_Open()
SMDH_Personas_Colectiva_Set_ProyectoConjunto($colectiva, $sigla, $c_proyecto)
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Colectiva_Borrar($colectiva, $sigla)
