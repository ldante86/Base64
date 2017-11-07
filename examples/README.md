# README for /examples

## DESCRIPTION

These files utilize the Base64 module.

## FILES

* b64.pl
  - Usage: ````perl b64.pl string````
  - Encode a string as a command line argument.
* d64.pl
  - Usage: ````perl d64.pl string````
  - Decode a base64 string as a command line argument.
* decode.pl
  - Usage: ````perl decode.pl < file > file2````
  - This is used in decoding a file which has a long base64 string that has been broken up into individual lines.
* decode.sh
  - Usage: ````sh decode.sh string````
  - This script shows how to use the Base64 module as a perl one-liner. Decode version.
* encode.pl
  - Usage: ````perl encode.pl file > file2````
  - Encode text from a file to base64.
* encode.sh
  - Usage: ````sh encode.sh string````
  - This script shows how to use the Base64 module as a perl one-liner. Encode version.
* stdin1.pl
  - Usage: ````perl stdin1.pl````
  - Encode string through standard input.
* strdiff.sh
  - Usage: bash ````strdiff.sh```` "string"
  - Encode a string, decode it, then compare it. 
