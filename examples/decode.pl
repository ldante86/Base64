#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use Base64 qw(decode);

## Usage: decode.pl < file
## or read from standard input

foreach my $line (<STDIN>) {
  chomp($line);
  decode($line);
}
