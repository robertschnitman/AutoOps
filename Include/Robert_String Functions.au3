#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Last Modified: 2020-06-09
Description: A collection of custom
  string functions for AutoIt.

List of Functions:
   1. StringReplaceV()
   2. StringSplitV()
   3. StringMidV()
   4. StringLeftV()
   5. StringRightV()
   6. StringLenV()
   7. StringConcatenateV()
   8. StringRegExpReplaceV()
   9. StringInStrV()
   10. StringStripCRV()
   11. StringStripWSV()
   12. StringIsSpaceV()
   13. ZeroFlag()
   14. ZeroFlagV()
   15. ZeroFlagSSN()
   16. ZeroFlagSSNV()
   17. StringJoin()

#ce ---------------------------------------

#cs -- ;DEPENDENCIES
#include ".\Robert_Functionals.au3" ; Duplicate function error?

#ce --



;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: StringReplaceV()
Description: A vectorization of StringReplace().
  In other words, it applies StringReplace() for
  every element in an array (for 1 dimension).

  An attempted replication of gsub() from R.

#ce ---------------------------------------

Func StringReplaceV($a, $search, $replace) ; array, character(s) to search for, character(s) to replace the search query.

   ; For each element, search for the character(s) to replace and then replace it with the desired character(s).
   For $i = 0 to Ubound($a) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $a[$i] = StringReplace($a[$i], $search, $replace)

   Next

   Return $a ; always use the Return command to return a value when creating a function.

EndFunc


#cs -- BEGIN TEST
#include <Array.au3>
Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

$a2 = StringReplaceV($my_array, "_", " ")

_ArrayDisplay($a2)


#ce -- END TEST

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: StringSplitV()
Description: A vectorization of StringSplit().
  In other words, it applies StringSplit() for
  every element in an array (for 1 dimension).

  *WARNING: The output is an array of arrays.

#ce ---------------------------------------

Func StringSplitV($a, $split) ; array, character to split by

   ; For each element, search for the character(s) to split by.
   For $i = 0 to Ubound($a) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $a[$i] = StringSplit($a[$i], $split)

   Next

   Return $a ; always use the Return command to return a value when creating a function.

EndFunc

#cs -- BEGIN TEST
#include <Array.au3>
#include ".\_NestedArrayDisplay.au3"

Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

$a2 = StringSplitV($my_array, "_")

_NestedArrayDisplay($a2)
#ce -- END TEST



;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: StringMidV()
Description: A vectorization of StringMid().
  In other words, it applies StringMid() for
  every element in an array (for 1 dimension).


#ce ---------------------------------------

Func StringMidV($a, $start, $count = -1) ; array, character to split by

   ; For each element, search for the character(s) to split by.
   For $i = 0 to Ubound($a) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $a[$i] = StringMid($a[$i], $start, $count)

   Next

   Return $a ; always use the Return command to return a value when creating a function.

EndFunc

#cs -- BEGIN TEST
#include <Array.au3>

Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

$a2 = StringMidV($my_array, 3, 5)

_ArrayDisplay($a2)
#ce -- END TEST



;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: StringLeftV()
Description: A vectorization of StringLeft().
  In other words, it applies StringLeft() for
  every element in an array (for 1 dimension).


#ce ---------------------------------------

Func StringLeftV($a, $count) ; array, character to split by

   ; For each element, search for the character(s) to split by.
   For $i = 0 to Ubound($a) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $a[$i] = StringLeft($a[$i], $count)

   Next

   Return $a ; always use the Return command to return a value when creating a function.

EndFunc

#cs -- BEGIN TEST
#include <Array.au3>

Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

$a2 = StringLeftV($my_array, 3)

_ArrayDisplay($a2)
#ce -- END TEST


;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: StringRightV()
Description: A vectorization of StringRight().
  In other words, it applies StringRight() for
  every element in an array (for 1 dimension).


#ce ---------------------------------------

Func StringRightV($a, $count) ; array, character to split by

   ; For each element, search for the character(s) to split by.
   For $i = 0 to Ubound($a) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $a[$i] = StringRight($a[$i], $count)

   Next

   Return $a ; always use the Return command to return a value when creating a function.

EndFunc

#cs -- BEGIN TEST
#include <Array.au3>

Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

$a2 = StringRightV($my_array, 3)

_ArrayDisplay($a2)
#ce -- END TEST



;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: StringLenV()
Description: A vectorization of StringLen().
  In other words, it applies StringLen() for
  every element in an array (for 1 dimension).


#ce ---------------------------------------

Func StringLenV($a) ; array, character to split by

   ; For each element, search for the character(s) to split by.

   $x = Map(StringLen, $a); Map() is from Robert_Functionals.au3

   Return $x ; always use the Return command to return a value when creating a function.

EndFunc

#cs -- BEGIN TEST
#include <Array.au3>
#include ".\Robert_Array Management.au3" ; to load _ArrayColInsert2()

Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

; Get the lengths of each element from $my_array.
$lens = StringLenV($my_array) ; from Robert_String Functions.au3

; Have to create a new object because _ArrayColInsert2() is immutable (i.e., it does not auto-update the reference array).
$my_array2 = _ArrayColInsert2($my_array, 1, $lens)

_ArrayDisplay($my_array2)

#ce -- END TEST

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-08
Function: StringConcatenateV()
Description: Concatenate elements for each element
  in an array.

#ce ---------------------------------------

Func StringConcatenateV($a, $concat)

   For $i = 0 to UBound($a) - 1

	  $a[$i] = $a[$i] & $concat

   Next

   Return $a

EndFunc

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-08
Function: StringRegExpReplaceV()
Description: A vectorization of StringRegExpReplace().

#ce ---------------------------------------

