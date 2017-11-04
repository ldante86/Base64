# Revision history for Perl extension Base64.

* 0.01  Wed Nov  1 01:13:24 2017
	- version; created by h2xs 1.23 with options *-AXc -n Base64*
* 0.02  Thu Nov  2 2017
	- added line wrapping to encode() with $wrap and $width variables.
	- added TODO.md
	- small updates
* 0.03  Fri Nov  3 2017
	- fixed memory issue with decode(). I created a hash table that sped things up.
