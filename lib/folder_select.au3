; #FUNCTION# ====================================================================================================================
; Name...........: _BFF_SelectFolder
; Description ...: Automates the "Browse for Folder" Dialog so you can specify with a standard path
; Syntax.........: _BFF_SelectFolder($sPath[, $bClickOK = True])
; Parameters ....: $sPath       - Path to select in dialog
;               $bClickOK       - Optional: Click OK button. Default or True then click OK button
; Return values .: Success - returns True
;               Failure - False
;               |@Error  - 1 = "Browse for Folder" dialog not found
;               |@Error  - 2 = Drive letter not in path
;               |@Error  - 3 = unable to locate my computer in tree
;               |@Error  - 4 = unable to locate directory
; Author ........: Storm-E aka John Morrison
; Modified.......:
; Remarks .......: Thanks to JohnOne for his fix for the clickitem delay
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _BFF_SelectFolder($sPath, $bClickOK = True)
Local $asPath ; holds drive and folder section(s)
Local $next
Sleep(500)
;Get handle of "Browse for Folder" dialog
Local $HWND = ControlGetHandle("Browse for Folder", "", "[CLASS:SysTreeView32; INSTANCE:1]")
If @error Then
  Return SetError(1, 0, "")
EndIf
; get first item - ya gota start somewhere :)
Local $hCurrentItem = _GUICtrlTreeView_GetFirstItem($HWND)
$hCurrentItem = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem) ; items under desktop
$asPath = StringSplit($sPath, "\")
If $asPath[$asPath[0]] = "" Then $asPath[0] -= 1 ; eliminates blank entry if path has a trailng \
If StringRight($asPath[1], 1) <> ":" Then
  Return SetError(2, 0, "")
EndIf
;Find My Computer
Local $hCurrentItemChild = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem) ; get items child
While StringRight(_GUICtrlTreeView_GetText($HWND, $hCurrentItemChild), 2) <> ":)"
  $hCurrentItem = _GUICtrlTreeView_GetNextSibling($HWND, $hCurrentItem) ; Step to next item
  If $hCurrentItem = 0 Then
   ;Ran out of items so didn't find my computer
   Return SetError(3, 0, "")
  EndIf
  $hCurrentItemChild = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem)
WEnd
_GUICtrlTreeView_Expand($HWND, $hCurrentItem)
_GUICtrlTreeView_ClickItem($HWND, $hCurrentItem)
Do
  $next = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem)
Until $next <> $hCurrentItem
;Find drive
$hCurrentItem = $hCurrentItemChild
While StringLeft(StringRight(_GUICtrlTreeView_GetText($HWND, $hCurrentItem), 3), 2) <> $asPath[1]
  $hCurrentItem = _GUICtrlTreeView_GetNextSibling($HWND, $hCurrentItem) ; Step to next item
  If $hCurrentItem = 0 Then
   ;Ran out of items so didn't find my computer
   Return SetError(3, 0, "")
  EndIf
WEnd
;Needed for dialog to update
_GUICtrlTreeView_Expand($HWND, $hCurrentItem)
_GUICtrlTreeView_ClickItem($HWND, $hCurrentItem)
Do
  $next = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem)
Until $next <> $hCurrentItem
;Find directory
If $asPath[0] > 1 Then ; Check if only drive was specified
  For $item = 2 To $asPath[0]
   $hCurrentItem = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem)
   _GUICtrlTreeView_Expand($HWND, $hCurrentItem)
   _GUICtrlTreeView_ClickItem($HWND, $hCurrentItem)
   Do
    $next = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem)
   Until $next <> $hCurrentItem
   While _GUICtrlTreeView_GetText($HWND, $hCurrentItem) <> $asPath[$item]
    $hCurrentItem = _GUICtrlTreeView_GetNextSibling($HWND, $hCurrentItem) ; Step to next item
    If $hCurrentItem = 0 Then
    ;Ran out of items so didn't find directory
    Return SetError(4, 0, "")
    EndIf
   WEnd
   _GUICtrlTreeView_Expand($HWND, $hCurrentItem)
   _GUICtrlTreeView_ClickItem($HWND, $hCurrentItem)
   Do
    $next = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem)
   Until $next <> $hCurrentItem
  Next
EndIf
;Needed for dialog to update
_GUICtrlTreeView_Expand($HWND, $hCurrentItem)
_GUICtrlTreeView_ClickItem($HWND, $hCurrentItem)
Do
  $next = _GUICtrlTreeView_GetFirstChild($HWND, $hCurrentItem)
Until $next <> $hCurrentItem
If $bClickOK Then
  ;Click OK button
  ControlClick("Browse for Folder", "", "[CLASS:Button; INSTANCE:1]")
EndIf
EndFunc   ;==>_BFF_SelectFolder