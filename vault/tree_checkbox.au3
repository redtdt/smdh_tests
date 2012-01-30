#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <GuiTreeView.au3>
#include <Array.au3>

; Create an array to hold the handles and checkstate of the treeview items
Global $aItems[17][3]

$winGUI = GUICreate("Food_Drink", 500, 500)

$tvItems = GUICtrlCreateTreeView(8, 16, 241, 305, BitOR($GUI_SS_DEFAULT_TREEVIEW, $TVS_CHECKBOXES), _
    $WS_EX_DLGMODALFRAME+$WS_EX_CLIENTEDGE)
    $hTV = GUICtrlGetHandle(-1) ; Get handle of the control - works better in the UDF commands used later on

$aItems[0][2] = GUICtrlCreateTreeViewItem("Food", $tvItems)
$aItems[0][0] = GuiCtrlGetHandle($aItems[0][2]) ; Set the [n][0] element to the handle of the item
$aItems[1][2] = GUICtrlCreateTreeViewItem("Fruit", $aItems[0][2])
$aItems[1][0] = GuiCtrlGetHandle($aItems[1][2])
$aItems[2][2] = GUICtrlCreateTreeViewItem("Apple", $aItems[1][2])
$aItems[2][0] = GuiCtrlGetHandle($aItems[2][2])
$aItems[3][2] = GUICtrlCreateTreeViewItem("Meat", $aItems[0][2])
$aItems[3][0] = GuiCtrlGetHandle($aItems[3][2])
$aItems[4][2] = GUICtrlCreateTreeViewItem("Steak", $aItems[3][2])
$aItems[4][0] = GuiCtrlGetHandle($aItems[4][2])
$aItems[5][2] = GUICtrlCreateTreeViewItem("Chicken", $aItems[3][2])
$aItems[5][0] = GuiCtrlGetHandle($aItems[5][2])
$aItems[6][2] = GUICtrlCreateTreeViewItem("Dairy", $aItems[0][2])
$aItems[6][0] = GuiCtrlGetHandle($aItems[6][2])
$aItems[7][2] = GUICtrlCreateTreeViewItem("Cheese", $aItems[6][2])
$aItems[7][0] = GuiCtrlGetHandle($aItems[7][2])
$aItems[8][2] = GUICtrlCreateTreeViewItem("Drinks", $tvItems)
$aItems[8][0] = GuiCtrlGetHandle($aItems[8][2])
$aItems[9][2] = GUICtrlCreateTreeViewItem("Water", $aItems[8][2])
$aItems[9][0] = GuiCtrlGetHandle($aItems[9][2])
$aItems[10][2] = GUICtrlCreateTreeViewItem("Fizzy", $aItems[8][2])
$aItems[10][0] = GuiCtrlGetHandle($aItems[10][2])
$aItems[11][2] = GUICtrlCreateTreeViewItem("Cola", $aItems[10][2])
$aItems[11][0] = GuiCtrlGetHandle($aItems[11][2])
$aItems[12][2] = GUICtrlCreateTreeViewItem("Juice", $aItems[8][2])
$aItems[12][0] = GuiCtrlGetHandle($aItems[12][2])
$aItems[13][2] = GUICtrlCreateTreeViewItem("OrangeJuice", $aItems[12][2])
$aItems[13][0] = GuiCtrlGetHandle($aItems[13][2])
$aItems[14][2] = GUICtrlCreateTreeViewItem("Hot Drinks", $aItems[8][2])
$aItems[14][0] = GuiCtrlGetHandle($aItems[14][2])
$aItems[15][2] = GUICtrlCreateTreeViewItem("Tea", $aItems[14][2])
$aItems[15][0] = GuiCtrlGetHandle($aItems[15][2])
$aItems[16][2] = GUICtrlCreateTreeViewItem("Coffee", $aItems[14][2])
$aItems[16][0] = GuiCtrlGetHandle($aItems[16][2])

; Create buttons to set/clear all
$hSet = GUICtrlCreateButton("Set All", 300, 10, 80, 30)
$hClear = GUICtrlCreateButton("Clear All", 300, 50, 80, 30)

GUISetState()

; This will store the last selected item to save time in the loop
$hLastSelected = 0

While 1

    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $hSet
            _Set_All()
        Case $hClear
            _Set_All(False) ; See the function code to see why we need to specify here and not in teh call above
    EndSwitch

    ; Get selected item
    $hSelected = _GUICtrlTreeView_GetSelection($hTV)

    ; Has it changed - we only need to get the index if it has
    If $hSelected <> $hLastSelected Then
        ; Get index of the newly selected item
        $iSelectedIndex = _ArraySearch($aItems, $hSelected)
        ; And save new selection
        $hLastSelected = $hSelected
    EndIf

    ; Now we check if the selected item check state matches the stored version
    If _GUICtrlTreeView_GetChecked($hTV, $hSelected) <> $aItems[$iSelectedIndex][1] Then

        ; If not we set the array to match so we do not repeat this on each pass
        $aItems[$iSelectedIndex][1] = _GUICtrlTreeView_GetChecked($hTV, $hSelected)

        ; And now we check/uncheck the related checkboxes
        Switch $aItems[$iSelectedIndex][1]
            Case True
                ; If checked then check the parents
                _Check_Parents($hSelected)
                ; If checked then check the children
                _Check_Children($hSelected, True)
            Case False
                ; Or uncheck the children
                _Check_Children($hSelected, False)
        EndSwitch
    EndIf

WEnd

Func _Check_Parents($hHandle)

    ; Get the handle of the parent
    $hParent = _GUICtrlTreeView_GetParentHandle($hTV, $hHandle)
    ; If there is no parent
    If $hParent = 0 Then
        Return
    EndIf
    ; Check the parent
    _GUICtrlTreeView_SetChecked($hTV, $hParent)
    ; Adjust the array
    $iIndex = _ArraySearch($aItems, $hParent)
    $aItems[$iIndex][1] = True
    ; And look for the grandparent and so on
    _Check_Parents($hParent)

EndFunc

Func _Check_Children($hHandle, $fState)

    ; Get the handle of the first child
    $hChild = _GUICtrlTreeView_GetFirstChild($hTV, $hHandle)
    ; If there is no child
    If $hChild = 0 Then
        Return
    EndIf
    ; Uncheck the child
    _GUICtrlTreeView_SetChecked($hTV, $hChild, $fState)
    ; Adjust the array
    $iIndex = _ArraySearch($aItems, $hChild)
    $aItems[$iIndex][1] = $fState
    ; Check for children
    _Check_Children($hChild, $fState)

    ; Now look for all grandchildren
    While 1
        ; Look for next child
        $hChild = _GUICtrlTreeView_GetNextChild($hTV, $hChild)
        ; Exit the loop if none found
        If $hChild = 0 Then
            ExitLoop
        EndIf
        ; Uncheck the child
        _GUICtrlTreeView_SetChecked($hTV, $hChild, $fState)
        ; Adjust the array
        $iIndex = _ArraySearch($aItems, $hChild)
        $aItems[$iIndex][1] = $fState
        ; Check for children
        _Check_Children($hChild, $fState)
        ; And then look for the next child
    WEnd

EndFunc

Func _Set_All($fState = True) ; This means that the value is True unless we set it otherwise when we call the function
    ; Loop through the array and set the checkboxes
    For $i = 0 To UBound($aItems) - 1
        _GUICtrlTreeView_SetChecked($hTV, $aItems[$i][0], $fState)
		$aItems[$i][1] = $fState ; This goes through the awway and sets the checked value
    Next
EndFunc