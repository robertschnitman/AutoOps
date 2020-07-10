#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Last Modified: 2020-06-14
Description: A collection of custom
  string functions for AutoIt as mostly inspired
  by the stringr package from R and string methods
  from Ruby.

  https://stringr.tidyverse.org/reference/index.html
  https://ruby-doc.org/core-2.6/String.html

Notes: Unless otherwise noted, The "V" at the end of the
  function name denotes that it applies to every element in a 1D array.

List of Functions:
   1. StringReplaceV()
   2. StringSplitV()
   3. StringMidV()
   4. StringLeftV()
   5. StringRightV()
   6. StringLenV()
   7. StringConcatenateV() = Concatenate a string to another string.
		1. StringPaste()   = Shorthand for StringConcatenateV().
   8. StringRegExpReplaceV() = Replace a string based on a regular expresion.
		1. StringSub()       = Replace a string based on a regular expression (shorthand of StringRegExpReplace()).
		2. StringSubV()      = Replace each array element with another string based on a regular expression (shorthand of StringRegExpReplaceV()).
		3. StringRemove()    = Removes a specified string from a larger string.
		4. StringRemoveV()   = Applies StringRemove() to each element in an array.
   9. StringInStrV()
   10. StringStripCRV()
   11. StringStripWSV()
   12. StringIsSpaceV()
   13. ZeroFlag()    = Specify a width to flag a 0 at the beginning of a string.
   14. ZeroFlagV()
   15. ZeroFlagSSN() = Flag zeros to fill a 9-digit string.
   16. ZeroFlagSSNV()
   17. StringJoin()    = Combine all array elements into a single string.
   18. StringDetect()  = Detect whether a string meets a specified regular expression.
   19. StringDetectV()
   20. StringExtract() = Return array of string matches based on a regular expression.
   21. StringExtractV()
   22. StringDup() = Repeat a string a specified number of times.
		1. StringDupV()
   23. StringPos()        = Return array of positions of a specified string pattern.
		1. StringSubset() = Subset an array of strings based on a regular expression pattern.
   24. StringChomp() = Remove all white space characters from a string.
		1. StringChompV()
   25. StringLocate()      = List the starting and ending positions of a specified substring.
		1. StringLocateV()
		2. StringStart()   = Output the starting position of a string. A simpler StringInStr().
		3. StringStartV()
		4. StringEnd()     = Output the ending position of a string.
		5. StringEndV()
   26. StringRange() = Similar to StringMid, but the 3rd input is an ending position index.
   27. StringTrim() = Removes leading and trailing white spaces.
		1. StringTrimV()
		2. StringTrim2WS() = Removes double or more spaces.
		3. StringTrim2WSV()
   28. StringPrefix()   = Appends a prefix to a string.
	  1. StringPrefixV()
	  2. StringSuffix() = Appends a suffix to a string.
	  3. StringSuffixV()
   29. StringClear() = Removes all characters from a string.
	  1. StringClearV()
   30. StringSwitch() = For an array, replaces specified values with another set of specified values.
   31. StringSwitchSub() = Replace specified values with another set of specified values based on a regular expression.
   32. StringInsertV() = Insert a string at a specified position for each element in an array.
   33. grep() = synonym for StringSubset()
	  1. grepl() = synonym for StringDetect()
	  2. greplv() = vectorization of grepl(); synonym for StringDetectV)_.
	  3. gsub() = synonym of StringSub()
	  4. gsubv() = synonym of StringSubV().
#ce ---------------------------------------

; DEPENDENCIES
;#include ".\RS__Library.au3" ; Load this in a separate tab to test the functions below.
#include <StringConstants.au3>

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

Func StringReplaceV($array, $search, $replace) ; array, character(s) to search for, character(s) to replace the search query.

   ; For each element, search for the character(s) to replace and then replace it with the desired character(s).
   For $i = 0 to Ubound($array) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $array[$i] = StringReplace($array[$i], $search, $replace)

   Next

   Return $array ; always use the Return command to return a value when creating a function.

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

Func StringSplitV($array, $split) ; array, character to split by

   ; For each element, search for the character(s) to split by.
   For $i = 0 to Ubound($array) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $array[$i] = StringSplit($array[$i], $split)

   Next

   Return $array ; always use the Return command to return a value when creating a function.

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

Func StringMidV($array, $start, $count = -1) ; array, character to split by

   ; For each element, search for the character(s) to split by.
   For $i = 0 to Ubound($array) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $array[$i] = StringMid($array[$i], $start, $count)

   Next

   Return $array ; always use the Return command to return a value when creating a function.

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

