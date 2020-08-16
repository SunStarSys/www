package path;
use SunStarSys::Util qw/walk_content_tree Load/;
use strict;
use warnings;

my $conf = Load join "", <DATA>;

our @patterns = (
    [qr!^/sitemap\.html\.(\w+)$!, set_title_from_capture => {
	    view           => "sitemap",
        nest           => 1,
        quick_deps => 1,
        conf          => $conf,
		choices      => {
			en => "Sitemap",
			es => "Mapa del sitio",
			de => "Seitenverzeichnis",
		}
    }],
    [qr!/index\.html!, sitemap => {
        headers    => {title => "Index"},
        quick_deps => 1,
	    nest       => 1,
        conf       => $conf,
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

walk_content_tree {
	for my $lang (qw/en es/) {
    	if (/\.md\.$lang$/ or m!/index\.html\.$lang$! or m!/files/!) {
        	push @{$dependencies{"/sitemap.html.$lang"}}, $_;
    	}
    	if (s!/index\.html\.$lang$!!) {
        	$dependencies{"$_/index.html.$lang"} = [
            	grep s/^content//, (glob("content$_/*.{md.$lang,pl,pm}"),
                	               glob("content$_/*/index.html.$lang"))
        	];
        	push @{$dependencies{"$_/index.html.$lang"}}, grep -f && s/^content// && !m!/index\.html.$lang$!,
            	glob("content$_/*") if m!/files\b!;
    	}
	}
};

my @essays_glob = glob("content/essays/files/*/*");
for my $lang (qw/en es/) {
	push @{$dependencies{"/essays/files/index.html.$lang"}}, grep -f && s/^content// && !m!/index\.html\b!,
    	@essays_glob;
}

1;


__DATA__
title: "SunStar Systems"
keywords: "perl,mod_perl,mod_apreq2,c,xs,httpd,apache,puppet,qmail,ezmlm,git,subversion,mysql,postgresql,linux,freebsd,solaris,devops"
