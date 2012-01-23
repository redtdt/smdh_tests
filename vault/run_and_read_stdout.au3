#include <Constants.au3>

Global $sExtCmd = "netstat -n"
;Global $iPID = RunWait($sExtCmd, @SystemDir, @SW_MINIMIZE, 0x10)
Global $iPID = Run($sExtCmd, @SystemDir, @SW_MINIMIZE, $STDOUT_CHILD)
Global $sOut = ""

Do
    $sOut &= StdoutRead($iPID)
Until @error

ConsoleWrite("$sOut  = " & $sOut & @LF)
MsgBox(64, "Result", "$sOut   = " & $sOut)