Func StringLeftV($array, $count) ; array, character to split by

   ; For each element, search for the character(s) to split by.
   For $i = 0 to Ubound($array) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $array[$i] = StringLeft($array[$i], $count)

   Next

   Return $array ; always use the Return command to return a value when creating a function.

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

Func StringRightV($array, $count) ; array, character to split by

   ; For each element, search for the character(s) to split by.
   For $i = 0 to Ubound($array) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $array[$i] = StringRight($array[$i], $count)

   Next

   Return $array ; always use the Return command to return a value when creating a function.

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

Func StringLenV($array) ; array, character to split by
   ; For each element, search for the character(s) to split by.

   $x = Map(StringLen, $array); Map() is from RS_Functionals.au3. It applies a function to each element in an array.

   Return $x ; always use the Return command to return a value when creating a function.

EndFunc

#cs -- BEGIN TEST
#include <Array.au3>
#include ".\RS_ArrayOps.au3" ; to load _ArrayColInsert2()
Local $my_array[3] = ["hi_robert", "hi_nathan", "hi_faith"]
; Get the lengths of each element from $my_array.
$lens = StringLenV($my_array) ; from RS_StringOps.au3
; Have to create a new object because _ArrayColInsert2() is immutable (i.e., it does not auto-update the reference array).
$my_array2 = _ArrayColInsert2($my_array, 1, $lens)
_ArrayDisplay($my_array2)
#ce -- END TEST

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-08
Function: StringConcatenateV(), StringPaste()
Description: Concatenate elements for each element
  in an array.
  StringPaste() is a shorthand for StringConcatenateV().
#ce ---------------------------------------

Func StringConcatenateV($array, $concat)

   For $i = 0 to UBound($array) - 1

	  $array[$i] = $array[$i] & $concat

   Next

   Return $array

EndFunc

Func StringPaste($array, $concat)

	Return StringConcatenateV($array, $concat)

EndFunc

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date Created: 2020-06-08
Date Modified: 2020-06-14
Functions: StringRegExpReplaceV(),
		   StringSub(),
		   StringSubV(),
		   StringRemove(),
		   StringRemoveV()
Description: A vectorization of StringRegExpReplace().
  StringSub() is a shorthand for the defaults of StringRegExpReplace().
  StringSubV() is a shorthand for the StringRegExpReplaceV()
  ("generalized substitution").
  StringRemove() removes a matched pattern from a string.
  StringRemoveV() is a vectorization of StringRemove().
#ce ---------------------------------------

Func StringRegExpReplaceV($array, $search, $replace) ; array, character(s) to search for, character(s) to replace the search query.

   ; For each element, search for the character(s) to replace and then replace it with the desired character(s).
   For $i = 0 to Ubound($array) - 1 ; AutoIt uses 0-based indexing, so the maximum index value is the number of elements minus 1.

	  $array[$i] = StringRegExpReplace($array[$i], $search, $replace)

   Next

   Return $array ; always use the Return command to return a value when creating a function.

EndFunc

Func StringSub($string, $search, $replace)

	Return StringRegExpReplace($string, $search, $replace)

EndFunc

Func StringSubV($array, $search, $replace)

	$x = StringRegExpReplaceV($array, $search, $replace)

	Return $x

EndFunc

Func StringRemove($string, $string_to_remove)

	Return StringSub($string, $string_to_remove, "")

EndFunc

Func StringRemoveV($array, $string_to_remove)

	For $i = 0 to UBound($array) - 1

		$array[$i] = StringRemove($array[$i], $string_to_remove)

	Next

	Return $array

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

Func StringInStrV($array, $substring, $casesense = 0, $occurrence = 1, $start = 1)

   For $i = 0 to Ubound($array) - 1

	  $array[$i] = StringInStr($array[$i], $substring, $casesense, $occurrence, $start)

   Next

   Return $array

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

Func StringStripCRV($array)

   $x = Map(StringStripCR, $array) ; Map() is from RS_Functionals.au3. It applies a function to each element in an array.

   Return $x

EndFunc

#cs -- TEST
#include <Array.au3>
#include ".\RS_Functionals.au3"
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
Func StringStripWSV($array, $flag = $STR_STRIPALL)

   For $i = 0 to Ubound($array) - 1

	  $array[$i] = StringStripWS($array[$i], $flag)

   Next

   Return $array


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

