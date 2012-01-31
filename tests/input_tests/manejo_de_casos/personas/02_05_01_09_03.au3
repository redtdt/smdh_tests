#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 5.1.9.3 Que guarde correctamente si es largo
; prueba con 100, 200, 300, 400 y 500 caracteres

Local $base = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"

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

Local $loc = ""
For $i = 1 To 5 Step 1
	$loc = $loc & $base
	SMDH_Personas_Individual_Nueva($nombre, $apellido)
	SMDH_Personas_Individual_Select($nombre, $apellido)
	SMDH_Personas_Individual_Set_Estado_Idx($nombre, $apellido, 3)
	SMDH_Personas_Individual_Set_Localidad($nombre, $apellido, $loc)
	SMDH_Personas_Individual_Borrar($nombre, $apellido)


	SMDH_Personas_Colectiva_Nueva($colectiva, $sigla)
	SMDH_Personas_Colectiva_Select($colectiva, $sigla)
	SMDH_Personas_Colectiva_Set_Estado_Idx($colectiva, $sigla, 3)
	SMDH_Personas_Colectiva_Set_Localidad($colectiva, $sigla, $loc)
	SMDH_Personas_Colectiva_Borrar($colectiva, $sigla)
Next
