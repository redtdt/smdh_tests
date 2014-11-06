#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "../../../../lib/smdh_utils.au3"
#include "../../../../lib/smdh_users.au3"

; 1.1.1 nombre de usuario que contenga caracteres especiales

Local $adminuser= "admin"
Local $adminspasswd= "password"
Local $username = "·ÈÌÛ˙¡…Õ”⁄Ò~`!@#$%^&*()_-+={}[]|\:;'<>,.?/ø°"
Local $passwd= "1234"

Func TearDown()
	SMDH_Terminate_No_Asserts()
	; Be sure to delete user
	SMDH_Run()
	SMDH_Login($adminuser, $adminspasswd, $ADMIN)
	SMDH_UserDelete($username, False)
	SMDH_Terminate()
EndFunc

OnAutoItExitRegister("TearDown")

SMDH_Run()
SMDH_Login($adminuser, $adminspasswd, $ADMIN)
SMDH_UserCreate($username, $passwd);
SMDH_Terminate()
SMDH_Login($username, $passwd, $DEFAULT_ACCESS);
