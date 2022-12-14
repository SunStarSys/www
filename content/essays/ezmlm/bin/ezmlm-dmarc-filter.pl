#!/usr/bin/perl -p
use File::Basename;
use lib dirname(dirname $0) . "/lib";
use pull_header;

BEGIN { $alive = -f shift } # $ARGV[0] is a trigger file

if ($alive and 1 .. /^$/) { # the .. operator ensures we're in the headers

    /^dkim-signature:/i and pull_header {
        if (/\b d \s* = \s* ([\w.-]+) \b/x) {
            $domain = $1;
            $reject = `dig +short TXT _dmarc.$domain 2>&1` =~ /\bp=reject\b/i;
        }
        $reject or print;
    };

    $reject and /^from:/i and pull_header {
        s/(\b\Q$domain\E\b)/$1.INVALID/gi;
        print;
    };
}

=pod

How to enable this contraption?

Simple: run

% ezmlm-make -+ /path/to/list

on hermes as the apmail user.

That's it.  Our .ezmlmrc file will change the list's "editor" file to enable
this filter on inbound list messages.  That aspect is irreversible.  In
addition ezmlm-make will inspect the list's config flags and touch a "dmarc"
file in the list's directory, which will turn this filter "alive", if it needs
to.  Otherwise it's a glorified noop.

All this script does is add a .INVALID suffix to affected users' "From:"
headers, as well as dropping the "DKIM-Signature:" header for good measure.
Use it as you see fit.  To test it out use an existing filename as the first
argument and put a test message on stdin:

% echo "DKIM-Signature: d=yahoo.com\nTo: you\n"From: foo@yahoo.com \
 | ezmlm-dmarc-filter /path/to/existing/file

If there is instead a preference to disable all associated ezmlm message
munging, eg for Subject prefixes, message Trailers, or MIME removals, then
that request may be accommodated by running

% ezmlm-make -+ -FTX /path/to/list

which will ensure there is no "dmarc" file in the list's directory, disabling
the munging actions of this filter as well as any other munging actions of
ezmlm.

BUGS:

Assumes DKIM-Signature header appears before the From header in the message.
Empirical evidence suggests this is always the case, but I'm sure some clever
person did DKIM header-injection backwards.

LICENSE:

#  Licensed to the Apache Software Foundation (ASF) under one or more
#  contributor license agreements.  See the NOTICE file distributed with
#  this work for additional information regarding copyright ownership.
#  The ASF licenses this file to You under the Apache License, Version 2.0
#  (the "License"); you may not use this file except in compliance with
#  the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

=cut
