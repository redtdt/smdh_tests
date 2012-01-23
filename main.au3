#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "lib/test_runner.au3"

Local $tests[1]
$tests[0] = "tests\basic_tests.au3"
;$tests[0] = "bugs\0002.au3"
;_ArrayAdd($tests, "bugs\0002.au3")

TestRunner($tests)
