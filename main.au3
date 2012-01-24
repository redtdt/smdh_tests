#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "lib/test_runner.au3"

Local $tests[1]
;$tests[0] = "bugs\0002.au3"
$tests[0] = "tests\input_tests\menu_general\configuracion_local\01_02_01.au3"
_ArrayAdd($tests, "tests\input_tests\menu_general\configuracion_local\01_02_02.au3")
_ArrayAdd($tests, "tests\input_tests\menu_general\configuracion_local\01_02_03.au3")
_ArrayAdd($tests, "tests\input_tests\menu_general\configuracion_local\01_02_04.au3")
_ArrayAdd($tests, "tests\input_tests\menu_general\configuracion_local\01_02_05.au3")

TestRunner($tests)
