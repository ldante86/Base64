#!/usr/bin/perl
#
# SCRIPT: base64.pl
# AUTHOR: Luciano D. Cecere
# DATE: 11/04/2017-08:47:44 PM
########################################################################
#
# base64.pl - encode and decode base64 data
# Copyright (C) 2017 Luciano D. Cecere <ldante86@aol.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
########################################################################

use strict;
use warnings;
use 5.010;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0) . '/lib';

use Getopt::Long;
use Base64 qw(encode decode);

$Base64::wrap = 0;	# default is off
$Base64::width = 80;	# default is 80 columns
$Base64::newline = 0;	# default if off

my $request_wrap = '';
my @request_width = ();
my $request_no_newline = '';
my $request_decode = '';
my $request_help = '';
my @request_string = ();
my @request_string_decode = ();

GetOptions(
  'd|decode'		=> \$request_decode,
  'h|help'		=> \$request_help,
  'n|no_newline'	=> \$request_no_newline,
  's=s{0,}'		=> \@request_string,
  'sd=s{0,}'		=> \@request_string_decode,
  'w|wrap'		=> \$request_wrap,
  'width=i{1}'		=> \@request_width,
);

my $help = "
base64.pl - encode and decode base64 data

Usage:  perl base64.pl [option] string

	perl base64.pl
	perl base64.pl --width=76 -n < file1 > file2
	perl base64.pl -d < file1 > file2
	perl base64.pl -d > file1
	perl base64.pl > file1
	perl base64.pl -sd dXNlIEJhc2U2NDsK

Note: if no `<` operator is given, read from standard input.
Output prints to stanard output unless redirected by `> file`.
To process data typed on standard input, press ctrl-d.


Options
  -d 			Decode string
  -h			Print this and exit
  -n			No new line character
  -s string		Encode string from command line
  -sd string		Decode string from command line
  -w			Enable line wrapping (default: 80)
  -width=num		Set line width for wrapping

";


################################################################################
if ($request_help) {
  print $help;
  exit;
}

if ($request_wrap) {
  $Base64::wrap = 1;
  shift
}

if (@request_width) {
  $Base64::wrap = 1;
  $Base64::width = $request_width[0];
  shift;
}

if ($request_no_newline) {
  $Base64::newline = 1;
  shift;
}

if ($request_decode) {
  my $file = '';

  foreach my $line (<STDIN>) {
    $line =~ s/\n//g;
    $file .= $line;
  }

  decode($file);
  exit;
}

if (@request_string) {
  encode("$request_string[0]");
  exit;
}

if (@request_string_decode) {
  decode("$request_string_decode[0]");
  exit;
}

my $file = '';

foreach my $line (<STDIN>) {
  $file .= $line;
}

encode($file);

