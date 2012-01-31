#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.5.2.2.1 Que guarde correctamente la selección (probar todas las opciones)

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
Local $idiomas = SMDH_Personas_Individual_Get_Idiomas($nombre, $apellido)
For $i = 0 To UBound($idiomas) - 1
	SMDH_Personas_Individual_Add_Idioma($nombre, $apellido, $idiomas[$i])
	SMDH_Personas_Individual_Remove_Idioma($nombre, $apellido, $idiomas[$i])
Next
For $i = 0 To UBound($idiomas) - 1
	SMDH_Personas_Individual_Add_Idioma($nombre, $apellido, $idiomas[$i])
Next
For $i = 0 To UBound($idiomas) - 1
	SMDH_Personas_Individual_Remove_Idioma($nombre, $apellido, $idiomas[$i])
Next
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($nombre, $apellido)

SMDH_Personas_Colectiva_Nueva($colectiva, $sigla)
SMDH_Personas_Colectiva_Select($colectiva, $sigla)
SMDH_ManejoDeCasos_Personas_Detalles_Open()
Local $idiomas = SMDH_Personas_Colectiva_Get_Idiomas($colectiva, $sigla)
For $i = 0 To UBound($idiomas) - 1
	SMDH_Personas_Colectiva_Add_Idioma($colectiva, $sigla, $idiomas[$i])
	SMDH_Personas_Colectiva_Remove_Idioma($colectiva, $sigla, $idiomas[$i])
Next
For $i = 0 To UBound($idiomas) - 1
	SMDH_Personas_Colectiva_Add_Idioma($colectiva, $sigla, $idiomas[$i])
Next
For $i = 0 To UBound($idiomas) - 1
	SMDH_Personas_Colectiva_Remove_Idioma($colectiva, $sigla, $idiomas[$i])
Next
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Colectiva_Borrar($colectiva, $sigla)

