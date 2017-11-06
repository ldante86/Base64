package Base64;

use 5.022001;
#use 5.010;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(encode decode);
our %EXPORT_TAGS = ( 'all' => [ qw(encode decode) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our $VERSION = '0.03';

our @base64      =       ( "A".."Z", "a".."z", "0".."9", "+", "/" );
our @end         =       qw( o= K Cg== == = );
our $newline	=	0;      ## 0 = add new line, 1 = no new line
our $width	=	80;
our $wrap	=	0;

our %offset = (
	"A"  => "0",	"B"  => "1",
	"C"  => "2",	"D"  => "3",
	"E"  => "4",	"F"  => "5",
	"G"  => "6",	"H"  => "7",
	"I"  => "8",	"J"  => "9",
	"K"  => "10",	"L"  => "11",
	"M"  => "12",	"N"  => "13",
	"O"  => "14",	"P"  => "15",
	"Q"  => "16",	"R"  => "17",
	"S"  => "18",	"T"  => "19",
	"U"  => "20",	"V"  => "21",
	"W"  => "22",	"X"  => "23",
	"Y"  => "24",	"Z"  => "25",
	"a"  => "26",	"b"  => "27",
	"c"  => "28",	"d"  => "29",
	"e"  => "30",	"f"  => "31",
	"g"  => "32",	"h"  => "33",
	"i"  => "34",	"j"  => "35",
	"k"  => "36",	"l"  => "37",
	"m"  => "38",	"n"  => "39",
	"o"  => "40",	"p"  => "41",
	"q"  => "42",	"r"  => "43",
	"s"  => "44",	"t"  => "45",
	"u"  => "46",	"v"  => "47",
	"w"  => "48",	"x"  => "49",
	"y"  => "50",	"z"  => "51",
	"0"  => "52",	"1"  => "53",
	"2"  => "54",	"3"  => "55",
	"4"  => "56",	"5"  => "57",
	"6"  => "58",	"7"  => "59",
	"8"  => "60",	"9"  => "61",
	"+"  => "62",	"/"  => "63",
);

sub ascii_to_bin {
  unpack("B*", $_[0]);
}

sub bin_to_dec {
  oct("0b" . $_[0]);
}

sub bin_to_ascii {
  my $len = length($_[0]);
  pack("B$len", $_[0]);
}

sub ascii_to_dec {
  ord($_[0]);
}

sub dec_to_bin {
  sprintf("%.6b", $_[0]);
}

### This routine encodes an ascii string into a base64 string.
##  Usage:
##    encode("$string");
##  $newline = 0	print newline character ('\n')
##  $newline = 1	print no newline character
sub encode {
  my ($c, $block, $lb, $i, $str) = (0, 0, 0, 0, ascii_to_bin(@_));

  for ($i = 0; $i < length($str); $i += 6) {
    $block = substr($str, $i, 6);
    if (length($block) < 5) {
      $lb = length($block);
    }
    while (length($block) < 6) {
      $block = "$block" . 0;
    }
    $c += 1;
    if ($wrap == 1 && $c == $width) {
      $c = 0;
      print $base64[bin_to_dec($block)] . "\n";
      next;
    }
    print $base64[bin_to_dec($block)];
  }

  if ($lb == 4) { $lb -= 2; }
  else          { $lb -= 1; }

  if ($newline == 0) {
    if          ($lb == 1)      { print "$end[0]\n"; }
    elsif       ($lb == 2)      { print "$end[1]\n"; }
    else                        { print "$end[2]\n"; }
  }
  else {
    if          ($lb == 1)      { print "$end[3]\n"; }
    elsif       ($lb == 2)      { print "$end[4]\n"; }
    else                        { print "\n"; }
  }

}

sub decode {
  my ($str, $i, $d, $n, $offset, $trim) = ($_[0], 0, 0, 0, '', 0);
  my ($l_4, $l_2, $l) = (substr($str, -4), substr($str, -2), substr($str, -1));

  if ($l_4 eq $end[2]) {
    $trim = $end[2];
  }
  elsif ($l_2 eq $end[0] || $l_2 eq $end[3]) {
    $trim = $end[3];
  }
  elsif ($l eq $end[1] || $l eq $end[4]) {
    $trim = $end[4];
  }

  for ($i = 0; $i < length($str)-1; $i++) {
    $d = substr($str, $i, 1);
    last if ($d eq '');
    $offset .= dec_to_bin($offset{$d});
  }

  if ($trim eq $end[4] || $trim eq $end[1]) {
    $offset = substr($offset, 0, -2);
  }
  elsif ($trim eq $end[3] || $trim eq $end[2]) {
    $offset = substr($offset, 0, -4);
  }

  for ($i = 0 ; $i < length($offset); $i += 8) {
    print bin_to_ascii(substr($offset, $i, 8));
  }

  print "\n";
}
1;

__END__

=head1 NAME

Base64 - Encode/decode base64 strings.

=head1 SYNOPSIS

	use Base64 qw(encode);
	my $str = "Hello world";
	$Base64::wrap = 1;
	$Base64::width = 75;
	$Base64::newline = 0;
	encode("$str");

	use Base64 qw(decode);
	my $str = "SGVsbG8gd29ybGQK";
	decode("$str");

=head1 DESCRIPTION

This module provides subroutines for encoding and decoding base64 strings.

By default, B<encode()> prints newline characters at the end of the encoded string. To suppress the newline character, define:

	$Base64::newline = 1;

To enable line wrapping in encoded output, define:

	$Base64::wrap = 1;

The default line wrap is 80 columns. To change the width, define:

	$Base64::width = 80;

Setting the width to 0 turns off line wrapping.

=head1 SUBROUTINES

=over 12

=item B<encode>("Hello world");

Encode a string to base64. The string must be quoted.

=item B<decode>("SGVsbG8gd29ybGQK");

Decode a base64 string to ascii.

=back

=head1 AUTHOR

This module and documentation was written by B<Luciano Dante Cecere <ldante1986@gmail.com>>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.22.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