Func StringIsSpaceV($array)

   $x = Map(StringIsSpace, $array) ; Map() is from RS_Functionals.au3. It applies a function to each element in an array.

   Return $x

EndFunc

#cs -- TEST
#include <Array.au3>
#include ".\RS_Functionals.au3"
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

Func ZeroFlagV($array, $width)

   For $i = 0 to UBound($array) - 1

	  ; Prefix a 0 to the string until a width of $width has been reached.
	  ; https://www.autoitscript.com/autoit3/docs/functions/StringFormat.htm
	  $array[$i] = StringFormat("%0" & $width & "s", $array[$i])

   Next

   Return $array

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

Func ZeroFlagSSNV($array)

   $x = Map(ZeroFlagSSN, $array) ; Map() is from RS_Functionals.au3. It applies a function to each element in an array.

   Return $x

EndFunc

#cs -- TEST
#include <Array.au3>
#include "RS_Functionals.au3"
Local $test[3] = [700, 930, 1625]
_ArrayDisplay(ZeroFlagSSNV($test))
#ce

;=====================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date Created: 2020-06-09
Date Modified: 2020-06-11
Function: StringJoin()
Description: Concatenates all elements of an
  array into a single string.
  Inspired by the Ruby programming language's
  .join method.
#ce ---------------------------------------

Func StringJoin($array, $separator = "")

   ; initialize loop
   $x = ""

   ; self-concatenate until the last element has been concatenated.
   For $i in $array

	  $x &= $i & $separator

   Next

   ; if the last character is a separator, remove it.
   $last_char = StringRight($x, 1)

   If $last_char = $separator Then

	  $y = StringLeft($x, StringLen($x) - 1) ; Take out final separator

   Else

	  $y = $x

   EndIf

   ; Output should be the concatenation of all the elements into a single string.
   Return $y

EndFunc

#cs -- TEST
Local $strings[5] = ["hi", "mon ami", "robert", "nathan", "faith"]
$strings2 = StringJoin($strings, "|")
MsgBox(1, 'test', $strings2) ; output: "hi|mon ami|robert|nathan|faith"
#ce --

; =======

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-11
Functions: StringDetect(), StringDetectV()
Description: StringDetect() Detects whether there is a
  regular pattern match and outputs True/False.
  StringDetectV() is a vectorized version of
  StringDetect(), intended for arrays.
#ce ---------------------------------------

Func StringDetect($string, $pattern)

	If StringRegExp($string, $pattern) = 1 Then

		$x = True

	Else

		$x = False

	EndIf

	Return $x

EndFunc

#cs -- TEST
$str = "Loan Report_ABC Test.xls"
$test_me = StringDetect($str, "ABC|CBA|XYZ")
MsgBox(1, "test", $test_me & ": " & $str & " is in 'ABC|CBA|XYZ'")
#ce --

Func StringDetectV($array, $pattern) ; $a is an array

	For $i = 0 to UBound($array) - 1

		$array[$i] = StringDetect($array[$i], $pattern)

	Next

	Return $array

EndFunc

#cs -- TEST
#include <Array.au3>
Local $stra[] = ["Loan Report_ABC Test.xls", "Loan Report_CBA Test.xls", "Loan Report_dont select me.xls"]
$test_me = StringDetectV($stra, "ABC|CBA|XYZ")
_ArrayDisplay($test_me)
#ce --

; ====


#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-11
Function: StringExtract(), StringExtractV()
Description: StringExtract() extracts a
  substring based on a pattern match.
  StringExtractV() is a vectorization of
  StringExtract. Can pull multiple matches
  per row.
#ce ---------------------------------------

Func StringExtract($string, $pattern)

	; 3 = returns array of global matches
	; https://www.autoitscript.com/autoit3/docs/functions/StringRegExp.htm
	Return StringRegExp($string, $pattern, 3)

EndFunc

Func StringExtractV($array, $pattern, $separator = ",")

	For $i = 0 to UBound($array) - 1

		$array[$i] = StringJoin(StringExtract($array[$i], $pattern), $separator)

	Next

	Return $array

EndFunc

#cs -- TEST
Local $stra[] = ["Loan Report_ABC Test.xls", "Loan Report_CBA Test.xls", "Loan Report_dont select me.xls"]
$stra_join = StringJoin($stra)
$search_query = "ABC|XYZ|CBA"
_ArrayDisplay(StringExtract($stra_join, $search_query))
;_ArrayDisplay($x)
#ce

