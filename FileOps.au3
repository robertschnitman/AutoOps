#cs ---------------------------------------
Author: Robert Schnitman
Date: 2020-06-05
Description: A collection of custom
  AutoIt functions for file management.
List of Functions:
   1. FileRename()
   2. FileRenameAll()
#ce ---------------------------------------

; The functions in this file depend on the following scripts.
#include <Array.au3> ; for managing arrays.
#include <File.au3> ; For managing files.
; #include "I:\SAI\Auto-It files\Include\RS_StringOps.au3"; Causes duplicate function error?

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
   If StringRight($dir, 1)  <> '\' Then

	  MsgBox(1, 'ERROR', "Your directory object must have a final backslash ('\')! Add it and rerun.")

   ; Otherwise, rename the file.
   Else

	  ; * $dir MUST HAVE A BACKSLASH AT THE END!!!!
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
Function: FileRenameAll()
Description: Renames all files in a
  specified directory based on a given pattern.
#ce ---------------------------------------

Func FileRenameAll($dir, $file_pattern, $string_old, $string_new)

   ; If the last character in the directory name is NOT a back slash, throw an error.
   ; 	We need the final backslash so that we can concatenate the directory and the file names.
   If StringRight($dir, 1) <> '\' Then

	  MsgBox(1, 'ERROR', "Your directory object must have a final backslash ('\')! Add it and rerun.")

   ; Otherwise, rename the files.
   Else

	  ; Set up parameters for the loop
	  ;; name of files only
	  $my_files  = _FileListToArray($dir, $file_pattern, 1);

	  ;; Use the new file naming scheme.
	  ;;; StringReplaceV() is from "I:\SAI\Auto-It files\Include\RS_StringOps.au3"
	  $new_names = StringReplaceV($my_files, $string_old, $string_new)

	  ; For each of the old names, rename them to be the new names.
	  ;;  The 0th index contains the number of files, so we exclude it from the loop and start from index 1.
	  For $i = 1 to UBound($my_files) - 1

		 FileRename($dir, $my_files[$i], $new_names[$i])

	  Next

   EndIf

EndFunc


#cs -- TEST BEGIN
; load the StringReplaceV() function that's required for FileRenameAll() to run
#include ".\RS_StringOps.au3"
$my_dir = 'I:\Robert\AutoIt\Tests\RenameFiles\'
FileRenameAll($my_dir, 'RenameMe*.txt', 'RenameMe', 'NEWNAME')
;FileRenameAll($my_dir, 'NEWNAME*.txt', 'NEWNAME', 'RenameMe')
#ce -- TEST END