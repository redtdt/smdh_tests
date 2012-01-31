#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.5.2.8.3 Que guarde correctamente números en un rango (0-9999999999)

Local $nombre = "Juan"
Local $apellido = "Perez"

Local $colectiva = "Organismo Colectivo"
Local $sigla = "redtdt"

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
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()

SMDH_Personas_Individual_Nueva($nombre, $apellido)
SMDH_Personas_Individual_Select($nombre, $apellido)
SMDH_ManejoDeCasos_Personas_Detalles_Open()
SMDH_Personas_Individual_Set_NumeroDependientes($nombre, $apellido, 1000000000)
SMDH_Personas_Individual_Set_NumeroDependientes($nombre, $apellido, 9999999999)
SMDH_Personas_Individual_Set_NumeroDependientes($nombre, $apellido, 10000000001, True)
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($nombre, $apellido)


SMDH_Personas_Colectiva_Nueva($colectiva, $sigla)
SMDH_Personas_Colectiva_Select($colectiva, $sigla)
SMDH_ManejoDeCasos_Personas_Detalles_Open()
SMDH_Personas_Colectiva_Set_NumeroPersonas($colectiva, $sigla, 1000000000)
SMDH_Personas_Colectiva_Set_NumeroPersonas($colectiva, $sigla, 9999999999)
SMDH_Personas_Colectiva_Set_NumeroPersonas($colectiva, $sigla, 10000000001, True)
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Colectiva_Borrar($colectiva, $sigla)

