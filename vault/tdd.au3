#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Au3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 6 -d
#AutoIt3Wrapper_Run_After=md "%scriptdir%\Versions\%fileversion%"
#AutoIt3Wrapper_Run_After=copy "%in%" "%scriptdir%\Versions\%fileversion%\%scriptfile%%fileversion%.au3"
#AutoIt3Wrapper_Run_After=copy "%out%" "%scriptdir%\Versions\%fileversion%\%scriptfile%%fileversion%.exe"

;**** Function Name List ****
; TDD
; TDD_Write
; TDD_Equal
; TDD_NotEqual
; TDD_FileExists
; TDD_FileDoesNotExist
; TDD_GreaterThan
; TDD_NotGreaterThan
; TDD_GreaterThanOrEqualTo
; TDD_NotGreaterThanOrEqualTo
; TDD_LessThan
; TDD_NotLessThan
; TDD_LessThanOrEqualTo
; TDD_NotLessThanOrEqualTo
; TDD_Object
; TDD_NotObject
; TDD_ProcessExists
; TDD_ProcessDoesNotExist
; TDD_True
; TDD_NotTrue
; TDD_False
; TDD_NotFalse
; TDD_WindowExists
; TDD_WindowDoesNotExist

#include-once
#include "AutoItObject.au3"

Func TDD()
    Local $This = _AutoItObject_Class()

    $This.AddMethod( "Equal" , "TDD_Equal" )
    $This.AddMethod( "NotEqual" , "TDD_NotEqual" )

    $This.AddMethod( "FileExists" , "TDD_FileExists" )
    $This.AddMethod( "NotFileExists" , "TDD_NotFileExists" )

    $This.AddMethod( "GreaterThan" , "TDD_GreaterThan" )
    $This.AddMethod( "NotGreaterThan" , "TDD_NotGreaterThan" )

    $This.AddMethod( "GreaterThanOrEqualTo" , "TDD_GreaterThanOrEqualTo" )
    $This.AddMethod( "NotGreaterThanOrEqualTo" , "TDD_NotGreaterThanOrEqualTo" )

    $This.AddMethod( "LessThan" , "TDD_LessThan" )
    $This.AddMethod( "NotLessThan" , "TDD_LessThan" )

    $This.AddMethod( "LessThanOrEqualTo" , "TDD_LessThanOrEqualTo" )
    $This.AddMethod( "NotLessThanOrEqualTo" , "TDD_NotLessThanOrEqualTo" )

    $This.AddMethod( "Object" , "TDD_Object" )
    $This.AddMethod( "NotObject" , "TDD_NotObject" )

    $This.AddMethod( "ProcessExists" , "TDD_ProcessExists" )
    $This.AddMethod( "NotProcessExists" , "TDD_NotProcessExists" )

    $This.AddMethod( "True" , "TDD_True" )
    $This.AddMethod( "NotTrue" , "TDD_NotTrue" )

    $This.AddMethod( "False" , "TDD_False" )
    $This.AddMethod( "NotFalse" , "TDD_NotFalse" )

    $This.AddMethod( "WindowExists" , "TDD_WindowExists" )
    $This.AddMethod( "NotWindowExists" , "TDD_NotWindowExists" )

    $This.AddMethod( "Write" , "_TDD_Write" , True )

    Return $This.Object
