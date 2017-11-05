# Base64 version 0.03

## MODULE

Base64 - encode/decode base64 strings.

## SYNOPSIS

````
use Base64 qw(encode);
my $str = "Hello world";
$Base64::wrap = 1;
$Base64::width = 75;
$Base64::newline = 0;
encode("$str");

use Base64 qw(decode);
my $str = "SGVsbG8gd29ybGQK";
decode("$str");
````

## DESCRIPTION

This library contains functions for encoding and decoding base64 strings. When encoding from the command line, the string must be quoted.

## FUNCTIONS

### encode("$str");
Encode "$str" to standard output.

### decode("$str");
Decode "$str" to standard output.

## VARIABLES

A 0 value means off; 1 means on.

````$Base64::newline = 0;````

Disable the newline character in encoded output.

````$Base64::wrap = 0;````

Enable line wrapping.

````$Base64::width = 80;````

Specify the line width. The default is 80 columns.

## INSTALLATION

To install this module type the following:

````
   perl Makefile.PL
   make
   make test
   sudo make install
````

## OTHERS

*/bin/base64.pl* is standalone program and provides a front-end to this module.

In */examples* there are several scripts that utilize the functions in this library. This module does not have to be installed in order to use the examples as long as they are executed from inside the project directory.

## COPYRIGHT AND LICENSE

Copyright (C) 2017 by **Luciano Dante Cecere**

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.22.1 or,
at your option, any later version of Perl 5 you may have available.