Func StringRegExpReplaceV($a, $search, $replace) ; array, character(s) to search for, character(s) to replace the search query.

   ; For each element, search for the character(s) to replace and then replace it with the desired character(s).
   For $i = 0 to Ubound($a) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $a[$i] = StringRegExpReplace($a[$i], $search, $replace)

   Next

   Return $a ; always use the Return command to return a value when creating a function.

EndFunc


;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: StringInStrV()
Description: A vectorization of StringInStr().
  As of 2020-06-09, the count parameter is
  not used.

#ce ---------------------------------------

Func StringInStrV($a, $substring, $casesense = 0, $occurrence = 1, $start = 1)

   For $i = 0 to Ubound($a) - 1

	  $a[$i] = StringInStr($a[$i], $substring, $casesense, $occurrence, $start)

   Next

   Return $a

EndFunc

#cs --
#include <Array.au3>

Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

$ssv_test = StringInStrV($my_array, "_")

_ArrayDisplay($ssv_test)
#ce --

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: StringStripCRV()
Description: A vectorization of StringStripCR().

#ce ---------------------------------------

Func StringStripCRV($a)

   $x = Map(StringStripCR, $a) ; Map() is from Robert_Functionals.au3

   Return $x

EndFunc

#cs -- TEST
#include <Array.au3>
#include ".\Robert_Functionals.au3"

Local $my_array[3] = ["hi" & Chr(13) & "robert", "hi" & Chr(13) & "nathan", "hi" & Chr(13) & "faith"]

$test = StringStripCRV($my_array)

_ArrayDisplay($test)
#ce --

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: StringStripWSV()
Description: A vectorization of StringStripWS().

#ce ---------------------------------------

; $Str_STRIPALL is from StringConstants.au3
;   https://www.autoitscript.com/autoit3/docs/functions/StringStripWS.htm
Func StringStripWSV($a, $flag = $STR_STRIPALL)

   For $i = 0 to Ubound($a) - 1

	  $a[$i] = StringStripWS($a[$i], $flag)

   Next

   Return $a


EndFunc

#cs -- TEST
#include <Array.au3>
#include <StringConstants.au3>

Local $my_array[3] = ["hi robert", "hi nathan", "hi faith"]

$test = StringStripWSV($my_array)

_ArrayDisplay($test)
#ce --

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: StringIsSpaceV()
Description: A vectorization of StringIsSpace().

#ce ---------------------------------------

Func StringIsSpaceV($a)

   $x = Map(StringIsSpace, $a) ; Map() is from Robert_Functionals.au3

   Return $x

EndFunc

#cs -- TEST
#include <Array.au3>
#include ".\Robert_Functionals.au3"

Local $my_array[4] = [Chr(13), "", "	", "hi"]

$test = StringIsSpaceV($my_array)

_ArrayDisplay($test)
#ce --

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: ZeroFlag()
Description: Flag a 0 at the beginning of
  a string if a specified width is not met.

#ce ---------------------------------------

Func ZeroFlag($string, $width)

   ; Prefix a 0 to the string until a width of $width has been reached.
   ; https://www.autoitscript.com/autoit3/docs/functions/StringFormat.htm
   $x = StringFormat("%0" & $width & "s", $string)

   Return $x

EndFunc

#cs -- TEST
$s = 700

MsgBox(1, 'ZeroFlag($s, 4) output', ZeroFlag($s, 4))
#ce --


;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: ZeroFlagV()
Description: A vectorization of ZeroFlag().

#ce ---------------------------------------

Func ZeroFlagV($a, $width)

   For $i = 0 to UBound($a) - 1

	  ; Prefix a 0 to the string until a width of $width has been reached.
	  ; https://www.autoitscript.com/autoit3/docs/functions/StringFormat.htm
	  $a[$i] = StringFormat("%0" & $width & "s", $a[$i])

   Next

   Return $a

EndFunc

#cs --
#include <Array.au3>

Local $test[3] = [700, 930, 1625]

_ArrayDisplay(ZeroFlagV($test, 4))
#ce --

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: ZeroFlagSSN()
Description: Flag a 0 at the beginning of
  a string until a width of 9 is reached.

#ce ---------------------------------------

Func ZeroFlagSSN($string)

   ; %09s --> prefix a 0 to the string until a width of 9 has been reached.
   ; https://www.autoitscript.com/autoit3/docs/functions/StringFormat.htm
   $x = StringFormat("%09s", $string)

   Return $x

EndFunc

#cs -- TEST
$s = 700

MsgBox(1, 'ZeroFlagSSN($s) output', ZeroFlagSSN($s))
#ce --


;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: ZeroFlagSSNV()
Description: A vectorization of ZeroFlagSSN().

#ce ---------------------------------------

Func ZeroFlagSSNV($a)

   $x = Map(ZeroFlagSSN, $a) ; Map() is from Robert_Functionals.au3.

   Return $x

EndFunc

#cs -- TEST
#include <Array.au3>
#include "Robert_Functionals.au3"

Local $test[3] = [700, 930, 1625]

_ArrayDisplay(ZeroFlagSSNV($test))
#ce

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: StringJoin()
Description: Concatenates all elements of an
  array into a single string.

  Inspired by the Ruby programming language's
  .join method.
#ce ---------------------------------------

Func StringJoin($a)

   ; initialize loop
   $x = ""

   ; self-concatenate until the last element has been concatenated.
   For $i in $strings

	  $x &= $i

   Next

   ; Output should be the concatenation of all the elements into a single string.
   Return $x

EndFunc

#cs -- TEST
Local $strings[5] = ["hi", "mon ami", "robert", "nathan", "faith"]

$strings2 = StringJoin($strings)

MsgBox(1, 'test', $strings2) ; output: "himon amirobert"
#ce --