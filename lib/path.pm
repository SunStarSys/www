package path;
use SunStarSys::Util qw/walk_content_tree seed_file_deps seed_file_acl archived Load/;
use strict;
use warnings;

open my $fh, "<:encoding(UTF-8)", "lib/facts.yml" or die "Can't locate facts.yml data: $!";
my $facts = Load join "", <$fh>;
close $fh;

# the only job of this __PACKAGE__ is to fill out the @patterns, @acl, and %dependencies data structures.
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
    compress   => 1,
    view       => [qw/sitemap/],
    nest       => 1,
    facts      => $facts,
  }],

  [qr!^/(essay|client)s/.*\.md(?:text)?!, memoize => {
    view            => [qw/set_template_from_capture snippet single_narrative/],
    compress        => 1,
    facts           => $facts,
    archive_root    => "/archives",
    category_root   => "/categories",
    markdown_search => 1, # search markdown instead of built html
    permalink       => 1,
  }],

  [qr!^/(categories|archives)/.*\.md(?:text)?!, memoize => {
    view       => [qw/set_template_from_capture ssi normalize_links snippet single_narrative/],
    compress   => 1,
    facts      => $facts,
  }],

  [qr/\.md(?:text)?/, memoize => {
    view       => [qw/snippet asymptote single_narrative/],
    compress   => 1,
    template   => "main.html",
    facts      => $facts,
  }],

);

#snippet
our (%dependencies, @acl);

# entries computed below at build-time, or drawn from the .deps cache file

walk_content_tree {

  return if m#/images/#;

  seed_file_deps, seed_file_acl if /\.md[^\/]*$/;

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
    my @categories_glob = glob("content/categories/*/*");

    for my $lang (qw/en es de fr/) {
      push @{$dependencies{"/essays/files/index.html.$lang"}}, grep -f && s/^content// && !m!/index\.html\.$lang$!,
        @essays_glob;
      push @{$dependencies{"/categories/index.html.$lang"}}, grep -f && s/^content// && !m!/index\.html\.$lang$!,
        @categories_glob if -f "content/categories/index.html.$lang";
    }

    # incorporate hard-coded deps in the __DATA__ section of this file
    while  (my ($k, $v) = each %{$facts->{dependencies}}) {
      push @{$dependencies{$k}}, grep $k ne $_, grep s/^content// && !archived, map glob("'content'$_"), ref $v ? @$v : split /[;,]?\s+/, $v;
    }
    open my $fh, "<:encoding(UTF-8)", "lib/acl.yml" or die "Can't open acl.yml: $!";
    push @acl, @{Load join "", <$fh>};
  };
#snippet

1;
