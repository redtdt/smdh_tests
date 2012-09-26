#include-once
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Func UTAssert($bool, $msg="Assert Failure", $erl=@ScriptLineNumber)
    If NOT $bool Then
		UTLogEndTestFAIL($msg, $erl)
		Exit 1;
    EndIf
	;If @error <> 0 Then SetError(@error, @extended, @error)
    Return $bool
EndFunc

Func UTExpect($bool, $msg="Expect Failure", $erl=@ScriptLineNumber)
    If NOT $bool Then
        ConsoleWrite("(" & $erl & ") := " & $msg & @LF)
    EndIf
	;If @error <> 0 Then SetError(@error, @extended, @error)
    Return $bool
EndFunc

Func UTLogInitTest($testname, $params="")
	ConsoleWrite( @TAB & "[TEST:" &$testname & "]" )
	If $params <> "" Then
		ConsoleWrite( "(" & $params & ") ")
	EndIf
		ConsoleWrite( " ")
EndFunc

Func UTLogEndTestOK()
	ConsoleWrite( "OK" & @CRLF )
EndFunc

Func UTLogEndTestFAIL($msg="Assert Failure", $erl=@ScriptLineNumber)
	ConsoleWrite("FAILED (" & $erl & ") := " & $msg & @LF)
EndFunc

Func dbg($msg, $line = @ScriptLineNumber, $err = @error, $ext = @extended)
    If Not @Compiled Then
        ConsoleWrite("(" & $line & ") := (" & $err & ")(" & $ext & ") " & $msg & @CRLF)
    EndIf
EndFunc   ;==>dbg

Func Assert($bool, $msg = "", $line = @ScriptLineNumber, $err = @error, $ext = @extended)
   If Not $bool Then
      dbg("FAILURE: Assert failed :" & $msg, $line, $err, $ext)
   EndIf
EndFunc

;dbg("This is a test. Click on this line in scites output pan")
;Assert(0, "Click on this line to")
;Assert(0==0, "The window handel has changed!")

