#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"
#include "../../../../lib/smdh_personas.au3"

; 2.5.4.8.2 Que guarde correctamente en los rangos adecuados

Local $nombre = "Juan"
Local $apellido = "Perez"

Local $rel_nombre = "Dolores"
Local $rel_apellido = "Heredia"
Local $rel = SMDH_Personas_Individual_Compose_String($rel_nombre, $rel_apellido)

Local $datoid = "identificador del dato"
Local $tipo = "Pareja"
Local $anio = 2010
Local $mes = 11
Local $dia = 20

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
;Anios
SMDH_Personas_Individual_DatoBiografico_Simple_Add($nombre, $apellido, $datoid)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA,   -1, 1, 1, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA,    1, 1, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1000, 1, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1879, 1, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1880, 1, 1)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 1, 1)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2050, 1, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2051, 1, 1, True)
SMDH_Personas_Individual_DatoBiografico_Simple_Borrar($nombre, $apellido, $datoid)

;Meses
SMDH_Personas_Individual_DatoBiografico_Simple_Add($nombre, $apellido, $datoid)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000,-1, 1, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 0, 1, False, True)
For $m = 1 To 12 Step 1
	SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, $m, 1)
Next
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000,13, 1, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA,    1, 1, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1000, 1, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1879,12, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1880, 1, 1)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 1, 1)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2050,12, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2051, 1, 1, True)
SMDH_Personas_Individual_DatoBiografico_Simple_Borrar($nombre, $apellido, $datoid)

;Dias
SMDH_Personas_Individual_DatoBiografico_Simple_Add($nombre, $apellido, $datoid)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 1, -1, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 1,  0, False, False, True)
For $d = 1 To 5 Step 1
	SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 1, $d)
Next
For $d = 28 To 31 Step 1
	SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 1, $d)
Next
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 1,32, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA,    1, 1, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1000, 1, 1, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1879,12,31, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 1880, 1, 1)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2000, 1, 1)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2050,12,31, False, False, False, True)
SMDH_Personas_Individual_DatoBiografico_Set_FechaVigencia($nombre, $apellido, $FECHA_TIPO_EXACTA, 2051, 1, 1, True)
SMDH_Personas_Individual_DatoBiografico_Simple_Borrar($nombre, $apellido, $datoid)

; delete persona
SMDH_ManejoDeCasos_Personas_Open()
SMDH_ManejoDeCasos_Personas_DatosGenerales_Open()
SMDH_Personas_Individual_Borrar($nombre, $apellido)
SMDH_Personas_Individual_Borrar($rel_nombre, $rel_apellido)
