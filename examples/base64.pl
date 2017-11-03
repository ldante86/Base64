#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use Base64 qw(encode decode);

my $help = "base64.pl - encode/decode base64 strings

Usage:  ./base64.pl [option] string

Options
  string		Encode string
  -d base64-string	Decode string
  -n string		No new line character
  -h			Print this and exit
";


if (@ARGV == 0) {
  print "$help";
  exit;
}
elsif ("$ARGV[0]" eq "-h") {
  print "$help";
  exit;
}
elsif ("$ARGV[0]" eq "-d") {
  shift;
  if (@ARGV == 0) {
    print "-d requires an argument\n";
    print "$help";
    exit 1;
  }
  decode(@ARGV);
}
elsif ("$ARGV[0]" eq "-n") {
  shift;
  $Base64::newline = 1;
  if (@ARGV == 0) {
    print "-n requires an argument\n";
    print "$help";
    exit 1;
  }
  encode(@ARGV);
}
else {
  encode(@ARGV);
}
