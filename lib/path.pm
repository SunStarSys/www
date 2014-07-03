package path;
use ASF::Util qw/walk_content_tree Load/;
use strict;
use warnings;

my $conf = Load(join "", <DATA>);

our @patterns = (
    [qr!^/sitemap\.html$!, sitemap => {
        headers    => {title => "Sitemap"},
        nest       => 1,
        quick_deps => 1,
        conf       => $conf,
    }],
    [qr/\.md(?:text)?$/,  single_narrative => {
        template   => "main.html",
        preprocess => 1,
        conf       => $conf,
    }],
);

our %dependencies;

walk_content_tree {
    if (/\.md(?:text)?$/ or m!/index\.html$!) {
        push @{$dependencies{"/sitemap.html"}}, $_;
    }
};


1;

__DATA__
title: "SunStar Systems"
