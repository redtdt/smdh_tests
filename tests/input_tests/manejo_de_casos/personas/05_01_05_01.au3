#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 5.1.4.1 Que guarde correctamente la selección (probar todas las opciones)

Local $nombre = "Juan"
Local $apellido = "Perez"
Local $anio = 2010
Local $mes = 11
Local $dia = 20

Local $colectiva = "Organismo Colectivo"
Local $sigla = "redtdt"
Local $c_anio = 2010
Local $c_mes = 11
Local $c_dia = 20

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
SMDH_Personas_Individual_Set_FechaNacimiento($nombre, $apellido, $FECHA_TIPO_VACIO, $anio, $mes, $dia)
SMDH_Personas_Individual_Set_FechaNacimiento($nombre, $apellido, $FECHA_TIPO_EXACTA, $anio, $mes, $dia)
SMDH_Personas_Individual_Set_FechaNacimiento($nombre, $apellido, $FECHA_TIPO_APROX, $anio, $mes, $dia)
SMDH_Personas_Individual_Set_FechaNacimiento($nombre, $apellido, $FECHA_TIPO_NO_DIA, $anio, $mes, $dia)
SMDH_Personas_Individual_Set_FechaNacimiento($nombre, $apellido, $FECHA_TIPO_NO_MES, $anio, $mes, $dia)
SMDH_Personas_Individual_Borrar($nombre, $apellido)

SMDH_Personas_Colectiva_Nueva($colectiva, $sigla)
SMDH_Personas_Colectiva_Set_FechaCreacion($colectiva, $sigla, $FECHA_TIPO_VACIO, $c_anio, $c_mes, $c_dia)
SMDH_Personas_Colectiva_Set_FechaCreacion($colectiva, $sigla, $FECHA_TIPO_EXACTA, $c_anio, $c_mes, $c_dia)
SMDH_Personas_Colectiva_Set_FechaCreacion($colectiva, $sigla, $FECHA_TIPO_APROX, $c_anio, $c_mes, $c_dia)
SMDH_Personas_Colectiva_Set_FechaCreacion($colectiva, $sigla, $FECHA_TIPO_NO_DIA, $c_anio, $c_mes, $c_dia)
SMDH_Personas_Colectiva_Set_FechaCreacion($colectiva, $sigla, $FECHA_TIPO_NO_MES, $c_anio, $c_mes, $c_dia)
SMDH_Personas_Colectiva_Borrar($colectiva, $sigla)
