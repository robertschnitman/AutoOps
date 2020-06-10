#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Last Modified: 2020-06-09
Description: A collection of custom
  math functions for AutoIt.

  List of Functions:
    1. Sum()
	2. Mean()

#ce ---------------------------------------


;========================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: Sum()
Description: Summation of all elements in
  an array.

#ce ---------------------------------------

Func Sum($a)

   $x = 0

   For $i = 0 to UBound($a) - 1

	  $x += $a[$i]

   Next

   Return $x

EndFunc

#cs -- TEST
Local $array = [1, 2, 3, 4, 5]

MsgBox(1, 'Sum of $array', Sum($array))
#ce --

;========================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: Mean()
Description: Average of all elements in
  an array.

#ce ---------------------------------------

Func Mean($a)

   Return Sum($a)/UBound($a)

EndFunc

#cs -- TEST
Local $array = [1, 2, 3, 4, 5]

MsgBox(1, 'Mean of $array', Mean($array))
#ce --

;========================================

#cs
#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Function: SD()
Description: Standard deviation of all
  elements in an array.

#ce ---------------------------------------

Func SD($a)

   Local $num[UBound($a)] = [0]

   For $i = 0 to UBound($a) - 1

	  $num[$i] = ($a[$i] - Mean($a))^2

   Next

   Return Sqrt(Mean($num))


EndFunc

;#cs -- TEST

#include <Array.au3>
Local $array = [1, 2, 3, 4, 5]

MsgBox(1, 'SD of $array', SD($array))
;#ce --

#ce