#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use Base64 qw(encode);


while (<>) {
  chomp($_);
  encode($_);
}
