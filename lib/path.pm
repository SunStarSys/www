package path;
use ASF::Util qw/walk_content_tree Load/;
use strict;
use warnings;

our @patterns = (
    [qr!^/sitemap\.html$!, sitemap => { headers => {title => "Sitemap"}, nest => 1 }],
    [qr/\.md(?:text)?$/,  single_narrative => { template => "main.html" }],
);


1;
