#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use Base64 qw(encode);

exit if (@ARGV == 0);

if ("$ARGV[0]" eq "-n") {
  $Base64::newline = 1;
  shift;
}

# 0 = wrap off; 1 = wrap on
$Base64::wrap = 1;

# Set wrap width. Default 80. Set width to 0
# to disable wrapping.
$Base64::width = 80;

exit if (@ARGV == 0);

encode(@ARGV);

