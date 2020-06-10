#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Description: A collection of custom functionals,
  which are functions that take other functions
  as inputs.

  List of Functions:
   1. Map()
   2. MapJoin()
   3. MapCol()
	  1. ColSums()
	  2. ColMeans()

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

;==============================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: MapJoin()
Description: A function that maps a function
  to each element in an array and then joins
  them all into a single string.

#ce ---------------------------------------

Func MapJoin($f, $a)

   For $i = 0 to UBound($a) - 1

	  $a[$i] = $f($a[$i])

   Next

   Return StringJoin($a)

EndFunc


#cs -- BEGIN TEST
#include "Robert_String Functions.au3"
Local $my_array[] = [4, 9, 16, 25]

$x = MapJoin(Sqrt, $my_array)

MsgBox(1, 'test', $x)

#ce -- END TEST

;==============================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: MapCol()
Description: A function that maps a function
  to each column.

#ce ---------------------------------------

Func MapCol($f, $a) ; $a is assumed to be 2D.

   ; Initialize loop
   Local $x[UBound($a)] = [0]

   ; For each column, execute a function over it.
   For $i = 0 to UBound($a) - 1

	  $x[$i] = $f(_ArrayExtract($a, -1, -1, $i, $i))

   Next

   ; Because we are executing column-wise, results should Beep
   ;   column-wise as well.
   _ArrayTranspose($x)

   ; Return the output
   Return $x

EndFunc

Func ColSums($a)

   Return MapCol(Sum, $a)

EndFunc

Func ColMeans($a)

   Return MapCol(Mean, $a)

EndFunc


#cs -- BEGIN TEST
#include <Array.au3>
#include "Robert_String Functions.au3"
#include "Robert_Math.au3"

Local $aArray[4][4]
For $i = 0 To 3
    For $j = 0 To 3
        $aArray[$i][$j] = $i + $j
    Next
Next

$z = MapCol(Mean, $aArray)

_ArrayDisplay($z)
_ArrayDisplay(ColSums($aArray))
_ArrayDisplay(ColMeans($aArray))

#ce -- END TEST