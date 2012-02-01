#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Math.au3>
#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.5.1.8.1 Que guarde correctamente la selección (probar todas las opciones)

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
Local $estados = SMDH_Personas_Individual_Get_Estados($nombre, $apellido)
For $estado = 0 To UBound($estados) - 1
	SMDH_Personas_Individual_Set_Estado_Idx($nombre, $apellido, $estado)
	Local $mpos = SMDH_Personas_Individual_Get_Municipios($nombre, $apellido)
	For $mpo = 0 To _Min( 5, UBound($mpos) - 1 )
		SMDH_Personas_Individual_Set_Municipio_Idx($nombre, $apellido, $mpo)
	Next
Next
SMDH_Personas_Individual_Borrar($nombre, $apellido)


SMDH_Personas_Colectiva_Nueva($colectiva, $sigla)
SMDH_Personas_Colectiva_Select($colectiva, $sigla)
Local $estados = SMDH_Personas_Colectiva_Get_Estados($colectiva, $sigla)
For $estado = 0 To UBound($estados) - 1
	SMDH_Personas_Colectiva_Set_Estado_Idx($colectiva, $sigla, $estado)
	Local $mpos = SMDH_Personas_Colectiva_Get_Municipios($colectiva, $sigla)
	For $mpo = 0 To _Min( 5, UBound($mpos) - 1 )
		SMDH_Personas_Colectiva_Set_Municipio_Idx($colectiva, $sigla, $mpo)
	Next
Next
SMDH_Personas_Colectiva_Borrar($colectiva, $sigla)

