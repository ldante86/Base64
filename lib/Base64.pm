package Base64;

use 5.022001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(encode decode);
our %EXPORT_TAGS = ( 'all' => [ qw(encode decode) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our $VERSION = '0.01';

our @base64      =       ( "A".."Z", "a".."z", "0".."9", "+", "/" );
our @end         =       qw( o= K Cg== == = );
our $newline	=	0;      ## 0 = add new line, 1 = no new line

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
  my ($block, $lb, $i, $str) = (0, 0, 0, ascii_to_bin(@_));

  for ($i = 0; $i < length($str); $i += 6) {
    $block = substr($str, $i, 6);
    if (length($block) < 5) {
      $lb = length($block);
    }
    while (length($block) < 6) {
      $block = "$block" . 0;
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

  for ($i = 0; $i < length($str); $i++) {
    $d = substr($str, $i, 1);
    for ($n = 0; $n < $#base64; $n++) {
      if ($base64[$n] eq $d) {
        $offset .= dec_to_bin($n);
      }
    }
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

B<Base64> - Encode/decode base64 strings.

=head1 SYNOPSIS

	use Base64 qw(encode);
	my $str = "Hello world";
	$Base64::newline = 0;
	encode("$str");

	use Base64 qw(decode);
	my $str = "SGVsbG8gd29ybGQK";
	decode("$str");

=head1 DESCRIPTION

This module provides subroutines for encoding and decoding base64 strings.

By default, B<encode()> prints newline characters at the end of the encoded string. To suppress the newline character, do:

	$Base64::newline = 1;

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
