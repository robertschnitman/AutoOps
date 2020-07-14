#cs ---
Author: Robert Schnitman
Date: 2020-07-13
Description: Functions for admin operations.
List of Functions:
	1. CheckAdmin()


#ce ---

; Dependencies
#include <Array.au3>

; CheckAdmin()
; https://www.autoitscript.com/forum/topic/65077-checking-for-admin-rights/

Func CheckAdmin($username)
    Local $_net_exe, $_users
    $_net_exe = Run(@SystemDir & "\net.exe localgroup Administrators", @SystemDir, @SW_HIDE, 2)
	Do
        $_users &= StdoutRead($_net_exe)
    Until @error <> 0

	$out = grepl($_users, $username); From Robert_String Functions.au3 within Robert__Library.au3.

	Return $out

EndFunc ; e.g. MsgBox(1, 'Does user have admin rights?', CheckAdmin(@UserName))