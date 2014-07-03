package path;
use ASF::Util qw/walk_content_tree Load/;
use strict;
use warnings;

our @patterns = (
    [qr!^/sitemap\.html$!, sitemap => {
        headers    => {title => "Sitemap"},
        nest       => 1,
        quick_deps => 1,
    }],
    [qr/\.md(?:text)?$/,  single_narrative => { template => "main.html", preprocess => 1 }],
);

our %dependencies;

walk_content_tree {
    if (/\.md(?:text)?$/ or m!/index\.html$!) {
        push @{$dependencies{"/sitemap.html"}}, $_;
    }
};


1;
