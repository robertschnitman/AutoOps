#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Description: Collection of functions for
  managing arrays.

List of functions:
  1. _ArrayColInsert2()
  2. Unnest()

#ce ---------------------------------------

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: _ArrayColInsert2()
Description: Inserts an array in a specified
 column of a reference array. Assumes that the
 array to insert is 1 dimensional.

#ce ---------------------------------------

; Dependency of _ArrayColInsert2().
#include <Array.au3>

Func _ArrayColInsert2($array_ref, $array_i, $col_position)

   ; Insert a column to the desired location
   _ArrayColInsert($array_ref, $col_position)

   ; For each row in the reference array, insert each element from the array to insert.
   For $i = 0 to Ubound($array_ref) - 1

	  $array_ref[$i][$col_position] = $array_i[$i]

   Next

   ; Return the modified array.
   Return $array_ref

EndFunc


#cs -- TEST

#include ".Include\Robert_String Functions.au3" ; to load StringLenV().

Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]

; Get the lengths of each element from $my_array.
$lens = StringLenV($my_array) ; from Robert_String Functions.au3

; In $my_array, insert $lens into the column index 1
; 	Have to create a new object because _ArrayColInsert2() is immutable (i.e., it does not auto-update the reference array).
$my_array2 = _ArrayColInsert2($my_array, $lens, 1)

_ArrayDisplay($my_array2)

#ce --

;==================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-04
Function: Unnest()
Description: A function that unnests an
  array of arrays (i.e. nested arrays).
#ce ---------------------------------------

; Functions and objects dependencies
#include <Date.au3>
#include <Array.au3>
#include <File.au3>

Func Unnest($aoa) ; $aoa = array of arrays

   ; Concatenate each array on top of each other
   For $i = 2 to UBound($aoa) - 1

	  _ArrayConcatenate($aoa[1], $aoa[$i])

   Next

   ; Combine all subarray elements into a single array
   $a1 = $aoa[1]
   $a2 = $aoa[2]

   ; This duplicates the array elements.
   ; 	This is so that we get a 1-dimensional array later when we apply _ArrayUnique().
   _ArrayConcatenate($a1, $a2)

   ; Get unique array values only
   $array_unique = _ArrayUnique($a1)

   Return $array_unique

EndFunc
