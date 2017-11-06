# README for base64.pl

## NAME
base64.pl

## DESCRIPTION

This script encodes and decodes base64 text using the Base64 module.

## USAGE
perl base64.pl [options] < infile > outfile

## OPTIONS

| Option     | Description     |
| :------------- | :------------- |
| -d --decode < data      | Decode data       |
| -h --help  | Show help text and exit  |
| -n --no-newline   | Suppress new character  |
| -s --string *string*  | Encode string as a command line argument  |
| -sd --string-decode *string*   | Decode string as a command line argument  |
| -w --wrap  | Enable line wrapping  |
| --width=*num*   | Set line width. Default is 80 columns |

## ENCODING TYPED OR PASTED INPUT

Basic encoding of typed input:
````
perl base64.pl
````
Text is read from standard input. Text can be typed or pasted. To encode the text, press ctrl-d. Encoded text will be printed to standard output.

To save the decoded text to a file, run as:
````
perl base64.pl > outfile
````

To encode a string as a command line argument:
````
perl base64.pl -s "string" [> outfile]
````

By default encoded data is printed as a single line. The string must be quoted. To break the encoded data up into even lines, enable the wrap feature:
````
perl base64.pl -w [> outfile]
````
The default line length for line wrapping is 80, but it can be changed by:
````
perl base64.pl --width=76 [> outfile]
````
If ````--width```` is used, line wrapping is automatically turned on. Setting the width to 0 turns off wrapping.

To turn off the newline character in encoded output:
````
perl base64.pl -n [> outfile]
````

Options ````-n````, ````-w````, ````-width```` and ````-s```` can be combined.

## ENCODING TEXT FROM A FILE

Encoding text from a file is done by a redirect:
````
perl base64.pl < infile [> outfile]
````

or through a pipe:
````
cat infile | perl base64.pl [> outfile]
````
Option ````-n```` should be used in encoding text from a file. ````-w````, ````-width```` and ````-s```` can also be combined here, as:
````
cat infile | perl base64.pl --width=76 -n [> outfile]
````

## DECODING TYPED OR PASTED INPUT
Basic encoding of typed input:
````
perl base64.pl -d [> outfile]
````
Decoding a base64 string as a command line argument:
Basic encoding of typed input:
````
perl base64.pl -sd base64-string [> outfile]
````

## DECODING AN ENCODED FILE

Encoding text from a file is done by a redirect:
````
perl base64.pl -d < infile [> outfile]
````

or through a pipe:
````
cat infile | perl base64.pl -d [> outfile]
````

## COPYRIGHT AND LICENSE

Copyright (C) 2017 by **Luciano Dante Cecere**

**base64.pl** is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.22.1 or,
at your option, any later version of Perl 5 you may have available.
