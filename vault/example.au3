#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Au3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 6 -d
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

#region Includes
#include <AutoItObject.au3>
#include <tdd.au3>
#endregion Includes

_AutoItObject_Startup()

Global $Assert = Tests()

; run the tests
$Assert.Example()
$Assert.Example1()
$Assert.ShouldBeEqual32()
$Assert.ShouldBeEqual64()

$Assert = ''

_AutoItObject_Shutdown()

#region Tests
Func Tests() ; Add your unit tests to this class...
    ; inherit the class under development in order to have access to private members and methods
    Local $this = _AutoItObject_Create(Calculator())

    _AutoItObject_AddProperty($this, "Result", $ELSCOPE_PRIVATE)

    _AutoItObject_AddProperty($this, "TDD", $ELSCOPE_PRIVATE, TDD())

    ; define the data that the tests may need...
    _AutoItObject_AddProperty($this, "INT32_MAX", $ELSCOPE_PRIVATE, 2147483647)
    _AutoItObject_AddProperty($this, "INT32_MIN", $ELSCOPE_PRIVATE, -2147483648)
    _AutoItObject_AddProperty($this, "INT64_MAX", $ELSCOPE_PRIVATE, 9223372036854775807)
    _AutoItObject_AddProperty($this, "INT64_MIN", $ELSCOPE_PRIVATE, -9223372036854775808)

    ; define your unit tests here...
    _AutoItObject_AddMethod($this, "Example", "Tests_Example")
    _AutoItObject_AddMethod($this, "Example1", "Tests_Example1")
    _AutoItObject_AddMethod($this, "ShouldBeEqual32", "Tests_ShouldBeEqual32")
    _AutoItObject_AddMethod($this, "ShouldBeEqual64", "Tests_ShouldBeEqual64")

    Return $this
EndFunc ;==>Tests

Func Tests_Example($this)
    $this.TDD.AreEqual(1, 0, "Example")
EndFunc ;==>Tests_Example

Func Tests_Example1($this)
    $this.TDD.AreEqual(0, 0, "Example1")
EndFunc ;==>Tests_Example1

Func Tests_ShouldBeEqual32($this)
    $this.Result = $this.Sum($this.INT32_MAX, 1)
    $this.TDD.AreEqual("overflow", $this.Result, "ShouldBeEqual32")
EndFunc ;==>Tests_ShouldBeEqual32

Func Tests_ShouldBeEqual64($this)
    $this.Result = $this.Sum($this.INT64_MAX, 1)
    $this.TDD.AreEqual("overflow", $this.Result, "ShouldBeEqual64")
EndFunc ;==>Tests_ShouldBeEqual64
#endregion Tests

; @@@@@@@@@@@@@@ This is an example class that is being developed with TDD @@@@@@@@@@@@@@@@@@@
#region Calculator Class
Func Calculator()
    Local $this = _AutoItObject_Create()
    _AutoItObject_AddMethod($this, "Sum", "Calculator_Sum")
    Return $this
EndFunc ;==>Calculator

; this is an example method that is being iteratively refactored according to the TDD method
Func Calculator_Sum($this, Const $p, Const $q)
    If ($p >= 0 And $q >= 0) Or ($p < 0 And $q < 0) Then ; possibility of overflow condition
        If $q >= 0 Then
            Local Const $result = $p + $q

            If $result < $p Then ; overfloweth
                Return SetError(1, 0, "overflow")
            Else

                Return $result
            EndIf
        EndIf
    Else ; no possibility of overflow
        Return $p + $q
    EndIf
EndFunc ;==>Calculator_Sum
#endregion Calculator Class