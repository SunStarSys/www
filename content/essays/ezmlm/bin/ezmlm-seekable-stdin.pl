#!/usr/bin/perl
# wrapper that ensures stdin is seekable
# solely needed to support ezmlm-gate -q

open $fh, "+>", undef or die "Can't open tmpfile: $!";
print $fh $_ while <STDIN>;
seek $fh, 0, 0;
open STDIN, "<&=", fileno $fh or die "Can't fdopen tmpfile: $!";
exec @ARGV;
