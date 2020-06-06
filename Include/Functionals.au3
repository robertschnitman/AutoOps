#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Description: A collection of custom functionals,
  which are functions that take other functions
  as inputs.

  List of Functions:
   1. Map()

#ce ---------------------------------------

; DEPENDENCY
#include <Array.au3>



;==============================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: Map()
Description: A function that maps a function
  to each element in an array. In other words,
  it "auto-creates" a loop for a function.

 This function is intended for arrays.

 This function is inspired by Map()
 from R.

 *WARNING: Cannot handle anonymous functions
 at this time. In the future, functions
 that require multiple parameters such as
 StringReplace() would be possible (perhaps
 in a new function called "Vectorize").

#ce ---------------------------------------

Func Map($f, $a)

   For $i = 0 to UBound($a) - 1

	  $a[$i] = $f($a[$i])

   Next

   Return $a

EndFunc


#cs -- BEGIN TEST
Local $my_array[] = [4, 9, 16, 25]

$my_array2 = Map(Sqrt, $my_array)

_ArrayDisplay($my_array2)

#ce -- END TEST