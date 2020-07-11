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
   4. Map2()
   5. filter()
	  1. gt()
	  2. gte()
	  3. lt()
	  4. lte()
	  5. eq()
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
#include "RS_String Functions.au3"
Local $my_array[] = [4, 9, 16, 25]
$x = MapJoin(Sqrt, $my_array)
MsgBox(1, 'test', $x)
#ce -- END TEST

;==============================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Functions: MapCol(), ColSums(), ColMeans()
Description: MapCol() maps a function
  to each column in an array.
  ColSums() applies Sum() to each column.
  ColMeans() applies Mean() to each column.
  Sum() and Mean() are from RS_Math.au3.
#ce ---------------------------------------

Func MapCol($f, $a) ; $a is assumed to be 2D.

   ; Initialize loop
   Local $x[UBound($a, 2)] = [0]

   ; For each column, execute a function over it.
   For $i = 0 to UBound($a, 2) - 1

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
#include "RS_String Functions.au3"
#include "RS_Math.au3"
Local $aArray[4][4]
For $i = 0 To UBound($aArray) - 1
    For $j = 0 To UBound($aArray, 2) - 1
        $aArray[$i][$j] = $i + $j
    Next
Next
$z = MapCol(Sum, $aArray)
_ArrayDisplay($z, "MapCol(Sum, $aArray)")
_ArrayDisplay(ColSums($aArray), "ColSums($aArray)")
_ArrayDisplay(ColMeans($aArray), "ColMeans($aArray)")
#ce -- END TEST

; ===

#cs ---
Author: Robert Schnitman
Date Created: 2020-06-18
Function: Map2()
Description: applies a function
to 2 arrays in parallel. Useful
when you want to apply a function
that accepts 2 inputs.
#ce ---

Func Map2($f, $array1, $array2)

	Local $x[Ubound($array1)] = [0]

	For $i = 0 to UBound($array1) - 1

		$x[$i] = $f($array1[$i], $array2[$i])

	Next

	Return $x

EndFunc

#cs --- BEGIN TEST
Func Add($x, $y)

	Return $x + $y

EndFunc

Local $x = [1, 2, 3]
Local $y = $x

#include <Array.au3>
_ArrayDisplay(Map2(Add, $x, $y))
#ce --- END TEST

; ===

#cs ---
Author: Robert Schnitman
Date: 2020-07-10
Function: MapReduce()
Description: Map
  a function to an array and
  then reduce it via another
  function.
#ce ---

Func MapReduce($x, $f, $o)

	Return $o(Map($f, $x))

EndFunc

#cs --- EXAMPLE
Local $y[] = [2, 3, 5, 7]

MsgBox(1, 'test', MapReduce($y, square, Sum))
MsgBox(1, 'test', MapReduce($y, square, StringJoin))

Func square($x)

	Return $x*$x

EndFunc

#ce ---

#cs ---
Author: Robert Schnitman
Date: 2020-07-10
Functions: filter(), gt(), gte(), lt(), lte(), eq()
Description:
	filter() subsets an array based on a filtering function.

	gt() subsets an array for elements greater than a specified value.

	gte() subsets an array for elements greater than or equal to a specified value.

	lt() subsets an array for elements less than a specified value.

	lte() subsets an array for elements less than or equal to a specified value.

	eq() subsets an array for elements equal to a specified value.

#ce ---

Func filter($array, $filt_fun, $val)

	; Subset array based on a filtering function
	Return $filt_fun($array, $val)

EndFunc

; Subset array for elements greater than a specified value.
Func gt($array, $val)

	; Create a True/False array to know where to find the desired elements.
	Local $test[UBound($array)] = [0]

		For $i = 0 to UBound($array) - 1

			If $array[$i] > $val Then

				$test[$i] = True

			Else

				$test[$i] = False

			EndIf

		Next

	; Find where the specified condition is True
	$indices = StringPos($test, "True")

	; The resultant array should only contain the elements where $indices is True.
	Local $out[UBound($indices)] = [0]

	For $i = 0 to UBound($out) - 1

		$out[$i] = $array[$indices[$i]]

	Next

	Return $out

EndFunc

; Subset array for elements greater than or equal to a specified value.
Func gte($array, $val)

	; Create a True/False array to know where to find the desired elements.
	Local $test[UBound($array)] = [0]

		For $i = 0 to UBound($array) - 1

			If $array[$i] >= $val Then

				$test[$i] = True

			Else

				$test[$i] = False

			EndIf

		Next

	; Find where the specified condition is True
	$indices = StringPos($test, "True")

	; The resultant array should only contain the elements where $indices is True.
	Local $out[UBound($indices)] = [0]

	For $i = 0 to UBound($out) - 1

		$out[$i] = $array[$indices[$i]]

	Next

	Return $out

EndFunc

; Subset an array for elements being less than a specified value.
Func lt($array, $val)

	Local $test[UBound($array)] = [0]

		For $i = 0 to UBound($array) - 1

			If $array[$i] < $val Then

				$test[$i] = True

			Else

				$test[$i] = False

			EndIf

		Next

	$indices = StringPos($test, "True")

	Local $out[UBound($indices)] = [0]

	For $i = 0 to UBound($out) - 1

		$out[$i] = $array[$indices[$i]]

	Next

	Return $out

EndFunc

; Subset an array for elements being less than or equal to a specified value.
Func lte($array, $val)

	Local $test[UBound($array)] = [0]

		For $i = 0 to UBound($array) - 1

			If $array[$i] <= $val Then

				$test[$i] = True

			Else

				$test[$i] = False

			EndIf

		Next

	$indices = StringPos($test, "True")

	Local $out[UBound($indices)] = [0]

	For $i = 0 to UBound($out) - 1

		$out[$i] = $array[$indices[$i]]

	Next

	Return $out

EndFunc

; Subset an array for elements equaling a specified value.
Func eq($array, $val)

	Local $test[UBound($array)] = [0]

		For $i = 0 to UBound($array) - 1

			If $array[$i] = $val Then

				$test[$i] = True

			Else

				$test[$i] = False

			EndIf

		Next

	$indices = StringPos($test, "True")

	Local $out[UBound($indices)] = [0]

	For $i = 0 to UBound($out) - 1

		$out[$i] = $array[$indices[$i]]

	Next

	Return $out

EndFunc

#cs --- TEST
Local $x[] = [2, 3, 5, 7, 3]

;_ArrayDisplay(gt($x, 4))
;_ArrayDisplay(lt($x, 4))
;_ArrayDisplay(eq($x, 3))
;_ArrayDisplay(filter($x, gt, 3))

#ce ---