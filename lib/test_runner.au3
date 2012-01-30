#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Constants.au3>
#include <Array.au3>

Func _RunAU3($sFilePath, $sWorkingDir = "", $iShowFlag = @SW_SHOW, $iOptFlag = 0)
    Return RunWait('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & $sFilePath & '"', $sWorkingDir, $iShowFlag, $iOptFlag)
EndFunc

Func RunTest($sFilePath, $sWorkingDir = "")
    Return _RunAU3($sFilePath, $sWorkingDir, @SW_SHOW, 0x10) ; STDIO_INHERIT_PARENT
EndFunc

; It does not detect when child finish with error. TODO. Use RunTest meanwhile.
Func RunTest2($sFilePath, $sWorkingDir = "")
	Local $iPID = Run('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & $sFilePath & '"', $sWorkingDir, @SW_SHOW, $STDOUT_CHILD)
	Local $sLast = ""
	Local $sOut = ""
	Do
		$sLast = StdoutRead($iPID)
		$sOut &= $sLast
		ConsoleWrite($sLast)
	Until @error
EndFunc

Func StdoutReadAll($iPID)
  Local $output = ""
  ProcessWaitClose($iPID)
  $output = StdoutRead($iPID)
  StdioClose($iPID)
  Return $output
EndFunc

Func TestRunner($tests)
	Local $file = FileOpen("test_results.txt", 2)
	; Check if file opened for writing OK
	If $file = -1 Then
		MsgBox(0, "Error", "Error abriendo el archivo test_results.txt")
		Exit
	EndIf

	For $test IN $tests
		Local $sPrefix = "[TESTFILE:" & $test & "] "
		ConsoleWrite( $sPrefix & "Running" & @CRLF )
		FileWrite($file, $sPrefix & "Running" & @CRLF)
		Local $res = RunTest($test)
		If $res<>0 Or ( $res==0 And @error<>0 )Then
			ConsoleWrite( $sPrefix & "FAILED" & @CRLF )
			FileWrite($file, $sPrefix & "FAILED" & @CRLF)
		Else
			ConsoleWrite( $sPrefix & "OK" & @CRLF )
			FileWrite($file, $sPrefix & "OK" & @CRLF)
		EndIf
	Next
EndFunc
