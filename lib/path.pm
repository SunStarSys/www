package path;
use SunStarSys::Util qw/walk_content_tree seed_deps archived Load/;
use strict;
use warnings;

my $conf = Load join "", <DATA>;

# the only job of this __PACKAGE__ is to fill out the @path::patterns and %path::dependendies data structures.
#
# entries in @patterns are three-element arrayrefs:
# [
#   $pattern,     # first pattern to match the source file's "/content/"-rooted path wins
#   $method_name, # provided/implemented in view.pm
#   \%args,       # to be merged with "path" and "lang" args, and passed (by list value) to view's $method_name)
# ]
#
# entries in %dependencies have keys that represent source file names,
# with each corresponding value as an arrayref of source files that
# the key's subsequent built artifact depends on.
# we only unravel the %dependencies at incremental build time, not in full site builds.
#
# there are three entry points into the %dependencies hash:
# 1. via walk_content_tree() code-block logic
# 2. via a "dependencies" header entry in an md.* file (through seed_deps())
# 3. via the "dependencies" YAML hash at the bottom of the __DATA__ block below

our @patterns = (

# the "memoize" view corrects most of the speed problems with quick_deps == 3:

  [qr!/(index|sitemap)\.html!, memoize => {
    view       => "sitemap",
    nest       => 1,
    conf       => $conf,
  }],

  [qr!^/(essay|client)s/.*\.md(?:text)?!, memoize => {
    view          => [qw/set_template_from_capture snippet single_narrative/],
    conf          => $conf,
    archive_root  => "/archives",
    category_root => "/categories",
    markdown      => 1, # search markdown instead of built html
    permalink     => 1,
  }],

  [qr!^/(categories|archives)/.*\.md(?:text)?!, memoize => {
    view      => [qw/set_template_from_capture ssi snippet single_narrative/],
    conf      => $conf,
  }],

  [qr/\.md(?:text)?/, memoize => {
    view       => [qw/snippet single_narrative/],
    template   => "main.html",
    conf       => $conf,
  }],

);

our %dependencies;

# entries computed below at build-time, or drawn from the .deps cache file

walk_content_tree {

  return if m#/images/#;

  seed_deps if /\.md[^\/]*$/;

  for my $lang (qw/en es de fr/) {

    if (/\.md\.$lang$/ or m!/index\.html\.$lang$! or m!/files/|/slides/|/bin/|/lib/!) {
      push @{$dependencies{"/sitemap.html.$lang"}}, $_ if !archived;
    }

    if (s!/index\.html\.$lang$!!) {
      $dependencies{"$_/index.html.$lang"} = [
        grep s/^content// && !archived, (glob("'content$_'/*.{md.$lang,pl,pm,pptx}"),
                            glob("'content$_'/*/index.html.$lang"))
        ];
      push @{$dependencies{"$_/index.html.$lang"}}, grep -f && s/^content// && !m!/index\.html\.$lang!,
        glob("'content$_'/*") if m!/files\b!;
    }
  }
}
  and do {

    my @essays_glob = glob("content/essays/files/*/*");
    for my $lang (qw/en es de fr/) {
      push @{$dependencies{"/essays/files/index.html.$lang"}}, grep -f && s/^content// && !m!/index\.html\.$lang$!,
        @essays_glob;
    }

    # incorporate hard-coded deps in the __DATA__ section of this file
    while  (my ($k, $v) = each %{$conf->{dependencies}}) {
      push @{$dependencies{$k}}, grep $k ne $_, grep s/^content// && !archived, map glob("'content'$_"), ref $v ? @$v : split /[;,]?\s+/, $v;
    }

  };

1;

__DATA__
title: "SunStar Systems"
keywords: "mod_perl,c,xs,nodejs,editor.md,python,httpd,apache,git,subversion,zfs,solaris,http/2"
releases:
  cms:
    url: https://github.com/SunStarSys/cms
    tag: v2.1.1
  pty:
    url: https://github.com/SunStarSys/pty
    tag: v2.1.1
  sealed:
    url: https://github.com/SunStarSys/sealed
    tag: v4.1.9
  orthrus:
    url: https://github.com/SunStarSys/orthrus
    tag: v1.0.0
  Algorithm_LCS_XS:
    url: https://github.com/SunStarSys/Algorithm-LCS-XS
    tag: v2.0.2
# hard-coded deps
dependencies: {}