EndFunc

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_Equal( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Equal" )
    Local Const $info_string = $testname & "'  |  " & "Expected: '" & $var1 & "'  |  Is: '" & $var2 & "'"
    Local Const $Pass = "> '" & $info_string
    Local Const $Fail = "! '" & $info_string

    Select
        Case IsString( $var1 ) And IsString( $var2 )
            Switch $var1 == $var2
                Case 1
                    $This.Write( $Pass )
                Case 0
                    $This.Write( $Fail )
            EndSwitch
        Case IsNumber( $var1 ) And IsNumber( $var2 )
            Switch $var1 = $var2
                Case 1
                    $This.Write( $Pass )
                Case 0
                    $This.Write( $Fail )
            EndSwitch
    EndSelect
EndFunc   ;==>TDD_Equal

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotEqual( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Not Equal" )
    Local Const $info_string = $testname & "'  |  " & "Expected: '" & $var1 & "'  |  Is: '" & $var2 & "'"
    Local Const $Pass = "> '" & $info_string
    Local Const $Fail = "! '" & $info_string

    Select
        Case IsString( $var1 ) And IsString( $var2 )
            Switch Not ( $var1 == $var2 )
                Case 1
                    $This.Write( $Pass )
                Case 0
                    $This.Write( $Fail )
            EndSwitch
        Case IsNumber( $var1 ) And IsNumber( $var2 )
            Switch Not ( $var1 = $var2 )
                Case 1
                    $This.Write( $Pass )
                Case 0
                    $This.Write( $Fail )
            EndSwitch
    EndSelect
EndFunc   ;==>TDD_NotEqual

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_FileExists( ByRef $This , Const $file , Const $testname = "File Exists" )
    Local Const $Pass = "> '" & $testname & "' File: " & $file & " exists."
    Local Const $Fail = "! '" & $testname & "' File: " & $file & " does not exist."

    Switch FileExists( $file )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_FileExists

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotFileExists( ByRef $This , Const $file , Const $testname = "NotFileExists" )
    Local Const $Pass = "> '" & $testname & "' File: " & $file & " does not exist."
    Local Const $Fail = "! '" & $testname & "' File: " & $file & " exists."

    Switch Not FileExists( $file )
        Case True ; pass
            $This.Write( $Pass )
        Case False ; fail
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_FileDoesNotExist

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_GreaterThan( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Greater Than" )
    Local Const $Pass = "> '" & $testname & "' " & $var1 & " is greater than " & $var2
    Local Const $Fail = "! '" & $testname & "' " & $var1 & " is not greater than " & $var2

    Switch $var1 > $var2
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_GreaterThan

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotGreaterThan( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Not Greater Than" )
    Local Const $Pass = "> '" & $testname & "' " & $var1 & " is not greater than " & $var2
    Local Const $Fail = "! '" & $testname & "' " & $var1 & " is greater than " & $var2

    Switch Not $var1 < $var2
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_NotGreaterThan

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_GreaterThanOrEqualTo( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Greater Than Or Equal To" )
    Local Const $Pass = "> '" & $testname & "' " & $var1 & " is greater than or equal to " & $var2
    Local Const $Fail = "! '" & $testname & "' " & $var1 & " is not greater than or equal to " & $var2

    Switch $var1 >= $var2
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_GreaterThanOrEqualTo

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotGreaterThanOrEqualTo( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Not Greater Than Or Equal To" )
    Local Const $Pass = "> '" & $testname & "' " & $var1 & " is not greater than or equal to " & $var2
    Local Const $Fail = "! '" & $testname & "' " & $var1 & " is greater than or equal to " & $var2

    Switch Not $var1 <= $var2
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_NotGreaterThanOrEqualTo

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_LessThan( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Less Than" )
    Local Const $Pass = "> '" & $testname & "' " & $var1 & " is less than " & $var2
    Local Const $Fail = "! '" & $testname & "' " & $var1 & " is not less than " & $var2

    Switch $var1 < $var2
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_LessThan

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotLessThan( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Not Less Than" )
    Local Const $Pass = "> '" & $testname & "' " & $var1 & " is not less than " & $var2
    Local Const $Fail = "! '" & $testname & "' " & $var1 & " is less than " & $var2

    Switch Not ( $var1 < $var2 )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_NotLessThan

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_LessThanOrEqualTo( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Less Than Or Equal To" )
    Local Const $Pass = "> '" & $testname & "' " & $var1 & " is less than or equal to " & $var2
    Local Const $Fail = "! '" & $testname & "' " & $var1 & " is not less than or equal to " & $var2

    Switch $var1 <= $var2
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_LessThanOrEqualTo

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotLessThanOrEqualTo( ByRef $This , Const $var1 , Const $var2 , Const $testname = "Not Less Than Or Equal To" )
    Local Const $Pass = "> '" & $testname & "' " & $var1 & " is not less than or equal to " & $var2
    Local Const $Fail = "! '" & $testname & "' " & $var1 & " is less than or equal to " & $var2

    Switch Not ( $var1 <= $var2 )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_NotLessThanOrEqualTo

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_Object( ByRef $This , Const $object , Const $testname = "Object" )
    Local Const $Pass = "> '" & $testname & "' " & ObjName( $object ) & " | is an object."
    Local Const $Fail = "! '" & $testname & "' " & $object & " | is not an object."

    Switch IsObj( $object )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_Object
; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotObject( ByRef $This , Const $object , Const $testname = "Not Object" )
    Local Const $Pass = "> '" & $testname & "' " & $object & " | is not an object."
    Local Const $Fail = "! '" & $testname & "' " & ObjName( $object ) & " | is an object."

    Switch Not IsObj( $object )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_NotObject

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_ProcessExists( ByRef $This , Const $Process , Const $testname = "Process Exists" )
    Local Const $Pass = "> '" & $testname & "' Process: " & $Process & " exists."
    Local Const $Fail = "! '" & $testname & "' Process: " & $Process & " does not exist."

    Switch ProcessExists( $Process )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_ProcessExists

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotProcessExists( ByRef $This , Const $Process , Const $testname = "Not Process Exists" )
    Local Const $Pass = "> '" & $testname & "' Process: " & $Process & " does not exist."
    Local Const $Fail = "! '" & $testname & "' Process: " & $Process & " exists."

    Switch Not ProcessExists( $Process )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_ProcessDoesNotExist

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_True( ByRef $This , Const $var , Const $testname = "True" )
    Local Const $Pass = "> '" & $testname & "' " & $var & " is TRUE."
    Local Const $Fail = "! '" & $testname & "' " & $var & " is FALSE."

    If IsInt( $var ) Then
        Switch $var
            Case True
                $This.Write( $Pass )
            Case False
                $This.Write( $Fail )
        EndSwitch
    Else
        ConsoleWrite( "TDD ERROR : " & $var & " is not an integer." )
    EndIf
EndFunc   ;==>TDD_True

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotTrue( ByRef $This , Const $var , Const $testname = "Not True" )
    Local Const $Pass = "> '" & $testname & "' " & $var & " is NOT TRUE."
    Local Const $Fail = "! '" & $testname & "' " & $var & " is FALSE."

    If IsInt( $var ) Then
        Switch Not $var
            Case True
                $This.Write( $Pass )
            Case False
                $This.Write( $Fail )
        EndSwitch
    Else
        ConsoleWrite( "TDD ERROR : " & $var & " is not an integer." )
    EndIf
EndFunc

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_False( ByRef $This , Const $var , Const $testname = "False" )
    Local Const $Pass = "> '" & $testname & "' " & $var & " is FALSE."
    Local Const $Fail = "! '" & $testname & "' " & $var & " is TRUE."

    If IsInt( $var ) Then
        Switch $var
            Case False
                $This.Write( $Pass )
            Case True
                $This.Write( $Fail )
        EndSwitch
    Else
        ConsoleWrite( "TDD ERROR : " & $var & " is not an integer." )
    EndIf
EndFunc   ;==>TDD_False

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotFalse( ByRef $This , Const $var , Const $testname = "Not False" )
    Local Const $Pass = "> '" & $testname & "' " & $var & " is NOT FALSE."
    Local Const $Fail = "! '" & $testname & "' " & $var & " is TRUE."

    If IsInt( $var ) Then
        Switch Not $var
            Case False
                $This.Write( $Pass )
            Case True
                $This.Write( $Fail )
        EndSwitch
    Else
        ConsoleWrite( "TDD ERROR : " & $var & " is not an integer." )
    EndIf
EndFunc

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_WindowExists( ByRef $This , Const $window , Const $testname = "Window Exists" )
    Local Const $Pass = "> '" & $testname & "' " & $window & " does exist."
    Local Const $Fail = "! '" & $testname & "' " & $window & " does not exist."

    Switch WinExists( $window )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_WindowExists

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func TDD_NotWindowExists( ByRef $This , Const $window , Const $testname = "Not Window Exists" )
    Local Const $Pass = "> '" & $testname & "' " & $window & " does not exist."
    Local Const $Fail = "! '" & $testname & "' " & $window & " does exist."

    Switch Not WinExists( $window )
        Case True
            $This.Write( $Pass )
        Case False
            $This.Write( $Fail )
    EndSwitch
EndFunc   ;==>TDD_WindowDoesNotExist

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

Func _TDD_Write( ByRef $This , Const $message )
    ConsoleWrite( $message & @LF )
EndFunc

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i