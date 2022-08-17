package path;
use SunStarSys::Util qw/walk_content_tree Load Dump/;
use strict;
use warnings;

my $conf = Load join "", <DATA>;

our @patterns = (
    [qr!/(index|sitemap)\.html!, sitemap => {
        quick_deps    => 1,
        nest          => 1,
        conf          => $conf,
    }],
    [qr!^/(essay|client)s/.*\.md(?:text)?!,  set_template_from_capture => {
        view       => "single_narrative",
        preprocess => 0,
        conf       => $conf,
    }],
    [qr/\.md(?:text)?/,  single_narrative => {
        template   => "main.html",
        preprocess => 1,
        conf       => $conf,
    }],
);

our %dependencies;
if (our $use_dependency_cache and -f "$ENV{TARGET_BASE}/.deps") {
    open my $deps, "<", "$ENV{TARGET_BASE}/.deps" or die "Can't open .deps for reading: $!";
    *dependencies = Load join "", <$deps>;
}
else {
    walk_content_tree {
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
    open my $deps, ">", "$ENV{TARGET_BASE}/.deps" or die "Can't open '.deps' for writing: $!";
    print $deps Dump \%dependencies;
}
1;

__DATA__
title: "SunStar Systems"
keywords: "perl,mod_perl,mod_apreq2,c,xs,httpd,apache,puppet,qmail,ezmlm,git,subversion,mysql,postgresql,linux,freebsd,solaris,devops"
