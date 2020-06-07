#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Description: A collection of custom
  AutoIt functions for file management.


List of Functions:
   1. FileRename()
   2. FileRename_All()

#ce ---------------------------------------

; The functions in this file depend on the following scripts.
#include <Array.au3> ; for managing arrays.
#include <File.au3> ; For managing files.
; #include ".\String Functions.au3"; Causes duplicate function error?

;================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: FileRename()
Description: Renames a single file in a
  specified directory. You must give the literal
  name of the old file.

#ce ---------------------------------------

Func FileRename($dir, $file_old, $file_new)

   ; If the last character in the directory name is NOT a back slash, throw an error.
   ; 	We need the final backslash so that we can concatenate the directory and the file name.
   If StringRight($my_dir, 1)  <> '\' Then

	  MsgBox(1, 'ERROR', "Your directory object must have a final backslash ('\')! Add it and rerun.")

   ; Otherwise, rename the file.
   Else

	  ; * $dir MUST HAVE A FORWARD SLASH AT THE END!!!!
	  $path_old = $dir & $file_old
	  $path_new = $dir & $file_new

	  ; Take the old file and overwrite them with the new name in the same directory.
	  FileMove($path_old, $path_new, $FC_OVERWRITE)

   EndIf

EndFunc


#cs -- TEST BEGIN
$my_dir = 'I:\Robert\AutoIt\Tests\RenameFiles\'

FileRename($my_dir, 'RenameMe_1.txt', 'NEWNAME_1.txt')
#ce -- TEST END

;================================================

#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Function: FileRename_All()
Description: Renames all files in a
  specified directory based on a given pattern.

#ce ---------------------------------------

Func FileRename_All($dir, $file_pattern, $string_old, $string_new)

   ; If the last character in the directory name is NOT a back slash, throw an error.
   ; 	We need the final backslash so that we can concatenate the directory and the file names.
   If StringMid($my_dir, StringLen($my_dir)) <> '\' Then

	  MsgBox(1, 'ERROR', "Your directory object must have a final backslash ('\')! Add it and rerun.")

   ; Otherwise, rename the files.
   Else

	  ; Set up parameters for the loop
	  $my_files  = _FileListToArray($my_dir, $file_pattern, 1); name of files only
	  $new_names = StringReplaceV($my_files, $string_old, $string_new); from ".\String Functions.au3"

	  ; For each of the old names, rename them to be the new names.
	  ; 	The 0th index contains the number of files, so we exclude it from the loop and start from index 1.
	  For $i = 1 to UBound($my_files) - 1

		 FileRename($my_dir, $my_files[$i], $new_names[$i])

	  Next

   EndIf

EndFunc


#cs -- TEST BEGIN
#include ".\String Functions.au3"; to load the StringReplaceV() function.

$my_dir = 'I:\Robert\AutoIt\Tests\RenameFiles\'

FileRename_All($my_dir, 'RenameMe*.txt', 'RenameMe', 'NEWNAME')

;FileRename_All($my_dir, 'NEWNAME*.txt', 'NEWNAME', 'RenameMe')

#ce-- TEST END