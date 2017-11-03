#!/bin/sh

# Base64 module used in shell script
if [ "$1" ]; then
	perl -MBase64 -e 'Base64::decode(@ARGV)' "$@"
fi
