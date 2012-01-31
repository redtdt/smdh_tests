#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.5.4.11.4 Que guarde correctamente si es corto

Local $nombre = "Juan"
Local $apellido = "Perez"

Local $rel_nombre = "Dolores"
Local $rel_apellido = "Heredia"
Local $rel = SMDH_Personas_Individual_Compose_String($rel_nombre, $rel_apellido)

Local $datoid = "identificador del dato"
Local $tipo = "Pareja"
Local $puesto = "d"

Func TearDown()
	SMDH_Terminate_No_Asserts()

	If (@exitCode <> 0) Then
		SMDH_Run()
		SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
		SMDH_ManejoDeCasos_Open()
		SMDH_ManejoDeCasos_Personas_Open()
		SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
		SMDH_Personas_Individual_Borrar($nombre, $apellido, False)
		SMDH_Personas_Individual_Borrar($rel_nombre, $rel_apellido, False)
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Nueva($nombre, $apellido)
SMDH_Personas_Individual_Nueva($rel_nombre, $rel_apellido)
SMDH_Personas_Individual_Select($nombre, $apellido)

; what we are testing
SMDH_ManejoDeCasos_Personas_DatosBiograficos_Open()
SMDH_Personas_Individual_DatoBiografico_Relacionado_Add($nombre, $apellido, $tipo, $rel)
SMDH_Personas_Individual_DatoBiografico_Set_Puesto($nombre, $apellido, $puesto)
SMDH_Personas_Individual_DatoBiografico_Relacionado_Borrar($nombre, $apellido, $tipo, $rel)

; delete persona
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($nombre, $apellido)
SMDH_Personas_Individual_Borrar($rel_nombre, $rel_apellido)
