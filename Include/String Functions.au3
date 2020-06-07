#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Description: A collection of custom
  string functions for AutoIt.

List of Functions:
   1. StringReplaceV()
   2. StringSplitV()
   3. StringMidV()
   4. StringLeftV()
   5. StringRightV()
   6. StringLenV()

#ce ---------------------------------------

#cs -- ;DEPENDENCIES
#include ".\Functionals.au3"

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
#include "I:\SAI\Auto-It files\Include\_NestedArrayDisplay.au3"

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

   $x = Map(StringLen, $a); Map() is from Functionals.au3

   Return $x ; always use the Return command to return a value when creating a function.

EndFunc

#cs -- BEGIN TEST
#include <Array.au3>
#include ".\Array Management.au3" ; to load _ArrayColInsert2().
#include ".\Functionals.au3"

Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

; Get the lengths of each element from $my_array.
$lens = StringLenV($my_array) ; from String Functions.au3

; Have to create a new object because _ArrayColInsert2() is immutable (i.e., it does not auto-update the reference array).
$my_array2 = _ArrayColInsert2($my_array, 1, $lens)

_ArrayDisplay($my_array2)

#ce -- END TEST

