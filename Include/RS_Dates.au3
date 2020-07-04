#cs -----------------------------------------
Author: Robert Schnitman
Date Created: 2020-06-04
Date Modified: 2020-06-16
Description: A collection of date elements
  and functions typically for file-naming
  conventions and convenience.
#ce -----------------------------------------

; Functions and objects to include
#include <Date.au3>
#include <Array.au3>
#include <File.au3>

; Split today's and yesterday's dates into 3-element arrays.
$Today = StringSplit(_DateAdd("d", 0, _NowCalcDate()), "/") ; Today in YYYY/MM/DD format, being split into 3 elements
$Yesterday = StringSplit(_DateAdd("d", -1, _NowCalcDate()), "/")

; Save each element into their own objects.
; This is done so that we can input them into file names.
$yr_now = $Today[1]
$mo_now = $Today[2]
$dd_now = $Today[3]

$yr_yes = $Yesterday[1]
$mo_yes = $Yesterday[2]
$dd_yes = $Yesterday[3]

; === FUNCTIONS

#cs -----------------------------------------
Author: Robert Schnitman
Date Created: 2020-06-16
Date Modified: 2020-06-16
Functions: date_now(), date_yesterday(), yday()
Description: Get today's and yesterday's date.
Optionally, have a delimiter seperate the
year, month, and day.

yday() returns @YDAY (Day of the year).
#ce -----------------------------------------

Func date_now($delimiter = "-")

	$split = StringSplit(_DateAdd("d", 0, _NowCalcDate()), "/", 2); 2 = Exclude count

	Return StringJoin($split, $delimiter) ; From Robert_String Functions.au3

EndFunc

Func date_yesterday($delimiter = "-")

	$split = StringSplit(_DateAdd("d", -1, _NowCalcDate()), "/", 2); 2 = Exclude count

	Return StringJoin($split, $delimiter) ; From Robert_String Functions.au3

EndFunc

Func yday()

	Return @YDAY ; e.g. 165

EndFunc
