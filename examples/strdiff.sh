#!/bin/bash -

if (( $# == 0 )); then
	echo "String required"
	exit 1
fi

string="$@"

encoded=$(perl -MBase64 -e 'Base64::encode(@ARGV)' "$@")
decoded=$(perl -MBase64 -e 'Base64::decode(@ARGV)' "$encoded")

echo "Original string: $string"
echo "Encoded string: $encoded"
echo "Decoded string: $decoded"

if [[ $encode == $decode ]]; then
	echo "Identical"
else
	echo "Strings are different"
	exit 1
fi