; ====

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-12
Functions: StringDup(), StringDupV()
Description: StringDup() repeats a string
  a specified number of times.
  StringDupV() is a vectorization of
  StringDup().
#ce ---------------------------------------

Func StringDup($string, $times)

	Local $array[$times] = [0]

	For $i = 0 to UBound($array) - 1

		$array[$i] = $string

	Next

	Return StringJoin($array)

EndFunc

Func StringDupV($array, $times)

	For $i = 0 to UBound($array) - 1

		$array[$i] = StringDup($array[$i], $times)

	Next

	Return $array

EndFunc

#cs -- TEST
#include "I:\SAI\Auto-it Files\Include\RS__Library.au3"
$s = "robert"
$test = StringDup($s, 5)
MsgBox(1, 'test', $test)
#ce --

; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-14
Functions: StringPos(), StringSubset()
Description: StringPos() finds specific indices
  of an array based on a regular expression pattern.
  StringSubset() calls StringPos() to return
  the matching values.
#ce ---------------------------------------

Func StringPos($array, $search_pattern)

	$indices = _ArrayFindAll($array, $search_pattern, Default, Default, Default, 3); 3 = regular expression pattern

	Return $indices

EndFunc

; simpler version of _ArrayFilter() from RS_ArrayOps.au3.
Func StringSubset($array, $search_pattern)

	; find the indices
	$indices = StringPos($array, $search_pattern)

	; initialize loop
	Local $output[UBound($indices)] = [0]

	; Insert into $indices the matching values from $a.
	For $i = 0 to UBound($indices) - 1

		$output[$i] = $array[$indices[$i]]

	Next

	; Return the array.
	Return $output

EndFunc


; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-14
Functions: StringChomp(), StringChompV()
Description: StringChomp() removes all spaces.
  It is a shorthand for StringStripWS(string, 8).
  StringChompV is a vectorization of StringChomp().
  Inspired by Ruby's chomp method (https://ruby-doc.org/core-2.4.0/String.html#method-i-chomp).
#ce ---------------------------------------

Func StringChomp($string)

	Return StringStripWS($string, 8)

EndFunc

Func StringChompV($array)

	$output = Map(StringChomp, $array) ; Map() is from RS_Functionals.au3. It applies a function to each element in an array.

	Return $output

EndFunc

; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-14
Functions: StringLocate(),
		   StringLocateV()
		   StringStart(),
		   StringStartV()
		   StringEnd(),
		   StringEndV()
Description: Locate the start and end of a specific
  string. These functions are case-sensitive.
#ce ---------------------------------------

; StringStart()
Func StringStart($string, $substring)

	Return StringinStr($string, $substring, 1) ; case-sensitive

EndFunc

Func StringStartV($array, $substring)

	For $i = 0 to UBound($array) - 1

		$array[$i] = StringStart($array[$i], $substring)

	Next

	Return $array

EndFunc

; StringEnd()
Func StringEnd($string, $substring)

  Return StringStart($string, $substring) + StringLen($substring) - 1 ; Need to discount position 0?

EndFunc

Func StringEndV($array, $substring)

	For $i = 0 to UBound($array) - 1

		$array[$i] = StringEnd($array[$i], $substring)

	Next

	Return $array

EndFunc

; StringLocate()
Func StringLocate($string, $substring)

	$start = StringStart($string, $substring)
	$end   = StringEnd($string, $substring)
	$out   = $start & "," & $end

	Return $out

EndFunc

Func StringLocateV($array, $substring)

	For $i = 0 to UBound($array) - 1

		$array[$i] = StringLocate($array[$i], $substring)

	Next

	Return $array

EndFunc

; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-14
Functions: StringRange()
Description: Similar to StringMid(), but the 3rd input
is not a "count" but a position index.
#ce ---------------------------------------

Func StringRange($string, $start, $end)

	Return StringMid($string, $start, $end - $start + 1)

EndFunc


; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-14
Functions: StringTrim(),
           StringTrimV(),
		   StringTrim2WS(),
		   StringTrim2WSV()

Description:
	StringTrim() removes leading and trailing whitespaces from a string.
	StringTrimV() applies StringTrim for each element in an array.
	StringTrim2WS() removes double spaces from a string.
	StrimgTrim2WSV() applies StringTrim2WS over an array.
#ce ---------------------------------------

Func StringTrim($string)

	Return StringStripWS($string, 3) ; 3 = removes leading and trailing white space.

EndFunc

