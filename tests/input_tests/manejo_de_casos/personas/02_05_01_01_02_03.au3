#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.5.1.1.2.3 Que guarde correctamente el apellido/sigla si es largo
; prueba con 100, 200, 300, 400 y 500 caracteres

Local $base = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"

Local $nombre = "Juan"
Local $colectiva = "Red"

Func TearDown()
	SMDH_Terminate_No_Asserts()

	If (@exitCode <> 0) Then
		SMDH_Run()
		SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
		SMDH_ManejoDeCasos_Open()
		SMDH_ManejoDeCasos_Personas_Open()
		SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
		Local $apellido = ""
		Local $sigla = ""
		For $i = 1 To 5 Step 1
			$apellido = $apellido & $base
			$sigla = $sigla & $base
			SMDH_Personas_Individual_Borrar($nombre, $apellido)
			SMDH_Personas_Colectiva_Borrar($colectiva, $sigla)
		Next
		SMDH_Terminate()
	EndIf
EndFunc

SMDH_Run()
OnAutoItExitRegister("TearDown")

SMDH_Login("usercapture", "passwdcapture", $CAPTURA_CONSULTA_REPORTES)
SMDH_ManejoDeCasos_Open()
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()

Local $apellido = ""
Local $sigla = ""
For $i = 1 To 5 Step 1
	$apellido = $apellido & $base
	$sigla = $sigla & $base
	SMDH_Personas_Individual_Nueva($nombre, $apellido)
	SMDH_Personas_Individual_Borrar($nombre, $apellido)
	SMDH_ManejoDeCasos_Personas_Open()
	SMDH_Personas_Colectiva_Nueva($colectiva, $sigla)
	SMDH_Personas_Colectiva_Borrar($colectiva, $sigla)
Next