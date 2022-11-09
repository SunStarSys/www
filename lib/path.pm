package path;
use SunStarSys::Util qw/read_text_file walk_content_tree Load Dump/;
use strict;
use warnings;
use File::Path 'mkpath';

my $conf = Load join "", <DATA>;

# the only job of this __PACKAGE__ is to fill out the @path::patterns and %path::dependendies data structures.
#
# entries in @patterns are three-element arrays:
# [
#   $pattern,     # first pattern to match the source file's "/content/"-rooted path wins
#   $method_name, # provided/implemented in view.pm
#   \%args,       # to be merged with "path" and "lang" args, and passed (by list value) to view's $method_name)
# ]
#
# entries in %dependencies have keys that represent source file names,
# with each corresponding value as an array of source files that the key's subsequent built artifact depends on
# we only unravel the %dependencies at incremental build time, not in full site builds.
#
# there are three entry points into the %dependencies hash:
# 1. via walk_content_tree() logic
# 2. via a "dependencies" header entry in an md.* file (in walk_content_tree)
# 3. via the "dependencies" YAML hash at the bottom of the __DATA__ block below

our @patterns = (
  [qr!/(index|sitemap)\.html!, sitemap => {
    quick_deps    => 1,
    nest          => 1,
    conf          => $conf,
  }],
  [qr!^/(essay|client)s/.*\.md(?:text)?!, set_template_from_capture => {
    view       => [qw/snippet single_narrative/],
    conf       => $conf,
  }],
  [qr/\.md(?:text)?/, snippet => {
    view       => "single_narrative",
    template   => "main.html",
    conf       => $conf,
  }],
);

our %dependencies;
# entries computed below at build-time, or drawn from the .deps cache file

if (our $use_dependency_cache and -f "$ENV{TARGET_BASE}/.deps") {
  # use the cached .deps file if the incremental build system deems it appropriate

  open my $deps, "<", "$ENV{TARGET_BASE}/.deps" or die "Can't open .deps for reading: $!";
  *dependencies = Load join "", <$deps>;
}

else {
  # generate .deps and save it

  walk_content_tree {

    if (/\.md[^\/]*$/) {
      read_text_file "content$_", \my %d, 0;
      push @{$dependencies{$_}}, grep s/^content//, map glob("content$_"), ref $d{headers}{dependencies} ? @{$d{headers}{dependencies}} : split /,?\s+/, $d{headers}{dependencies} if exists $d{headers}{dependencies};
    }

    for my $lang (qw/en es de fr/) {

      if (/\.md\.$lang$/ or m!/index\.html\.$lang$! or m!/files/|/slides/|/bin/|/lib/!) {
        push @{$dependencies{"/sitemap.html.$lang"}}, $_;
      }

      if (s!/index\.html\.$lang$!!) {
        $dependencies{"$_/index.html.$lang"} = [
          grep s/^content//, (glob("content$_/*.{md.$lang,pl,pm,pptx}"),
                              glob("content$_/*/index.html.$lang"))
          ];
        push @{$dependencies{"$_/index.html.$lang"}}, grep -f && s/^content// && !m!/index\.html\.$lang$!,
          glob("content$_/*") if m!/files\b!;
      }
    }
  };

  my @essays_glob = glob("content/essays/files/*/*");
  for my $lang (qw/en es de fr/) {
    push @{$dependencies{"/essays/files/index.html.$lang"}}, grep -f && s/^content// && !m!/index\.html\.$lang$!,
      @essays_glob;
  }

  # incorporate hard-coded deps in the __DATA__ section of this file
  while  (my ($k, $v) = each %{$conf->{dependencies}}) {
    push @{$dependencies{$k}}, grep s/^content//, map glob("content$_"), ref $v ? @$v : split /,?\s+/, $v;
  }

  mkpath $ENV{TARGET_BASE};
  open my $deps, ">", "$ENV{TARGET_BASE}/.deps" or die "Can't open '.deps' for writing: $!";
  print $deps Dump \%dependencies;
}

1;


__DATA__
title: "SunStar Systems"
keywords: "mod_perl,c,xs,nodejs,editor.md,python,httpd,apache,git,subversion,zfs,solaris"
releases:
  cms:
    url: https://github.com/SunStarSys/cms
    tag: v1.0.1
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
dependencies: {}