Func StringTrimV($array)

	Return Map(StringTrim, $array) ; Map() is from RS_Functionals.au3. It applies a function to each element in an array.

EndFunc

Func StringTrim2WS($string)

	Return StringStripWS($string, 4) ; 4 = removes double or more spaces between words

EndFunc

Func StringTrim2WSV($array)

	Return Map(StringTrim2WS, $array) ; Map is from RS_Functionals.au3. It applies a function to each element in an array.

EndFunc

; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-14
Functions: StringPrefix(),
		   StringSuffix()
		   StringPrefixV()
		   StringSuffixV()
StringPrefix() prefixes a given string to another string.
StringSuffix() appends a string to another string.
The String*fixV() functions are vectorized versions of the above functions.
#ce ---------------------------------------

Func StringPrefix($string, $prefix)

   Return $prefix & $string

EndFunc

Func StringSuffix($string, $suffix)

   Return $string & $suffix

EndFunc

Func StringPrefixV($array, $prefix)

   For $i = 0 to UBound($array) - 1

	  $array[$i] = $prefix & $array[$i]

   Next

   Return $array

EndFunc

Func StringSuffixV($array, $suffix)

      For $i = 0 to UBound($array) - 1

	  $array[$i] = $array[$i] & $suffix

   Next

   Return $array

EndFunc

; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-14
Functions: StringClear(), StringClearV()
Description: StringClear() removes all characters from a string.
StringClearV() applies StringClear() to all array elements.
#ce ---------------------------------------

Func StringClear($string)

   Return StringSub($string, ".*", "")

EndFunc

Func StringClearV($array)

   Return Map(StringClear, $array)

EndFunc

; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-26
Function: StringSwitch()
Description: For an array, replaces specified values
  with another set of specified values.

  Inspired by recode() from the dm R package
  (https://rs-dm.netlify.app/recode.html).
#ce ---------------------------------------

Func StringSwitch($array, $v_initial, $v_new)

	; Find each initial element and replace it with the new value.
	For $i = 0 to UBound($v_initial) - 1

		$array = StringReplaceV($array, $v_initial[$i], $v_new[$i])

	Next

	; The output array size should equal the input array size.
	Return $array


EndFunc

#cs
; EXAMPLE
Local $x[] = ['1', '2', '3', '4', _
              '1', '2', '3', '4']

Local $search[]  = ['2', '4']
Local $replace[] = ["Japanese", "Thai"]

_ArrayDisplay(StringSwitch($x, $search, $replace))

#ce

; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-26
Function: StringSwitchSub()
Description: For an array, replaces specified values
  with another set of specified values based on a regular expression.

  Inspired by recode() from the dm R package
  (https://rs-dm.netlify.app/recode.html).
#ce ---------------------------------------

Func StringSwitchSub($array, $v_initial, $v_new)

	; Find each initial element and replace it with the new value.
	For $i = 0 to UBound($v_initial) - 1

		$array = StringSubV($array, $v_initial[$i], $v_new[$i])

	Next

	; The output array size should equal the input array size.
	Return $array


EndFunc

; ===
#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-07-01
Function: StringInsertV()
Description: Insert a string at a specified
  position for each element in an array.
#ce ---------------------------------------

Func StringInsertV($array, $string_insert, $position)

	For $i = 0 to Ubound($array) - 1

		$array[$i] = _StringInsert($array[$i], $string_insert, $position)

	Next

	Return $array

EndFunc

#cs --- EXAMPLE
#include <Array.au3>
#include <String.au3>

Local $array = ["robert", "nathan", "faith"]

_ArrayDisplay(StringInsertV($array, ",", 3))
#ce ---

; ===

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-07-09
Functions: grep(), grepl(), greplv(), gsub(),
	gsubv()
Description:
	grep() is a synonym for StringSubset().

	grepl() is a synonym for StringDetect().

	greplv() is a synonym for StringDetectV().

	gsub() is a synonym for StringSub().

	gsubv() is a synonym for StringSubV().
#ce ---------------------------------------


Func grep($array, $pattern)

	Return StringSubset($array, $pattern)

EndFunc

Func grepl($string, $pattern)

	Return StringDetect($string, $pattern)

EndFunc

Func greplv($array, $pattern)

	Return StringDetectV($array, $pattern)

EndFunc

Func gsub($string, $pattern, $replacement)

	Return StringSub($string, $pattern, $replacement)

EndFunc

Func gsubv($array, $pattern, $replacement)

	Return StringSubV($array, $pattern, $replacement)

EndFunc