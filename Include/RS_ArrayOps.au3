#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Description: Collection of functions for
  managing arrays.
List of functions:
  1. _ArrayColInsert2()
  2. Unnest()
  3. _ArrayExtractCols()
  4. _ArrayExtractRows()
  5. _ArrayFilter()
  6. _ArrayFilter2() ; IN PROGRESS
  7. SelectCol()
  8. SelectCols()
#ce ---------------------------------------

; Dependency
#include <Array.au3>

;===============================================


#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: _ArrayColInsert2()
Description: Inserts an array in a specified
 column of a reference array. Assumes that the
 array to insert is 1 dimensional.
#ce ---------------------------------------

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
#include "I.\Robert_String Functions.au3" ; to load StringLenV().
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

; =================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-09
Functions: _ArrayExtractCols(),
           _ArrayExtractRows()
Description: _ArrayExtractCols() extracts a
  specific column(s) while retaining all rows.
  _ArrayExtractRows() does the opposite:
  it extracts a specific row(s) while
  retaining all columns.
#ce ---------------------------------------

Func _ArrayExtractCols($array_ref, $col_start, $col_end)

   Return _ArrayExtract($array_ref, -1, -1, $col_start, $col_end)

EndFunc

Func _ArrayExtractRows($array_ref, $row_start, $row_end)

   Return _ArrayExtract($array_ref, $row_start, $row_end, -1, -1)

EndFunc

#cs
Local $aArray[4][4]
For $i = 0 To 3
    For $j = 0 To 3
        $aArray[$i][$j] = $i + $j
    Next
 Next
_ArrayDisplay($aArray, "$aArray")
 _ArrayDisplay(_ArrayExtractCols($aArray, 1, 2), "_ArrayExtractCols($aArray, 1, 2)")
 _ArrayDisplay(_ArrayExtractRows($aArray, 1, 2), "_ArrayExtractRows($aArray, 1, 2)")
#ce

; ====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-10
Functions: _ArrayFilter, _ArrayFilter2()
Description: _ArrayFilter() subsets an array
  based on a search pattern.
  _ArrayFilter2() does the same but keeps
  all columns for a 2D array.
#ce ---------------------------------------

Func _ArrayFilter($a, $search_pattern, $pattern_type = 3)

	; Find indices
	Local $indices = _ArrayFindAll($a, $search_pattern, Default, Default, Default, $pattern_type); patterntype = 3 = regular expression pattern

	; Create an array of the elements matching the indices only
	Local $output[UBound($indices)] = [0]

	For $i = 0 to UBound($indices) - 1

		$output[$i] = $a[$indices[$i]]

	Next

	; Output should be a subset of the given array.
	Return $output

EndFunc

#cs
Func _ArrayFilter2($a, $search_pattern, $pattern_type = 3)
	Local $indices = _ArrayFindAll($a, $search_pattern, Default, Default, Default, $pattern_type); patterntype = 3 = regular expression pattern
	; Create an array of of just the indices only
	Local $output[UBound($indices)] = [0]
	For $i = 0 to UBound($indices) - 1
		_ArrayExtract($a, $i, $i)
	Next
	Return
EndFunc
#ce

; ===

#cs ---
Author: Robert Schnitman
Date: 2020-06-23
Function: SelectCol()
Description: Select a column based on a
  search pattern of the header row.
#ce ---

Func SelectCol($a, $search)

	; Extract the header
	$header = _ArrayExtractRows($a, 0, 0); This function is from Robert_ARray Management.au3.

	; Transpose so we can use StringPos() to find the column position for _ArrayExtractCols().
	_ArrayTranspose($header) ; So that we can use StringPos().

	; Find where a specific column is based on a search pattern.
	$index = StringPos($header, $search) ; StringPos() is from Robert_String Functions.au3

	; Select the column based on the index.
	$col = _ArrayExtractCols($a, $index[0], $index[0]) ; This function is from Robert_Array Management.au3.

	; The output should be a 1D array.
	Return $col

EndFunc

#cs ---
#include "P:\Automation\Auto-It files\Include\Robert__Library.au3"

; Initialize array
$df = 0

_FileReadToArray("./mtcars.csv", $df, 0, ",")

$sub = SelectCol($df, "wt")

_ArrayDisplay($sub)
#ce ---

; ===

#cs ---
Author: Robert Schnitman
Date: 2020-06-23
Function: SelectCols()
Description: Select multiple columns based on
  a search pattern.
#ce ---

Func SelectCols($a, $search)

	; Extract the header
	$header = _ArrayExtractRows($a, 0, 0); This function is from Robert_Array Management.au3.

	; Transpose so we can use StringPos() to find the column position for _ArrayExtractCols().
	_ArrayTranspose($header)

	; Find where a specific column is based on a search pattern.
	$indices = StringPos($header, $search) ; StringPos() is from Robert_String Functions.au3

	; Select columns based on indices.
	; Initialize subset array
	Local $subset[UBound($a)] = [0]

	; Make a column in subset for each index found in $indices.
	For $j = 0 to UBound($indices) - 1

		_ArrayColInsert($subset, $j)

	Next

	; Insert values from $a into the subset
	For $i = 0 to UBound($a) - 1

		For $j = 0 to UBound($indices) - 1

			; FROM array[i, j] to subset[i, j].
			; Should have same number of rows.
			$subset[$i][$j] = $a[$i][$indices[$j]]

		Next

	Next

	; The output should be a 1D array that excludes the "null" column (i.e. the initialized column).
	; Last column index is UBound($subset) - 1, so we subtract 1 more to remove the initialized column.
	Return _ArrayExtractCols($subset, 0, UBound($subset, 2) - 2); _ArrayExtractCols is from Robert_Array Management.au3.

EndFunc

#cs ---
#include "P:\Automation\Auto-It files\Include\Robert__Library.au3"

; Initialize array
$df = 0

_FileReadToArray("./mtcars.csv", $df, 0, ",")

$sub = SelectCols($df, "mpg|wt|hp|am")

_ArrayDisplay($sub)
#ce ---